package kr.or.batirplan;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class BatirPlanApplication {

	public static void main(String[] args) {
		SpringApplication.run(BatirPlanApplication.class, args);
	}

}
