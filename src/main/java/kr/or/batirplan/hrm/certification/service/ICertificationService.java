package kr.or.batirplan.hrm.certification.service;

import java.util.List;

import kr.or.batirplan.hrm.certification.vo.CertificationVO;

public interface ICertificationService {
	
    List<CertificationVO> searchEmployees(String searchKeyword);
    
    CertificationVO getCertification(String emplCode, String type);
}
