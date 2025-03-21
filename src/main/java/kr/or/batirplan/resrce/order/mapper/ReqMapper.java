package kr.or.batirplan.resrce.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.resrce.order.vo.AutoReqVO;
import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqSearchVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;

@Mapper
public interface ReqMapper {

	public List<PrdlstVO> getPrdlstByCcpyCode(String ccpyCode);

	public void insertReq(ReqVO req);

	public void insertReqDetail(ReqDetailVO reqDet);

	public int setSafeInvntryQyByPrdlstNo(AutoReqVO autoReq);

	public int setAutoReqByPrdlstNo(AutoReqVO autoReq);

	public int getReqCount(@Param("searchVO") ReqSearchVO reqSearchVO);

	public List<ReqVO> getReqList(@Param("pagingVO") PaginationInfoVO<ReqVO> pagingVO,@Param("searchVO") ReqSearchVO reqSearchVO);

	public List<ReqDetailVO> getReqDetailsByReqNo(String reqno);

	public ReqVO gerReqInfoByReqNo(String reqno);

	public OrderVO getOrderInfoByOrderNo(String orderno);

	public ReqVO getReqInfoByReqNo(String reqno);

}
