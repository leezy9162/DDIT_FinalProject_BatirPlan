package kr.or.batirplan.resrce.stock.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.batirplan.resrce.stock.service.StockService;
import kr.or.batirplan.resrce.stock.vo.StockConfirmVO;
import kr.or.batirplan.resrce.stock.vo.StockSearchVO;
import kr.or.batirplan.warehouse.service.IWarehouseService;
import kr.or.batirplan.warehouse.vo.WarehouseVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@PreAuthorize("hasRole('ROLE_DEPT_RESRCE')")
@RequestMapping("/batirplan/resrce/stock")
@RequiredArgsConstructor
public class StockPermitController {
	
	@Autowired
    private IWarehouseService warehouseService;
	
	@Autowired
	private StockService stockService;
	
	private final Gson gson;
	
	@GetMapping("/list")
	public String getPermitStockPage(Model model) {
		
		List<WarehouseVO> whList = warehouseService.getWarehouseList("", "", "");
		
		model.addAttribute("whList", whList);
		return "stock/stockList";
	}
	
	@PostMapping("/getStockTargetList")
	@ResponseBody
	public String getStockTargetList(@RequestBody StockSearchVO searchVO) {
		
		Map<String, Object> resultMap = stockService.getStockTargetList(searchVO);
		
		return gson.toJson(resultMap);
	}
	
	@ResponseBody
	@PostMapping("/confirmStock")
	public String confirmStock(@RequestBody StockConfirmVO confirmVO) {
		log.info(confirmVO.toString());
		
		stockService.stockService(confirmVO);
		
		return gson.toJson(String.valueOf(confirmVO.getItems().size()));
	}
	
}
