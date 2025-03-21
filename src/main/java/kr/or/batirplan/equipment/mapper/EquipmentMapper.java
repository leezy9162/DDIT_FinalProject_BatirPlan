package kr.or.batirplan.equipment.mapper;

import kr.or.batirplan.equipment.vo.EquipmentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface EquipmentMapper {
	List<EquipmentVO> getEquipmentList(@Param("keyword") String keyword);
    EquipmentVO getEquipmentByNo(int eqpmnNo);
    void insertEquipment(EquipmentVO equipment);
    void updateEquipmentStatus(int eqpmnNo, String status);
    List<EquipmentVO> getIncomingEquipment(@Param("keyword") String keyword);
    void receiveEquipment(int eqpmnNo);
    int countBySerialNumber(String eqpmnSn);
    
    // 추가: 장비명 검색 (키워드 기반)
    List<EquipmentVO> searchEquipment(String keyword);
}
