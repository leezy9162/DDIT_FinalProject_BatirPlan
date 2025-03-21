package kr.or.batirplan.fnnr.salary.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.fnnr.salary.vo.SalaryVO;

@Mapper
public interface ISalaryMapper {
    List<SalaryVO> getAllSalaries();
    List<SalaryVO> getUnpaidEmployees(String salaryYm);
    List<SalaryVO> getPaidEmployees(String salaryYm);
    int countSalaryPayments(String salaryYm, String emplCode);
    void processSalaryPayment(String salaryYm, String emplCode);
}
