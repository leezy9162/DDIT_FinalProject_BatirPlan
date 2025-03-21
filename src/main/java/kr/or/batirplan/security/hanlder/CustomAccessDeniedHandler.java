package kr.or.batirplan.security.hanlder;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler{

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.info("##CustomAccessDeniedHandler.handle() 실행...!!");
		log.info("##AccessDeniedException info================================");
		log.info(accessDeniedException.getMessage());
		response.sendRedirect("/batirplan/security/accessdenied");
	}

}
