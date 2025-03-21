package kr.or.batirplan.electronicdocument.vo;

import lombok.Data;

@Data
public class DocumentVO {
	 private int docNo;
	 private int formNo;
	 private String drftDe;
	 private String tmlmtDe;
	 private String sj;
	 private String drafter;
	 private String sttus;
	 private String emrgncyDocAt;
	 private String lastSanctnAt;
	 private String bdtCn;
	 
	 private String drafterName;
	 private String approverCodes;
	 private String referenceCodes;
	 private String firstApproverName;
	 private String nextApproverName;
	 private String displayApproverName;
	 private String existingApproverNames;
	 private String existingApproverCodes;
	 private String existingReferenceNames;
	 private String existingReferenceCodes;
	 private String drafterStampUrl;
}