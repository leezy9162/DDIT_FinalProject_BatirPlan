package kr.or.batirplan.forccpy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;

@Mapper
public interface ForCcpyMapper {

	public int getReqCountByCcpyCode(String loginCcpyCode);

	public List<ReqVO> getReqListByCcpyCode(Map<String, Object> pramMap);

	public void permitReq(String req);

	public int getOrderCountByCcpyCode(String loginCcpyCode);

	public List<OrderVO> getOrderListByCcpyCode(Map<String, Object> pramMap);

	public int getRejectedReqCountByCcpyCode(String loginCcpyCode);

	public List<ReqVO> getRejectedReqListByCcpyCode(Map<String, Object> pramMap);

	public List<ReqDetailVO> getOrderDetailsByOrdrNo(String orderno);

	public void rejectReqByReqNo(@Param("reqNo") String req,@Param("reason") String reason);

}
