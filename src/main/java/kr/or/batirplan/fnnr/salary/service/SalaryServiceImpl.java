package kr.or.batirplan.fnnr.salary.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.fnnr.salary.mapper.ISalaryMapper;
import kr.or.batirplan.fnnr.salary.vo.SalaryVO;

@Service
public class SalaryServiceImpl implements ISalaryService {

    private final ISalaryMapper salaryMapper;

    @Autowired
    public SalaryServiceImpl(ISalaryMapper salaryMapper) {
        this.salaryMapper = salaryMapper;
    }

    @Override
    public List<SalaryVO> getAllSalaries() {
        return salaryMapper.getAllSalaries();
    }

    @Override
    public List<SalaryVO> getUnpaidEmployees(String salaryYm) {
        return salaryMapper.getUnpaidEmployees(salaryYm);
    }

    @Override
    public List<SalaryVO> getPaidEmployees(String salaryYm) {
        return salaryMapper.getPaidEmployees(salaryYm);
    }

    @Override
    public boolean processSalaryPayment(String salaryYm, String emplCode) {
        try {
            int count = salaryMapper.countSalaryPayments(salaryYm, emplCode);
            if (count > 0) {
                System.out.println("[LOG] 급여 지급 실패: 이미 지급된 직원 (" + emplCode + ")");
                return false;
            }
            salaryMapper.processSalaryPayment(salaryYm, emplCode);
            System.out.println("[LOG] 급여 지급 성공: 직원 코드 (" + emplCode + ")");
            return true;
        } catch (Exception e) {
            System.err.println("[ERROR] 급여 지급 오류 발생: " + e.getMessage());
            return false;
        }
    }
}

