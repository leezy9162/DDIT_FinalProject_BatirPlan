package kr.or.batirplan.electronicdocument.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.batirplan.electronicdocument.service.IElectronicDocumentService;
import kr.or.batirplan.electronicdocument.vo.CorbonCopyVO;
import kr.or.batirplan.electronicdocument.vo.DocumentVO;
import kr.or.batirplan.electronicdocument.vo.FormVO;
import kr.or.batirplan.electronicdocument.vo.SanctionLineVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/batirplan/erp/electronicdocument")
@PreAuthorize("hasRole('ROLE_EMPL')")		// 권한 설정
public class ElectronicDocumentController {

    @Autowired
    private IElectronicDocumentService documentService;

    @GetMapping("/list")
    public String documentList(
            @AuthenticationPrincipal CustomUser loginUser,
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            @RequestParam(value = "sj", required = false) String sj,
            Model model) {
        
        // 1. 페이지 사이즈 및 오프셋 계산
        int pageSize = 10;
        int offset = (currentPage - 1) * pageSize;
        
        // 2. 검색 조건과 페이지네이션 정보 파라미터 설정
        Map<String, Object> params = new HashMap<>();
        params.put("sj", sj);
        params.put("myEmplCode", loginUser.getMemberVO().getEmpVO().getEmplCode());
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        
        // 3. 전체 레코드 수 조회 (검색 조건 포함)
        int totalRecord = documentService.getTotalDocumentCount(params);
        
        // 4. 현재 페이지에 해당하는 목록 데이터 조회
        List<DocumentVO> documentList = documentService.selectDocumentList(params);
        
        // 5. 전체 페이지 수 계산
        int totalPage = (int) Math.ceil(totalRecord / (double) pageSize);
        
        // 6. 모델에 데이터 담기
        model.addAttribute("documentList", documentList);
        model.addAttribute("sj", sj);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("totalRecord", totalRecord);
        
        return "electronicdocument/documentList";
    }
    
    @GetMapping("/create")
    public String documentFormList(Model model) {
    	List<FormVO> formList = documentService.getAllDocumentForms();
    	model.addAttribute("formList", formList);
    	
    	return "electronicdocument/documentFormList";
    }
    
    @GetMapping("/createForm")
    public String documentWriteForm(@RequestParam("formNo") int formNo, Model model) {
    	FormVO form = documentService.getDocumentWriteForm(formNo);
    	
    	DocumentVO document = new DocumentVO();
    	document.setFormNo(form.getFormNo());
    	document.setSj(form.getFormNm());
    	
    	String currentDate = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        document.setDrftDe(currentDate);
        document.setTmlmtDe(null);
        
        String todayDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    	
    	model.addAttribute("document", document);
    	model.addAttribute("form", form);
    	model.addAttribute("todayDate", todayDate);
    	
    	return "electronicdocument/documentWriteForm";
    }
    
    @GetMapping("/approverList")
    public String getApproverList(Model model) {
        List<EmployeeVO> employeeList = documentService.getAllEmployees();
        model.addAttribute("employeeList", employeeList);
        
        return "electronicdocument/approverSelect";
    }
    
    @GetMapping("/employeeList")
    public String employeeList(@AuthenticationPrincipal CustomUser loginUser, Model model) {
        List<EmployeeVO> employeeList = documentService.getAllEmployees();
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("employeeList", employeeList);

        return "electronicdocument/employeeList";
    }
    
    @GetMapping("/referenceList")
    public String getReferenceList(@AuthenticationPrincipal CustomUser loginUser, Model model) {
        List<EmployeeVO> employeeList = documentService.getAllEmployees();
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("employeeList", employeeList);
        
        return "electronicdocument/referenceSelect";
    }
    
