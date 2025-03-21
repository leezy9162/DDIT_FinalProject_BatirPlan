package kr.or.batirplan.warehouse.mapper;

import kr.or.batirplan.warehouse.vo.WarehouseProductVO;
import kr.or.batirplan.warehouse.vo.WarehouseVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IWarehouseMapper {

    List<WarehouseVO> selectWarehouseList(@Param("wrHousNm") String wrHousNm, 
                                          @Param("wrHousOperSttus") String wrHousOperSttus, 
                                          @Param("wrHousLc") String wrHousLc);

    WarehouseVO selectWarehouseByCode(@Param("wrHousCode") String wrHousCode);

    void insertWarehouse(WarehouseVO warehouseVO);

    void updateWarehouse(WarehouseVO warehouseVO);

    int deleteWarehouse(@Param("wrHousCode") String wrHousCode);

    int countWarehouseMaterials(@Param("wrHousCode") String wrHousCode);

    String getLastInsertedWarehouseCode();

	int countMaterialsInWarehouse(String wrHousCode);

	List<WarehouseProductVO> getMaterialsByWarehouse(String wrHousCode);

	void closeWarehouse(String wrHousCode);
}
