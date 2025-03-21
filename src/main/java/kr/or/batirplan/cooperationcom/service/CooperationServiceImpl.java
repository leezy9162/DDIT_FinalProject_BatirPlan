package kr.or.batirplan.cooperationcom.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.or.batirplan.cooperationcom.mapper.CooperationMapper;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class CooperationServiceImpl implements ICooperationService {

    @Autowired
    private CooperationMapper cooperationMapper;

    @Override
    @Transactional // 🔥 트랜잭션 적용 (중복 방지)
    public synchronized String generateCooperationCode() {
        // 현재 년월 (YYMM)
        String prefix = "C" + new SimpleDateFormat("yyMM").format(new Date());

        // 현재 년월에 대한 최대 일련번호 조회
        String lastSeq = cooperationMapper.generateCooperationCode();
        int nextSeq = (lastSeq == null) ? 1 : Integer.parseInt(lastSeq) + 1;

        // 4자리 일련번호 포맷 (ex: 0001, 0023, 0123)
        String seqFormatted = String.format("%04d", nextSeq);

        return prefix + seqFormatted;
    }

    @Override
    @Transactional // 🔥 트랜잭션 적용 (코드 생성 + 저장 동시 처리)
    public void insertCooperation(CooperationcomVO cooperationVO) {
        // 협력업체 코드 생성
        String newCode = generateCooperationCode();
        cooperationVO.setCcpyCode(newCode);

        // DB 저장
        cooperationMapper.insertCooperation(cooperationVO);
    }


    @Override
    public List<EmployeeVO> getEmployeeList() {
        return cooperationMapper.getEmployeeList();
    }
    
    @Override
    public List<CooperationcomVO> selectCooperationList(String ccpyNm, String bizrno, String ccpyCl, int offset, int limit) {
        return cooperationMapper.selectCooperationList(ccpyNm, bizrno, ccpyCl, offset, limit);
    }
    
    @Override
    public int selectCooperationCount(String ccpyNm, String bizrno, String ccpyCl) {
        return cooperationMapper.selectCooperationCount(ccpyNm, bizrno, ccpyCl);
    }
}
