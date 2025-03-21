package kr.or.batirplan.projectmanage.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.batirplan.projectmanage.service.ProjectManageService;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTSearchVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePRCSVO;
import kr.or.batirplan.security.vo.CustomUser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/batirplan/project/projectmanage")
@RequiredArgsConstructor
//@PreAuthorize
public class ProjectManageController {
	
	@Autowired
	private ProjectManageService projectManageService;
	
	private final Gson gson;
	
	@GetMapping("/list")
	public String getListPage() {
		return "projectmanage/list";
	}
	
	/**
	 * 모든 진행중 OR 완료된 프로젝트의 리스트를 가져오는 메서드
	 * @author leezy
	 * @param projectManagePJTSearchVO
	 * @return
	 */
	@PostMapping("/list")
	@ResponseBody
	public String getProjectList(@RequestBody ProjectManagePJTSearchVO projectManagePJTSearchVO) {
		log.info("[ProjectManageController] ProjectManageController - getDataList 프로젝트 검색 조건 > {}", projectManagePJTSearchVO.toString());
		
		Map<String, Object> resultMap = projectManageService.getProjectList(projectManagePJTSearchVO);
		
		return gson.toJson(resultMap);
	}
	
	/**
	 * 로그인 정보를 기준으로 관련된 프로젝트 리스트를 가져오는 메서드
	 * (담당중인 프로젝트 + 현장 담당자로 배정된 프로젝트)
	 * @author leezy
	 * @param loginUser : 로그인 정보
	 * @param currentPage : 현재 페이지
	 * @return
	 */
	@GetMapping("/mylist")
	@ResponseBody
	public String getMyProjectList(@AuthenticationPrincipal CustomUser loginUser, @RequestParam("currentPage") int currentPage) {
		
		Map<String, Object> resultMap = projectManageService.getMyProjectList(currentPage, loginUser.getMemberVO().getEmpVO().getEmplCode());
		
		return gson.toJson(resultMap);
	}
	
	/**
	 * 프로젝트 상세화면(관리 화면)으로 이동하는 메서드
	 * 일반 / 현장 관리자 / 현장 관리자-모바일 다른 목적지로 이동
	 * 완공 처리는 나중에 로그인정보를 다시한번 체크할 예정
	 * @param loginUser
	 * @param prjctNo
	 * @param model
	 * @param request
	 * @return
	 */
	@GetMapping("/detail")
	public String getDetailPage(@AuthenticationPrincipal CustomUser loginUser, int prjctNo, Model model,  HttpServletRequest request) {
		ProjectManagePJTVO projectManagePJTVO = projectManageService.getProjectInfoByPrjctNo(prjctNo);
		List<ProjectManagePRCSVO> processList = projectManageService.getProcessListByPrjctNo(prjctNo);
		
		model.addAttribute("safetyStatus", "nope");
		model.addAttribute("prjctInfo", projectManagePJTVO);
		model.addAttribute("processList", processList);
		
		int total = 0;
		for (ProjectManagePRCSVO process : processList) {
			int temp = process.getProcsPrgs();
			total += temp; 
		}
		projectManagePJTVO.setAllPrgs(total/processList.size());
		
		
		// 요청에서 접속정보 획득
		String userAgent = request.getHeader("User-Agent");
		
		// 사원인지 확인 + 협력업체도 조회할 수 있도록 확장 해야 함
		if (loginUser.getMemberVO().getEmpVO() != null) {
			// 사원인 경우에 해당하기 때문에 로그인 정보를 가져옴
			String userCode = loginUser.getMemberVO().getEmpVO().getEmplCode();
			
			// 로그인 사원코드와 가져온 프로젝트 현장담당자코드가 같다면
			if (userCode.equals(projectManagePJTVO.getSptMngr())) {
				// 체크리스트 상세 정보 가져오기
				
				
				return "projectmanage/detailForMngr";
			}
			// 현장 담당자가 아닌 경우는 일반
			return "projectmanage/detail";
		} else {
			// 나중에 협력 업체도 일반 페이지로
			return "projectmanage/detail";
		}
	}
	
	private boolean isMobile(String userAgent) {
	    String ua = userAgent.toLowerCase();
	    return (ua.contains("mobi")      // Android, iPhone, 기타 모바일
	         || ua.contains("android")
	         || ua.contains("iphone")
	         || ua.contains("ipad"));
	}
	
	
	@GetMapping("/getDetailData")
	@ResponseBody
	public String getDetailData(int prjctNo) {
		Map<String, Object> resultMap = new HashMap<>();
		
		ProjectManagePJTVO projectManagePJTVO = projectManageService.getProjectInfoByPrjctNo(prjctNo);
		List<ProjectManagePRCSVO> processList = projectManageService.getProcessListByPrjctNo(prjctNo);
		
		int total = 0;
		for (ProjectManagePRCSVO process : processList) {
			int temp = process.getProcsPrgs();
			total += temp; 
		}
		projectManagePJTVO.setAllPrgs(total/processList.size());
		
		
		resultMap.put("project", projectManagePJTVO);
		resultMap.put("processList", processList);
		return gson.toJson(resultMap);
	}
	
	
	
	@PostMapping("/updateProgress")
	@ResponseBody
	public String updateProgress(@RequestBody List<ProjectManagePRCSVO> prcsList) {
	    log.info(prcsList.toString());
	    
	    projectManageService.updatePrcsPrgs(prcsList);
	    
	    return "OK"; 
	}

}
