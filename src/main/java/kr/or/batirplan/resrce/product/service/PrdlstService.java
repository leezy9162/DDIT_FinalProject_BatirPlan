package kr.or.batirplan.resrce.product.service;

import java.util.List;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.resrce.product.vo.PrdlstCtgryVO;
import kr.or.batirplan.resrce.product.vo.PrdlstSearchVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;

public interface PrdlstService {

	public List<String> getUnitList();

	public List<PrdlstCtgryVO> getLevelOneCtgryList();

	public List<PrdlstCtgryVO> getLevelTwoCtgryList(int levelOneCtgryNo);

	public List<PrdlstCtgryVO> getLevelThreeCtgryList(int levelTwoCtgryNo);

	public int getCcpyCount(PaginationInfoVO<CooperationcomVO> pagingVO);

	public List<CooperationcomVO> getCcpyList(PaginationInfoVO<CooperationcomVO> pagingVO);

	public int prdlstRegister(PrdlstVO prdlstVO);

	public PrdlstVO getPrdlstByPrdlstNo(int prdlstNo);

	public int prdlstModify(PrdlstVO prdlstVO);

	public int getPrdlstCount(PrdlstSearchVO prdlstSearchVO);

	public List<PrdlstVO> getPrdlstList(PaginationInfoVO<PrdlstVO> pagingVO, PrdlstSearchVO prdlstSearchVO);


}
