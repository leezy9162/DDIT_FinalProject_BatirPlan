package kr.or.batirplan.bid.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.bid.mapper.IBidMapper;
import kr.or.batirplan.bid.vo.BidVO;
import java.util.List;

@Service
public class BidServiceImpl implements IBidService {

    @Autowired
    private IBidMapper bidMapper;

	@Override
	public int selectBidsWithCount(PaginationInfoVO<BidVO> pagingVO) {
		return bidMapper.selectBidsWithCount(pagingVO);
	}
	
	@Override
	public List<BidVO> selectBidWithAllList() {
		return bidMapper.selectBidWithAllList();
	}

	@Override
	public List<BidVO> selectBidsWithList(PaginationInfoVO<BidVO> pagingVO) {
		return bidMapper.selectBidsWithList(pagingVO);
	}

	@Override
	public BidVO selectBidDetail(String pblancNo) {
		return bidMapper.selectBidDetail(pblancNo);
	}

}

