package kr.or.batirplan.warehouse.service;

import kr.or.batirplan.warehouse.mapper.IWarehouseMapper;
import kr.or.batirplan.warehouse.vo.WarehouseProductVO;
import kr.or.batirplan.warehouse.vo.WarehouseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.List;

@Service
public class WarehouseServiceImpl implements IWarehouseService {

    private static final Logger logger = LoggerFactory.getLogger(WarehouseServiceImpl.class);
    private final IWarehouseMapper warehouseMapper;

    @Autowired
    public WarehouseServiceImpl(IWarehouseMapper warehouseMapper) {
        this.warehouseMapper = warehouseMapper;
    }

    /**
     * 📌 창고 목록 조회
     */
    @Override
    public List<WarehouseVO> getWarehouseList(String wrHousNm, String wrHousOperSttus, String wrHousLc) {
        logger.info("📌 창고 목록 조회 요청: wrHousNm={}, wrHousOperSttus={}, wrHousLc={}", wrHousNm, wrHousOperSttus, wrHousLc);
        return warehouseMapper.selectWarehouseList(wrHousNm, wrHousOperSttus, wrHousLc);
    }

    /**
     * 📌 특정 창고 상세 조회
     */
    @Override
    public WarehouseVO getWarehouseByCode(String wrHousCode) {
        logger.info("📌 창고 상세 조회 요청: wrHousCode={}", wrHousCode);
        return warehouseMapper.selectWarehouseByCode(wrHousCode);
    }

    /**
     * 📌 창고 등록
     */
    @Transactional
    @Override
    public void insertWarehouse(WarehouseVO warehouseVO) {
        logger.info("📌 창고 등록 요청: {}", warehouseVO);
        warehouseMapper.insertWarehouse(warehouseVO);
    }

    /**
     * 📌 창고 정보 수정
     */
    @Transactional
    @Override
    public void updateWarehouse(WarehouseVO warehouseVO) {
        logger.info("📌 창고 정보 수정 요청: {}", warehouseVO);
        warehouseMapper.updateWarehouse(warehouseVO);
    }

    /**
     * 📌 창고 폐쇄 (운영 상태 변경)
     * - 창고를 삭제하는 것이 아니라 '폐쇄' 상태(02)로 변경
     */
    @Transactional
    @Override
    public boolean closeWarehouse(String wrHousCode) {
        logger.info("📌 창고 폐쇄 요청: wrHousCode={}", wrHousCode);

        // 📌 창고 내 자재가 존재하는 경우 폐쇄 불가
        boolean hasMaterials = hasMaterialsInWarehouse(wrHousCode);
        if (hasMaterials) {
            logger.warn("🚨 창고 폐쇄 불가 - 창고에 자재가 남아 있음: wrHousCode={}", wrHousCode);
            return false;
        }

        // 📌 창고 상태를 '폐쇄'로 변경
        warehouseMapper.closeWarehouse(wrHousCode);
        logger.info("✅ 창고 폐쇄 완료: wrHousCode={}", wrHousCode);
        return true;
    }

    /**
     * 📌 창고 삭제 (자재가 없을 경우만 삭제)
     */
    @Transactional
    @Override
    public boolean deleteWarehouse(String wrHousCode) {
        logger.info("📌 창고 삭제 요청: wrHousCode={}", wrHousCode);
        
        // 📌 창고 내 자재 개수 확인
        int materialCount = warehouseMapper.countMaterialsInWarehouse(wrHousCode);
        if (materialCount > 0) {
            logger.warn("🚨 창고 삭제 불가 - 창고에 {}개의 자재가 존재함", materialCount);
            return false;
        }

        // 📌 자재가 없으면 창고 삭제
        warehouseMapper.deleteWarehouse(wrHousCode);
        logger.info("✅ 창고 삭제 완료: wrHousCode={}", wrHousCode);
        return true;
    }

    /**
     * 📌 창고 내 자재 존재 여부 확인
     */
    @Override
    public boolean hasMaterialsInWarehouse(String wrHousCode) {
        int materialCount = warehouseMapper.countMaterialsInWarehouse(wrHousCode);
        return materialCount > 0;
    }

    /**
     * 📌 특정 창고에 보관된 자재 목록 조회
     */
    @Override
    public List<WarehouseProductVO> getMaterialsByWarehouse(String wrHousCode) {
        logger.info("📌 창고 내 자재 목록 조회 요청: wrHousCode={}", wrHousCode);
        return warehouseMapper.getMaterialsByWarehouse(wrHousCode);
    }

    /**
     * 📌 마지막으로 등록된 창고 코드 조회
     */
    @Override
    public String getLastInsertedWarehouseCode() {
        String lastCode = warehouseMapper.getLastInsertedWarehouseCode();
        logger.info("📌 마지막으로 등록된 창고 코드: {}", lastCode);
        return lastCode;
    }

	@Override
	public boolean checkWarehouseMaterials(String wrHousCode) {
		return false;
	}

	@Override
	public void registerWarehouse(WarehouseVO warehouseVO) {
		// TODO Auto-generated method stub
		
	}
}
