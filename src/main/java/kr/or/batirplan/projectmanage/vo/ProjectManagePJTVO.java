package kr.or.batirplan.projectmanage.vo;

import lombok.Data;

@Data
public class ProjectManagePJTVO {
	
	private int    prjctNo             ;   // 프로젝트 번호
	private String charger             ;   // 프로젝트 담당자 사원 코드
	private String prjctNm             ;   // 프로젝트 이름
	private String prjctCtgry          ;   // 프로젝트 카테고리
	private String prjctCn             ;   // 프로젝트 내용
	private int    prjctBudget         ;   // 프로젝트 예산
	private String prjctProgrsSttus    ;   // 프로젝트 진행 상태
	private String prjctBgnde          ;   // 프로젝트 시작일
	private String prjctEndde          ;   // 프로젝트 종료일
	private String prjctLc             ;   // 프로젝트 위치
	private String prjctProgrsAt       ;   // 프로젝트 진행 여부(사용 x)
	private String sptMngr             ;   // 프로젝트 현장 관리자 사원 코드
	private String planSttus           ;   // 프로젝트 계획 상태
	
	private int    allPrgs			   ;   // 전체 진척도
	
	private String chargerNm		   ;   // 담당자 사원명
	private String sptMngrNm		   ;   // 현장 관리자 사원명
	
	
	
	
}
