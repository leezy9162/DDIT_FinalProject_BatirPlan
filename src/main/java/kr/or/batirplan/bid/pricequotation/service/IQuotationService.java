package kr.or.batirplan.bid.pricequotation.service;

import java.util.List;
import kr.or.batirplan.bid.pricequotation.vo.QuotationVO;
import kr.or.batirplan.common.ServiceResult;

public interface IQuotationService {
    
    // 견적서 등록
    int insertQuotation(QuotationVO vo);
    
    // 견적서 조회 (공고번호 + 회사명 + 비밀번호 기준)
    List<QuotationVO> searchQuotation(String pblancNo, String cmpnyNm, String prqudoPassword);

    // ▼ 추가: 견적서 상세 (단건) 조회
    QuotationVO selectQuotationDetail(String prqudoNo);

	int deleteQuotation(String prqudoNo, String prqudoPassword);

	// 공고번호와 사업자 번호를 통해 해당 회사가 해당 공고에 맞는 견적서를 제출했는지 필터링한다.
	ServiceResult selectQuotation(QuotationVO vo);

	String getAnnouncementTitle(String pblancNo);
}
