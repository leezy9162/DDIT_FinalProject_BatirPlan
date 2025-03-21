package kr.or.batirplan.equipment.service;

import kr.or.batirplan.equipment.vo.EquipmentArrangementVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import java.util.List;

public interface EquipmentArrangementService {
    EquipmentArrangementVO getEquipmentArrangementDetail(int requestNo);
    void approveEquipmentArrangement(int requestNo, int eqpmnNo);
    void insertEquipmentArrangement(EquipmentArrangementVO arrangement);
    List<EquipmentArrangementVO> getPendingEquipmentArrangementList();
    void rejectEquipmentArrangement(int requestNo);

    
    List<ProjectVO> searchProject(String keyword);
    List<EmployeeVO> searchEmployee(String keyword);

    List<EquipmentArrangementVO> getEquipmentArrangementList(String searchType, String searchKeyword, String approvalStatus);
    void cancelApproval(int requestNo); // ✅ 승인 취소 추가
    
}
