package kr.or.batirplan.inquiry.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.inquiry.vo.InquiryAnswerVO;

@Mapper
public interface IInquiryAnswerMapper {
	
    void addAnswer(InquiryAnswerVO answer);
    
    List<InquiryAnswerVO> getAnswers(@Param("inqryNo") int inqryNo);
    
	void updateAnswer(InquiryAnswerVO answer);
	
	void deleteAnswer(int answerNo);
	
	void deleteAllAnswer(int inqryNo);
}
