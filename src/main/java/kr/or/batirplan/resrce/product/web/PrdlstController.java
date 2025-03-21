package kr.or.batirplan.resrce.product.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.resrce.product.service.PrdlstService;
import kr.or.batirplan.resrce.product.vo.PrdlstCtgryVO;
import kr.or.batirplan.resrce.product.vo.PrdlstSearchVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@PreAuthorize("hasRole('ROLE_DEPT_RESRCE')")
@RequestMapping("/batirplan/resrce/prdlst")
public class PrdlstController {

	@Autowired
	private PrdlstService prdlstService;
	
	private final Gson gson;
	
	
	@GetMapping("/list")
	public String getListPage(Model model) {
		List<String> unitList = prdlstService.getUnitList();
		List<PrdlstCtgryVO> levelOneCtgryList = prdlstService.getLevelOneCtgryList();

		model.addAttribute("unitList", unitList);
		model.addAttribute("levelOneCtgryList", levelOneCtgryList);
		return "resrce/prdlst/list";
	}
	
	
	@ResponseBody
	@PostMapping("/data")
	public String getTableData(@RequestBody PrdlstSearchVO prdlstSearchVO) {
		log.info(prdlstSearchVO.toString());
		
		
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    PaginationInfoVO<PrdlstVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(prdlstSearchVO.getCurrentPage());
	    
	    int totalRecord = prdlstService.getPrdlstCount(prdlstSearchVO);
	    pagingVO.setTotalRecord(totalRecord);
	    
	    
	    List<PrdlstVO> prdlstList = prdlstService.getPrdlstList(pagingVO, prdlstSearchVO);
	    pagingVO.setDataList(prdlstList);

	    String pagingHTML = pagingVO.getPagingHTML();
	    log.info(pagingHTML);
	    resultMap.put("dataList", prdlstList);
	    resultMap.put("paging", pagingHTML);

	    return gson.toJson(resultMap);
	}

	
	
	
	@GetMapping("/register")
	public String getRegisterPage(Model model) {
		
		List<String> unitList = prdlstService.getUnitList();
		List<PrdlstCtgryVO> levelOneCtgryList = prdlstService.getLevelOneCtgryList();

		model.addAttribute("unitList", unitList);
		model.addAttribute("levelOneCtgryList", levelOneCtgryList);
		return "resrce/prdlst/register";
	}
	
	@ResponseBody
	@GetMapping("/getleveltwoctgry")
	public String getlevelTwoCtgry(@RequestParam Integer parentCtgry) {
		
		// Integer는 Null을 받을 수 있음. (혹시 몰라서...)
		if (parentCtgry == null) {
			return gson.toJson(null);
		}
		List<PrdlstCtgryVO> leveltwoCtgryList =	prdlstService.getLevelTwoCtgryList(parentCtgry.intValue());
		return gson.toJson(leveltwoCtgryList);
	}
	
	@ResponseBody
	@GetMapping("/getlevelthreectgry")
	public String getlevelThreeCtgry(@RequestParam Integer parentCtgry) {
		
		// Integer는 Null을 받을 수 있음. (혹시 몰라서...)
		if (parentCtgry == null) {
			return gson.toJson(null);
		}
		List<PrdlstCtgryVO> levelThreeCtgryList =	prdlstService.getLevelThreeCtgryList(parentCtgry.intValue());
		return gson.toJson(levelThreeCtgryList);
	}
	
	
	@ResponseBody
	@GetMapping("/getcccpylist")
	public String getCcpyList(
							  @RequestParam(value = "page", required = false, defaultValue = "1") int page,
							  @RequestParam(value = "searchWord", required = false) String searchWord,
							  @RequestParam(value = "searchType", required = false) String searchType) {
		
		Map<String, Object> resultMap = new HashMap<>();
		PaginationInfoVO<CooperationcomVO> pagingVO = new PaginationInfoVO<>(10, 5);
		
		if (StringUtils.isNotBlank(searchWord)) {
        	
        	if (StringUtils.isBlank(searchType)) {
                searchType = "all";
            }
        	
            pagingVO.setSearchType(searchType);
            pagingVO.setSearchWord(searchWord);
        }
		
		pagingVO.setCurrentPage(page);
		
		int totalRecord = prdlstService.getCcpyCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<CooperationcomVO> dataList = prdlstService.getCcpyList(pagingVO);
        if (dataList.size() > 0) {
        	pagingVO.setDataList(dataList);
		}
        
        String paging = pagingVO.getPagingHTML();
        resultMap.put("res", pagingVO);
        resultMap.put("paging", paging);
		return gson.toJson(resultMap);
	}
	
	
	
	@GetMapping("/modify")
	public String getModifyPage(int prdlstNo, Model model) {
		PrdlstVO prdlstVO = prdlstService.getPrdlstByPrdlstNo(prdlstNo);
		if (prdlstVO == null) {
		return "redirect:/batirplan/erp/main";
		}
		
		List<String> unitList = prdlstService.getUnitList();
		List<PrdlstCtgryVO> levelOneCtgryList = prdlstService.getLevelOneCtgryList();

		model.addAttribute("unitList", unitList);
		model.addAttribute("levelOneCtgryList", levelOneCtgryList);
		
		model.addAttribute("status", "u"); 
		model.addAttribute("prdlstVO", prdlstVO);
		return "resrce/prdlst/register";
	}
	
	@GetMapping("/detail")
	public String getDetailPage(int prdlstNo, Model model) {
		if (Integer.valueOf(prdlstNo) == null) {
			return "redirect:/batirplan/resrce/prdlst/list";
		}
		List<String> unitList = prdlstService.getUnitList();
		List<PrdlstCtgryVO> levelOneCtgryList = prdlstService.getLevelOneCtgryList();
		PrdlstVO prdlstVO = prdlstService.getPrdlstByPrdlstNo(prdlstNo);
		
		model.addAttribute("unitList", unitList);
		model.addAttribute("levelOneCtgryList", levelOneCtgryList);
		model.addAttribute("prdlstVO", prdlstVO);
		return "resrce/prdlst/detail";
	}
	
	@PostMapping("/register")
	public ResponseEntity<String> prlstRegister(PrdlstVO prdlstVO){
		ResponseEntity<String> result = null;
		log.info(prdlstVO.toString());
		
		if (prdlstService.prdlstRegister(prdlstVO) == 1) {
			result = new ResponseEntity<String>(String.valueOf(prdlstVO.getPrdlstNo()), HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return result;
	}
	
	@PostMapping("/modify")
	public ResponseEntity<String> prlstModify(PrdlstVO prdlstVO){
		log.info(prdlstVO.toString());
		ResponseEntity<String> result = null;
		
		if (prdlstService.prdlstModify(prdlstVO) == 1) {
			result = new ResponseEntity<String>(String.valueOf(prdlstVO.getPrdlstNo()), HttpStatus.OK);
		} else {
			result = new ResponseEntity<String>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return result;
	}
	
	
	
}
