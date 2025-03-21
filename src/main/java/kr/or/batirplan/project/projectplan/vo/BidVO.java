package kr.or.batirplan.project.projectplan.vo;

import lombok.Data;

@Data
public class BidVO {
	private int pblancNo;
	private int prjctNo;
	private int procsNo;
	private String pblancWrter;
	private String pblancSe;
	private String pblancSj;
	private String demandCndCn;
	private long pblancAmount;
	private String pblancBgnde;
	private String pblancEndde;
	private String progrsSttus;
	
	private String pblancWrterName;
}