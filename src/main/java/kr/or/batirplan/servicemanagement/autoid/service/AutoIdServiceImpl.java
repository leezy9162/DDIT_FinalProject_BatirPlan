package kr.or.batirplan.servicemanagement.autoid.service;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.hrcard.mapper.HrCardMapper;
import kr.or.batirplan.security.vo.MemberVO;
import kr.or.batirplan.servicemanagement.autoid.mapper.AutoIdMapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AutoIdServiceImpl implements AutoIdService {
	
	@Autowired
	private AutoIdMapper autoIdMapper;
	
	@Autowired
	private HrCardMapper hrCardMapper;
	
	@Override
	public int getNoIdEmplCount() {
		return autoIdMapper.getNoIdEmplCount();
	}

	@Override
	public List<EmployeeVO> getNoIdEmplList(PaginationInfoVO<EmployeeVO> pagingVO) {
		return autoIdMapper.getNoIdEmplList(pagingVO);
	}

	@Override
	public int getNoIdCcpyCount() {
		return autoIdMapper.getNoIdCcpyCount();
	}

	@Override
	public List<CooperationcomVO> getNoIdCcpyList(PaginationInfoVO<CooperationcomVO> pagingVO) {
		return autoIdMapper.getNoIdCcpyList(pagingVO);
	}

	@Transactional
    @Override
    public void autoEmplMberProcess(List<String> selectedemplCodes) {
        for (String empCode : selectedemplCodes) {
            // 8자리 랜덤 숫자/문자 조합 생성
        	// 현재 버전은 기본 비밀번호 2222
            String rawPassword = "2222";
            // BCryptPasswordEncoder로 암호화
            BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
            String encodedPassword = bCryptPasswordEncoder.encode(rawPassword);
            log.info("[AutoIdServiceImpl] ###autoEmplMberProcess### 부여된 아이디  - 비밀번호 >>>" + empCode + " - " + rawPassword);
            
            // VO 생성 및 필드 설정 (필요한 다른 값들도 설정하세요)
            MemberVO member = new MemberVO();
            member.setMberId(empCode);
            member.setMberPassword(encodedPassword);
            member.setSeCode("01");
            member.setEnabled(1);
            
            // tb_member 테이블에 Insert 후, tb_employee에 반영
            autoIdMapper.autoMberProcess(member);
            autoIdMapper.autoSetEmplId(empCode);
            autoIdMapper.autoSetEmplBasicAuthor(empCode);
            
            // 권한 세팅을 위해 부서 정보 조회...
            EmployeeVO employeeVO = hrCardMapper.getEmployeeByEmplCode(empCode);
            String deptCode = employeeVO.getDeptCode();
            
            // 권한 insert
            Map<String, String> paramMap = new HashMap<>();
            paramMap.put("empCode", empCode);
            
            if (StringUtils.isNotBlank(deptCode)) {
            	switch (deptCode) {
					case "01": {
						paramMap.put("deptAuthor", "ROLE_MNGMT");
						break;
					}
					case "02": {
						paramMap.put("deptAuthor", "ROLE_DEPT_BILDNGPLANNG");
						break;
					}
					case "03": {
						paramMap.put("deptAuthor", "ROLE_DEPT_FNNR");
						break;
					}
					case "04": {
						paramMap.put("deptAuthor", "ROLE_DEPT_RESRCE");
						break;
					}
					case "05": {
						paramMap.put("deptAuthor", "ROLE_DEPT_IT");
						break;
					}
            	}
            	autoIdMapper.autoSetEmplDeptAuthor(paramMap);
			}
        }
    }

	@Override
	public void autoCcpyMberProcess(List<String> selectedCcpyCodes) {
		for (String ccpyCode : selectedCcpyCodes) {
			String rawPassword = "2222";
            // BCryptPasswordEncoder로 암호화
            BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
            String encodedPassword = bCryptPasswordEncoder.encode(rawPassword);
            log.info("[AutoIdServiceImpl] ###autoEmplMberProcess### 부여된 아이디  - 비밀번호 >>>" + ccpyCode + " - " + rawPassword);
            
            // VO 생성 및 필드 설정 (필요한 다른 값들도 설정하세요)
            MemberVO member = new MemberVO();
            member.setMberId(ccpyCode);
            member.setMberPassword(encodedPassword);
            member.setSeCode("02");
            member.setEnabled(1);
            
            autoIdMapper.autoMberProcess(member);
            autoIdMapper.autoSetCcpyId(ccpyCode);
            autoIdMapper.autoSetCcpyBasicAuthor(ccpyCode);
		}
	}
	
    // 8자리 랜덤 문자열 생성 (알파벳 대소문자와 숫자 포함)
    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }


	
	
}
