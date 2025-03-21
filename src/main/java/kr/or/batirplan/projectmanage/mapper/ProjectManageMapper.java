package kr.or.batirplan.projectmanage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTSearchVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePRCSVO;

@Mapper
public interface ProjectManageMapper {

	public int getProjectCount(@Param("searchVO") ProjectManagePJTSearchVO projectManagePJTSearchVO);
	

	public List<ProjectManagePJTVO> getProjectList(@Param("pagingVO") PaginationInfoVO<ProjectManagePJTVO> pagingVO,
			@Param("searchVO") ProjectManagePJTSearchVO projectManagePJTSearchVO);


	public int getMyProjectCount(String emplCode);

	public List<ProjectManagePJTVO> getMyProjectList(@Param("pagingVO") PaginationInfoVO<ProjectManagePJTVO> pagingVO,@Param("emplCode") String emplCode);


	public ProjectManagePJTVO getProjectInfoByPrjctNo(int prjctNo);


	public List<ProjectManagePRCSVO> getProcessListByPrjctNo(int prjctNo);


	public void updatePrcsPrgs(ProjectManagePRCSVO prcs);
}
