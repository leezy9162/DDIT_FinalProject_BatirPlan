package kr.or.batirplan.project.projectmanage.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ProcessVO {
	private int procsNo;
	private int prjctNo;
	private String procsNm;
	private String procsCn;
	private Date procsBgnde;
	private Date procsEndde;
	private String progrsSttus;
	private String kpiAt;
	private String procsPrgs;
	private int procsOrdr;
	private String ccpyCode;
	
	private String status;
	private String assignedChecklistTitle;
}