    @PostMapping("/create")
    public String createDocument(@AuthenticationPrincipal CustomUser loginUser, DocumentVO documentVO, Model model) {
    	documentVO.setDrafter(loginUser.getMemberVO().getEmpVO().getEmplCode());
    	documentVO.setSttus("02");
    	
    	int docNo = documentService.createDocument(documentVO);
    	
    	if(docNo > 0) {
            String approverCodes = documentVO.getApproverCodes();
            if(approverCodes != null && !approverCodes.trim().isEmpty()){
                String[] approvers = approverCodes.split("-");
                int order = 1;
                for(String approver : approvers) {
                    documentService.insertSanctionLine(docNo, approver.trim(), order++);
                }
            }
            
            String referenceCodes = documentVO.getReferenceCodes();
            if(referenceCodes != null && !referenceCodes.trim().isEmpty()){
                String[] references = referenceCodes.split(", ");
                for(String ref : references) {
                    documentService.insertCorbonCopy(docNo, ref.trim());
                }
            }
            
            model.addAttribute("message", "문서 기안이 완료되었습니다.");
        } else {
            model.addAttribute("message", "문서 기안 처리 중 오류가 발생했습니다.");
        }
    	
        return "redirect:/batirplan/erp/electronicdocument/list";
    }
    
    @GetMapping("/detail")
    public String documentDetail(@RequestParam("docNo") int docNo,
                                 @AuthenticationPrincipal CustomUser loginUser,
                                 Model model) {
    	
        DocumentVO document = documentService.getDocumentDetail(docNo);

        List<SanctionLineVO> sanctionLines = documentService.getSanctionLinesWithPrevInfo(docNo);
        List<CorbonCopyVO> corbonCopies = documentService.getCorbonCopies(docNo);
        
        String content = document.getBdtCn();
        if (content != null) {
            String pattern = "(?i)(<p>(?:\\s|&nbsp;|<br\\s*/?>)*</p>\\s*){1,2}$";
            content = content.replaceAll(pattern, "");
            document.setBdtCn(content);
        }

        model.addAttribute("document", document);
        model.addAttribute("sanctionLines", sanctionLines);
        model.addAttribute("corbonCopies", corbonCopies);
        model.addAttribute("bdtCn", document.getBdtCn());
        model.addAttribute("loginUser", loginUser); 

        return "electronicdocument/documentDetail";
    }
    
    @PostMapping("/draft")
    public String saveDraft(@AuthenticationPrincipal CustomUser loginUser, DocumentVO documentVO, Model model) {
        documentVO.setDrafter(loginUser.getMemberVO().getEmpVO().getEmplCode());
        documentVO.setSttus("01");

        int docNo = 0;
        if (documentVO.getDocNo() == 0) {
            docNo = documentService.createDocument(documentVO);
        } else {
            docNo = documentService.updateDocument(documentVO);
        }

        if (docNo > 0) {
        	documentService.deleteSanctionLines(docNo); 
            documentService.deleteCorbonCopies(docNo);
            
            String approverCodes = documentVO.getApproverCodes();
            if(approverCodes != null && !approverCodes.trim().isEmpty()) {
                String[] approvers = approverCodes.split("-");
                int order = 1;
                for(String approver : approvers) {
                    documentService.insertSanctionLine(docNo, approver.trim(), order++);
                }
            }
            
            String referenceCodes = documentVO.getReferenceCodes();
            if(referenceCodes != null && !referenceCodes.trim().isEmpty()) {
                String[] references = referenceCodes.split(", ");
                for(String ref : references) {
                    documentService.insertCorbonCopy(docNo, ref.trim());
                }
            }

            model.addAttribute("message", "임시저장이 완료되었습니다.");
        } else {
            model.addAttribute("message", "임시저장 처리 중 오류가 발생했습니다.");
        }

        return "redirect:/batirplan/erp/electronicdocument/list";
    }
    
