package kr.or.batirplan.forccpy.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.batirplan.forccpy.service.ForCcpyService;
import kr.or.batirplan.resrce.order.service.ReqService;
import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import kr.or.batirplan.security.vo.CustomUser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/batirplan/forccpy")
@PreAuthorize("hasRole('ROLE_CCPY')")
@RequiredArgsConstructor
public class ForCcpyController {
	
	@Autowired
	private ForCcpyService forCcpyService;
	
	@Autowired
	private ReqService reqService;
	
	private final Gson gson;
	
	@GetMapping("/req/list")
	public String getReqListPage() {
		return "forccpy/reqList";
	}
	
	/**
	 * 미승인 발주 요청 조회 메서드
	 * @author leezy
	 * @param loginUser
	 * @param currentpage
	 * @return
	 */
	@ResponseBody
	@GetMapping("/req/reqdatalist")
	public String getReqDataList(@AuthenticationPrincipal CustomUser loginUser,@RequestParam int currentpage) {
		// 로그인한 협력 업체
		String loginCcpyCode = loginUser.getMemberVO().getCcpyVO().getCcpyCode();
		log.info("[ForCcpyController] 로그인 협력 업체 코드 : {}", loginCcpyCode);
		
		Map<String, Object> resultMap = forCcpyService.getReqDataList(loginCcpyCode, currentpage);
		
		return gson.toJson(resultMap);
	}
	
	/**
	 * 반려 발주 요청 조회 메서드
	 * @author leezy
	 * @param loginUser
	 * @param currentpage
	 * @return
	 */
	@ResponseBody
	@GetMapping("/req/rejecteddatalist")
	public String getRejectedReqDataList(@AuthenticationPrincipal CustomUser loginUser,@RequestParam int currentpage) {
		// 로그인한 협력 업체
		String loginCcpyCode = loginUser.getMemberVO().getCcpyVO().getCcpyCode();
		log.info("[ForCcpyController] 로그인 협력 업체 코드 : {}", loginCcpyCode);
		
		Map<String, Object> resultMap = forCcpyService.getRejectedReqDataList(loginCcpyCode, currentpage);
		
		return gson.toJson(resultMap);
	}
	
	@ResponseBody
	@GetMapping("/req/orderdatalist")
	public String getOrderDataList(@AuthenticationPrincipal CustomUser loginUser,@RequestParam int currentpage) {
		// 로그인한 협력 업체
		String loginCcpyCode = loginUser.getMemberVO().getCcpyVO().getCcpyCode();
		log.info("[ForCcpyController] 로그인 협력 업체 코드 : {}", loginCcpyCode);
		
		Map<String, Object> resultMap = forCcpyService.getOrderDataList(loginCcpyCode, currentpage);
		
		return gson.toJson(resultMap);
	}
	
	@GetMapping("/req/reqdetail")
	public String getReqDetail(String reqno, Model model) {
		
		
		ReqVO reqInfo = reqService.gerReqInfoByReqNo(reqno);
		List<ReqDetailVO> rdList = reqService.gerReqDetailsByReqNo(reqno);
		for (ReqDetailVO rd : rdList) {
			if (rd.getReqDeSttus().equals("3")) {
				model.addAttribute("status", 3);
				break;
			}
		}
		
		model.addAttribute("reqInfo", reqInfo);
		model.addAttribute("detailList", rdList);
		return "forccpy/reqDetail";
	}
	
	@GetMapping("/req/orderdetail")
	public String getOrderDetail(String orderno, Model model) {
		
		OrderVO order =  reqService.getOrderInfoByOrderNo(orderno);
		List<ReqDetailVO> rdList = forCcpyService.getOrderDetailsByOrdrNo(orderno);
		
		model.addAttribute("order", order);
		model.addAttribute("detailList", rdList);
		return "forccpy/orderDetail";
	}
	
	@PostMapping("/req/permitreq")
	public ResponseEntity<String> permitReq(@RequestBody List<String> reqNos){
		log.info("[ForCcpyController-permitReq] 승인 대상 발주 요청 번호: {}", reqNos.toString());
		
		forCcpyService.permitReq(reqNos);
		
		return new ResponseEntity<String>(String.valueOf(reqNos.size()), HttpStatus.OK);		
	}
	
	@PostMapping("/req/rejectreq")
	@ResponseBody
	public int rejectReq(@RequestBody Map<String, Object> param) {
	    List<String> reqNos = (List<String>) param.get("reqNos");
	    String reason = (String) param.get("reason");
	    
	    log.info(param.toString());
	    log.info(reqNos.toString());
	    log.info(reason);
	    
	    forCcpyService.rejectReqsByReqNo(reqNos, reason);
	    
	    return reqNos.size();
	}
}
