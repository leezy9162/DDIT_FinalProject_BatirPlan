package kr.or.batirplan.noticeboard.vo;



import java.util.Date;

import lombok.Data;

@Data
public class NoticeBoardVO {
    private int bbscttNo;       // 게시글 번호
    private String sj;          // 제목
    private String cn;          // 내용
    private String writer;      // 작성자
    private Date writingDt;  // 작성일자
    private int rdCnt;          // 조회수
    private String clCode = "a001"; // 기본값을 5자 이내로 설정
    
    private int displayNo;  
}