    @GetMapping("/editModal")
    public String editDocumentModal(@RequestParam("docNo") int docNo, Model model) {
        DocumentVO document = documentService.getDocumentDetail(docNo);
        
        if (!("01".equals(document.getSttus()) || "03".equals(document.getSttus()))) {
            return "redirect:/batirplan/erp/electronicdocument/detail?docNo=" + docNo;
        }
        
        List<SanctionLineVO> sanctionLines = documentService.getSanctionLines(docNo);
        List<CorbonCopyVO> corbonCopies = documentService.getCorbonCopies(docNo);
        List<String> nameList = new ArrayList<>();
        List<String> codeList = new ArrayList<>();
        
        for (SanctionLineVO line : sanctionLines) {
            nameList.add(line.getSanctnerName());
            codeList.add(line.getSanctner());
        }
        
        String joinedNames = String.join("-", nameList);
        String joinedCodes = String.join("-", codeList);
        String todayDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
        
        String referenceNames = corbonCopies.stream()
            .map(CorbonCopyVO::getEmplName)
            .collect(Collectors.joining(", "));

        String referenceCodes = corbonCopies.stream()
            .map(CorbonCopyVO::getEmplCode)
            .collect(Collectors.joining(", "));
        
        String content = document.getBdtCn();
        if (content != null) {
            String pattern = "(?i)(<p>(?:\\s|&nbsp;|<br\\s*/?>)*</p>\\s*){1,2}$";
            content = content.replaceAll(pattern, "");
            document.setBdtCn(content);
        }

        document.setExistingApproverNames(joinedNames);
        document.setExistingApproverCodes(joinedCodes);
        document.setExistingReferenceNames(referenceNames);
        document.setExistingReferenceCodes(referenceCodes);

        model.addAttribute("document", document);
        model.addAttribute("todayDate", todayDate);

        return "electronicdocument/documentWriteForm";
    }
    
    @PostMapping("/submit")
    public String submitDocument(@AuthenticationPrincipal CustomUser loginUser,
                                 DocumentVO documentVO,
                                 Model model) {
    	
        documentVO.setSttus("02"); 
        documentVO.setDrafter(loginUser.getMemberVO().getEmpVO().getEmplCode());

        int docNo;
        
        if (documentVO.getDocNo() == 0) {
            docNo = documentService.createDocument(documentVO);
        } else {
            docNo = documentService.updateDocument(documentVO);
        }

        if (docNo > 0) {
            documentService.deleteSanctionLines(docNo);
            documentService.deleteCorbonCopies(docNo);

            String approverCodes = documentVO.getApproverCodes();
            if (approverCodes != null && !approverCodes.trim().isEmpty()) {
                String[] approvers = approverCodes.split("-");
                int order = 1;
                for (String approver : approvers) {
                    documentService.insertSanctionLine(docNo, approver.trim(), order++);
                }
            }

            String referenceCodes = documentVO.getReferenceCodes();
            if (referenceCodes != null && !referenceCodes.trim().isEmpty()) {
                String[] refs = referenceCodes.split(", ");
                for (String ref : refs) {
                    documentService.insertCorbonCopy(docNo, ref.trim());
                }
            }

            model.addAttribute("message", "기안서가 제출이 완료되었습니다.");
        } else {
            model.addAttribute("message", "기안서 제출 처리 중 오류가 발생했습니다.");
        }

        return "redirect:/batirplan/erp/electronicdocument/list";
    }
    
    @GetMapping("/stampRegistration")
    public String stampRegistration(@AuthenticationPrincipal CustomUser loginUser, Model model) {
        String emplCode = loginUser.getMemberVO().getEmpVO().getEmplCode();
        
        String approvalStamp = documentService.selectStampUrl(emplCode);
        
        model.addAttribute("stampUrl", approvalStamp);
        
        return "electronicdocument/stampRegistration"; 
    }
    
