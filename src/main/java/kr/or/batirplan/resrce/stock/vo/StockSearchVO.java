package kr.or.batirplan.resrce.stock.vo;

import java.util.Date;

import lombok.Data;

@Data
public class StockSearchVO {
	
	private String ordrDeNo        ;
	private String ordrNo          ;
	private String prdlstNo        ;
	private int    ordrQty         ;
	private int    totalPrice      ;
	private String deSttus         ;
	private Date   receivedDate    ;
	
	private String prdlstNm		   ;
	private int    currentPage	   ; // 현재 페이지 번호	
	
}
