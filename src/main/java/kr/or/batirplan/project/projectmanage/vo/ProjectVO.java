package kr.or.batirplan.project.projectmanage.vo;

import lombok.Data;

@Data
public class ProjectVO {
	private int prjctNo;
	private String charger;
	private String prjctNm;
	private String prjctCtgry;
	private String prjctCn;
	private long prjctBudget;
	private String prjctProgrsSttus;
	private String prjctBgnde;
	private String prjctEndde;
	private String prjctLc;
	private String prjctProgrsAt;
	private String sptMngr;
	private String planSttus;
}