package kr.or.batirplan.servicemanagement.autoid.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.ConstructorArgs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.servicemanagement.autoid.service.AutoIdService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/servicem/acntm")
@PreAuthorize("hasRole('ROLE_RSPNBER_IT')")
@RequiredArgsConstructor
public class AutoIdController {
	
	@Autowired
	private AutoIdService autoIdService;
	
	// 비동기 통신을 위한 
	private final Gson gson;
	
	@GetMapping("/list")
	public String getListPage() {
		return "autoid/list";
	}
	
	@ResponseBody
	@GetMapping("/empllist.do")
	public String getEmplList(
			@RequestParam(defaultValue = "1") int currentPage
			) {
		log.info("[AutoIdController] empllist.do >>>> CurrentPage = " + currentPage);
		
		// PaginationInfoVO는 페이지네이션 관련 정보(총 건수, 시작/끝 row 등)를 계산합니다.
	    PaginationInfoVO<EmployeeVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(currentPage);
		
	    // 아이디 발급이 안된 사원의 총 레코드 수 조회
	    int totalRecord = autoIdService.getNoIdEmplCount();
	    pagingVO.setTotalRecord(totalRecord);
	    
	    // 검색 조건과 페이징 정보를 서비스 레이어에 전달합니다.
	    List<EmployeeVO> empList = autoIdService.getNoIdEmplList(pagingVO);
	    pagingVO.setDataList(empList);
	    // 페이지네이션 HTML
	    String pagination = pagingVO.getPagingHTML();

	    // Map을 Json으로
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("empList", empList);
	    resultMap.put("pagingHTML", pagination);
	    resultMap.put("currentPage", pagingVO.getCurrentPage());
	    resultMap.put("totalRecord", pagingVO.getTotalRecord());

	    return gson.toJson(resultMap);
	}
	
	@ResponseBody
	@GetMapping("/ccpylist.do")
	public String getCcpyList(
			@RequestParam(defaultValue = "1") int currentPage
			) {
		log.info("[AutoIdController] ccypylist.do >>>> CurrentPage = " + currentPage);
		
		// PaginationInfoVO는 페이지네이션 관련 정보(총 건수, 시작/끝 row 등)를 계산합니다.
		PaginationInfoVO<CooperationcomVO> pagingVO = new PaginationInfoVO<>(10, 5);
		pagingVO.setCurrentPage(currentPage);
		
		// 아이디 발급이 안된 사원의 총 레코드 수 조회
		int totalRecord = autoIdService.getNoIdCcpyCount();
		pagingVO.setTotalRecord(totalRecord);
		
		// 검색 조건과 페이징 정보를 서비스 레이어에 전달합니다.
		List<CooperationcomVO> ccpyList = autoIdService.getNoIdCcpyList(pagingVO);
		pagingVO.setDataList(ccpyList);
		// 페이지네이션 HTML
		String pagination = pagingVO.getPagingHTML();
		
		// Map을 Json으로
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("ccpyList", ccpyList);
		resultMap.put("pagingHTML", pagination);
		resultMap.put("currentPage", pagingVO.getCurrentPage());
		resultMap.put("totalRecord", pagingVO.getTotalRecord());
		
		return gson.toJson(resultMap);
	}
	
	
	@ResponseBody
	@PostMapping("/emplidporcess.do")
	public String emplAutoIdProcess(@RequestBody List<String> selectedemplCodes) {
	    log.info(selectedemplCodes.get(0));
	    log.info(String.valueOf(selectedemplCodes.size()));
	    
	    try {
	        autoIdService.autoEmplMberProcess(selectedemplCodes);
	        log.info("자동 회원 아이디 발급 성공");
	        return String.valueOf(selectedemplCodes.size());
	    } catch (Exception e) {
	        log.error("회원 아이디 발급 중 에러 발생", e);
	        return "회원 아이디 발급 실패";
	    }
	}
	
	@ResponseBody
	@PostMapping("/ccpyidporcess.do")
	public String ccpyAutoIdProcess(@RequestBody List<String> selectedCcpyCodes){
		log.info(selectedCcpyCodes.get(0));
		log.info(String.valueOf(selectedCcpyCodes.size()));
		 
	    try {
	        autoIdService.autoCcpyMberProcess(selectedCcpyCodes);
	        log.info("자동 회원 아이디 발급 성공");
	        return String.valueOf(selectedCcpyCodes.size());
	    } catch (Exception e) {
	        log.error("회원 아이디 발급 중 에러 발생", e);
	        return "회원 아이디 발급 실패";
	    }
	}
	
	
}
