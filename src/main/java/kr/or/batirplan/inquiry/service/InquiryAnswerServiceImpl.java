package kr.or.batirplan.inquiry.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.batirplan.inquiry.mapper.IInquiryAnswerMapper;
import kr.or.batirplan.inquiry.vo.InquiryAnswerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class InquiryAnswerServiceImpl implements IInquiryAnswerService {

    @Autowired
    private IInquiryAnswerMapper mapper;

    @Override
    public void addAnswer(InquiryAnswerVO answer) {
        log.info("댓글 추가: {}", answer);
        mapper.addAnswer(answer);
    }

    @Override
    public List<InquiryAnswerVO> getAnswers(int inqryNo) {
        return mapper.getAnswers(inqryNo);
    }

	@Override
	public void updateAnswer(InquiryAnswerVO answer) {
		mapper.updateAnswer(answer);
	}

	@Override
	public void deleteAnswer(int answerNo) {
		mapper.deleteAnswer(answerNo);
	}
}