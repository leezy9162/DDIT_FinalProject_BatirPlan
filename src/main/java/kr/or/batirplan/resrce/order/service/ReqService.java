package kr.or.batirplan.resrce.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.resrce.order.vo.AutoReqVO;
import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqSearchVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;
import kr.or.batirplan.security.vo.CustomUser;

public interface ReqService {

	public List<PrdlstVO> getPrdlstByCcpyCode(String ccpyCode);

	public int reqRegister(List<ReqVO> requests, CustomUser loginUser);

	public List<Map<String, Object>> parseExcelFile(MultipartFile excelFile);

	public int autoReqRegister(AutoReqVO autoReq);

	public int getReqCount(ReqSearchVO reqSearchVO);

	public List<ReqVO> getReqList(PaginationInfoVO<ReqVO> pagingVO, ReqSearchVO reqSearchVO);

	public List<ReqDetailVO> gerReqDetailsByReqNo(String reqno);

	public ReqVO gerReqInfoByReqNo(String reqno);

	public OrderVO getOrderInfoByOrderNo(String orderno);

	public ReqVO getReqInfoByReqNo(String reqno);




}
