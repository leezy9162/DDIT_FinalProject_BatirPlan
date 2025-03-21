package kr.or.batirplan.attachmentfile.vo;

import lombok.Data;

@Data
public class AttachmentFileVO {
    private String fileNo;      // 첨부파일 번호 (PK)
    private String tableTy;     // 첨부파일이 속한 테이블 타입 (예: "QUOTATION")
    private String tableNo;     // 첨부파일이 연결된 테이블의 PK (예: 견적서 번호)
    private String fileNm;      // 서버에 저장된 파일명
    private Long fileMg;        // 파일 크기 (바이트)
    private String fileMime;    // MIME 타입 (예: "image/png")
    private String fileTy;      // 파일 유형 (확장자 등)
    private String fileCours;   // 파일 저장 경로
    // 원본 파일명을 저장하고 싶으면 추가 필드 사용 가능
    // private String originalNm;
}
