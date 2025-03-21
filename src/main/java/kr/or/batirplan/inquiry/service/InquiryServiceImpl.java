package kr.or.batirplan.inquiry.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.inquiry.mapper.IInquiryAnswerMapper;
import kr.or.batirplan.inquiry.mapper.IInquiryMapper;
import kr.or.batirplan.inquiry.vo.InquiryVO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InquiryServiceImpl implements IInquiryService {
	
	@Autowired
    private final IInquiryMapper inquiryMapper;
	
	@Autowired
    private IInquiryAnswerMapper inquiryAnswerMapper;
    
    @Override
    public List<InquiryVO> list() {
        return inquiryMapper.list();
    }

    @Override
    public void register(InquiryVO inquiry) {
        inquiryMapper.register(inquiry);
    }

    @Override
    public InquiryVO read(int inqryNo) {
        return inquiryMapper.read(inqryNo);
    }

    @Override
    public void update(InquiryVO inquiry) {
        inquiryMapper.update(inquiry);
    }

    @Override
    public void remove(int inqryNo) {
    	inquiryAnswerMapper.deleteAllAnswer(inqryNo);
        inquiryMapper.remove(inqryNo);
    }

    @Override
    public List<InquiryVO> searchInquiries(String searchKeyword) {
        return inquiryMapper.searchInquiries(searchKeyword);
    }

	@Override
	public int selectInquiryCount(PaginationInfoVO<InquiryVO> pagingVO) {
		return inquiryMapper.selectInquiryCount(pagingVO);
	}

	@Override
	public List<InquiryVO> selectInquiryList(PaginationInfoVO<InquiryVO> pagingVO) {
		return inquiryMapper.selectInquiryList(pagingVO);
	}
}
