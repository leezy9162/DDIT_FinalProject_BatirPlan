package kr.or.batirplan.project.projectplan.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.batirplan.electronicdocument.service.IElectronicDocumentService;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.hrcard.service.HrCardService;
import kr.or.batirplan.project.projectmanage.vo.ProcessVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.project.projectplan.service.IProjectPlanService;
import kr.or.batirplan.project.projectplan.vo.BidVO;
import kr.or.batirplan.project.projectplan.vo.CheckListVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationProductVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationVO;
import kr.or.batirplan.project.projectplan.vo.PriceQuotationVO;
import kr.or.batirplan.resrce.product.service.PrdlstService;
import kr.or.batirplan.resrce.product.vo.PrdlstCtgryVO;
import kr.or.batirplan.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/batirplan/project")
@PreAuthorize("hasRole('ROLE_DEPT_BILDNGPLANNG')")		// 권한 설정
public class ProjectPlanController {

	@Autowired
	private IProjectPlanService planService;
	
	@Autowired
	private IElectronicDocumentService documentService;
	
	@Autowired
	private HrCardService hrCardService;
	
	@Autowired
	private PrdlstService prdlstService;
	
	@GetMapping("/projectpm/list")
	public String projectList(
	        @RequestParam(value="page", defaultValue="1") int currentPage,
	        @RequestParam(value="search", required=false) String search,
	        Model model) {
	    try {
	        // 1. 페이지 사이즈 및 오프셋 계산 (예: 한 페이지에 10건)
	        int pageSize = 10;
	        int offset = (currentPage - 1) * pageSize;
	        
	        // 2. 검색 및 페이징 조건 파라미터 설정 (필요 시 다른 조건도 추가)
	        Map<String, Object> params = new HashMap<>();
	        params.put("search", search);  // 검색어 조건 (예: 프로젝트명)
	        params.put("offset", offset);
	        params.put("pageSize", pageSize);
	        
	        // 3. 전체 레코드 수 조회 (검색 조건 포함)
	        int totalRecord = planService.getProjectTotalCount(params);
	        
	        // 4. 현재 페이지에 해당하는 목록 데이터 조회 (페이징 적용)
	        List<ProjectVO> projects = planService.getProjectList(params);
	        
	        // 5. 담당자 이름 셋팅 (기존 로직)
	        for (ProjectVO project : projects) {
	            String employeeName = planService.getEmployeeNameByCode(project.getCharger());
	            project.setCharger(employeeName);
	        }
	        
	        // 6. 전체 페이지 수 계산
	        int totalPage = (int) Math.ceil(totalRecord / (double) pageSize);
	        
	        // 7. 모델에 데이터 담기
	        model.addAttribute("projects", projects);
	        model.addAttribute("currentPage", currentPage);
	        model.addAttribute("totalPage", totalPage);
	        model.addAttribute("totalRecord", totalRecord);
	        model.addAttribute("search", search);
	    } catch (Exception e) {
	        log.error("프로젝트 목록 조회 중 오류 발생", e);
	        model.addAttribute("error", "프로젝트 목록 조회 실패");
	    }
	    return "project/projectList";
	}
	
