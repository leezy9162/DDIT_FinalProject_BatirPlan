package kr.or.batirplan.equipment.vo;

import lombok.Data;

@Data
public class EquipmentVO {
    private int eqpmnNo;           // 장비 번호
    private String eqpmnNm;        // 장비 명
    private String eqpmnTy;        // 장비 유형
    private String eqpmnSn;        // 장비 일련번호
    private String makrNm;         // 제조사 명
    private int eqpmnPc;           // 장비 가격
    private String eqpmnPurchsDe;  // 장비 구매 일자
    private String eqpmnSttus;     // 장비 상태
    private String eqpmnLc;        // 장비 위치
    private String eqpmnImageCours;// 장비 이미지 경로
}
