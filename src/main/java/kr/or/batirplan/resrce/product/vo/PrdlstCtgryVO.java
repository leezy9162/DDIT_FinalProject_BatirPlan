package kr.or.batirplan.resrce.product.vo;

import lombok.Data;

@Data
public class PrdlstCtgryVO {
	private int ctgryNo              	;		// 카테고리 번호
	private String ctgryNm              ;		// 카테고리 이름
	private int parentCtgry             ;		// 상위 카테고리
	private int ctgryLevel              ;		// 카테고리 수준
}
