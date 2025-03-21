package kr.or.batirplan.hrm.certification.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.hrm.certification.mapper.ICertificationMapper;
import kr.or.batirplan.hrm.certification.vo.CertificationVO;

@Service
public class CertificationServiceImpl implements ICertificationService {

    @Autowired
    private ICertificationMapper certificationMapper;

    @Override
    public List<CertificationVO> searchEmployees(String searchKeyword) {
        return certificationMapper.searchEmployees(searchKeyword);
    }

    @Override
    public CertificationVO getCertification(String emplCode, String type) {
        if (emplCode == null || emplCode.isEmpty()) {
            throw new IllegalArgumentException("사원 코드(emplCode)는 필수 입력 사항입니다.");
        }
        return certificationMapper.getCertification(emplCode, type);
    }
}
