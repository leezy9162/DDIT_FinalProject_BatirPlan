package kr.or.batirplan.electronicdocument.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	private int commentNo;
	private int docNo;
	private String wrter;
	private String cn;
	private Date writngDt;
}