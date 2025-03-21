package kr.or.batirplan.warehouse.service;

import kr.or.batirplan.warehouse.vo.WarehouseProductVO;
import kr.or.batirplan.warehouse.vo.WarehouseVO;
import java.util.List;

public interface IWarehouseService {

    /**
     * 📌 창고 목록 조회 (필터링 포함)
     * @param wrHousNm 창고명 (검색 필터)
     * @param wrHousOperSttus 운영 상태 (운영 중 / 폐쇄)
     * @param wrHousLc 창고 위치 (검색 필터)
     * @return 조회된 창고 목록
     */
    List<WarehouseVO> getWarehouseList(String wrHousNm, String wrHousOperSttus, String wrHousLc);

    /**
     * 📌 창고 단건 상세 조회
     * @param wrHousCode 조회할 창고의 코드
     * @return 창고 상세 정보 (WarehouseVO)
     */
    WarehouseVO getWarehouseByCode(String wrHousCode);

    /**
     * 📌 창고 정보 등록
     * @param warehouseVO 등록할 창고 객체
     */
    void insertWarehouse(WarehouseVO warehouseVO);

    /**
     * 📌 창고 정보 수정
     * @param warehouseVO 수정할 창고 객체
     */
    void updateWarehouse(WarehouseVO warehouseVO);

    /**
     * 📌 창고 정보 삭제
     * @param wrHousCode 삭제할 창고의 코드
     * @return 
     */
    boolean deleteWarehouse(String wrHousCode);

    /**
     * 📌 창고에 자재가 있는지 확인
     * @param wrHousCode 창고 코드
     * @return 자재가 존재하면 true, 없으면 false
     */
    boolean checkWarehouseMaterials(String wrHousCode);

void registerWarehouse(WarehouseVO warehouseVO);

String getLastInsertedWarehouseCode();

/**
 * 📌 창고 폐쇄 (운영 상태 변경)
 * - 창고를 삭제하는 것이 아니라 '폐쇄' 상태(02)로 변경
 */
boolean closeWarehouse(String wrHousCode);

boolean hasMaterialsInWarehouse(String wrHousCode);

List<WarehouseProductVO> getMaterialsByWarehouse(String wrHousCode);
}