package kr.or.batirplan.servicemanagement.autoid.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.security.vo.MemberVO;

@Mapper
public interface AutoIdMapper {

	public int getNoIdEmplCount();

	public List<EmployeeVO> getNoIdEmplList(PaginationInfoVO<EmployeeVO> pagingVO);

	public int getNoIdCcpyCount();

	public List<CooperationcomVO> getNoIdCcpyList(PaginationInfoVO<CooperationcomVO> pagingVO);

	public void autoEmplMberProcess(List<String> selectedemplCodes);

	public void autoMberProcess(MemberVO member);

	public void autoSetEmplId(String empCode);

	public void autoSetEmplBasicAuthor(String empCode);

	public void autoSetEmplDeptAuthor(Map<String, String> paramMap);

	public void autoSetCcpyId(String ccpyCode);

	public void autoSetCcpyBasicAuthor(String ccpyCode);
	
	
}
