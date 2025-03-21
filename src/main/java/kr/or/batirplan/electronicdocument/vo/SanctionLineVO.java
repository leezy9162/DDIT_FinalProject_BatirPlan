package kr.or.batirplan.electronicdocument.vo;

import lombok.Data;

@Data
public class SanctionLineVO {
	private int sanctnLineNo;
	private int docNo;
	private String sanctner;
	private String realSanctner;
	private int sanctnOrdr;
	private String sanctnSttus;
	private String sanctnDt;
	private String returnResn;
	
	private String sanctnerName;
	private String clsfCode;
	private String approvalStamp;
	private boolean prevDone;
	private boolean approved;
}