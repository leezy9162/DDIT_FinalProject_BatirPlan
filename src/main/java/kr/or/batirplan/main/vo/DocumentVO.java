package kr.or.batirplan.main.vo;

import lombok.Data;
import java.util.Date;

@Data
public class DocumentVO {
    private Long docNo;          // 문서 번호
    private String sj;           // 제목
    private String sttus;        // 상태 (진행중, 기안중, 완료 등)
    private Date approvalDate;   // 승인일자
    private String role;         // 역할 (기안자, 결재자, 참조자)
}
