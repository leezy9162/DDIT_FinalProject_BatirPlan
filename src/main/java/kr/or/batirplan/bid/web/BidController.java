package kr.or.batirplan.bid.web;

import java.util.List;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType; // (추가)
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping; // (추가)
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart; // (추가)
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile; // (추가)

import kr.or.batirplan.bid.service.IBidService;
import kr.or.batirplan.bid.vo.BidVO;
import kr.or.batirplan.common.vo.PaginationInfoVO;

@RestController
@RequestMapping("/api/announcements")
public class BidController {

    @Autowired
    private IBidService bidService;
    
    @GetMapping(value="/bidWithList")
    public PaginationInfoVO<BidVO> selectBidWithList(
        @RequestParam(defaultValue = "1") int currentPage,
        @RequestParam(defaultValue = "") String searchWord
    ) {
        PaginationInfoVO<BidVO> pagingVO = new PaginationInfoVO<>();
        pagingVO.setCurrentPage(currentPage);

        if(StringUtils.isNotBlank(searchWord)) {
            pagingVO.setSearchWord(searchWord);
        }
        
        int totalRecord = bidService.selectBidsWithCount(pagingVO);
        pagingVO.setTotalRecord(totalRecord);
        
        List<BidVO> dataList = bidService.selectBidsWithList(pagingVO);
        pagingVO.setDataList(dataList);
        
        return pagingVO;
    }
    
    @GetMapping(value="/bidWithAllList")
    public List<BidVO> selectBidWithAllList() {
    	return bidService.selectBidWithAllList();
    }
    
    @GetMapping(value="/bidDetail")
    public BidVO selectBidDetail(@RequestParam String pblancNo) {
        return bidService.selectBidDetail(pblancNo);
    }
    
    // ▼▼▼ 예시 파일 업로드 API (TB_ATTACHMENT_FILE에 넣으려면 비슷한 로직 필요)
    @PostMapping(value="/uploadFile", consumes=MediaType.MULTIPART_FORM_DATA_VALUE)
    public String uploadFile(
        @RequestParam(required=false) String pblancNo,
        @RequestPart(required=false) MultipartFile file
    ) {
        // TODO: 실제 파일 저장/DB 저장 로직
        if (file != null && !file.isEmpty()) {
            // 1) 서버에 저장
            // 2) AttachmentFileVO에 set
            // 3) attachmentFileService.insertFile(...)
        }
        return "File uploaded successfully. pblancNo = " + pblancNo;
    }
}
