package kr.or.batirplan.hrm.hrcard.vo;

import lombok.Data;

@Data
public class HrCardSearchVO {
    private String emplCode;       // 사원코드
    private String emplNm;         // 사원명
    private String deptCode;       // 소속 부서
    private String clsfCode;       // 직급
    private String email;          // 이메일
    private String mbtlnum;        // 휴대폰 번호

    // 날짜 검색 조건 (입사일, 퇴사일 범위)
    private String hireDateStart;  // 입사일 시작
    private String hireDateEnd;    // 입사일 종료
    private String retireDateStart;// 퇴사일 시작
    private String retireDateEnd;  // 퇴사일 종료

    private String hffcSttus;      // 재직 상태 (재직, 휴직, 퇴사)
}
