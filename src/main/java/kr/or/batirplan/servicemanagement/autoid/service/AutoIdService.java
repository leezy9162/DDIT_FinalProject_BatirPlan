package kr.or.batirplan.servicemanagement.autoid.service;

import java.util.List;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;

public interface AutoIdService {
	
	
	public int getNoIdEmplCount();

	public List<EmployeeVO> getNoIdEmplList(PaginationInfoVO<EmployeeVO> pagingVO);

	public int getNoIdCcpyCount();

	public List<CooperationcomVO> getNoIdCcpyList(PaginationInfoVO<CooperationcomVO> pagingVO);

	public void autoEmplMberProcess(List<String> selectedemplCodes);

	public void autoCcpyMberProcess(List<String> selectedCcpyCodes);


}
