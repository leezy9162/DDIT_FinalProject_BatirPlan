package kr.or.batirplan.project.projectplan.vo;

import lombok.Data;

@Data
public class DeclarationProductVO {
	private int dclrtNo;
	private int prdlstNo;
	private int prdlstQy;
	
	private String prdlstNm;
	private int prdlstPrice;
	private int totalAmount;
}