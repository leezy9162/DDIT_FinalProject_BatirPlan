package kr.or.batirplan.resrce.order.vo;

import lombok.Data;

@Data
public class AutoReqVO {
	
	private int prdlstNo        ;
	private String prdlstNm        ;
	private int safeInvntryQy   ;
	private int dailyDemand     ;
	private int leadTime        ;
	private int orderCost       ;
	private int holdingCost     ;
	private String autoOrderYn     ;
	
	/* 자동 발주시 사용할 필드 */
	private String suplrCode	   ;
	private int unitPrice	   ;
	private int reqQty		   ;
	private int nowInvntryQy;
}
