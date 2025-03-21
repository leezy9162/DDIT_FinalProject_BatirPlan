package kr.or.batirplan.resrce.order.vo;

import lombok.Data;
import java.math.BigDecimal;

/**
 * 발주 요청 상세 VO
 */
@Data
public class ReqDetailVO {
    
    private String reqDeNo;      	/* 요청 상세 번호 */
    private String reqNo;        	/* 요청 번호 (FK) */
    private String suplrNm;     	/* 품목 공급 업체 명 */
    private String prdlstNo;     	/* 품목 번호 */
    private String prdlstNm;     	/* 품목 이름 */
    private int reqQty;          	/* 요청 수량 */
    private int unitPrice;  	/* 단가 */
    private int totalPrice; 	/* 합계 금액 (req_qty * unit_price) */
    private String reqDeSttus;  	/* 품목별 상태 (1: 요청 중, 2: 승인됨, 3: 완료, 4: ) */
}
