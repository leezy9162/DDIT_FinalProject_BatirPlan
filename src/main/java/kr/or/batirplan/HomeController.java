package kr.or.batirplan;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.batirplan.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/erp")
public class HomeController {
	
	@PreAuthorize("hasAnyRole('ROLE_EMPL','ROLE_CCPY')")
	@GetMapping({"/main","/"})
	public String test() {
		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (user.getMemberVO().getEmpVO() == null) {
			return "erp/ccpyMain";
		}
		
		/*
		 * log.info(user.getMemberVO().getEmpVO().getEmplCode());
		 * log.info(user.getMemberVO().getEmpVO().getEmplNm());
		 */
		return "erp/main";
	}
}
