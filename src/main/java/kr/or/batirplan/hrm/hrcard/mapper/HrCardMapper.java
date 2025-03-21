package kr.or.batirplan.hrm.hrcard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.hrcard.vo.HrCardSearchVO;

@Mapper
public interface HrCardMapper {

	public int insertEmployee(EmployeeVO employeeVO);

	public int setEmployeEmplImageCours(EmployeeVO employeeVO);

	public EmployeeVO getEmployeeByEmplCode(String emplCode);

	public int modifyEmployee(EmployeeVO employeeVO);

	public int getEmployeeCount(@Param("searchVO") HrCardSearchVO searchVO);
	
	/**
	 * <필터링된 사원 정보 & 페이지네이션을 위한 메서드>
	 * - searchWord와 searchType이 하나가 아니기때문에 파라미터 2개를 던짐.
	 * - 2개의 파라미터를 던져야 해서 어노테이션 붙임.
	 * - 쿼리문에서도 어떤 파라미터의 변수인지 표시해야 함.
	 * @author leezy
	 * @param searchVO 검색 필터를 위한 VO
	 * @param pagingVO 페이지네이션을 위한 VO
	 * @return 필터링된 페이지네이션 사원 리스트
	 */
	public List<EmployeeVO> getEmployeeList(@Param("searchVO") HrCardSearchVO searchVO,@Param("pagingVO") PaginationInfoVO<EmployeeVO> pagingVO);

	public int emplRetireProcess(String emplCode);

}