	@GetMapping("/projectpm/detail/{prjctNo}")
    public String projectDetail(@PathVariable("prjctNo") int prjctNo, Model model) {
        try {
            ProjectVO project = planService.getProjectDetail(prjctNo);  // 상세 프로젝트 정보 조회
            
            String employeeName = planService.getEmployeeNameByCode(project.getCharger());
            project.setCharger(employeeName);
            
            EmployeeVO siteManager = planService.getEmployeeByCode(project.getSptMngr());
            if (siteManager != null) {
                project.setSptMngr(siteManager.getEmplNm());
                model.addAttribute("siteManager", siteManager);
            } else {
                // siteManager가 null일 경우 처리 (예: 미배정 표시)
                project.setSptMngr("(담당자 설정이 필요합니다)");
                model.addAttribute("siteManager", null);
            }
            
            List<ProcessVO> processes = planService.getProcessListByProject(prjctNo); // 공정 리스트 조회
            List<EmployeeVO> employeeList = documentService.getAllEmployees();
            
            if (!processes.isEmpty()) {
                model.addAttribute("firstProcessNo", processes.get(0).getProcsNo());
            }
            
            DeclarationVO declaration = planService.getDeclarationForProject(prjctNo);
            List<BidVO> bidList = planService.getBidForProject(prjctNo);
            
            Map<Integer, BidVO> bidMap = new HashMap<>();
            for (ProcessVO process : processes) {
                if (process.getProcsOrdr() != 1) {  // 첫 번째 공정은 제외
                    BidVO bids = planService.getBidForProcess(process.getProcsNo());
                    if (bids != null) {
                        bidMap.put(process.getProcsNo(), bids);
                    }
                }
            }
            
            Map<Integer, PriceQuotationVO> approvedQuotationMap = new HashMap<>();
            for (ProcessVO process : processes) {
                if ("05".equals(process.getProgrsSttus())) {
                    BidVO bid = bidMap.get(process.getProcsNo());
                    if (bid != null) {
                        PriceQuotationVO approvedQuotation = planService.getApprovedQuotation(bid.getPblancNo());
                        if (approvedQuotation != null) {
                            approvedQuotationMap.put(process.getProcsNo(), approvedQuotation);
                        }
                    }
                }
            }
            
         // (1) SecurityContext에서 Authentication 객체 가져오기
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();

            // (2) principal을 CustomUser로 캐스팅해서 emplCode 얻어오기 (예시)
            Object principal = auth.getPrincipal();
            String emplCode = "";
            if (principal instanceof CustomUser) {
                CustomUser customUser = (CustomUser) principal;
                emplCode = customUser.getMemberVO().getEmpVO().getEmplCode();
            } else {
                // principal이 CustomUser가 아니라면 예외 처리 등
                throw new RuntimeException("로그인 사용자 정보를 가져올 수 없습니다.");
            }
            
            List<CheckListVO> checklistList = planService.getSafetyChecklistList(emplCode);
            
            model.addAttribute("project", project);  // 상세 정보 모델에 추가
            model.addAttribute("processes", processes); // 공정 정보 모델에 추가
            model.addAttribute("employeeList", employeeList);
            model.addAttribute("declaration", declaration);
            model.addAttribute("bidList", bidList);
            model.addAttribute("bidMap", bidMap);
            model.addAttribute("approvedQuotationMap", approvedQuotationMap);
            model.addAttribute("checklistList", checklistList);
        } catch (Exception e) {
            log.error("프로젝트 상세 조회 중 오류 발생", e);
            model.addAttribute("error", "프로젝트 상세 조회 실패");
        }
        return "project/projectDetail";  // 상세 페이지 뷰로 반환
    }
	
	@ResponseBody
	@PostMapping("/projectpm/updateSiteManager")
	public ResponseEntity<Map<String, Object>> updateSiteManager(@RequestParam String emplCode, 
	                                                              @RequestParam String emplName, 
	                                                              @RequestParam int prjctNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 담당자 업데이트 서비스 호출
	        boolean success = planService.updateSiteManager(emplCode, emplName, prjctNo);
	        if (success) {
	        	EmployeeVO empl = hrCardService.getEmployeeByEmplCode(emplCode); 
	        	response.put("empl", empl);
			}
	        response.put("success", success);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@PostMapping("/projectpm/deleteSiteManager")
	public ResponseEntity<Map<String, Object>> deleteSiteManager(@RequestParam String emplCode, 
	                                                              @RequestParam int prjctNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean success = planService.deleteSiteManager(emplCode, prjctNo);
	        response.put("success", success);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@GetMapping("/projectpm/getEmployeeDetails")
	public ResponseEntity<Map<String, Object>> getEmployeeDetails(@RequestParam String emplCode) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        EmployeeVO employee = planService.getEmployeeDetails(emplCode); // DB에서 사원 정보 조회
	        if (employee != null) {
	            response.put("success", true);
	            response.put("employee", employee);  // 사원 정보를 포함하여 반환
	        } else {
	            response.put("success", false);
	            response.put("message", "사원 정보를 찾을 수 없습니다.");
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류가 발생했습니다.");
	    }
	    return ResponseEntity.ok(response); // 응답 반환
	}
	
	@PostMapping("/projectpm/updateProcessStatus")
	@ResponseBody
	public Map<String, Object> updateProcessStatus(@RequestParam int procsNo, @RequestParam String progrsSttus) {
	    System.out.println("Received update for processNo: " + procsNo + " with status: " + progrsSttus);
	    Map<String, Object> response = new HashMap<>();
	    try {
	        planService.updateProcessStatus(procsNo, progrsSttus);  // 공정 상태 업데이트
	        response.put("success", true);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	    }
	    return response;
	}
	
	@GetMapping("/declaration/list")
    public String declarationList(Model model) {
        try {
            // 기초 품목 신고서 목록을 조회
            List<DeclarationVO> declarations = planService.getDeclarationList();
            model.addAttribute("declarations", declarations); // 모델에 데이터 추가
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "기초 품목 신고서 목록 조회 중 오류 발생");
        }
        return "project/declarationList"; // 뷰 페이지로 반환
    }
	
