package kr.or.batirplan.project.projectplan.vo;

import java.util.Date;

import lombok.Data;

@Data
public class DateDetailCheckHistoryVO {
	private int procsChklstDetailNo;
	private int procsChklstNo;
	private int procsNo;
	private int prjctNo;
	private Date checkDe;
}