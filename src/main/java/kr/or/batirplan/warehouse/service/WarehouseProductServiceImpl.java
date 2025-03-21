package kr.or.batirplan.warehouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.warehouse.mapper.WarehouseProductMapper;
import kr.or.batirplan.warehouse.vo.WarehouseProductVO;

@Service
public class WarehouseProductServiceImpl implements WarehouseProductService {
	
	@Autowired
	private WarehouseProductMapper mapper;
	
	@Override
	public List<WarehouseProductVO> getProductsByWarehouse(String wrHousCode) {
		
		return mapper.getProductsByWarehouse(wrHousCode);
	}

	@Override
	public boolean hasMaterialsInWarehouse(String wrHousCode) {
		
		return mapper.hasMaterialsInWarehouse(wrHousCode);
	}

	@Override
	public int countMaterialsInWarehouse(String wrHousCode) {
		
		return mapper.countMaterialsInWarehouse(wrHousCode);
	}

	@Override
	public boolean canCloseWarehouse(String wrHousCode) {
		return mapper.canCloseWarehouse(wrHousCode);
	}

	@Override
	public List<WarehouseProductVO> getMaterialsByWarehouse(String wrHousCode) {
		return mapper.getMaterialsByWarehouse(wrHousCode);
	}

}
