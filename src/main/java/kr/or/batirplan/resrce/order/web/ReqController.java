package kr.or.batirplan.resrce.order.web;

import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.forccpy.service.ForCcpyService;
import kr.or.batirplan.resrce.order.service.ReqService;
import kr.or.batirplan.resrce.order.vo.AutoReqVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqSearchVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import kr.or.batirplan.resrce.product.service.PrdlstService;
import kr.or.batirplan.resrce.product.vo.PrdlstCtgryVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;
import kr.or.batirplan.security.vo.CustomUser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/resrce/req")
@PreAuthorize("hasRole('ROLE_DEPT_RESRCE')")
@RequiredArgsConstructor
public class ReqController {
		
	@Autowired
	private ReqService reqService;
	
	@Autowired
	private PrdlstService prdlstService;
	
	private final Gson gson;
	
	
	@GetMapping("/list")
	public String getReqListPage() {
		return "req/reqList";
	}
	
	@ResponseBody
	@PostMapping("/getreqlist")
	public String getReqList(@RequestBody ReqSearchVO reqSearchVO) {
		log.info("[발주 요청 정보 확인]발주 요청 검색 정보{}",reqSearchVO.toString());
		
		Map<String, Object> resultMap = new HashMap<>();
	    
	    PaginationInfoVO<ReqVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(reqSearchVO.getCurrentPage());
	    
	    int totalRecord = reqService.getReqCount(reqSearchVO);
	    pagingVO.setTotalRecord(totalRecord);
	    
	    List<ReqVO> reqDataList = reqService.getReqList(pagingVO, reqSearchVO);
	    pagingVO.setDataList(reqDataList);
	    
	    String pagingHTML = pagingVO.getPagingHTML();
	    resultMap.put("dataList", reqDataList);
	    resultMap.put("paging", pagingHTML);
	    
	    return gson.toJson(resultMap);
	}
	
	
	@GetMapping("/reqdetail")
	public String getReqDetail(String reqno, Model model) {
		ReqVO reqInfo =  reqService.getReqInfoByReqNo(reqno);
		List<ReqDetailVO> rdList = reqService.gerReqDetailsByReqNo(reqno);
		
		model.addAttribute("reqInfo", reqInfo);
		model.addAttribute("detailList", rdList);
		return "req/reqDetail";
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 수동 발주 요청 페이지 이동 메서드
	 * @author leezy
	 * @return 수동 발주 요청 생성 페이지 경로
	 */
	@GetMapping("/handreq")
	public String getMkHandReqPage() {
		return "req/handreq";
	}
	
	/**
	 * 수동 발주 요청 처리 메서드
	 * 수동으로 작성된 발주 내용을 ForEach로 순회하며 처리
	 * Transactional로 실패시 롤백
	 * @author leezy
	 * @param requests
	 * @return 처리 완료된 수동 발주 요청의 갯수
	 * @exception 발주 요청 및 요청 상세 DB삽입 오류
	 */
	@PostMapping("/handreq/reqregister")
	public ResponseEntity<String> reqRegister(
			  @RequestBody List<ReqVO> requests
			, @AuthenticationPrincipal CustomUser loginUser
			){
		log.info("[reqRegister] 발주 요청자 >>> "  + loginUser.getMemberVO().getEmpVO().getEmplCode()); 
		
        try {
        	for (ReqVO reqVO : requests) {
				reqVO.setReqType("1");
			}
            int total = reqService.reqRegister(requests, loginUser); 
            return ResponseEntity.ok(String.valueOf(total));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("FAIL");
        }
	}
	
	/**
	 * 자동 발주 등록 페이지 이동 메서드
	 * @author leezy
	 * @return 자동 발주 등록 페이지 경로
	 */
	@GetMapping("/autoreq")
	public String getMkAutoReqPage(Model model) {
		List<String> unitList = prdlstService.getUnitList();
		List<PrdlstCtgryVO> levelOneCtgryList = prdlstService.getLevelOneCtgryList();

		model.addAttribute("unitList", unitList);
		model.addAttribute("levelOneCtgryList", levelOneCtgryList);
		
		return "req/autoreq";
	}
	
	
	@PostMapping("/autoreq")
	public ResponseEntity<String> autoReqRegister(@RequestBody AutoReqVO autoReq){
		ResponseEntity<String> result = null;
		log.info(autoReq.toString());
		
		int resultStatus = reqService.autoReqRegister(autoReq);
		
		if (resultStatus > 0) {
			result = ResponseEntity.ok(autoReq.getPrdlstNm());
			return result;
		}
		
		return result;
	}
	
	
	
	/**
	 * 보낸 협력업체 코드의 품목 리스트를 반환하는 메서드
	 * @author leezy
	 * @param ccpyCode
	 * @return
	 */
	@ResponseBody
	@GetMapping("/getprdlstbyccpycode")
	public String getPrdlstByCcpyCode(String ccpyCode) {
		List<PrdlstVO> prdlstList = reqService.getPrdlstByCcpyCode(ccpyCode);
		return gson.toJson(prdlstList);
	}
	
	
	@ResponseBody
	@PostMapping("/excelupload")
	public String excelUpload(@RequestParam("excelFile") MultipartFile excelFile) {
		List<Map<String, Object>> result = null;
		result = reqService.parseExcelFile(excelFile);
		return gson.toJson(result);
	}
	
	
}
