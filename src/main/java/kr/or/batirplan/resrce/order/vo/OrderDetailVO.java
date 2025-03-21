package kr.or.batirplan.resrce.order.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDetailVO {
	
	private String orderDeNo     ;
	private String ordrNo        ;
	private String prdlstNo      ;
	private int    ordrQty       ;
	private int    totalPrice    ;
	private String deSttus       ;
	private Date   receivedDate  ;
	
	private String prdlstNm		 ;
	
}
