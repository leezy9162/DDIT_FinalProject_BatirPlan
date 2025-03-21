package kr.or.batirplan.resrce.order.scheduler;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.batirplan.resrce.order.service.ReqServiceForScheduler;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AutoReqScheduler {
	
	@Autowired
	private ReqServiceForScheduler reqServiceForScheduler;
	
	@Scheduled(cron = "0 0 0 * * *")    
	public void dailyAutoReq() {
    	
    	int status = reqServiceForScheduler.autoReqProcess();
    	if (status > 0) {
    		log.info("[자동 발주" + status + "건 발생]");
		}
    }
}
