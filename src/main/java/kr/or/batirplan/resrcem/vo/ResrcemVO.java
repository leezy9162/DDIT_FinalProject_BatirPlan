package kr.or.batirplan.resrcem.vo;

import lombok.Data;

@Data
public class ResrcemVO {
    private int rcordNo;         // 기록 번호
    private String wrhousCode;   // 창고 코드
    private int prdlstNo;        // 품목 번호
    private String prdlstNm;     // 품목명
    private String prjctNm;      // 프로젝트명
    private String prjctNo;      // 프로젝트 번호 (출고 시 사용)
    private String ordrDeNo;     // 발주 상세 번호 (입고 시 사용)
    private String wrhsdlvrTy;   // 입출고 유형 (입고, 출고)
    private int wrhsdlvrQy;      // 입출고 수량
    private String wrhsdlvrDe;   // 입출고 날짜 (YYYYMMDD)
    private String rm;           // 비고 (설명)

    private String source;       // 입출고 구분명 (출고 시 프로젝트 번호, 입고 시 발주 상세 번호)
}
