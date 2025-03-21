package kr.or.batirplan.resrce.order.vo;

import lombok.Data;

@Data
public class ReqSearchVO {
	
	private int reqType;     // 발주 구분 (1: 수동, 2: 자동)
	private String reqDateS;    // 발주 검색 시작 날짜
	private String reqDateE;    // 발주 검색 종료 날짜
	private String reqstrNm;    // 발주자 명
	private String reqstrCode;  // 발주자 코드
	private String suplrNm;     // 협력업체 명
	private String suplrCode;   // 협력 업체 코드
	private int reqSttus;    // 발주 요청 상태 (1: 요청중, 2: 발주 승인, 3: 입고 완료, 4: 반려)
	
	private int    currentPage; // 현재 페이지 번호		
}