	@GetMapping("/declaration/write/{prjctNo}")
	public String declarationWriteForm(@PathVariable int prjctNo, Model model) {
	    // 품목 단위 리스트와 대분류 목록을 불러옴
	    List<String> unitList = prdlstService.getUnitList();
	    List<PrdlstCtgryVO> levelOneCtgryList = prdlstService.getLevelOneCtgryList();

	    model.addAttribute("unitList", unitList);
	    model.addAttribute("levelOneCtgryList", levelOneCtgryList);
	    model.addAttribute("prjctNo", prjctNo); // 프로젝트 번호 추가

	    return "project/declarationWriteForm"; // 기초 품목 신고서 작성 페이지로 이동
	}
	
	@ResponseBody
	@PostMapping("/declaration/submit")
    public String submitDeclaration(
            @RequestParam int prjctNo, // 프로젝트 번호
            @RequestParam String dclrtSj, // 제목
            @RequestParam int totalAmount, // 총합 금액
            @RequestParam List<Integer> selectedProductIds, // 선택된 품목들
            @RequestParam List<Integer> quantities, // 각 품목들의 수량
            Model model) {

        try {
            // 1. 신고서 번호 시퀀스 이용하여 TB_BASIS_PRODUCT_LIST_DECLARATION 테이블에 INSERT
            int declarationNo = planService.insertDeclaration(prjctNo, dclrtSj, totalAmount);

            // 2. TB_DECLARATION_PRODUCT_LIST 테이블에 품목 및 수량 INSERT
            planService.insertDeclarationProductList(declarationNo, selectedProductIds, quantities);

            return "success"; // 신고서 목록 페이지로 이동
        } catch (Exception e) {
            log.error("신고서 제출 중 오류 발생", e);
            model.addAttribute("error", "신고서 제출 실패");
            return "fail";  // 작성 폼으로 돌아가기
        }
    }
	
