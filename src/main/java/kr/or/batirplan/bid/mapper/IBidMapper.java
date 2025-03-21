package kr.or.batirplan.bid.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.bid.vo.BidVO;
import kr.or.batirplan.common.vo.PaginationInfoVO;

@Mapper
public interface IBidMapper {

//    List<BidVO> findAllBids();
//    int countBids(@Param("searchWord") String searchWord);
//    List<BidVO> findBidsWithPagination(PaginationInfoVO<BidVO> pagingVO);
//	BidVO findBidByNo(String pblancNo);

	public int selectBidsWithCount(PaginationInfoVO<BidVO> pagingVO);
	public List<BidVO> selectBidsWithList(PaginationInfoVO<BidVO> pagingVO);
	public BidVO selectBidDetail(String pblancNo);
	public List<BidVO> selectBidWithAllList();
}
