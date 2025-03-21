package kr.or.batirplan.project.projectplan.service;

import java.util.List;
import java.util.Map;

import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.project.projectmanage.vo.ProcessVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.project.projectplan.vo.BidVO;
import kr.or.batirplan.project.projectplan.vo.CheckListVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationProductVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationVO;
import kr.or.batirplan.project.projectplan.vo.PriceQuotationVO;

public interface IProjectPlanService {
	public List<ProjectVO> getProjectList(Map<String, Object> params);
	public ProjectVO getProjectDetail(int prjctNo);
	public String getEmployeeNameByCode(String charger);
	public EmployeeVO getEmployeeByCode(String sptMngr);
	public List<ProcessVO> getProcessListByProject(int prjctNo);
	public boolean updateSiteManager(String emplCode, String emplName, int prjctNo);
	public boolean deleteSiteManager(String emplCode, int prjctNo);
	public void updateProcessStatus(int procsNo, String progrsSttus);
	public EmployeeVO getEmployeeDetails(String emplCode);
	public List<DeclarationVO> getDeclarationList();
	public int insertDeclaration(int prjctNo, String reportTitle, int totalAmount);
	public void insertDeclarationProductList(int declarationNo, List<Integer> selectedProductIds, List<Integer> quantities);
	public int getFirstProcessNo(int prjctNo);
	public boolean updateProjectPlanStatus(int prjctNo, String planStatus);
	public DeclarationVO getDeclarationDetail(int dclrtNo);
	public List<DeclarationProductVO> getDeclarationProductList(int dclrtNo);
	public DeclarationVO getDeclarationForProject(int prjctNo);
	public List<BidVO> getBidList();
	public boolean insertBid(BidVO bid);
	public BidVO getBidDetail(int pblancNo);
	public List<BidVO> getBidForProject(int prjctNo);
	public BidVO getBidForProcess(int procsNo);
	public List<PriceQuotationVO> getQuotationList(int pblancNo);
	public PriceQuotationVO getQuotationDetail(int prqudoNo);
	public boolean isQuotationApproved(int pblancNo);
	public boolean approveQuotation(int prqudoNo);
	public PriceQuotationVO getApprovedQuotation(int pblancNo);
	public boolean updateProcessDetails(int procsNo, String procsCn, String procsBgnde, String procsEndde);
	public  boolean saveSafetyChecklist(CheckListVO checkList, List<String> detailItems);
	public List<CheckListVO> getSafetyChecklistList(String emplCode);
	public CheckListVO getSafetyChecklistDetail(int chklstNo);
	public List<String> getSafetyChecklistDetailItems(int chklstNo);
	public boolean assignChecklistToProcess(int procsNo, int chklstNo, int prjctNo);
	public Map<Integer, Integer> getAssignedChecklistMapping(int prjctNo);
	public boolean deleteAssignedChecklistMapping(int prjctNo, int procsNo);
	public boolean updateProjectProgressStatus(int prjctNo, String progressStatus);
	public int getProjectTotalCount(Map<String, Object> params);
}