	@GetMapping("/projectpm/getFirstProcessNo")
	@ResponseBody
	public Map<String, Object> getFirstProcessNo(@RequestParam int prjctNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        int procsNo = planService.getFirstProcessNo(prjctNo);  // 첫 번째 공정 번호를 가져오는 서비스 호출
	        response.put("success", true);
	        response.put("procsNo", procsNo);  // 첫 번째 공정 번호를 반환
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "공정 번호 조회 실패");
	    }
	    return response;
	}
	
	@PostMapping("/projectpm/updatePlanStatus")
	@ResponseBody
	public Map<String, Object> updatePlanStatus(@RequestParam int prjctNo, @RequestParam String planStatus) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean success = planService.updateProjectPlanStatus(prjctNo, planStatus);  // 프로젝트 상태 업데이트
	        response.put("success", success);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	    }
	    return response;
	}
	
	@GetMapping("/declaration/detail/{dclrtNo}")
	public String declarationDetail(@PathVariable int dclrtNo, Model model) {
	    try {
	        // 신고서 헤더 정보 조회
	        DeclarationVO declaration = planService.getDeclarationDetail(dclrtNo);
	        // 해당 신고서에 포함된 품목 리스트 조회
	        List<DeclarationProductVO> productList = planService.getDeclarationProductList(dclrtNo);
	        
	        model.addAttribute("declaration", declaration);
	        model.addAttribute("productList", productList);
	    } catch (Exception e) {
	        log.error("신고서 상세 조회 중 오류 발생", e);
	        model.addAttribute("error", "신고서 상세 조회 실패");
	    }
	    return "project/declarationDetail"; // 상세 페이지 뷰 이름
	}
	
	@GetMapping("/bid/list")
    public String bidList(Model model) {
        try {
            List<BidVO> bids = planService.getBidList();
            model.addAttribute("bids", bids);
        } catch (Exception e) {
            // 로그 찍기 등 예외 처리
            e.printStackTrace();
            model.addAttribute("error", "입찰 공고 조회 실패");
        }
        return "project/bidList";
    }
	
	@GetMapping("/bid/write/{prjctNo}/{procsNo}")
	public String bidWriteForm(@PathVariable int prjctNo,
	                           @PathVariable int procsNo,
	                           Model model) {
	    // 로그인한 사용자 정보는 세션 등에서 가져오고, 필요하다면 추가로 전달
	    model.addAttribute("prjctNo", prjctNo);
	    model.addAttribute("procsNo", procsNo);
	    // 예: 공고 구분(select box용 공통코드 등)을 조회하여 모델에 추가할 수도 있음
	    return "project/bidWriteForm"; // JSP 파일명 (WEB-INF/views/project/bidWriteForm.jsp)
	}

	@PostMapping("/bid/submit")
	@ResponseBody
	public Map<String, Object> submitBidAnnouncement(@ModelAttribute BidVO bid) {
		Map<String, Object> response = new HashMap<>();
	    try {
	        // 예를 들어, 로그인한 사용자의 사원코드를 bid 객체에 셋팅하는 로직도 추가 가능
	        boolean success = planService.insertBid(bid);
	        response.put("success", success);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	    }
	    return response;
	}
	
	@GetMapping("/bid/detail/{pblancNo}")
	public String bidDetail(@PathVariable int pblancNo, Model model) {
	    try {
	        // 서비스에서 입찰 공고 상세 정보를 조회
	        BidVO bid = planService.getBidDetail(pblancNo);
	        model.addAttribute("bid", bid);

	        // 해당 입찰 공고의 견적서 목록을 조회
	        List<PriceQuotationVO> quotationList = planService.getQuotationList(pblancNo);
	        model.addAttribute("quotationList", quotationList);

	        // 이미 승인된 견적서가 있는지 확인
	        boolean approvedQuotationExists = false;
	        for (PriceQuotationVO quotation : quotationList) {
	            if ("Y".equals(quotation.getConfmAt())) {
	                approvedQuotationExists = true;
	                break;  // 하나라도 있으면 종료
	            }
	        }
	        model.addAttribute("approvedQuotationExists", approvedQuotationExists);

	    } catch (Exception e) {
	        log.error("입찰 공고 상세 조회 중 오류 발생", e);
	        model.addAttribute("error", "입찰 공고 상세 조회에 실패했습니다.");
	    }

	    return "project/bidDetail";
	}
	
	@GetMapping("/bid/quotation/detail/{prqudoNo}")
	public String quotationDetail(@PathVariable int prqudoNo, Model model) {
	    try {
	        // 견적서 상세 정보를 가져옴
	        PriceQuotationVO quotation = planService.getQuotationDetail(prqudoNo);
	        if (quotation == null) {
	            model.addAttribute("error", "견적서 정보를 찾을 수 없습니다.");
	            return "error"; // 오류 페이지로 리턴 
	        }
	        // 해당 견적서가 속한 입찰 공고 번호를 사용하여 이미 승인된 견적서가 있는지 확인함
	        boolean approvedQuotationExists = planService.isQuotationApproved(quotation.getPblancNo());
	        model.addAttribute("quotation", quotation);
	        model.addAttribute("approvedQuotationExists", approvedQuotationExists);
	    } catch (Exception e) {
	        log.error("견적서 상세 조회 중 오류 발생", e);
	        model.addAttribute("error", "견적서 상세 조회에 실패했습니다.");
	        return "error"; // 오류 페이지로 리턴 
	    }
	    return "project/quotationDetail";  // 견적서 상세보기 페이지로 이동
	}
	
	@ResponseBody
	@PostMapping("/bid/quotation/approve/{prqudoNo}")
	public Map<String, Object> approveQuotation(@PathVariable int prqudoNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 견적서 승인 전, 이미 승인된 견적서가 있는지 확인
	        PriceQuotationVO quotation = planService.getQuotationDetail(prqudoNo);
	        if (quotation != null) {
	            int pblancNo = quotation.getPblancNo();
	            boolean alreadyApproved = planService.isQuotationApproved(pblancNo);
	            if (alreadyApproved) {
	                response.put("success", false);
	                response.put("message", "이미 승인된 견적서가 존재합니다.");
	                return response;
	            }
	        }
	        
	        // 승인 처리 및 공정 상태 업데이트
	        boolean success = planService.approveQuotation(prqudoNo);
	        
	        if (success) {
	            // 승인 후, 해당 견적서에 연결된 입찰 공고의 정보를 조회
	            PriceQuotationVO updatedQuotation = planService.getQuotationDetail(prqudoNo);
	            if (updatedQuotation != null) {
	                int pblancNo = updatedQuotation.getPblancNo();
	                BidVO bid = planService.getBidDetail(pblancNo);
	                if (bid != null) {
	                    response.put("prjctNo", bid.getPrjctNo());
	                } else {
	                    // 만약 Bid 정보가 없는 경우 기본값(예: 0) 또는 예외처리
	                    response.put("prjctNo", 0);
	                }
	            }
	        }
	        response.put("success", success);
	    } catch (Exception e) {
	        log.error("견적서 승인 처리 중 오류 발생", e);
	        response.put("success", false);
	    }
	    return response;
	}
	
	@GetMapping("/bid/quotation/checkApproved/{pblancNo}")
	@ResponseBody
	public Map<String, Object> checkApproved(@PathVariable int pblancNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 입찰 공고에 대해 승인된 견적서가 이미 존재하는지 확인
	        boolean alreadyApproved = planService.isQuotationApproved(pblancNo);
	        response.put("success", !alreadyApproved);
	    } catch (Exception e) {
	        response.put("success", false);
	        e.printStackTrace();
	    }
	    return response;
	}
	
	@PostMapping("/process/updateDetails")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateProcessDetails(
	        @RequestParam int procsNo,
	        @RequestParam String procsCn,
	        @RequestParam String procsBgnde,  // 예: "2025-03-01"
	        @RequestParam String procsEndde) { // 예: "2025-03-31"\
		log.info(procsCn);
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean success = planService.updateProcessDetails(procsNo, procsCn, procsBgnde, procsEndde);
	        response.put("success", success);
	        response.put("message", success ? "공정 내용이 저장되었습니다." : "저장에 실패하였습니다.");
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "오류 발생: " + e.getMessage());
	    }
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@PostMapping("/safetyCheckList/save")
	public ResponseEntity<Map<String, Object>> saveSafetyChecklist(
	        @RequestParam String chklstSj,
	        @RequestParam List<String> detailItems) {  // 변경: List<String> 타입으로 받기
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // Authentication에서 principal을 CustomUser로 캐스팅하여 사용
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        Object principal = auth.getPrincipal();
	        String emplCode = "";
	        if (principal instanceof CustomUser) {
	            CustomUser customUser = (CustomUser) principal;
	            emplCode = customUser.getMemberVO().getEmpVO().getEmplCode();
	        } else {
	            throw new RuntimeException("로그인 사용자 정보가 올바르지 않습니다.");
	        }

	        // 체크리스트 VO 생성 및 값 설정
	        CheckListVO checkList = new CheckListVO();
	        checkList.setChklstSj(chklstSj);
	        checkList.setEmplCode(emplCode);
	        // writngDe는 DB에서 SYSDATE 처리되므로 별도 셋팅 없음

	        // 서비스 호출 (트랜잭션 처리)
	        boolean success = planService.saveSafetyChecklist(checkList, detailItems);

	        response.put("success", success);
	        if(success) {
	            response.put("checklist", checkList);
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    }
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@GetMapping("/safetyCheckList/list")
	public ResponseEntity<Map<String, Object>> getSafetyChecklistList(@RequestParam String emplCode) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        List<CheckListVO> list = planService.getSafetyChecklistList(emplCode);
	        response.put("success", true);
	        response.put("list", list);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    }
	    return ResponseEntity.ok(response);
	}
	
	@GetMapping("/safetyCheckList/detail/{chklstNo}")
	public String checklistDetail(@PathVariable int chklstNo, Model model) {
	    try {
	        // 체크리스트 기본 정보 조회 (체크리스트 제목, 작성일, 작성자 등)
	        CheckListVO checklist = planService.getSafetyChecklistDetail(chklstNo);
	        // 체크리스트 세부 항목 목록 조회 (예: 각 항목의 내용)
	        List<String> detailItems = planService.getSafetyChecklistDetailItems(chklstNo);
	        
	        model.addAttribute("checklist", checklist);
	        model.addAttribute("detailItems", detailItems);
	    } catch (Exception e) {
	        model.addAttribute("error", "체크리스트 상세 조회에 실패했습니다.");
	        e.printStackTrace();
	    }
	    return "project/checklistDetail";  // JSP 뷰 파일 (예: WEB-INF/views/project/checklistDetail.jsp)
	}
	
	// 예: ProjectPlanController 안에 추가
	@GetMapping("/safetyCheckList/detailAjax/{chklstNo}")
	@ResponseBody
	public Map<String, Object> getChecklistDetailAjax(@PathVariable int chklstNo) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        // 체크리스트 기본 정보 조회
	        CheckListVO checklist = planService.getSafetyChecklistDetail(chklstNo);
	        // 체크리스트 세부 항목 목록 조회
	        List<String> detailItems = planService.getSafetyChecklistDetailItems(chklstNo);

	        result.put("success", true);
	        result.put("checklist", checklist);
	        result.put("detailItems", detailItems);
	    } catch (Exception e) {
	        result.put("success", false);
	        result.put("message", e.getMessage());
	    }
	    return result;
	}
	
	@PostMapping("/safetyCheckList/assign")
	@ResponseBody
	public Map<String, Object> assignChecklistToProcess(
	        @RequestParam int prjctNo,
	        @RequestParam int procsNo,
	        @RequestParam int chklstNo) 
	{
	    Map<String, Object> result = new HashMap<>();
	    try {
	        // 서비스에서 배정 로직 처리
	        // e.g. planService.assignChecklistToProcess(prjctNo, procsNo, chklstNo);

	        result.put("success", true);
	    } catch (Exception e) {
	        result.put("success", false);
	        result.put("message", e.getMessage());
	    }
	    return result;
	}
	
	@PostMapping("/safetyCheckList/assign/process")
	@ResponseBody
	public Map<String, Object> assignChecklist(
	    @RequestParam int procsNo,
	    @RequestParam int chklstNo,
	    @RequestParam int prjctNo
	) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 체크리스트 배정 처리 (신규 삽입 또는 업데이트)
	        boolean success = planService.assignChecklistToProcess(procsNo, chklstNo, prjctNo);
	        response.put("success", success);
	        
	        // 배정 성공 시, 프로젝트 상태를 확인
	        if (success) {
	            // 예를 들어, getProjectDetail API를 호출하여 최신 프로젝트 정보를 가져와서 상태 확인
	            ProjectVO project = planService.getProjectDetail(prjctNo);
	            if ("03".equals(project.getPlanSttus())) {
	                response.put("complete", true);
	            } else {
	                response.put("complete", false);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    }
	    return response;
	}
	
	@ResponseBody
	@GetMapping("/safetyCheckList/getAssignedChecklist")
	public ResponseEntity<Map<String, Object>> getAssignedChecklist(@RequestParam int prjctNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        // Map<Integer, Integer>로 받습니다.
	        Map<Integer, Integer> assignedMap = planService.getAssignedChecklistMapping(prjctNo);
	        response.put("success", true);
	        response.put("assignedMap", assignedMap);
	    } catch(Exception e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    }
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@PostMapping("/safetyCheckList/deleteAssignment")
	public ResponseEntity<Map<String, Object>> deleteAssignedChecklist(
	        @RequestParam int prjctNo,
	        @RequestParam int procsNo) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        boolean success = planService.deleteAssignedChecklistMapping(prjctNo, procsNo);
	        response.put("success", success);
	        if (!success) {
	            response.put("message", "배정 삭제에 실패했습니다.");
	        }
	    } catch(Exception e) {
	        response.put("success", false);
	        response.put("message", e.getMessage());
	    }
	    return ResponseEntity.ok(response);
	}
}