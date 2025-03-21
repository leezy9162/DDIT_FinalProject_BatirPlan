package kr.or.batirplan.warehouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.warehouse.vo.WarehouseProductVO;
import kr.or.batirplan.warehouse.vo.WarehouseVO;

@Mapper
public interface WarehouseProductMapper {

    /**
     * 📌 특정 창고의 제품 목록을 조회
     */
    List<WarehouseProductVO> getProductsByWarehouse(String wrHousCode);

    /**
     * 📌 특정 창고의 자재 목록 조회 (창고 상세 조회 시 사용)
     */
    List<WarehouseProductVO> getMaterialsByWarehouse(String wrHousCode);

    /**
     * 📌 전체 창고의 모든 제품 목록 조회
     *
 */
    List<WarehouseProductVO> getAllWarehouseProducts();

    /**
     * 📌 창고 정보 등록
     */
    void insertWarehouse(WarehouseVO warehouseVO);

    /**
     * 📌 가장 마지막에 삽입된 창고 코드 조회
     */
    String getLastInsertedWarehouseCode();

    /**
     * 📌 창고 정보 수정
     */
    void updateWarehouse(WarehouseVO warehouseVO);

    /**
     * 📌 창고 삭제 (자재가 없을 경우만 가능)
     */
    void deleteWarehouse(String wrHousCode);

    /**
     * 📌 창고 폐쇄 처리 (운영 상태 변경, 자재가 없을 경우만 가능)
     */
    void closeWarehouse(String wrHousCode);

    /**
     * 📌 특정 창고에 보관된 자재 개수 조회
     */
    int countMaterialsInWarehouse(String wrHousCode);

    /**
     * 📌 창고 목록 조회 (필터링 포함)
     */
    List<WarehouseVO> selectWarehouseList(String wrHousNm, String wrHousOperSttus, String wrHousLc);

    /**
     * 📌 창고 코드로 창고 정보 조회
     */
    WarehouseVO selectWarehouseByCode(String wrHousCode);

	boolean hasMaterialsInWarehouse(String wrHousCode);

	boolean canCloseWarehouse(String wrHousCode);
} 