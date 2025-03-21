package kr.or.batirplan.projectmanage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.projectmanage.mapper.ProjectManageMapper;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTSearchVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePJTVO;
import kr.or.batirplan.projectmanage.vo.ProjectManagePRCSVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ProjectManageServiceImpl implements ProjectManageService {

	@Autowired
	private ProjectManageMapper projectManageMapper;

	@Override
	public Map<String, Object> getProjectList(ProjectManagePJTSearchVO projectManagePJTSearchVO) {
		Map<String, Object> resultMap = new HashMap<>();
		
		PaginationInfoVO<ProjectManagePJTVO> pagingVO = new PaginationInfoVO<>(10,5);
		pagingVO.setCurrentPage(projectManagePJTSearchVO.getCurrentPage());
		
		int totalRecord = projectManageMapper.getProjectCount(projectManagePJTSearchVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<ProjectManagePJTVO> dataList = projectManageMapper.getProjectList(pagingVO, projectManagePJTSearchVO);
		pagingVO.setDataList(dataList);
		
		String pagingHTML = pagingVO.getPagingHTML();
		
		resultMap.put("dataList", dataList);
		resultMap.put("paging", pagingHTML);
		
		return resultMap;
	}

	@Override
	public Map<String, Object> getMyProjectList(int currentPage, String emplCode) {
		Map<String, Object> resultMap = new HashMap<>();
		
		PaginationInfoVO<ProjectManagePJTVO> pagingVO = new PaginationInfoVO<>(10,5);
		pagingVO.setCurrentPage(currentPage);
		
		int totalRecord = projectManageMapper.getMyProjectCount(emplCode);
		pagingVO.setTotalRecord(totalRecord);
		
		List<ProjectManagePJTVO> dataList = projectManageMapper.getMyProjectList(pagingVO, emplCode);
		pagingVO.setDataList(dataList);
		
		String pagingHTML = pagingVO.getPagingHTML();
		
		resultMap.put("dataList", dataList);
		resultMap.put("paging", pagingHTML);
		
		return resultMap;
	}

	@Override
	public ProjectManagePJTVO getProjectInfoByPrjctNo(int prjctNo) {
		return projectManageMapper.getProjectInfoByPrjctNo(prjctNo);
	}

	@Override
	public List<ProjectManagePRCSVO> getProcessListByPrjctNo(int prjctNo) {
		return projectManageMapper.getProcessListByPrjctNo(prjctNo);
	}

	@Override
	public void updatePrcsPrgs(List<ProjectManagePRCSVO> prcsList) {
		for (ProjectManagePRCSVO prcs : prcsList) {
			projectManageMapper.updatePrcsPrgs(prcs);
		}
	}
	
}
