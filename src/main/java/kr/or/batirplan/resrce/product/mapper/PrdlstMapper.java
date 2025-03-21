package kr.or.batirplan.resrce.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.resrce.product.vo.PrdlstCtgryVO;
import kr.or.batirplan.resrce.product.vo.PrdlstSearchVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;

@Mapper
public interface PrdlstMapper {

	public List<String> getUnitList();

	public List<PrdlstCtgryVO> getLevelOneCtgryList();

	public List<PrdlstCtgryVO> getLevelTwoCtgryList(int levelOneCtgryNo);

	public List<PrdlstCtgryVO> getLevelThreeCtgryList(int levelTwoCtgryNo);

	public int getCcpyCount(PaginationInfoVO<CooperationcomVO> pagingVO);

	public List<CooperationcomVO> getCcpyList(PaginationInfoVO<CooperationcomVO> pagingVO);

	public int prdlstRegister(PrdlstVO prdlstVO);

	public int setPrdlstImageCours(PrdlstVO prdlstVO);

	public PrdlstVO getPrdlstByPrdlstNo(int prdlstNo);

	public int prdlstModify(PrdlstVO prdlstVO);

	public int getPrdlstCount(@Param("searchVO") PrdlstSearchVO prdlstSearchVO);

	public List<PrdlstVO> getPrdlstList(@Param("pagingVO") PaginationInfoVO<PrdlstVO> pagingVO,@Param("searchVO") PrdlstSearchVO prdlstSearchVO);

}
