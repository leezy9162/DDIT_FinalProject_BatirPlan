package kr.or.batirplan.fnnr.salary.service;

import java.util.List;

import kr.or.batirplan.fnnr.salary.vo.SalaryVO;

public interface ISalaryService {
    List<SalaryVO> getAllSalaries();
    List<SalaryVO> getUnpaidEmployees(String salaryYm);
    List<SalaryVO> getPaidEmployees(String salaryYm);
    boolean processSalaryPayment(String salaryYm, String emplCode);
}
