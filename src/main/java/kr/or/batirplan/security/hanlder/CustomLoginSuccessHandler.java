package kr.or.batirplan.security.hanlder;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{
	
	// 예제 파일에 있어 가져왔지만 어디에 쓰이는지는 의문...
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("[AuthenticationSuccess]###AuthenticationSuccessHandler###");
		User user = (User) authentication.getPrincipal();
		log.info("[AuthenticationSuccess]>>>username: " + user.getUsername());
		
		// SPRING_SECURITY_EXCEPION으로 등록된 에러 정보를 삭제
		clearAuthenticationAttribute(request);
		log.info("[AuthenticationSuccess]>>>password: " + user.getPassword());
		response.sendRedirect("/batirplan/erp/main");
	}
	
	// 예제 파일에  있어 가져왔지만 어디에 쓰이는지 의문...
	private void clearAuthenticationAttribute(HttpServletRequest request) {
		// session 정보가 존재한다면 현재 session을 반환하고 존재하지 않으면 null을 반환합니다.
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		
		// SPRING_SECURITY_LAST_EXCEPTION 값
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
	
}
