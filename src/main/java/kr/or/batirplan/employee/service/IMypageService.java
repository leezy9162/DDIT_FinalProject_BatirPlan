package kr.or.batirplan.employee.service;

import kr.or.batirplan.employee.vo.EmployeeVO;

public interface IMypageService {
    public boolean updateEmployeeAccount(String emplCode, String bankCode, String accountNumber);
    public EmployeeVO getEmployeeById(String emplCode);
}