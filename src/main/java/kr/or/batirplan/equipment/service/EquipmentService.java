package kr.or.batirplan.equipment.service;

import kr.or.batirplan.equipment.vo.EquipmentVO;
import java.util.List;

import com.github.pagehelper.PageInfo;


public interface EquipmentService {
	List<EquipmentVO> getEquipmentList(String keyword);
    EquipmentVO getEquipmentByNo(int eqpmnNo);
    void insertEquipment(EquipmentVO equipment);
    void updateEquipmentStatus(int eqpmnNo, String status);
    PageInfo<EquipmentVO> getIncomingEquipment(int pageNum, int pageSize, String keyword);
    void receiveEquipment(int eqpmnNo);
    boolean isSerialNumberExists(String eqpmnSn);
    
    // 추가: 장비 검색 메서드
    List<EquipmentVO> searchEquipment(String keyword);
}
