package kr.or.batirplan.message.vo;

import lombok.Data;

@Data
public class MessageReceptionVO {
    private int recptnNo;       // 수신 번호
    private int mssageNo;       // 쪽지 번호
    private String rcver;       // 수신자 사원 코드
    private String recptnDt;    // 수신 일시
    private String messageSttus; // 쪽지 읽음 여부
    private String recovryPosblAt; // 복구 가능 여부 (Y/N)
    private String dsptcher;  // 발신자
    private String cn;         // 내용
    private String dsptcherName; // 발신자 이름
    
}