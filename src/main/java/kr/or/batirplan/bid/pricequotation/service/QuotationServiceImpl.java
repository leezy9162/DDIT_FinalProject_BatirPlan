package kr.or.batirplan.bid.pricequotation.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.bid.pricequotation.mapper.IQuotationMapper;
import kr.or.batirplan.bid.pricequotation.vo.QuotationVO;
import kr.or.batirplan.common.ServiceResult;

@Service
public class QuotationServiceImpl implements IQuotationService {

    @Autowired
    private IQuotationMapper quotationMapper;

    @Override
    public int insertQuotation(QuotationVO vo) {
        // DB Insert
        int cnt = quotationMapper.insertQuotation(vo);
        // 이후 vo.getPrqudoNo()에 새 PK가 세팅될 수도 있음 (useGeneratedKeys=true가 제대로 동작할 경우)
        return cnt;
    }

    @Override
    public List<QuotationVO> searchQuotation(String pblancNo, String cmpnyNm, String prqudoPassword) {
        return quotationMapper.searchQuotation(pblancNo, cmpnyNm, prqudoPassword);
    }

    // ▼ 추가: 단건 상세 조회
    @Override
    public QuotationVO selectQuotationDetail(String prqudoNo) {
        return quotationMapper.selectQuotationDetail(prqudoNo);
    }

    @Override
    public int deleteQuotation(String prqudoNo, String prqudoPassword) {
        return quotationMapper.deleteQuotation(prqudoNo, prqudoPassword);
    }

	@Override
	public ServiceResult selectQuotation(QuotationVO vo) {
		ServiceResult result = null;
		QuotationVO qVO = quotationMapper.selectQuotation(vo);
		if(qVO != null) {	// 지원한 공고에 따른 견적서가 존재함
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		return result;
	}

	@Override
	public String getAnnouncementTitle(String pblancNo) {
	    return quotationMapper.getAnnouncementTitle(pblancNo);
	}
}
