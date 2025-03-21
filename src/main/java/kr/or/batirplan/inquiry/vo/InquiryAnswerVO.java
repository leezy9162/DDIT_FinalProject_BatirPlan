package kr.or.batirplan.inquiry.vo;

import lombok.Data;
import java.util.Date;

@Data
public class InquiryAnswerVO {
	
    private int answerNo;         
    
    private int inqryNo;     
    
    private String answrr;  
    
    private String answerCn; 
    
    private Date answerRegistDt;  
}
