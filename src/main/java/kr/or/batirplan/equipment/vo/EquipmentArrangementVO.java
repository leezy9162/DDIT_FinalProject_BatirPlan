package kr.or.batirplan.equipment.vo;

import lombok.Data;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@Data
public class EquipmentArrangementVO {
    private int requestNo;           // 배치 신청 번호
    private int prjctNo;             // 프로젝트 번호
    private String prjctNm;          // 프로젝트명 (JOIN으로 가져옴)
    private String prjctLc;          // 프로젝트 위치 (JOIN으로 가져옴)
    private String emplCode;         // 신청자(사원) 코드
    private String emplNm;           // 신청자 이름 (JOIN으로 가져옴)
    private int eqpmnNo;             // 장비 번호
    private String eqpmnNm;          // 장비명 (JOIN으로 가져옴)
    private String eqpmnTy;          // 장비 유형 (JOIN)
    private String eqpmnSn;          // 장비 일련번호 (JOIN)
    private String makrNm;           // 제조사 명 (JOIN)
    private Date requestDate;        // 신청 일자
    private String approvalStatus;   // 승인 여부 ('01': 미승인, '02': 승인)
    
    
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")  // ✅ 변환 설정 추가
    private Date rentalStartDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")  // ✅ 변환 설정 추가
    private Date rentalEndDate;
    
    
    private String arrangementReason;
}
