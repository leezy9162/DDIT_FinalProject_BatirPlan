package kr.or.batirplan.resrce.order.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.batirplan.resrce.order.mapper.ReqMapperForScheduler;
import kr.or.batirplan.resrce.order.vo.AutoReqVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ReqServiceForSchedulerImpl implements ReqServiceForScheduler {

	@Autowired
	private ReqMapperForScheduler mapperForScheduler;
	
	@Autowired
	private ReqService reqService;
	
	@Transactional
	@Override
	public int autoReqProcess() {
		log.info("[autoReqProcess] >>> 설정된 지점에 따라 자동 발주를 시작합니다.");

		
		List<AutoReqVO> autoReqTargetList = mapperForScheduler.getAutoReqTargetListBySttus();
		
		
		List<ReqVO> autoReqList = new ArrayList<>();
		
		// 자동 발주로 설정된 품목들을 순회
		for (AutoReqVO autoReq : autoReqTargetList) { 
			
			// 재주문 시점 산출
			// ROP = 일일소요 * 리드 타임 + 설정 안전재고
			int rop = autoReq.getDailyDemand() * autoReq.getLeadTime() + autoReq.getSafeInvntryQy();
			
			// 현재 재고가 ROP보다 낮다면? 자동 발주 시작
			if (autoReq.getNowInvntryQy() < rop) {
				
				// 자동 발주 재상 품목
				int prdlstNo = autoReq.getPrdlstNo();
				
				// 최적 주문량 산출
				// (2 * 연간 수요(daily_demand * 365) * 주문 비용) / 보관 비용(holdingCost)
				int eoq = (int) Math.sqrt((2 * (autoReq.getDailyDemand() * 365) * autoReq.getOrderCost()) / autoReq.getHoldingCost());
				
				// 해당 품목의 발주가 요청 상태인 총합 산출
				// 보통 자동 발주 품목을 수동으로 발주하지 않을 테니까 이미 전날 자동 발주가 되어 있거나 하는 상태에 또 발주하는 것을 방지하기 위함...
				// 수동을 발주 했어도 남은 EOQ만큼 재고를 보유하기 위해 발주
				// 어느 테이블을 기준으로 가져올것인가...
				// 발주 요청(req)? 승인되서 발주(order)? 골머리 아프네....
				int searchReqResultQty = mapperForScheduler.searchReqProcessQty(prdlstNo);
				int searchOrderResultQty = mapperForScheduler.searchOrderProcessQty(prdlstNo);
				
				int autoReqQty = eoq - searchReqResultQty - searchOrderResultQty;
				log.info("eoq>>> " + eoq + " searchReqResultQty>>> " + searchReqResultQty + " searchOrderResultQty>>> " + searchOrderResultQty);
				log.info("[품목 번호]prdlstNo>>> " + prdlstNo + " [자동 발주량]autoReqQty>>> " +autoReqQty);
				
				// 부족한 분량 만큼 주문
				if (autoReqQty > 0) {
					log.info("[품목 번호]prdlstNo>>> " + prdlstNo + " ###자동발주 실행### ");
					ReqVO req = new ReqVO();
					req.setReqType("2");
					req.setSuplrCode(autoReq.getSuplrCode());
					
					List<ReqDetailVO> reqDList = new ArrayList<>();
					ReqDetailVO reqD = new ReqDetailVO();
					reqD.setPrdlstNo(String.valueOf(autoReq.getPrdlstNo()));
					reqD.setUnitPrice(autoReq.getUnitPrice());
					reqD.setReqQty(autoReqQty);
					reqD.setTotalPrice(autoReqQty * autoReq.getUnitPrice());
					reqDList.add(reqD);
					req.setDetails(reqDList);
					
					autoReqList.add(req);
				}
			}
		}
		
		int status = reqService.reqRegister(autoReqList, null);

		return status;
	}

}
