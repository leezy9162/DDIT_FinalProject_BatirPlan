package kr.or.batirplan.forccpy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.forccpy.mapper.ForCcpyMapper;
import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ForCcpyServiceImpl implements ForCcpyService {
	
	@Autowired
	private ForCcpyMapper forCcpyMapper; 
	
	@Override
	public Map<String, Object> getReqDataList(String loginCcpyCode, int currentPage) {
		Map<String, Object> resultMap = new HashMap<>();
		
		
	    PaginationInfoVO<ReqVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(currentPage);
	    
	    int totalRecord = forCcpyMapper.getReqCountByCcpyCode(loginCcpyCode);
	    pagingVO.setTotalRecord(totalRecord);
	    
	    
	    Map<String, Object> pramMap = new HashMap<>();
	    pramMap.put("ccpyCode", loginCcpyCode);
	    pramMap.put("pagingVO", pagingVO);
	    List<ReqVO> reqDataList = forCcpyMapper.getReqListByCcpyCode(pramMap);
	    pagingVO.setDataList(reqDataList);
	    
	    String pagingHTML = pagingVO.getPagingHTML();
	    resultMap.put("dataList", reqDataList);
	    resultMap.put("paging", pagingHTML);
		
		return resultMap;
	}


	@Override
	public Map<String, Object> getOrderDataList(String loginCcpyCode, int currentpage) {
		Map<String, Object> resultMap = new HashMap<>();
		
	    PaginationInfoVO<OrderVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(currentpage);
	    
	    int totalRecord = forCcpyMapper.getOrderCountByCcpyCode(loginCcpyCode);
	    pagingVO.setTotalRecord(totalRecord);
	    
	    
	    Map<String, Object> pramMap = new HashMap<>();
	    pramMap.put("ccpyCode", loginCcpyCode);
	    pramMap.put("pagingVO", pagingVO);
	    List<OrderVO> orderDataList = forCcpyMapper.getOrderListByCcpyCode(pramMap);
	    pagingVO.setDataList(orderDataList);
	    
	    String pagingHTML = pagingVO.getPagingHTML();
	    resultMap.put("dataList", orderDataList);
	    resultMap.put("paging", pagingHTML);
		
		return resultMap;
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void permitReq(List<String> reqNos) {
		
		if(reqNos == null || reqNos.isEmpty()) {
			return;
		}
		
		for (String req : reqNos) {
			forCcpyMapper.permitReq(req);
		}
	}


	@Override
	public Map<String, Object> getRejectedReqDataList(String loginCcpyCode, int currentpage) {
		Map<String, Object> resultMap = new HashMap<>();
		
		
	    PaginationInfoVO<ReqVO> pagingVO = new PaginationInfoVO<>(10, 5);
	    pagingVO.setCurrentPage(currentpage);
	    
	    int totalRecord = forCcpyMapper.getRejectedReqCountByCcpyCode(loginCcpyCode);
	    pagingVO.setTotalRecord(totalRecord);
	    
	    
	    Map<String, Object> pramMap = new HashMap<>();
	    pramMap.put("ccpyCode", loginCcpyCode);
	    pramMap.put("pagingVO", pagingVO);
	    List<ReqVO> reqDataList = forCcpyMapper.getRejectedReqListByCcpyCode(pramMap);
	    pagingVO.setDataList(reqDataList);
	    
	    String pagingHTML = pagingVO.getPagingHTML();
	    resultMap.put("dataList", reqDataList);
	    resultMap.put("paging", pagingHTML);
		
		return resultMap;
	}


	@Override
	public List<ReqDetailVO> getOrderDetailsByOrdrNo(String orderno) {
		
		return forCcpyMapper.getOrderDetailsByOrdrNo(orderno);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void rejectReqsByReqNo(List<String> reqNos, String reason) {
		for (String req : reqNos) {
			forCcpyMapper.rejectReqByReqNo(req, reason);
		}
	}



}
