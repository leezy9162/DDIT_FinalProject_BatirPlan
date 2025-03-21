package kr.or.batirplan.hrm.certification.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.or.batirplan.hrm.certification.vo.CertificationVO;

@Mapper
public interface ICertificationMapper {
    List<CertificationVO> searchEmployees(@Param("searchKeyword") String searchKeyword);

    CertificationVO getCertification(@Param("emplCode") String emplCode, @Param("type") String type);
}
