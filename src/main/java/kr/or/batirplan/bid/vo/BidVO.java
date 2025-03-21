package kr.or.batirplan.bid.vo;

import lombok.Data;

@Data
public class BidVO {
	
	private String pblancNo; 		/* 공고 번호 */
	private String prjctNo; 		/* 프로젝트 번호 */
	private String procsNo; 		/* 공정 번호 */
	private String pblancWrter; 	/* 공고 작성자 사원 코드 */
	private String pblancSe; 		/* 공고 구분 */
	private String pblancSj; 		/* 공고 제목 */
	private String demandCndCn; 	/* 요구 조건 내용(본문) */
	private String pblancAmount;	/* 공고 금액 */
	private String pblancBgnde; 	/* 공고 시작일 */
	private String pblancEndde; 	/* 공고 종료일 */
	private String progrsSttus; 	/* 공고 진행 상태 (01: 진행중 / 02: 마감) */
	
}
