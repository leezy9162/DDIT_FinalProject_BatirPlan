package kr.or.batirplan.resrce.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.resrce.order.vo.AutoReqVO;

@Mapper
public interface ReqMapperForScheduler {

	public List<AutoReqVO> getAutoReqTargetListBySttus();

	public int searchOrderProcessQty(int prdlstNo);

	public int searchReqProcessQty(int prdlstNo);

}
