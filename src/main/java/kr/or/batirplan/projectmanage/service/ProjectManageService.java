package kr.or.batirplan.projectmanage.service;

import java.util.List;
import java.util.Map;

import kr.or.batirplan.projectmanage.vo.ProjectManagePJTSearchVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePRCSVO;

public interface ProjectManageService {

	public Map<String, Object> getProjectList(ProjectManagePJTSearchVO projectManagePJTSearchVO);

	public Map<String, Object> getMyProjectList(int currentPage, String emplCode);

	public ProjectManagePJTVO getProjectInfoByPrjctNo(int prjctNo);

	public List<ProjectManagePRCSVO> getProcessListByPrjctNo(int prjctNo);

	public void updatePrcsPrgs(List<ProjectManagePRCSVO> prcsList);

}
