package kr.or.batirplan.electronicdocument.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.common.config.FieldMappingConfig;
import kr.or.batirplan.common.vo.CommonnessCodeVO;
import kr.or.batirplan.electronicdocument.mapper.IElectronicDocumentMapper;
import kr.or.batirplan.electronicdocument.vo.CorbonCopyVO;
import kr.or.batirplan.electronicdocument.vo.DocumentVO;
import kr.or.batirplan.electronicdocument.vo.FieldSelectorVO;
import kr.or.batirplan.electronicdocument.vo.FormVO;
import kr.or.batirplan.electronicdocument.vo.SanctionLineVO;
import kr.or.batirplan.employee.mapper.IMypageMapper;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.project.projectmanage.vo.ProcessVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.project.projectplan.mapper.IProjectPlanMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ElectronicDocumentServiceImpl implements IElectronicDocumentService {

    @Autowired
    private IElectronicDocumentMapper documentMapper;
    
    @Autowired
    private IProjectPlanMapper planMapper;
    
    @Autowired
    private IMypageMapper employeeMapper;
    
    @Value("${stamp.upload.path}")
    private String uploadPath;

    @Override
    public List<DocumentVO> selectDocumentList(Map<String, Object> params) {
        return documentMapper.selectDocumentList(params);
    }

	@Override
	public List<FormVO> getAllDocumentForms() {
		return documentMapper.getAllDocumentForms();
	}

	@Override
	public FormVO getDocumentWriteForm(int formNo) {
		return documentMapper.getDocumentWriteForm(formNo);
	}

	@Override
	public int createDocument(DocumentVO documentVO) {
		documentMapper.createDocument(documentVO);
		return documentMapper.getLastInsertedDocNo();
	}

	@Override
	public List<EmployeeVO> getAllEmployees() {
		return documentMapper.getAllEmployees();
	}

	@Override
	public void insertSanctionLine(int docNo, String approver, int order) {
		Map<String, Object> params = new HashMap<>();
	    params.put("docNo", docNo);
	    params.put("approver", approver);
	    params.put("order", order);
	    documentMapper.insertSanctionLine(params);
	}

	@Override
	public void insertCorbonCopy(int docNo, String refCode) {
		Map<String, Object> params = new HashMap<>();
	    params.put("docNo", docNo);
	    params.put("emplCode", refCode);
	    documentMapper.insertCorbonCopy(params);
	}

	@Override
	public DocumentVO getDocumentDetail(int docNo) {
	    DocumentVO document = documentMapper.getDocumentDetail(docNo);
	    
	    if(document != null && document.getDrafter() != null) {
	        String stampUrl = documentMapper.selectStampUrl(document.getDrafter());
	        document.setDrafterStampUrl(stampUrl);
	    }

	    return document;
	}

	@Override
	public List<SanctionLineVO> getSanctionLines(int docNo) {
		return documentMapper.getSanctionLines(docNo);
	}

	@Override
	public List<CorbonCopyVO> getCorbonCopies(int docNo) {
		return documentMapper.getCorbonCopies(docNo);
	}

	@Override
	public int updateDocument(DocumentVO documentVO) {
        int rows = documentMapper.updateDocument(documentVO);
        return (rows > 0) ? documentVO.getDocNo() : 0;
	}

	@Override
	public void deleteSanctionLines(int docNo) {
		documentMapper.deleteSanctionLines(docNo);
	}

	@Override
	public void deleteCorbonCopies(int docNo) {
		documentMapper.deleteCorbonCopies(docNo);
	}

	@Override
	public String uploadStampImage(String emplCode, MultipartFile stampImage) throws Exception {
	    if (stampImage.isEmpty()) {
	        throw new Exception("파일이 비어있습니다.");
	    }
	    
	    String originalFilename = stampImage.getOriginalFilename();
	    String filename = System.currentTimeMillis() + "_" + originalFilename;
	    
	    File destFile = new File(uploadPath, filename); 
	    stampImage.transferTo(destFile);
	    
	    String approvalStamp = "/upload/stamps/" + filename;
	    
	    int updated = documentMapper.updateStampImage(emplCode, approvalStamp);
	    if (updated <= 0) {
	        throw new Exception("도장 이미지 URL DB 업데이트 실패");
	    }
	    
	    return approvalStamp;
	}

	@Override
	public String selectStampUrl(String emplCode) {
		return documentMapper.selectStampUrl(emplCode);
	}

	@Override
	public List<SanctionLineVO> getSanctionLinesWithPrevInfo(int docNo) {
	    List<SanctionLineVO> lines = documentMapper.getSanctionLines(docNo);

	    for (int i = 0; i < lines.size(); i++) {
	        SanctionLineVO current = lines.get(i);

	        current.setApproved("02".equals(current.getSanctnSttus()));

	        if (i == 0) {
	            current.setPrevDone(true);
	        } else {
	            SanctionLineVO prev = lines.get(i - 1);
	            boolean prevIsApproved = "02".equals(prev.getSanctnSttus());
	            current.setPrevDone(prevIsApproved);
	        }
	    }

	    return lines;
	}
	
	@Override
	public boolean deleteStampImage(String emplCode) throws Exception {
	    String stampUrl = documentMapper.selectStampUrl(emplCode);
	    
	    if (stampUrl == null || stampUrl.trim().isEmpty()) {
	        return false;
	    }

	    String fileName = stampUrl.substring("/upload/stamps/".length());
	    File file = new File(uploadPath, fileName);
	    
	    if (file.exists()) {
	        file.delete(); 
	    }

	    int updated = documentMapper.updateStampImage(emplCode, null);
	    return (updated > 0);
	}

	@Override
    public void rejectDocument(int docNo, int sanctnLineNo, String emplCode, String returnResn) {
        SanctionLineVO line = documentMapper.selectSanctionLineByNo(sanctnLineNo);
        
        if (line == null || line.getDocNo() != docNo) {
            throw new RuntimeException("잘못된 반려 요청입니다. (존재하지 않는 라인)");
        }
        if (!line.getSanctner().equals(emplCode)) {
            throw new RuntimeException("해당 라인의 결재자가 아닙니다.");
        }
        if ("02".equals(line.getSanctnSttus())) {
            throw new RuntimeException("이미 결재 완료된 라인입니다.");
        }

        documentMapper.rejectSanctionLine(sanctnLineNo, returnResn);
        documentMapper.updateDocumentStatus(docNo, "03");
    }

	@Override
    public void updateRejectedDocument(DocumentVO document, List<String> approverList, List<String> referenceList) {
        documentMapper.updateDocument(document);

        documentMapper.deleteSanctionLines(document.getDocNo());
        documentMapper.deleteCorbonCopies(document.getDocNo());

        int order = 1;
        for (String approver : approverList) {
            if (approver == null || approver.isBlank()) continue;
            
            Map<String, Object> param = new HashMap<>();
            param.put("docNo", document.getDocNo());
            param.put("approver", approver);
            param.put("order", order++);
            
            documentMapper.insertSanctionLine(param);
        }

        for (String ref : referenceList) {
            if (ref == null || ref.isBlank()) continue;

            Map<String, Object> refParam = new HashMap<>();
            refParam.put("docNo", document.getDocNo());
            refParam.put("emplCode", ref);

            documentMapper.insertCorbonCopy(refParam);
        }
    }
	
	@Transactional
	@Override
	public boolean approveSanction(int docNo, int sanctnLineNo, String emplCode) {
	    SanctionLineVO line = documentMapper.selectSanctionLineByNo(sanctnLineNo);
	    
	    if (line == null || line.getDocNo() != docNo) return false;
	    if (!line.getSanctner().equals(emplCode) || "02".equals(line.getSanctnSttus())) {
	        return false;
	    }
	    documentMapper.updateSanctionApprove(sanctnLineNo);
	    
	    int notApprovedCount = documentMapper.countNotApprovedLines(docNo);
	    
	    // 결재 안한 사람이 없을때, 최종 결재일때
	    if (notApprovedCount == 0) {
	        documentMapper.updateDocumentStatus(docNo, "04");
	        
	        DocumentVO doc = documentMapper.getDocumentDetail(docNo);
	        String html = (doc.getBdtCn() != null) ? doc.getBdtCn() : "";

	        // Jsoup 파싱
	        Document jsoupDoc = Jsoup.parse(html);

	        // 양식별 필드매핑 정보 불러오기
	        int formNo = doc.getFormNo();  // 문서에 연결된 양식 번호
	        List<FieldSelectorVO> fieldList = FieldMappingConfig.FORM_FIELD_MAP.get(formNo);

	        // formNo가 없으면, 기본값 or 로그만 찍고 종료
	        if (fieldList == null || fieldList.isEmpty()) {
	            log.info("===== 결재완료 문서 #{} =====", docNo);
	            log.info("formNo={} 에 대한 필드매핑 정보가 없어, 추가 처리 없이 종료합니다.", formNo);
	            return true;
	        }

	        // 각 필드 추출
	        log.info("===== 결재완료 문서 #{} (formNo={}) =====", docNo, formNo);
	        
	        Map<String, String> dataMap = new HashMap<>(); // id or class 와 추출 값을 담기위한 Map
	        
	        for (FieldSelectorVO fs : fieldList) {
	            String selectorType = fs.getSelectorType();   // "id" or "class"
	            String selectorName = fs.getSelectorName();   // "deptCell", "positionCell" 등
	            String label = fs.getFieldLabel();            // "소속", "직급" 등

	            String extractedText = "";

	            if ("id".equalsIgnoreCase(selectorType)) {
	                // id로 추출
	                org.jsoup.nodes.Element el = jsoupDoc.getElementById(selectorName);
	                if (el != null) {
	                    extractedText = el.text();
	                    dataMap.put(selectorName, extractedText);
	                }
	            } else if ("class".equalsIgnoreCase(selectorType)) {
	                // class로 추출 (첫 번째 항목)
	                org.jsoup.select.Elements els = jsoupDoc.getElementsByClass(selectorName);
	                if (!els.isEmpty()) {
	                    extractedText = els.first().text();
	                    dataMap.put(selectorName, extractedText);
	                }
	            } 
	        }
	        log.info("#DataMap key - value >>>" + dataMap);
	        
	        // 자동 업무 처리 진행!
	        int autoWorkStatus = autoWorkProcess(formNo, dataMap);
	        if (autoWorkStatus == 0) {
	        	log.error("자동 업무 처리 실패!");
				return false;
			}
	    }
	    return true;
	}
	
	@Transactional
	@Override
	public boolean finalApproval(int docNo, String emplCode) {
	    List<SanctionLineVO> sanctionLines = documentMapper.getSanctionLines(docNo);

	    boolean updated = false;
	    for (SanctionLineVO line : sanctionLines) {
	        if (line.getSanctner().equals(emplCode)
	            && "01".equals(line.getSanctnSttus())) {
	            documentMapper.updateSanctionToFinal(line.getSanctnLineNo());
	            updated = true;
	            break;
	        }
	    }
	    if (!updated) {
	        return false;
	    }

	    documentMapper.updateDocumentStatus(docNo, "04");
	    
	    DocumentVO doc = documentMapper.getDocumentDetail(docNo);
        String html = (doc.getBdtCn() != null) ? doc.getBdtCn() : "";

        // Jsoup 파싱
        Document jsoupDoc = Jsoup.parse(html);

        // 양식별 필드매핑 정보 불러오기
        int formNo = doc.getFormNo();  // 문서에 연결된 양식 번호
        List<FieldSelectorVO> fieldList = FieldMappingConfig.FORM_FIELD_MAP.get(formNo);

        // formNo가 없으면, 기본값 or 로그만 찍고 종료
        if (fieldList == null || fieldList.isEmpty()) {
            log.info("===== 결재완료 문서 #{} =====", docNo);
            log.info("formNo={} 에 대한 필드매핑 정보가 없어, 추가 처리 없이 종료합니다.", formNo);
            return true;
        }

        // 각 필드 추출
        log.info("===== 결재완료 문서 #{} (formNo={}) =====", docNo, formNo);
        
        Map<String, String> dataMap = new HashMap<>(); // id or class 와 추출 값을 담기위한 Map
        
        for (FieldSelectorVO fs : fieldList) {
            String selectorType = fs.getSelectorType();   // "id" or "class"
            String selectorName = fs.getSelectorName();   // "deptCell", "positionCell" 등
            String label = fs.getFieldLabel();            // "소속", "직급" 등

            String extractedText = "";

            if ("id".equalsIgnoreCase(selectorType)) {
                // id로 추출
                org.jsoup.nodes.Element el = jsoupDoc.getElementById(selectorName);
                if (el != null) {
                    extractedText = el.text();
                    dataMap.put(selectorName, extractedText);
                }
            } else if ("class".equalsIgnoreCase(selectorType)) {
                // class로 추출 (첫 번째 항목)
                org.jsoup.select.Elements els = jsoupDoc.getElementsByClass(selectorName);
                if (!els.isEmpty()) {
                    extractedText = els.first().text();
                    dataMap.put(selectorName, extractedText);
                }
            } 
        }
        log.info("#DataMap key - value >>>" + dataMap);
        
        // 자동 업무 처리 진행!
        int autoWorkStatus = autoWorkProcess(formNo, dataMap);
        if (autoWorkStatus == 0) {
        	log.error("자동 업무 처리 실패!");
			return false;
		}
        return true;
    }
	
	// 양식별 입력 값 매핑
	private int autoWorkProcess(int formNo, Map<String, String> dataMap) {
		
		switch (formNo) {
			case 1: 
				
				return 1;
			case 2: 
				
				return 1;
			case 3: 
				
				return 1;
			case 4: 
				/*
				 * 휴가 처리일때
				 * @Author: 감상우
				 * 
				 *  <dataMap Key>
				 * - deptCell (소속)
				 * - empNameCell (성명)
				 * - positionCell (직급)
				 * - typeCell (종류)
				 * - reasonCell (사유)
				 * - periodCell (기간)
				 * - emergencyCell (비상연락망)
				 * 반드시 성공여부 int값으로 메서드를 작성해주세요
				 */
				log.info("휴가 자동 처리 완료!");
				
				return 1;
			case 5: 
				
				return 1;
			case 6: 
				/*
				 * <dataMap Key>
				 * - deptCell (소속)
				 * - positionCell (직급)
				 * - empNameCell (작성자)
				 * - todaySpan (작성일자)
				 * - proNameCell (프로젝트명)
				 * - managerCell (담당자)
				 * - startDateCell (시작일)
				 * - endDateCell (종료일)
				 * - categoryCell (카테고리)
				 * - participationCell (참여인원)
				 * - proContentCell (프로젝트 내용)
				 * - budgetCell (프로젝트 예산)
				 * - locationCell (위치)
				 * - expectationCell (기대효과)
				 */
				log.info("프로젝트 계획 처리 완료!");
				
				try {
                    ProjectVO projectVO = new ProjectVO();

                    // (1) 담당자 이름 → 사원코드
                    String managerName = dataMap.get("managerCell");
                    String managerCode = null;
                    if (managerName != null && !managerName.isBlank()) {
                        managerCode = employeeMapper.selectEmpCodeByName(managerName.trim());
                        if (managerCode == null) {
                            // 없는 이름이면 예외 or 임시코드 ...
                            log.warn("사원 이름 '{}' → 사원코드 없음", managerName);
                            managerCode = "";
                        }
                    } else {
                        managerCode = "";
                    }
                    projectVO.setCharger(managerCode);

                    // (2) 프로젝트명, 카테고리, 내용
                    projectVO.setPrjctNm(dataMap.get("proNameCell"));
                    projectVO.setPrjctCtgry(dataMap.get("categoryCell"));
                    projectVO.setPrjctCn(dataMap.get("proContentCell"));

                    // (3) 예산(숫자만 추출)
                    String rawBudget = dataMap.get("budgetCell"); // "1,000,000원" 등
                    if (rawBudget == null) rawBudget = "0";
                    String onlyDigits = rawBudget.replaceAll("[^0-9]", ""); // 정규식: 숫자 아닌 것 제거
                    long budgetValue = 0;
                    if (!onlyDigits.isEmpty()) {
                        budgetValue = Long.parseLong(onlyDigits);
                    }
                    projectVO.setPrjctBudget(budgetValue);

                    // (4) 시작일·종료일(숫자만 추출 → YYYYMMDD)
                    String startRaw = dataMap.get("startDateCell"); // "2025-02-20" 등
                    if (startRaw == null) startRaw = "";
                    String startDigits = startRaw.replaceAll("[^0-9]", ""); // "20250220"

                    String endRaw = dataMap.get("endDateCell");
                    if (endRaw == null) endRaw = "";
                    String endDigits = endRaw.replaceAll("[^0-9]", "");   // "20250310"

                    projectVO.setPrjctBgnde(startDigits);
                    projectVO.setPrjctEndde(endDigits);

                    // (5) 위치
                    projectVO.setPrjctLc(dataMap.get("locationCell")) ; 

                    // (6) 진행상태='01'(등록), 진행여부='N'
                    projectVO.setPrjctProgrsSttus("01");
                    projectVO.setPrjctProgrsAt("N");

                    // (7) 실제 INSERT
                    int rowCount = planMapper.insertProject(projectVO);
                    if (rowCount > 0) {
                        log.info("프로젝트 계획 insert 성공");

                        // 자동 생성된 prjctNo를 가져옴
                        int projectNo = projectVO.getPrjctNo();

                        // 공정 정보 삽입
                        insertProjectProcess(projectNo, projectVO.getPrjctCtgry()); // 프로젝트 번호와 카테고리를 넘김
                        return 1;
                    } else {
                        log.error("프로젝트 계획 insert 실패");
                        return 0;
                    }
                } catch (Exception e) {
                    log.error("프로젝트 계획 처리 중 예외", e);
                    return 0;
                }
        }
        return 1;
    }
	
	private void insertProjectProcess(int projectNo, String category) {
	    if (category != null && !category.isEmpty()) {
	        // 카테고리 값에 맞는 GROUP_CODE 찾기
	        String groupCode = planMapper.selectGroupCodeByCategory(category);

	        if (groupCode != null) {
	            // 해당 GROUP_CODE에 맞는 공정 정보 가져오기 (OUTPT_ORDR 오름차순)
	            List<CommonnessCodeVO> commonnessCodes = planMapper.selectCommonnessCodesByGroupCode(groupCode);

	            // 공정 정보 TB_PROCESS 테이블에 INSERT
	            for (int i = 0; i < commonnessCodes.size(); i++) {
	                CommonnessCodeVO code = commonnessCodes.get(i);
	                ProcessVO processVO = new ProcessVO();
	                processVO.setPrjctNo(projectNo);  // 삽입된 프로젝트 번호 사용

	                // 공정 번호는 시퀀스를 사용하여 자동 생성
	                processVO.setProcsNo(0); // 0을 넣으면 시퀀스 사용

	                processVO.setProcsNm(code.getCodeNm());  // 공정명 (CODE_NM 값)
	                processVO.setProcsOrdr(code.getOutptOrdr());  // 공정 순서 (OUTPT_ORDR 값)

	                // 첫 번째 공정은 '01' (기초 품목 신고 필요), 나머지는 '03' (업체 미선정)
	                String initialStatus = (i == 0) ? "01" : "03";  // 첫 번째 공정만 '01'로 설정
	                processVO.setProgrsSttus(initialStatus);  // 공정 상태 설정

	                planMapper.insertProcess(processVO);  // 공정 정보 삽입
	            }
	        }
	    }
	}

	@Override
    public int getTotalDocumentCount(Map<String, Object> params) {
        return documentMapper.getTotalDocumentCount(params);
    }
}