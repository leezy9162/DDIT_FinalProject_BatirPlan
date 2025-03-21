package kr.or.batirplan.cooperationcom.vo;

import lombok.Data;

@Data
public class ContractDocumentVO {
    private int ctrtcNo;             // 계약서 번호 (PK)
    private String cntrctCharger;    // 계약 담당자 (사원 코드)
    private String ccpyCode;         // 협력 업체 코드 (FK)
    private String se;               // 계약 구분 (예: '01' 용역, '02' 자재)
    private String cntrctNm;         // 계약 명
    private String cntrctCndCn;      // 계약 조건 내용
    private int cntrctAmount;        // 계약 금액
    private String bgnDe;            // 계약 시작일 (YYYYMMDD)
    private String endDe;            // 계약 종료일 (YYYYMMDD)
    private String cntrctSttus;      // 계약 상태 (예: '01' 진행중, '02' 종료)
    private String updtNtcNPrarnDe;  // 업데이트 예정일 (YYYYMMDD)
}