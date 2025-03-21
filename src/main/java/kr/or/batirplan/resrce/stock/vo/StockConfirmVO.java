package kr.or.batirplan.resrce.stock.vo;

import java.util.List;

import kr.or.batirplan.resrce.order.vo.OrderDetailVO;
import lombok.Data;

@Data
public class StockConfirmVO {
	
	private String whCode;
	private List<OrderDetailVO> items;
}
