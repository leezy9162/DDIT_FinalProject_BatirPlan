package kr.or.batirplan.employee.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.batirplan.employee.mapper.IMypageMapper;
import kr.or.batirplan.employee.vo.EmployeeVO;

@Service
public class MypageServiceImpl implements IMypageService {

    @Autowired
    private IMypageMapper mypageMapper;

    @Override
    public boolean updateEmployeeAccount(String emplCode, String bankCode, String accountNumber) {
        int updatedRows = mypageMapper.updateAccountInfo(emplCode, bankCode, accountNumber);
        return updatedRows > 0;
    }

    @Override
    public EmployeeVO getEmployeeById(String emplCode) {
        return mypageMapper.findEmployeeById(emplCode);
    }
}
