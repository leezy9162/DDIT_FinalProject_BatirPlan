package kr.or.batirplan.resrce.product.vo;

import lombok.Data;

@Data
public class PrdlstSearchVO {
	private int 		currentPage				; 		// 현재 페이지
	private int   		level1Select            ;		// 품목 소분류
	private int   		level2Select            ;		// 품목 소분류
	private int   		ctgryNo             	;		// 품목 소분류
	private String   	prdlstNm             	;		// 품목명
	private String   	ccpyNm             		;		// 풍목 담당 협력업체명
	private String   	ccpyCode             	;		// 풍목 담당 협력업체 코드
	private String   	prdlstStndrd            ;		// 품목 규격
	private String   	prdlstUnit              ;		// 품목 단위
	private int   		prdlstPriceStart        ;		// 품목 단가 시작
	private int   		prdlstPriceEnd          ;		// 품목 단가 끝
}
