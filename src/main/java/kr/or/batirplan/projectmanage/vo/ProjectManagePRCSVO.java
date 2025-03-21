package kr.or.batirplan.projectmanage.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProjectManagePRCSVO {
	
	private int    procsNo      ;    // 공정 번호
	private int    prjctNo      ;    // 프로젝트 번호
	private String procsNm      ;    // 공정 이름
	private String procsCn      ;    // 공정 내용
	private Date   procsBgnde   ;    // 공정 시작일 
	private Date   procsEndde   ;    // 공정 종료일
	private String progrsSttus  ;    // 공정 진행상태 (01: 진행전 / 02: 진행중 / 03: 완료)
	private String kpiAt        ;    // KPI 여부
	private int    procsPrgs    ;    // 공정 진척도 (현재는 varchar2인데 물어보고 관계없음 고쳐야함)
	private int    procsOrdr    ;    // 공정 순서
	private String ccpyCode     ;    // 담당 협력 업체 코드
	
	private int    pblancAmount ;	 // 공정별 금액
	private String ccpyNm	    ;    // 담당 협력 업체 이름
	private List<ProjectManageSFTYCHKVO> saftyList	;	// 공정별 체크리스트 상세
}
