package kr.or.batirplan.common.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import jakarta.servlet.DispatcherType;
import java.util.List;

import kr.or.batirplan.security.hanlder.CustomAccessDeniedHandler;
import kr.or.batirplan.security.hanlder.CustomLoginFailureHandler;
import kr.or.batirplan.security.hanlder.CustomLoginSuccessHandler;
import kr.or.batirplan.security.service.CustomUserDetailsService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;

	@Bean
	public PasswordEncoder passwordEncoder() {
	    return NoOpPasswordEncoder.getInstance();  // 평문 비밀번호 허용
	}

	@Bean
	protected AuthenticationManager authenticationManager(
			HttpSecurity http, NoOpPasswordEncoder noOpPasswordEncoder,
			UserDetailsService userDetailsService
	) {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		authProvider.setUserDetailsService(customUserDetailsService);
		authProvider.setPasswordEncoder(noOpPasswordEncoder);
		return new ProviderManager(authProvider);
	}

	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

		// CORS 설정
		http.cors(cors -> cors.configurationSource(corsConfigurationSource()));

		
		http.csrf(csrf -> csrf.disable());

		http.authorizeHttpRequests(
			(authorize) ->
				authorize.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll()
				.requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
				.requestMatchers("/assets/**", "/batirplan/security/**").permitAll()
				.requestMatchers("/").permitAll()
				.requestMatchers("/api/**").permitAll()
				.requestMatchers("/api/**").anonymous()
				.anyRequest().authenticated()	// 인증된 사용자만 접근
		);

		// 예외 처리 (접근 거부 핸들러)
		http.exceptionHandling(exception -> 
			exception.accessDeniedHandler(new CustomAccessDeniedHandler())
		);

		// 커스텀 로그인 설정
		http.formLogin(formLogin -> formLogin
			.loginPage("/batirplan/security/login")
            .loginProcessingUrl("/login")
            .successHandler(new CustomLoginSuccessHandler())
            .failureHandler(new CustomLoginFailureHandler())
		);

		// 커스텀 로그아웃 설정
		http.logout(logout -> logout
		    .logoutUrl("/logout")
		    .logoutSuccessUrl("/batirplan/security/login")
		    .invalidateHttpSession(true)
		    .deleteCookies("JSESSIONID")
		);

		// 세션 설정
		http.sessionManagement(session -> 
			session.invalidSessionUrl("/batirplan/security/sessiontimeout")
		);

		return http.build();
	}

	// CORS 설정을 위한 Bean 추가
	@Bean
	public CorsConfigurationSource corsConfigurationSource() {
		CorsConfiguration configuration = new CorsConfiguration();
		configuration.setAllowedOrigins(List.of("http://localhost:5173"));
		configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
		configuration.setAllowedHeaders(List.of("*"));
		configuration.setAllowCredentials(false);

		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		source.registerCorsConfiguration("/api/**", configuration);
		return source;
	}
}
