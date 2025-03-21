package kr.or.batirplan.project.projectplan.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.project.projectmanage.vo.ProcessVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.project.projectplan.mapper.IProjectPlanMapper;
import kr.or.batirplan.project.projectplan.vo.BidVO;
import kr.or.batirplan.project.projectplan.vo.CheckListVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationProductVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationVO;
import kr.or.batirplan.project.projectplan.vo.PriceQuotationVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectPlanServiceImpl implements IProjectPlanService {
	
	@Autowired
	private IProjectPlanMapper planMapper;
	
	@Override
	public List<ProjectVO> getProjectList(Map<String, Object> params) {
		return planMapper.getProjectList(params);
	}

	@Override
	public ProjectVO getProjectDetail(int prjctNo) {
		return planMapper.getProjectDetail(prjctNo);
	}

	@Override
	public String getEmployeeNameByCode(String charger) {
		return planMapper.getEmployeeNameByCode(charger);
	}

	@Override
	public EmployeeVO getEmployeeByCode(String sptMngr) {
		return planMapper.getEmployeeByCode(sptMngr);
	}
	
	@Override
	public List<ProcessVO> getProcessListByProject(int prjctNo) {
		return planMapper.getProcessListByProject(prjctNo);
	}

	@Override
	public boolean updateSiteManager(String emplCode, String emplName, int prjctNo) {
	    try {
	        // 매퍼에서 담당자 업데이트 메서드 호출
	        planMapper.updateSiteManager(emplCode, emplName, prjctNo);
	        return true;
	    } catch (Exception e) {
	        log.error("담당자 업데이트 실패", e);
	        return false;  // 실패 시 false 반환
	    }
	}

	@Override
	public boolean deleteSiteManager(String emplCode, int prjctNo) {
	    try {
	        planMapper.deleteSiteManager(emplCode, prjctNo);  // 매퍼에서 삭제 메서드 호출
	        return true;
	    } catch (Exception e) {
	        log.error("담당자 삭제 실패", e);
	        return false;  // 실패 시 false 반환
	    }
	}

	@Override
	public void updateProcessStatus(int procsNo, String progrsSttus) {
	    planMapper.updateProcessStatus(procsNo, progrsSttus);
	    
	    // 현재 업데이트한 공정 정보를 조회해서 프로젝트 번호를 가져옴
	    ProcessVO process = planMapper.getProcessByNo(procsNo);
	    if (process != null) {
	        checkAndUpdateProjectPlanStatus(process.getPrjctNo());
	    }
	}

	@Override
	public EmployeeVO getEmployeeDetails(String emplCode) {
	    return planMapper.getEmployeeDetails(emplCode);  // planMapper를 통해 사원 정보 조회
	}

	@Override
	public List<DeclarationVO> getDeclarationList() {
		return planMapper.getDeclarationList();
	}

	@Override
    public int insertDeclaration(int prjctNo, String dclrtSj, int totalAmount) {
        try {
            planMapper.insertDeclaration(prjctNo, dclrtSj, totalAmount);
            return planMapper.getLastInsertedDeclarationNo(); // 최근에 삽입된 신고서 번호 반환
        } catch (Exception e) {
            log.error("신고서 INSERT 오류", e);
            throw new RuntimeException("신고서 등록 실패");
        }
    }
	
	@Transactional
	@Override
    public void insertDeclarationProductList(int declarationNo, List<Integer> selectedProductIds, List<Integer> quantities) {
        try {
            for (int i = 0; i < selectedProductIds.size(); i++) {
                int prdlstNo = selectedProductIds.get(i);
                int qty = quantities.get(i);
                Map<String, Object> paramMap = new HashMap<>();
                paramMap.put("declarationNo", declarationNo);
                paramMap.put("prdlstNo", prdlstNo);
                paramMap.put("qty", qty);
                planMapper.insertDeclarationProduct(declarationNo, prdlstNo, qty); // 품목과 수량 insert
            }
        } catch (Exception e) {
            log.error("품목 INSERT 오류", e);
            throw new RuntimeException("품목 등록 실패");
        }
    }

	@Override
	public int getFirstProcessNo(int prjctNo) {
		return planMapper.getFirstProcessNo(prjctNo);
	}

	@Override
	public boolean updateProjectPlanStatus(int prjctNo, String planStatus) {
	    try {
	        planMapper.updateProjectPlanStatus(prjctNo, planStatus);  // 매퍼를 통해 DB 업데이트
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	public DeclarationVO getDeclarationDetail(int dclrtNo) {
		return planMapper.getDeclarationDetail(dclrtNo);
	}

	@Override
	public List<DeclarationProductVO> getDeclarationProductList(int dclrtNo) {
		return planMapper.getDeclarationProductList(dclrtNo);
	}

	@Override
    public DeclarationVO getDeclarationForProject(int prjctNo) {
		return planMapper.getDeclarationForProject(prjctNo);
    }

	@Override
	public List<BidVO> getBidList() {
		return planMapper.getBidList();
	}

	@Override
	public boolean insertBid(BidVO bid) {
		try {
            planMapper.insertBid(bid);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

	@Override
	public BidVO getBidDetail(int pblancNo) {
		return planMapper.getBidDetail(pblancNo);
	}

	@Override
	public List<BidVO> getBidForProject(int prjctNo) {
		return planMapper.getBidForProject(prjctNo);
	}
	
	@Override
	public BidVO getBidForProcess(int procsNo) {
	    return planMapper.getBidForProcess(procsNo);
	}

	@Override
	public List<PriceQuotationVO> getQuotationList(int pblancNo) {
		return planMapper.getQuotationList(pblancNo);
	}

	@Override
	public PriceQuotationVO getQuotationDetail(int prqudoNo) {
		return planMapper.getQuotationDetail(prqudoNo);
	}

	@Override
	public boolean isQuotationApproved(int pblancNo) {
	    // 입찰 공고에 승인된 견적서가 있는지 확인
	    int count = planMapper.getApprovedQuotationCount(pblancNo);
	    return count > 0; // 0보다 크면 승인된 견적서가 존재함
	}

	@Transactional
	@Override
	public boolean approveQuotation(int prqudoNo) {
	    try {
	        PriceQuotationVO quotation = planMapper.getQuotationDetail(prqudoNo);
	        if (quotation != null) {
	            int pblancNo = quotation.getPblancNo();
	            if (isQuotationApproved(pblancNo)) {
	                return false;
	            }
	        }
	        
	        // 견적서 승인 처리
	        boolean approved = planMapper.approveQuotation(prqudoNo);
	        if (!approved) {
	            return false;
	        }
	        
	        
			/*범준이 작업공간*/
	        /* 🔥 [수정된 위치] 견적서 승인 후, 협력업체 자동 등록 */
	        String bizrno = quotation.getBizrno();
	        int existingCompanyCount = planMapper.checkCooperationCompanyByBizrno(bizrno);
	        String cooperationCode;

	        // 5. 협력업체가 없으면 자동 등록
	        if (existingCompanyCount == 0) {
	            // 협력업체 코드 자동 생성
	            cooperationCode = planMapper.generateCooperationCompanyCode();

	            // 협력업체 등록을 위한 데이터 매핑
	            Map<String, Object> cooperationData = new HashMap<>();
	            cooperationData.put("ccpyCode", cooperationCode);
	            cooperationData.put("ccpyNm", quotation.getCmpnyNm());
	            cooperationData.put("bizrno", quotation.getBizrno());
	            cooperationData.put("charger", "22010004"); // 하드코딩된 담당자 사원코드
	            cooperationData.put("ccpyTelno", quotation.getCmpnyTelno());
	            cooperationData.put("ccpyEmail", "qwer1234@gmail.com");
	            cooperationData.put("ccpyAdres", "서울 가로수길");
	            cooperationData.put("ccpyDetailAdres", "1233번길");
	            cooperationData.put("ccpyCl", "02");
	            cooperationData.put("mberId", null);
	            cooperationData.put("bankCode", null);
	            cooperationData.put("acnutno", null);

	            // 협력업체 정보 등록
	            planMapper.insertCooperationCompany(cooperationData);
	            log.info("새로운 협력업체 등록 완료: " + cooperationCode);
	        } else {
	            // 기존 협력업체 코드 가져오기
	            cooperationCode = planMapper.getCooperationCompanyCodeByBizrno(bizrno);
	            log.info("협력업체가 이미 존재함: 사업자번호 " + bizrno + ", 협력업체 코드: " + cooperationCode);
	        }

	        /* 🔥 3️⃣ [추가] 공정 테이블(TB_PROCESS)에 협력업체 코드 업데이트 */
	        if (cooperationCode != null) {
	            Integer procsNo = planMapper.getProcessNoByPblancNo(quotation.getPblancNo());
	            if (procsNo != null) {
	                Map<String, Object> params = new HashMap<>();
	                params.put("procsNo", procsNo);
	                params.put("ccpyCode", cooperationCode);

	                planMapper.updateProcessWithCooperationCompany(params);
	                log.info("공정 테이블 업데이트 완료! procsNo: " + procsNo + ", 협력업체 코드: " + cooperationCode);
	            } else {
	                log.warn("공정 번호를 찾을 수 없습니다. pblancNo: " + quotation.getPblancNo());
	            }
	        }

	       
	        
	        /*범준이 작업공간*/
	        
	        
	        // 승인 후 다시 견적서 정보 조회
	        PriceQuotationVO updatedQuotation = planMapper.getQuotationDetail(prqudoNo);
	        if (updatedQuotation != null) {
	            int pblancNo = updatedQuotation.getPblancNo();
	            BidVO bid = planMapper.getBidDetail(pblancNo);
	            if (bid != null) {
	                log.info("Updating process status for procsNo: " + bid.getProcsNo());
	                // planMapper.updateProcessStatus(bid.getProcsNo(), "05");
	                // 대신 서비스의 updateProcessStatus 메서드를 호출합니다.
	                updateProcessStatus(bid.getProcsNo(), "05");
	            } else {
	                log.error("입찰 공고 정보를 찾을 수 없습니다. pblancNo: " + pblancNo);
	            }
	        }
	        return true;
	    } catch (Exception e) {
	        log.error("견적서 승인 처리 중 오류 발생", e);
	        return false;
	    }
	}

	@Override
	public PriceQuotationVO getApprovedQuotation(int pblancNo) {
	    return planMapper.getApprovedQuotation(pblancNo);
	}
	
	private void checkAndUpdateProjectPlanStatus(int prjctNo) {
	    // 해당 프로젝트의 모든 공정 조회
	    List<ProcessVO> processList = planMapper.getProcessListByProject(prjctNo);
	    // 만약 프로젝트에 2개 이상의 공정이 없으면(첫 번째 공정 외 다른 공정이 없으면) 업데이트하지 않음.
	    if (processList == null || processList.size() < 2) {
	        return;
	    }
	    
	    // 첫 번째 공정(프로세스 순서가 1인 공정) 찾기
	    ProcessVO firstProcess = null;
	    for (ProcessVO process : processList) {
	        if (process.getProcsOrdr() == 1) {
	            firstProcess = process;
	            break;
	        }
	    }
	    // 첫 번째 공정이 없거나 상태가 "02"가 아니면 업데이트하지 않음.
	    if (firstProcess == null || !"02".equals(firstProcess.getProgrsSttus())) {
	        return;
	    }
	    
	    // 나머지 공정들이 모두 "05"인지 확인
	    boolean allOthersApproved = true;
	    for (ProcessVO process : processList) {
	        if (process.getProcsOrdr() != 1 && !"05".equals(process.getProgrsSttus())) {
	            allOthersApproved = false;
	            break;
	        }
	    }
	    
	    // 조건 충족 시 프로젝트의 PLAN_STTUS를 "02"로 업데이트
	    if (allOthersApproved) {
	        planMapper.updateProjectPlanStatus(prjctNo, "02");
	    }
	}

	@Override
	public boolean updateProcessDetails(int procsNo, String procsCn, String procsBgndeStr, String procsEnddeStr) {
	    try {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Date procsBgnde = sdf.parse(procsBgndeStr);
	        Date procsEndde = sdf.parse(procsEnddeStr);

		     ProcessVO process = new ProcessVO();
		     process.setProcsNo(procsNo);
		     process.setProcsCn(procsCn);
		     process.setProcsBgnde(procsBgnde);
		     process.setProcsEndde(procsEndde);
	
		     planMapper.updateProcessDetails(process);
	        return true;
	    } catch (ParseException e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Transactional
	@Override
	public boolean saveSafetyChecklist(CheckListVO checkList, List<String> detailItems) {
	    try {
	        // 1. 안전 체크리스트 저장 (insertSafetyChecklist)
	        planMapper.insertSafetyChecklist(checkList);
	        // selectKey를 통해 checkList.chklstNo가 세팅됨

	        // 2. detailItems 리스트 순회하여 각 항목 저장
	        for (String item : detailItems) {
	            if(item.trim().isEmpty()) continue;
	            planMapper.insertSafetyCheckDetailItem(checkList.getChklstNo(), item.trim());
	        }
	        return true;
	    } catch(Exception e) {
	        log.error("안전 체크리스트 저장 오류", e);
	        throw new RuntimeException("체크리스트 등록 실패");
	    }
	}

	@Override
	public List<CheckListVO> getSafetyChecklistList(String emplCode) {
		return planMapper.getSafetyChecklistList(emplCode);
	}

	@Override
	public CheckListVO getSafetyChecklistDetail(int chklstNo) {
	    return planMapper.getSafetyChecklistDetail(chklstNo);
	}

	@Override
	public List<String> getSafetyChecklistDetailItems(int chklstNo) {
	    return planMapper.getSafetyChecklistDetailItems(chklstNo);
	}

	@Transactional
	@Override
	public boolean assignChecklistToProcess(int procsNo, int chklstNo, int prjctNo) {
	    try {
	        // 1. 이미 배정된 체크리스트가 있는지 확인
	        Map<String, Object> param = new HashMap<>();
	        param.put("procsNo", procsNo);
	        param.put("prjctNo", prjctNo);
	        Integer existingAssignmentId = planMapper.selectProcessChecklistId(param);

	        // 2. 새 체크리스트의 세부 항목들 조회
	        List<String> detailItems = planMapper.getChecklistDetailItems(chklstNo);

	        if (existingAssignmentId != null) {
	            // 이미 배정된 경우: 기존 레코드 업데이트
	            Map<String, Object> updateMap = new HashMap<>();
	            updateMap.put("procsChklstNo", existingAssignmentId);
	            updateMap.put("chklstNo", chklstNo);
	            planMapper.updateProcessChecklist(updateMap);

	            // 기존 배정 세부 항목 삭제
	            planMapper.deleteProcessChecklistDetails(existingAssignmentId);

	            // 새로운 세부 항목 삽입
	            for (String detailItem : detailItems) {
	                Map<String, Object> detailMap = new HashMap<>();
	                detailMap.put("procsChklstNo", existingAssignmentId);
	                detailMap.put("procsNo", procsNo);
	                detailMap.put("prjctNo", prjctNo);
	                detailMap.put("detailItem", detailItem);
	                planMapper.insertProcessChecklistDetail(detailMap);
	            }
	        } else {
	            // 배정 내역이 없으면 신규 삽입 처리
	            Map<String, Object> newAssignmentMap = new HashMap<>();
	            newAssignmentMap.put("procsNo", procsNo);
	            newAssignmentMap.put("chklstNo", chklstNo);
	            newAssignmentMap.put("prjctNo", prjctNo);
	            
	            planMapper.insertProcessChecklist(newAssignmentMap);
	            
	            Integer procsChklstNo = (Integer) newAssignmentMap.get("procsChklstNo");
	            if (procsChklstNo == null) {
	                throw new RuntimeException("배정 테이블 PK 생성 실패");
	            }
	            
	            for (String detailItem : detailItems) {
	                Map<String, Object> detailMap = new HashMap<>();
	                detailMap.put("procsChklstNo", procsChklstNo);
	                detailMap.put("procsNo", procsNo);
	                detailMap.put("prjctNo", prjctNo);
	                detailMap.put("detailItem", detailItem);
	                planMapper.insertProcessChecklistDetail(detailMap);
	            }
	        }
	        
	        // 체크리스트 배정 작업 완료 후 모든 공정에 배정되었는지 확인
	        checkAndUpdateProjectPlanStatusForChecklist(prjctNo);
	        
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	@Override
	public Map<Integer, Integer> getAssignedChecklistMapping(int prjctNo) {
	    List<Map<String, Object>> list = planMapper.getAssignedChecklistMapping(prjctNo);
	    Map<Integer, Integer> mapping = new HashMap<>();
	    for (Map<String, Object> row : list) {
	        // 대문자로 키를 가져오기
	        Object procsNoObj = row.get("PROCSNO");
	        Object chklstNoObj = row.get("CHKLSTNO");
	        if (procsNoObj != null && chklstNoObj != null) {
	            Integer procsNo = Integer.valueOf(procsNoObj.toString());
	            Integer chklstNo = Integer.valueOf(chklstNoObj.toString());
	            mapping.put(procsNo, chklstNo);
	        }
	    }
	    return mapping;
	}

	@Override
	@Transactional
	public boolean deleteAssignedChecklistMapping(int prjctNo, int procsNo) {
	    try {
	        // 배정된 레코드를 찾기 위해 먼저 select (selectProcessChecklistId 메서드를 재사용)
	        Map<String, Object> param = new HashMap<>();
	        param.put("procsNo", procsNo);
	        param.put("prjctNo", prjctNo);
	        Integer assignmentId = planMapper.selectProcessChecklistId(param);
	        if (assignmentId != null) {
	            // TB_PROCESS_SAFETY_CHECK_LIST_DETAIL의 관련 세부 항목 삭제
	            planMapper.deleteProcessChecklistDetails(assignmentId);
	            // TB_PROCESS_SAFETY_CHECK_LIST 레코드 삭제 (삭제 쿼리를 추가해야 함)
	            planMapper.deleteProcessChecklist(assignmentId);
	            return true;
	        }
	        return false; // 없으면 false 반환
	    } catch(Exception e) {
	        log.error("배정 삭제 실패", e);
	        return false;
	    }
	}
	
	// 모든 공정에 대해 체크리스트 배정 여부를 확인하고, 모두 배정되어 있다면 PLAN_STTUS를 "03"으로 업데이트하는 메서드
	private void checkAndUpdateProjectPlanStatusForChecklist(int prjctNo) {
	    // 해당 프로젝트의 모든 공정 조회
	    List<ProcessVO> processes = planMapper.getProcessListByProject(prjctNo);
	    // 각 공정에 배정된 체크리스트 번호를 조회 (key: 공정 번호, value: 체크리스트 번호)
	    Map<Integer, Integer> assignedMap = getAssignedChecklistMapping(prjctNo);
	    boolean allAssigned = true;
	    
	    for (ProcessVO process : processes) {
	        // 만약 어떤 공정에 대해서도 체크리스트가 배정되지 않았다면
	        if (!assignedMap.containsKey(process.getProcsNo())) {
	            allAssigned = false;
	            break;
	        }
	    }
	    // 모든 공정에 체크리스트가 배정되어 있으면 상태 업데이트
	    if (allAssigned) {
	        // PLAN_STTUS를 "03"으로 업데이트
	        planMapper.updateProjectPlanStatus(prjctNo, "03");
	        log.info("모든 공정에 체크리스트 배정 완료. 프로젝트 상태를 03으로 업데이트 하였습니다. prjctNo: " + prjctNo);
	        
	        // PRJCT_PROGRS_STTUS를 "02"로 업데이트 (추가)
	        boolean progressUpdated = updateProjectProgressStatus(prjctNo, "02");
	        if (progressUpdated) {
	            log.info("프로젝트 진행 상태를 02로 업데이트 하였습니다. prjctNo: " + prjctNo);
	        } else {
	            log.error("프로젝트 진행 상태 업데이트 실패, prjctNo: " + prjctNo);
	        }
	    }
	}
	
	@Override
	public boolean updateProjectProgressStatus(int prjctNo, String progressStatus) {
	    try {
	        Map<String, Object> param = new HashMap<>();
	        param.put("prjctNo", prjctNo);
	        param.put("progressStatus", progressStatus);
	        planMapper.updateProjectProgressStatus(param);
	        return true;
	    } catch (Exception e) {
	        log.error("프로젝트 진행 상태 업데이트 실패", e);
	        return false;
	    }
	}

	@Override
	public int getProjectTotalCount(Map<String, Object> params) {
		return planMapper.getProjectTotalCount(params);
	}
}