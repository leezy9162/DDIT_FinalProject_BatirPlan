package kr.or.batirplan.project.projectplan.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DeclarationVO {
	private int dclrtNo;
	private int prjctNo;
	private String dclrtSj;
	private Date writngDt;
	private String confmAt;
	private Date confmDt;
	private int totalAmount;
	
	private String prjctNm;
}