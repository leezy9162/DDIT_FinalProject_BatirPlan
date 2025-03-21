package kr.or.batirplan.bid.pricequotation.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.bid.pricequotation.vo.QuotationVO;

@Mapper
public interface IQuotationMapper {

    // 견적서 등록
    int insertQuotation(QuotationVO vo);

    // 견적서 조회 (공고번호 + 회사명 + 비밀번호)
    List<QuotationVO> searchQuotation(
        @Param("pblancNo") String pblancNo,
        @Param("cmpnyNm") String cmpnyNm,
        @Param("prqudoPassword") String prqudoPassword
    );
    
    QuotationVO selectQuotationDetail(String prqudoNo);
    
    int deleteQuotation(@Param("prqudoNo") String prqudoNo, @Param("prqudoPassword") String prqudoPassword);

	QuotationVO selectQuotation(QuotationVO vo);

	String getAnnouncementTitle(@Param("pblancNo") String pblancNo);
}
