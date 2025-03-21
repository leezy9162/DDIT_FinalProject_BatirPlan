package kr.or.batirplan.project.projectplan.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.common.vo.CommonnessCodeVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.project.projectmanage.vo.ProcessVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.project.projectplan.vo.BidVO;
import kr.or.batirplan.project.projectplan.vo.CheckListVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationProductVO;
import kr.or.batirplan.project.projectplan.vo.DeclarationVO;
import kr.or.batirplan.project.projectplan.vo.PriceQuotationVO;

@Mapper
public interface IProjectPlanMapper {
	public int insertProject(ProjectVO projectVO);
	public String selectGroupCodeByCategory(String category);
	public List<CommonnessCodeVO> selectCommonnessCodesByGroupCode(String groupCode);
	public void insertProcess(ProcessVO processVO);
	public List<ProjectVO> getProjectList(Map<String, Object> params);
	public ProjectVO getProjectDetail(int prjctNo);
	public String getEmployeeNameByCode(String charger);
	public EmployeeVO getEmployeeByCode(String sptMngr);
	public List<ProcessVO> getProcessListByProject(int prjctNo);
	public void updateSiteManager(@Param("emplCode") String emplCode, @Param("emplName") String emplName, @Param("prjctNo") int prjctNo);
	public void deleteSiteManager(String emplCode, int prjctNo);
	public void updateProcessStatus(int procsNo, String progrsSttus);
	public EmployeeVO getEmployeeDetails(String emplCode);
	public List<DeclarationVO> getDeclarationList();
	public void insertDeclaration(int prjctNo, String dclrtSj, int totalAmount);
	public int getLastInsertedDeclarationNo();
	public void insertDeclarationProduct(@Param("declarationNo") int declarationNo,@Param("prdlstNo") int prdlstNo,@Param("qty") int qty);
	public int getFirstProcessNo(int prjctNo);
	public void updateProjectPlanStatus(int prjctNo, String planStatus);
	public DeclarationVO getDeclarationDetail(int dclrtNo);
	public List<DeclarationProductVO> getDeclarationProductList(int dclrtNo);
	public DeclarationVO getDeclarationForProject(@Param("prjctNo") int prjctNo);
	public List<BidVO> getBidList();
	public void insertBid(BidVO bid);
	public BidVO getBidDetail(@Param("pblancNo") int pblancNo);
	public List<BidVO> getBidForProject(int prjctNo);
	public BidVO getBidForProcess(int procsNo);
	public List<PriceQuotationVO> getQuotationList(int pblancNo);
	public PriceQuotationVO getQuotationDetail(int prqudoNo);
	public boolean isQuotationApproved(@Param("pblancNo") int pblancNo);
	public boolean approveQuotation(@Param("prqudoNo") int prqudoNo);
	public int getApprovedQuotationCount(int pblancNo);
	public PriceQuotationVO getApprovedQuotation(@Param("pblancNo") int pblancNo);
	public ProcessVO getProcessByNo(@Param("procsNo") int procsNo);
	public void updateProcessDetails(ProcessVO process);
	public void insertSafetyChecklist(CheckListVO checkList);
	public void insertSafetyCheckDetailItem(@Param("chklstNo") int chklstNo, @Param("detailItemCn") String detailItemCn);
	public List<CheckListVO> getSafetyChecklistList(@Param("emplCode") String emplCode);
	public CheckListVO getSafetyChecklistDetail(@Param("chklstNo") int chklstNo);
	public List<String> getSafetyChecklistDetailItems(@Param("chklstNo") int chklstNo);
	public List<String> getChecklistDetailItems(int chklstNo);
	public void insertProcessChecklist(Map<String, Object> paramMap);
	public void insertProcessChecklistDetail(Map<String, Object> paramMap);
	public Integer selectProcessChecklistId(Map<String, Object> param);
	public void updateProcessChecklist(Map<String, Object> updateMap);
	public void deleteProcessChecklistDetails(Integer existingAssignmentId);
	public List<Map<String, Object>> getAssignedChecklistMapping(int prjctNo);
	public void deleteProcessChecklist(Integer assignmentId);
	public void updateProjectProgressStatus(Map<String, Object> param);
	public int getProjectTotalCount(Map<String, Object> params);
	
	
	int checkCooperationCompanyByBizrno(@Param("bizrno") String bizrno);
	String generateCooperationCompanyCode();
	void insertCooperationCompany(Map<String, Object> cooperationData);
	
	
	
	void updateProcessWithCooperationCompany(Map<String, Object> params);
	Integer getProcessNoByPblancNo(@Param("pblancNo") int pblancNo);
	String getCooperationCompanyCodeByBizrno(@Param("bizrno") String bizrno);
	
}