package kr.or.batirplan.equipment.service;

import kr.or.batirplan.equipment.mapper.EquipmentArrangementMapper;
import kr.or.batirplan.equipment.vo.EquipmentArrangementVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.security.access.prepost.PreAuthorize;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EquipmentArrangementServiceImpl implements EquipmentArrangementService {

    private final EquipmentArrangementMapper arrangementMapper;

    @Override
    public List<EquipmentArrangementVO> getEquipmentArrangementList(String searchType, String searchKeyword, String approvalStatus) {
        return arrangementMapper.getEquipmentArrangementList(searchType, searchKeyword, approvalStatus);
    }

    @Override
    public EquipmentArrangementVO getEquipmentArrangementDetail(int requestNo) {
        return arrangementMapper.getEquipmentArrangementDetail(requestNo);
    }

    // 자원 관리자만 승인할 수 있도록 @PreAuthorize 적용
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @Override
    public void approveEquipmentArrangement(int requestNo, int eqpmnNo) {
        arrangementMapper.approveEquipmentArrangement(requestNo);
        arrangementMapper.updateEquipmentStatus(eqpmnNo);
    }

    @Override
    public void insertEquipmentArrangement(EquipmentArrangementVO arrangement) {
        arrangementMapper.insertEquipmentArrangement(arrangement);
    }
    
    // ✅ 프로젝트 검색 구현
    @Override
    public List<ProjectVO> searchProject(String keyword) {
        return arrangementMapper.searchProject(keyword);
    }
    
    @Override
    public List<EmployeeVO> searchEmployee(String keyword) {
        return arrangementMapper.searchEmployee(keyword);
    }

    @Override
    public List<EquipmentArrangementVO> getPendingEquipmentArrangementList() {
        return arrangementMapper.getPendingEquipmentArrangementList();
    }

    @Override
    public void rejectEquipmentArrangement(int requestNo) {
        arrangementMapper.rejectEquipmentArrangement(requestNo);
    }
    
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @Override
    public void cancelApproval(int requestNo) { // ✅ 승인 취소 추가
        arrangementMapper.cancelApproval(requestNo);
    }
    
}
