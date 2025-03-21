package kr.or.batirplan.inquiry.service;

import java.util.List;
import kr.or.batirplan.inquiry.vo.InquiryAnswerVO;

public interface IInquiryAnswerService {
	
    void addAnswer(InquiryAnswerVO answer);
    
    List<InquiryAnswerVO> getAnswers(int inqryNo);
    
	void updateAnswer(InquiryAnswerVO answer);
	
	void deleteAnswer(int answerNo);
}
