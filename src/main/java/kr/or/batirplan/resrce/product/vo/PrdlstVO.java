package kr.or.batirplan.resrce.product.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PrdlstVO {
	private int 	prdlstNo           	 ;	// 품목 코드
	private String 	ccpyCode             ;	// 공급 협력업체 코드
 	private int 	ctgryNo              ;  // 카테고리 번호
	private String 	prdlstNm             ;  // 품목 이름
	private String 	prdlstStndrd         ;  // 품목 규격
	private String 	prdlstUnit           ;  // 품목 단위
	private String 	prdlstPrice          ;  // 품목 단가
	private int 	nowInvntryQy         ;  // 현재 재고 수량
	private int 	safeInvntryQy        ;  // 안전 재고 수량
	private String 	prdlstImageCours     ;  // 품목 이미지 경로
	
	// 품목 사진 데이터를 받기 위한 필드
	// upload/pldst/prdlstCode별로 관리될 예정
	private MultipartFile prdlstImage	   ;
	private int levelOneCtgry;
	private int levelTwoCtgry;
	
	private String levelOneCtgryNm;
	private String levelTwoCtgryNm;
	private String ctgryNm        ;  // 카테고리 번호
	
	private String 	ccpyNm	             ;	// 공급 협력업체 코드
}
