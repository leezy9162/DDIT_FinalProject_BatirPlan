package kr.or.batirplan.equipment.mapper;

import kr.or.batirplan.equipment.vo.EquipmentArrangementVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.employee.vo.EmployeeVO;


@Mapper
public interface EquipmentArrangementMapper {
    EquipmentArrangementVO getEquipmentArrangementDetail(int requestNo);
    void approveEquipmentArrangement(int requestNo);
    void updateEquipmentStatus(int eqpmnNo);
    void insertEquipmentArrangement(EquipmentArrangementVO arrangement);
    void rejectEquipmentArrangement(int requestNo); // 거절 기능 추가
    List<EquipmentArrangementVO> getPendingEquipmentArrangementList();
    
    List<ProjectVO> searchProject(String keyword);
    List<EmployeeVO> searchEmployee(@Param("keyword") String keyword);

    List<EquipmentArrangementVO> getEquipmentArrangementList(
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword,
            @Param("approvalStatus") String approvalStatus
    );
   
    void cancelApproval(int requestNo); // ✅ 승인 취소 추가
}