package kr.or.batirplan.resrce.order.vo;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * 발주 요청 VO
 * 발주 요청 정보를 담는 객체
 */
@Data
public class ReqVO {
    
    private String reqNo;         /* 요청 번호 */
    private String reqType;       /* 요청 타입 (1: 수동 / 2: 자동) */
    private Date reqDate;       /* 요청 일자 */
    private String reqSttus;      /* 요청 상태 (1: 요청중 / 2: 승인 / 3: 완료 / 4: 반려) */
    private String suplrCode;     /* 협력 업체 코드 */
    private String suplrNm;     /* 협력 업체 코드 */
    private String reqstrNm;    /* 요청 사원 코드 */
    private String reqstrCode;    /* 요청 사원 코드 */
    private String remarks;       /* 요청 비고 */
    private String cancelReason;  /* 요청 반려 사유 */
    
    private List<ReqDetailVO> details; /* 요청 상세 목록 (1:N 관계) */
}
