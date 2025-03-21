package kr.or.batirplan.hrm.hrcard.web;


import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.hrcard.service.HrCardService;
import kr.or.batirplan.hrm.hrcard.vo.HrCardSearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j											// 로그 설정
@Controller										// 컨트롤러
@RequestMapping("/batirplan/hrm/hrcard")		// URL맵핑
@PreAuthorize("hasRole('ROLE_DEPT_MNGMT')")		// 권한 설정
public class HrCardController {
	
	@Autowired
	private HrCardService service;
	
	/**
	 * 인사카드 리스트 페이지 이동 메서드
	 * @author leezy
	 * @return 인사카드 등록 페이지로 forward
	 */
	@GetMapping("/list")
	public String getListPage(@ModelAttribute HrCardSearchVO searchVO,
	                          @RequestParam(defaultValue = "1") int currentPage,
	                          Model model) {
		// 하이픈 제거(DB는 VARCHAR2로 저장되어 있음...)
	    if(StringUtils.isNotBlank(searchVO.getHireDateStart())){
	        searchVO.setHireDateStart(searchVO.getHireDateStart().replaceAll("-", ""));
	    }
	    if(StringUtils.isNotBlank(searchVO.getHireDateEnd())){
	        searchVO.setHireDateEnd(searchVO.getHireDateEnd().replaceAll("-", ""));
	    }
	    if(StringUtils.isNotBlank(searchVO.getRetireDateStart())){
	        searchVO.setRetireDateStart(searchVO.getRetireDateStart().replaceAll("-", ""));
	    }
	    if(StringUtils.isNotBlank(searchVO.getRetireDateEnd())){
	        searchVO.setRetireDateEnd(searchVO.getRetireDateEnd().replaceAll("-", ""));
	    }
	    
	    // PaginationInfoVO는 페이지네이션 관련 정보(총 건수, 시작/끝 row 등)를 계산합니다.
	    PaginationInfoVO<EmployeeVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(currentPage);
	    
	    // 총 레코드 수 조회 (검색 조건을 활용)
	    int totalRecord = service.getEmployeeCount(searchVO);
	    pagingVO.setTotalRecord(totalRecord);
	    
	    // 검색 조건과 페이징 정보를 서비스 레이어에 전달합니다.
	    // (서비스 메서드 구현 시, 검색VO와 pagingVO를 함께 활용하여 조건에 맞는 데이터를 조회)
	    List<EmployeeVO> empList = service.getEmployeeList(searchVO, pagingVO);
	    pagingVO.setDataList(empList);
	    
	    log.info(pagingVO.getPagingHTML());
	    log.info("현재 페이지>>>"+pagingVO.getCurrentPage());
	    // 뷰에 전달
	    model.addAttribute("pagingVO", pagingVO);
	    model.addAttribute("searchVO", searchVO);
	    
	    return "hrm/hrcard/list";
	}
	
	/**
	 * 인사카드 등록 폼 페이지 이동 메서드
	 * @author leezy
	 * @return 등록 폼 페이지로 forward
	 */
	@GetMapping("/register")
	public String getregisterPage() {
		return "hrm/hrcard/register";
	}
	
	/**
	 * 인사 카드 수정 페이지 이동 메서드
	 * @author leezy
	 * @param emplCode
	 * @param model
	 * @return 수정 폼 페이지로
	 */
	@GetMapping("/modify")
	public String getModifyPage(@RequestParam String emplCode, Model model) {
		EmployeeVO employeeVO = service.getEmployeeByEmplCode(emplCode);
		
		// 등록과 같은 페이지를 공유하기 때문에 status라는 속성을 하나 담아서 보냄.
		model.addAttribute("status", "u");
		model.addAttribute("empVO", employeeVO);
		return "hrm/hrcard/register";
	}
	
	/**
	 * 인사 카드 수정 메서드
	 * @author leezy
	 * @param employeeVO
	 * @return
	 */
	@PostMapping("/modify")
	public ResponseEntity<String> modifyEmployee(EmployeeVO employeeVO) {
		// 응답을 담을 객체 생성
		ResponseEntity<String> result = null;
		
		if (service.modifyEmployee(employeeVO) == 1) {
			log.info("[HrCardController]" + employeeVO.getEmplCode() + " 회원 정보가 수정되었습니다.");
			result = new ResponseEntity<String>(employeeVO.getEmplCode(), HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return result;
	}
	
	/**
	 * 인사 카드 상세보기 페이지 이동 메서드
	 * @author leezy
	 * @param emplCode
	 * @param model
	 * @return
	 */
	@GetMapping("/detail")
	public String getDetailPage(@RequestParam String emplCode, Model model) {
		EmployeeVO employeeVO = service.getEmployeeByEmplCode(emplCode);
		
		model.addAttribute("empVO", employeeVO);
		return "hrm/hrcard/detail";
	}
	
	
	/**
	 * 인사카드 등록 메서드
	 * @author leezy
	 * @param employeeVO
	 * @return
	 */
	@PostMapping("/form")
	public ResponseEntity<String> insertEmployee(EmployeeVO employeeVO) {
		// 응답을 담을 객체 생성
		ResponseEntity<String> result = null;
		log.info("[HrCardController] " + employeeVO.getEmplNm() + " 사원을 등록합니다.");
		
		if (!employeeVO.getEmplProfile().isEmpty()) {
			log.info("프로필 파일 존재 확인!!");
		}
		
		if (service.insertEmployee(employeeVO) == 1) {
			log.info("[HrCardController]" + employeeVO.getEmplCode() + " 사원번호가 부여되었습니다.");
			result = new ResponseEntity<String>(employeeVO.getEmplCode(), HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return result;
	}
	
	/**
	 * 인사 카드 퇴직 처리 메서드
	 * @author leezy
	 * @param emplCode
	 * @return
	 */
	@PostMapping("/retire")
	public ResponseEntity<String> retireEmployee(String emplCode){
		// 응답을 담을 객체 생성
		ResponseEntity<String> result = null;
		
		if (service.emplRetireProcess(emplCode) == 1) {
			log.info("[HrCardController]" + emplCode + " 사원번호 퇴직 처리 완료.");
			result = new ResponseEntity<String>(emplCode, HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return result;
	}
	
}
