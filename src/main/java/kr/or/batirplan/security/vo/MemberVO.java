package kr.or.batirplan.security.vo;

import java.util.List;

import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import lombok.Data;

@Data
public class MemberVO {
	private String mberId;
	private String mberPassword;
	private String seCode;
	private int enabled;
	private EmployeeVO empVO;
	private CooperationcomVO ccpyVO;
	private List<MemberAuthVO> auths;
}
