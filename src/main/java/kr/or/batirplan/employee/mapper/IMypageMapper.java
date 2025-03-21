package kr.or.batirplan.employee.mapper;

import kr.or.batirplan.employee.vo.EmployeeVO;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface IMypageMapper {
    public EmployeeVO findEmployeeById(@Param("emplCode") String emplCode);
    public int updateAccountInfo(@Param("emplCode") String emplCode, 
                          @Param("bankCode") String bankCode, 
                          @Param("accountNumber") String accountNumber);
	public String selectEmpCodeByName(@Param("emplName") String emplName);
}