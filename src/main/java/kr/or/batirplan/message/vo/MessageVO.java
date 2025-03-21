package kr.or.batirplan.message.vo;

import lombok.Data;
import java.util.Date;

@Data
public class MessageVO {
    private int mssageNo;         // 쪽지 번호
    private String dsptcher;      // 발신자 사원 코드
    private String cn;            // 쪽지 내용
    private Date sndngDt;         // 발송 일시
    private String messageSttus;  // 쪽지 상태 (읽음, 읽지 않음)
    private String recovryPosblAt; // 복구 가능 여부 (Y/N)
    private String dsptcherName; // 발신자 이름
    private String rcverName;
}