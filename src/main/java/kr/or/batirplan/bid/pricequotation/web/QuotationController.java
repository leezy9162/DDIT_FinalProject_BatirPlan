package kr.or.batirplan.bid.pricequotation.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.attachmentfile.service.IAttachmentFileService;
import kr.or.batirplan.attachmentfile.vo.AttachmentFileVO;
import kr.or.batirplan.bid.pricequotation.service.IQuotationService;
import kr.or.batirplan.bid.pricequotation.vo.QuotationVO;
import kr.or.batirplan.common.ServiceResult;

@RestController
@RequestMapping("/api")
public class QuotationController {

    @Autowired
    private IQuotationService quotationService;

    @Autowired
    private IAttachmentFileService attachmentFileService;

    // 1) 견적서 등록
    @PostMapping(value="/quotation", consumes=MediaType.MULTIPART_FORM_DATA_VALUE)
    public String insertQuotation(
        @RequestParam(required=false) String pblancNo,
        @RequestParam(required=false) String cmpnyNm,
        @RequestParam(required=false) String rprsntvNm,
        @RequestParam(required=false) String bizrno,
        @RequestParam(required=false) String cmpnyTelno,
        @RequestParam(required=false) String mbtlnum,
        @RequestParam(required=false) String prqudoSj,
        @RequestParam(required=false) String prqudoCn,
        @RequestParam(required=false) String prqudoPassword,
        @RequestPart(required=false) MultipartFile file
    ) {
        // 1) VO 세팅
        QuotationVO vo = new QuotationVO();
        vo.setPblancNo(pblancNo);
        vo.setCmpnyNm(cmpnyNm);
        vo.setRprsntvNm(rprsntvNm);
        vo.setBizrno(bizrno);
        vo.setCmpnyTelno(cmpnyTelno);
        vo.setMbtlnum(mbtlnum);
        vo.setPrqudoSj(prqudoSj);
        vo.setPrqudoCn(prqudoCn);
        vo.setPrqudoPassword(prqudoPassword);
        
        ServiceResult res = quotationService.selectQuotation(vo);
        if(res.equals(ServiceResult.EXIST)) {
        	return ServiceResult.EXIST.toString();
        }
        
        // 2) 견적서 DB 저장
        int result = quotationService.insertQuotation(vo);
        // 여기서 vo.getPrqudoNo()에 값이 있어야 첨부파일과 매핑 가능
        // (Oracle 환경에서는 useGeneratedKeys 설정이 잘 안 먹을 수 있으므로 주의)

        // 3) 파일 처리
        if (file != null && !file.isEmpty()) {
            // (1) 서버에 저장할 파일명 (UUID + 확장자)
            String originalFilename = file.getOriginalFilename();
            if (originalFilename == null) {
                originalFilename = "unknown";
            }
            String ext = "";
            int dotIndex = originalFilename.lastIndexOf(".");
            if (dotIndex != -1) {
                ext = originalFilename.substring(dotIndex); 
            }
            String uuid = UUID.randomUUID().toString();
            String saveFileName = uuid + ext;

            // (2) 실제 저장 경로
            String uploadDir = "C:/upload/quotation"; 
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File dest = new File(dir, saveFileName);

            // (3) 파일 저장
            try {
                file.transferTo(dest);
            } catch (IOException e) {
                e.printStackTrace();
                return "FAIL - file upload error";
            }

            // (4) 첨부파일 테이블에 INSERT (TB_ATTACHMENT_FILE)
            AttachmentFileVO fileVO = new AttachmentFileVO();
            // fileNo는 AttachmentFileServiceImpl에서 자동 생성 (NUMBER 컬럼이면 직접 숫자 생성)
            fileVO.setTableTy("QTN");          // "QUOTATION" 대신 짧게 "QTN"
            fileVO.setTableNo(vo.getPrqudoNo());// 견적서 PK
            fileVO.setFileNm(saveFileName);    
            fileVO.setFileMg(file.getSize());  
            fileVO.setFileMime(file.getContentType());
            fileVO.setFileTy(ext.replace(".", "")); 
            fileVO.setFileCours(dest.getAbsolutePath());
            // 필요하다면 originalFilename 등을 추가로 저장

            attachmentFileService.insertFile(fileVO);
        }

        // 4) 결과 반환
        return (result > 0) ? "SUCCESS" : "FAIL";
    }

    // 2) 견적서 조회 (공고번호 + 회사명 + 비밀번호) - 다중 건 조회
    @GetMapping("/quotation")
    public List<QuotationVO> searchQuotation(
        @RequestParam String pblancNo,
        @RequestParam String cmpnyNm,
        @RequestParam String prqudoPassword
    ) {
        return quotationService.searchQuotation(pblancNo, cmpnyNm, prqudoPassword);
    }

    // ▼▼ 추가: 견적서 상세 (단건) 조회 API 예시 ▼▼
    // (만약 필요하다면, Mapper에 LEFT JOIN 쿼리로 첨부파일을 가져오도록 구성)
    @GetMapping("/quotationDetail")
    public QuotationVO getQuotationDetail(@RequestParam String prqudoNo) {
        // Service에 단건 조회용 메서드 추가
        return quotationService.selectQuotationDetail(prqudoNo);
    }
    
    @DeleteMapping("/quotation")
    public String deleteQuotation(
        @RequestParam String prqudoNo,
        @RequestParam String prqudoPassword
    ) {
        int result = quotationService.deleteQuotation(prqudoNo, prqudoPassword);
        return (result > 0) ? "SUCCESS" : "FAIL";
    }
    
 // 공고 제목 조회 API
    @GetMapping("/announcementTitle")
    public String getAnnouncementTitle(@RequestParam String pblancNo) {
        String title = quotationService.getAnnouncementTitle(pblancNo);
        return (title != null) ? title : "제목 없음";
    }
}
