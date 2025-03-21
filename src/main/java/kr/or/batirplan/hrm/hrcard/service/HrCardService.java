package kr.or.batirplan.hrm.hrcard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.hrcard.vo.HrCardSearchVO;

public interface HrCardService {

	public int insertEmployee(EmployeeVO employeeVO);

	public EmployeeVO getEmployeeByEmplCode(String emplCode);

	public int modifyEmployee(EmployeeVO employeeVO);

	
	
	public List<EmployeeVO> getEmployeeList(HrCardSearchVO searchVO, PaginationInfoVO<EmployeeVO> pagingVO);
	public int getEmployeeCount(HrCardSearchVO searchVO);

	public int emplRetireProcess(String emplCode);

}
