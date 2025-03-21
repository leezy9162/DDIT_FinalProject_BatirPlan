package kr.or.batirplan.resrce.stock.service;

import java.util.Map;

import kr.or.batirplan.resrce.stock.vo.StockConfirmVO;
import kr.or.batirplan.resrce.stock.vo.StockSearchVO;

public interface StockService {

	public Map<String, Object> getStockTargetList(StockSearchVO searchVO);

	public void stockService(StockConfirmVO confirmVO);

}
