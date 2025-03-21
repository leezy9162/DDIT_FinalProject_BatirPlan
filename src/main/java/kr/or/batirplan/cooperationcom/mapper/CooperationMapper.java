package kr.or.batirplan.cooperationcom.mapper;

import org.apache.ibatis.annotations.Mapper;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import java.util.List;

@Mapper
public interface CooperationMapper {
    String generateCooperationCode();  // 협력업체 코드 생성
    void insertCooperation(CooperationcomVO cooperationVO);  // 협력업체 정보 저장
    List<EmployeeVO> getEmployeeList();  // 사원 목록 조회 (담당자 선택용)
    
    // 리스트 조회용 (검색 필터와 페이지네이션)
    List<CooperationcomVO> selectCooperationList(String ccpyNm, String bizrno, String ccpyCl, int offset, int limit);
    int selectCooperationCount(String ccpyNm, String bizrno, String ccpyCl);
}
