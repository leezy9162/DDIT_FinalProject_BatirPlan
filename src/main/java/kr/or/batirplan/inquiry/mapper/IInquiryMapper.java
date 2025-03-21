package kr.or.batirplan.inquiry.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.inquiry.vo.InquiryVO;

@Mapper
public interface IInquiryMapper {

    List<InquiryVO> list();
    
    void register(InquiryVO inquiry);
    
    InquiryVO read(@Param("inqryNo") int inqryNo);
    
    void update(InquiryVO inquiry);
    
    void remove(int inqryNo);
    
    List<InquiryVO> searchInquiries(@Param("searchKeyword") String searchKeyword);

	int selectInquiryCount(PaginationInfoVO<InquiryVO> pagingVO);

	List<InquiryVO> selectInquiryList(PaginationInfoVO<InquiryVO> pagingVO);
}
