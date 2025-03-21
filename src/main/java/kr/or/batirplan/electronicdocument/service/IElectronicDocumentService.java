package kr.or.batirplan.electronicdocument.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.electronicdocument.vo.CorbonCopyVO;
import kr.or.batirplan.electronicdocument.vo.DocumentVO;
import kr.or.batirplan.electronicdocument.vo.FormVO;
import kr.or.batirplan.electronicdocument.vo.SanctionLineVO;
import kr.or.batirplan.employee.vo.EmployeeVO;

public interface IElectronicDocumentService {
	public List<DocumentVO> selectDocumentList(Map<String, Object> params);
	public List<FormVO> getAllDocumentForms();
	public FormVO getDocumentWriteForm(int formNo);
	public int createDocument(DocumentVO documentVO);
	public List<EmployeeVO> getAllEmployees();
	public void insertSanctionLine(int docNo, String approver, int order);
	public void insertCorbonCopy(int docNo, String refCode);
	
	public DocumentVO getDocumentDetail(int docNo);
	public List<SanctionLineVO> getSanctionLines(int docNo);
	public List<CorbonCopyVO> getCorbonCopies(int docNo);
	public int updateDocument(DocumentVO documentVO);
	public void deleteSanctionLines(int docNo);
	public void deleteCorbonCopies(int docNo);
	public String uploadStampImage(String emplCode, MultipartFile stampImage) throws Exception;
	public String selectStampUrl(String emplCode);
	public List<SanctionLineVO> getSanctionLinesWithPrevInfo(int docNo);
	public boolean approveSanction(int docNo, int sanctnLineNo, String emplCode);
	public boolean deleteStampImage(String emplCode) throws Exception;
	public void rejectDocument(int docNo, int sanctnLineNo, String emplCode, String returnResn);
	public void updateRejectedDocument(DocumentVO document, List<String> approverList, List<String> referenceList);
	public boolean finalApproval(int docNo, String emplCode);
	public int getTotalDocumentCount(Map<String, Object> params);
}