    @PostMapping("/uploadStamp")
    public ResponseEntity<String> uploadStamp(@RequestParam("stampImage") MultipartFile stampImage,
                                              @AuthenticationPrincipal CustomUser loginUser) {
        try {
            String emplCode = loginUser.getMemberVO().getEmpVO().getEmplCode();
            String approvalStamp = documentService.uploadStampImage(emplCode, stampImage);
            return ResponseEntity.ok("도장 등록이 완료되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("도장 등록 중 오류가 발생했습니다.");
        }
    }
    
    @ResponseBody
    @PostMapping("/deleteStamp")
    public ResponseEntity<String> deleteStamp(@AuthenticationPrincipal CustomUser loginUser) {
        try {
            String emplCode = loginUser.getMemberVO().getEmpVO().getEmplCode();
            boolean success = documentService.deleteStampImage(emplCode);
            
            if (success) {
                return ResponseEntity.ok("도장 삭제가 완료되었습니다.");
            } else {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                     .body("도장 삭제 중 오류가 발생했습니다.(DB 반영 안 됨)");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("도장 삭제 중 예외가 발생했습니다.");
        }
    }
    
    @ResponseBody
    @PostMapping("/approveAjax")
    public Map<String, Object> approveAjax(@AuthenticationPrincipal CustomUser loginUser,
    									   @RequestParam("docNo") int docNo,
    									   @RequestParam("sanctnLineNo") int sanctnLineNo) {
        
    	String emplCode = loginUser.getMemberVO().getEmpVO().getEmplCode();

        boolean success = documentService.approveSanction(docNo, sanctnLineNo, emplCode);

        Map<String, Object> result = new HashMap<>();

        if (!success) {
            result.put("success", false);
            result.put("message", "결재 처리 중 오류가 발생했습니다.(권한 없음 or 이미 결재됨)");
            return result;
        }

        result.put("success", true);
        result.put("message", "결재 처리가 완료되었습니다.");

        DocumentVO updatedDoc = documentService.getDocumentDetail(docNo);
        List<SanctionLineVO> updatedLines = documentService.getSanctionLinesWithPrevInfo(docNo);
        List<CorbonCopyVO> updatedRefs = documentService.getCorbonCopies(docNo);

        result.put("document", updatedDoc);
        result.put("sanctionLines", updatedLines);
        result.put("corbonCopies", updatedRefs);

        return result; 
    }
    
    @ResponseBody
    @PostMapping("/reject")
    public Map<String, Object> rejectDocument(@RequestParam("docNo") int docNo,
    										  @RequestParam("sanctnLineNo") int sanctnLineNo,
    										  @RequestParam("returnResn") String returnResn,
    										  @AuthenticationPrincipal CustomUser loginUser) {
        
    	Map<String, Object> result = new HashMap<>();
        
        try {
            String emplCode = loginUser.getMemberVO().getEmpVO().getEmplCode();
            
            documentService.rejectDocument(docNo, sanctnLineNo, emplCode, returnResn);
            
            result.put("success", true);
            result.put("message", "반려 처리가 완료되었습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "반려 처리 중 오류 : " + e.getMessage());
        }
        return result;
    }
    
    @PostMapping("/updateRejectedDocument")
    public String updateRejectedDocument(@ModelAttribute("document") DocumentVO document,
    									 @RequestParam("approverCodes") String approverCodes,
    									 @RequestParam("referenceCodes") String referenceCodes,
    									 @RequestParam("actionType") String actionType) {
        
    	DocumentVO originalDoc = documentService.getDocumentDetail(document.getDocNo());
        
        if (!"03".equals(originalDoc.getSttus())) {
            return "redirect:/batirplan/erp/electronicdocument/detail?docNo=" + document.getDocNo();
        }

        List<String> approverList = new ArrayList<>();
        if (approverCodes != null && !approverCodes.isBlank()) {
            approverList = Arrays.asList(approverCodes.split("-"));
        }

        List<String> referenceList = new ArrayList<>();
        if (referenceCodes != null && !referenceCodes.isBlank()) {
            referenceList = Arrays.asList(referenceCodes.split(",\\s*"));
        }

        if ("submit".equalsIgnoreCase(actionType)) {
            document.setSttus("02");
        } else {
            document.setSttus("01");
        }

        documentService.updateRejectedDocument(document, approverList, referenceList);

        return "redirect:/batirplan/erp/electronicdocument/list";
    }
    
    @ResponseBody
    @PostMapping("/finalApproval")
    public Map<String, Object> finalApproval(@RequestParam("docNo") int docNo, @AuthenticationPrincipal CustomUser loginUser) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String emplCode = loginUser.getMemberVO().getEmpVO().getEmplCode();
            String clsfCode = loginUser.getMemberVO().getEmpVO().getClsfCode();
            
            if (!("05".equals(clsfCode) || "06".equals(clsfCode) || "07".equals(clsfCode) || "08".equals(clsfCode))) {
                result.put("success", false);
                result.put("message", "전결 처리가 가능한 직급이 아닙니다.");
                return result;
            }

            boolean success = documentService.finalApproval(docNo, emplCode);
            
            if (success) {
                result.put("success", true);
                result.put("message", "전결 처리가 완료되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "전결 처리 중 오류가 발생했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "전결 처리 중 오류 : " + e.getMessage());
        }
        return result;
    }
}