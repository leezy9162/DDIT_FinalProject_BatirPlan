package kr.or.batirplan.resrce.stock.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.resrce.order.mapper.ReqMapper;
import kr.or.batirplan.resrce.order.vo.OrderDetailVO;
import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.stock.mapper.StockMapper;
import kr.or.batirplan.resrce.stock.vo.StockConfirmVO;
import kr.or.batirplan.resrce.stock.vo.StockSearchVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class StockServiceImpl implements StockService {
	
	@Autowired
	private StockMapper stockMapper;

	@Autowired
	private ReqMapper reqMapper;
	
	@Override
	public Map<String, Object> getStockTargetList(StockSearchVO searchVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		PaginationInfoVO<OrderDetailVO> pagingVO = new PaginationInfoVO<>(10,5);
		pagingVO.setCurrentPage(searchVO.getCurrentPage());
		
		int totalRecord = stockMapper.getStockTargetCount(searchVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<OrderDetailVO> odList = stockMapper.getStockTargetList(pagingVO, searchVO);
		pagingVO.setDataList(odList);
		
	    String pagingHTML = pagingVO.getPagingHTML();
	    resultMap.put("dataList", odList);
	    resultMap.put("paging", pagingHTML);
		
		return resultMap;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void stockService(StockConfirmVO confirmVO) {
		
		List<OrderDetailVO> odList = confirmVO.getItems();
		for (OrderDetailVO od : odList) {
			// step 1. order_de_no에 대한 입고 완료 처리 (req_de_no에도 반영됨-TRG_APPROVE_ORDER)
			stockMapper.updateOrderDeatailSttus(od.getOrderDeNo());
			// step 1-1. order_de_no에 해당하는 ordr_no가져오기
			String ordrNo = stockMapper.selectOrderNoByOrderDeNo(od.getOrderDeNo());
			// step 1-2. ordr_no를 가지는 detail들중 상태가 아직 1인 행들의 갯수를 수집
			int count = stockMapper.countPendingOrderDetails(ordrNo);
			// step 1-3. count가 0인경우는 완료로 처리한다.
			if (count == 0) {
				stockMapper.updateOrderComplete(ordrNo);
				//발주 요청도 처리 해야함
				OrderVO ov = reqMapper.getOrderInfoByOrderNo(ordrNo);
				stockMapper.updateReqSttus(ov.getReqNo());
			} 
			// step 2. 창고 재고 업데이트
			// step 2-1. 해당 품목 번호로 현재 모든 창고의 재고 수를 가져오기
			int totalStock = stockMapper.selectTotalInventoryByPrdlstNo(od.getPrdlstNo());
			stockMapper.updateStockWareHouseProduct(confirmVO.getWhCode(), od);
			// step 2-2 재고를 품목테이블에 반영
			stockMapper.updateProductInventory(od.getPrdlstNo(), totalStock + od.getOrdrQty());
			
			// step 3. 입고 정보 기록
			stockMapper.recodingStockIn(confirmVO.getWhCode(), od);
		}
		
	}

}
