package kr.or.batirplan.resrce.order.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	
	private String ordrNo            ;
	private String reqNo             ;
	private String ordrType          ;
	private Date   ordrDate          ;
	private String ordrSttus         ;
	private Date   completionDate    ;
	private String totalAmount       ;
	private Date   expectedDate      ;
	private String suplrCode         ;
	private String reqstrCode        ;
	private String remarks           ;
	private String cancelReason      ;
	
	private String reqstrNm        	 ;
}
