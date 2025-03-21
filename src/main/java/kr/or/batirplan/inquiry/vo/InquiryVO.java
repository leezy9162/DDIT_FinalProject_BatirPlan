package kr.or.batirplan.inquiry.vo;

import lombok.Data;
import java.util.Date;

@Data
public class InquiryVO {
	
	private int inqryNo;
	
    private String ty;
    
    private String sj;
    
    private String wrter;
    
    private String cn;
    
    private String writngDt;
    
    private String progrsSttus = "01";
    
    private String answerStatus;
    
    public String getProgrsSttus() {
        return progrsSttus;
    }

    public void setProgrsSttus(String progrsSttus) {
        this.progrsSttus = progrsSttus;
    }
}
