package kr.or.batirplan.warehouse.service;

import kr.or.batirplan.warehouse.vo.WarehouseProductVO;
import java.util.List;

public interface WarehouseProductService {

    /**
     * 📌 특정 창고에 보관된 자재 목록 조회
     * @param wrHousCode 창고 코드
     * @return 창고에 저장된 자재 목록
     */
    List<WarehouseProductVO> getProductsByWarehouse(String wrHousCode);

    /**
     * 📌 창고에 자재가 있는지 확인
     * @param wrHousCode 창고 코드
     * @return 자재가 존재하면 true, 없으면 false
     */
    boolean hasMaterialsInWarehouse(String wrHousCode);

    /**
     * 📌 특정 창고에 있는 자재 개수 조회
     * @param wrHousCode 창고 코드
     * @return 해당 창고에 있는 자재의 개수 (숫자)
     */
    int countMaterialsInWarehouse(String wrHousCode);
    
    /**
     * 📌 창고 폐쇄 가능 여부 확인
     * (자재가 하나라도 있으면 폐쇄 불가)
     * @param wrHousCode 창고 코드
     * @return 폐쇄 가능하면 true, 불가능하면 false
     */
    boolean canCloseWarehouse(String wrHousCode);

	List<WarehouseProductVO> getMaterialsByWarehouse(String wrHousCode);
}
