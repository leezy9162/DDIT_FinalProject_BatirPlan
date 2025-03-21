package kr.or.batirplan.resrce.stock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.resrce.order.vo.OrderDetailVO;
import kr.or.batirplan.resrce.stock.vo.StockSearchVO;

@Mapper
public interface StockMapper {

	public int getStockTargetCount(@Param("searchVO") StockSearchVO searchVO);

	public List<OrderDetailVO> getStockTargetList(@Param("pagingVO") PaginationInfoVO<OrderDetailVO> pagingVO,@Param("searchVO") StockSearchVO searchVO);

	public void updateOrderDeatailSttus(String orderDeNo);

	public void updateStockWareHouseProduct(@Param("wrhousCode") String whCode,@Param("od") OrderDetailVO od);

	public void recodingStockIn(@Param("wrhousCode") String whCode,@Param("od") OrderDetailVO od);

	public String selectOrderNoByOrderDeNo(String orderDeNo);

	public int countPendingOrderDetails(String ordrNo);

	public void updateOrderComplete(String ordrNo);

	public int selectTotalInventoryByPrdlstNo(String prdlstNo);

	public void updateProductInventory(@Param("prdlstNo") String prdlstNo,@Param("totalQty") int totalStock);

	public void updateReqSttus(String reqNo);

}
