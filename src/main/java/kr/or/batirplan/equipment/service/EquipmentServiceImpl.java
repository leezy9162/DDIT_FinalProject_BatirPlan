package kr.or.batirplan.equipment.service;

import kr.or.batirplan.equipment.mapper.EquipmentMapper;
import kr.or.batirplan.equipment.vo.EquipmentVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EquipmentServiceImpl implements EquipmentService {

    private final EquipmentMapper equipmentMapper;

    @Override
    public List<EquipmentVO> getEquipmentList(String keyword) {
        return equipmentMapper.getEquipmentList(keyword);
    }

    @Override
    public EquipmentVO getEquipmentByNo(int eqpmnNo) {
        return equipmentMapper.getEquipmentByNo(eqpmnNo);
    }

    @Override
    public void insertEquipment(EquipmentVO equipment) {
        equipmentMapper.insertEquipment(equipment);
    }

    @Override
    public void updateEquipmentStatus(int eqpmnNo, String status) {
        equipmentMapper.updateEquipmentStatus(eqpmnNo, status);
    }

    @Override
    public PageInfo<EquipmentVO> getIncomingEquipment(int pageNum, int pageSize, String keyword) {
        PageHelper.startPage(pageNum, pageSize);
        List<EquipmentVO> list = equipmentMapper.getIncomingEquipment(keyword);
        return new PageInfo<>(list);
    }

    @Override
    public void receiveEquipment(int eqpmnNo) {
        equipmentMapper.receiveEquipment(eqpmnNo);
    }

    @Override
    public boolean isSerialNumberExists(String eqpmnSn) {
        return equipmentMapper.countBySerialNumber(eqpmnSn) > 0;
    }
    
    // 추가: 장비 검색 구현
    @Override
    public List<EquipmentVO> searchEquipment(String keyword) {
        return equipmentMapper.searchEquipment(keyword);
    }
}
