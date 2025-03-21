package kr.or.batirplan.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 파일 관련 설정입니다.
 * 조현준 교수님과의 예제를 참고하였습니다.
 * @author leezy
 */
@Configuration
public class FileConfig implements WebMvcConfigurer{
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/upload/**")
		.addResourceLocations("file:///C:/upload/");
		WebMvcConfigurer.super.addResourceHandlers(registry);
	}
}
