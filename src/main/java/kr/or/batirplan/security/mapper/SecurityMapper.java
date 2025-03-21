package kr.or.batirplan.security.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.security.vo.MemberVO;

@Mapper
public interface SecurityMapper {

	public MemberVO readByUserInfo(Map<String, String> param);
	
}
