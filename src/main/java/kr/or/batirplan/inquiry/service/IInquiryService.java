package kr.or.batirplan.inquiry.service;

import java.util.List;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.inquiry.vo.InquiryVO;

public interface IInquiryService {
    
    List<InquiryVO> list();
    
    void register(InquiryVO inquiry);
    
    InquiryVO read(int inqryNo);
    
    void update(InquiryVO inquiry);
    
    void remove(int inqryNo);
    
    List<InquiryVO> searchInquiries(String searchKeyword);

	int selectInquiryCount(PaginationInfoVO<InquiryVO> pagingVO);

	List<InquiryVO> selectInquiryList(PaginationInfoVO<InquiryVO> pagingVO);
}
