package kr.or.batirplan.cooperationcom.service;

import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import java.util.List;

public interface ICooperationService {
    String generateCooperationCode();  // 협력업체 코드 생성
    void insertCooperation(CooperationcomVO cooperationVO);  // 협력업체 정보 저장
    List<EmployeeVO> getEmployeeList();  // 사원 목록 조회 (담당자 선택용)
    
    // 리스트 조회
    List<CooperationcomVO> selectCooperationList(String ccpyNm, String bizrno, String ccpyCl, int offset, int limit);
    int selectCooperationCount(String ccpyNm, String bizrno, String ccpyCl);
}
