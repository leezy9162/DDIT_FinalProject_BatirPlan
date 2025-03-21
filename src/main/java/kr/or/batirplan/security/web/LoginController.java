package kr.or.batirplan.security.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/security")
public class LoginController {

	@GetMapping("/login")
	public String goLogin() {
		return "common/login";
	}
	
	@GetMapping("/logininfo")
	public String goInfo() {
		return "common/loginInfo";
	}
	
	@GetMapping("/accessdenied")
	public String accessDenied() {
		return "common/accessError";
	}
	
	@GetMapping("/sessiontimeout")
	public String sessionTimeout() {
		return "common/sessionTimeout";
	}
	
}
