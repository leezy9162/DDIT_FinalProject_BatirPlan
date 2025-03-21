package kr.or.batirplan.forccpy.service;

import java.util.List;
import java.util.Map;

import kr.or.batirplan.resrce.order.vo.ReqDetailVO;

public interface ForCcpyService {

	public Map<String, Object> getReqDataList(String loginCcpyCode, int currentPage);

	public void permitReq(List<String> reqNos);

	public Map<String, Object> getOrderDataList(String loginCcpyCode, int currentpage);

	public Map<String, Object> getRejectedReqDataList(String loginCcpyCode, int currentpage);

	public List<ReqDetailVO> getOrderDetailsByOrdrNo(String orderno);

	public void rejectReqsByReqNo(List<String> reqNos, String reason);

}
