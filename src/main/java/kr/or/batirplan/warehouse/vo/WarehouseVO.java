package kr.or.batirplan.warehouse.vo;

import lombok.Data;

@Data
public class WarehouseVO {
    private String wrHousCode;        // 창고 코드
    private String wrHousNm;          // 창고명
    private String wrHousLc;          // 창고 위치
    private String wrHousDetailAdres; // 창고 상세 주소
    private String wrHousZip;         // 전화번호 (우편번호 필드 활용)
    private String wrHousOperSttus;   // 운영 상태 (운영 중 / 폐쇄)
    private String partclrMatter;     // 특이사항 (등록일 대체)
    
   // private String wrHousImageCours;  // 📌 창고 이미지 경로 추가
    private boolean hasMaterials;     // 창고에 자재가 있는지 여부
}
