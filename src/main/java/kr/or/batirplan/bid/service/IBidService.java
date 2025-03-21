package kr.or.batirplan.bid.service;

import java.util.List;

import kr.or.batirplan.bid.vo.BidVO;
import kr.or.batirplan.common.vo.PaginationInfoVO;

public interface IBidService {

//    List<BidVO> getAllBids();
//    PaginationInfoVO<BidVO> getBidsWithPagination(PaginationInfoVO<BidVO> pagingVO);
//	BidVO getBidDetail(String pblancNo);
	public int selectBidsWithCount(PaginationInfoVO<BidVO> pagingVO);
	public List<BidVO> selectBidsWithList(PaginationInfoVO<BidVO> pagingVO);
	public BidVO selectBidDetail(String pblancNo);
	public List<BidVO> selectBidWithAllList();
}
