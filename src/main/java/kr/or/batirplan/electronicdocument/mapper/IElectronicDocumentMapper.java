package kr.or.batirplan.electronicdocument.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.electronicdocument.vo.CorbonCopyVO;
import kr.or.batirplan.electronicdocument.vo.DocumentVO;
import kr.or.batirplan.electronicdocument.vo.FormVO;
import kr.or.batirplan.electronicdocument.vo.SanctionLineVO;
import kr.or.batirplan.employee.vo.EmployeeVO;

@Mapper
public interface IElectronicDocumentMapper {
    public List<DocumentVO> selectDocumentList(Map<String, Object> params);
	public List<FormVO> getAllDocumentForms();
	public FormVO getDocumentWriteForm(int formNo);
	public int createDocument(DocumentVO documentVO);
	public int getLastInsertedDocNo();
	public List<EmployeeVO> getAllEmployees();
	public void insertSanctionLine(Map<String, Object> params);
	public void insertCorbonCopy(Map<String, Object> params);
	
	public DocumentVO getDocumentDetail(int docNo);
	public List<SanctionLineVO> getSanctionLines(int docNo);
	public List<CorbonCopyVO> getCorbonCopies(int docNo);
	public int updateDocument(DocumentVO documentVO);
	public void deleteSanctionLines(int docNo);
	public void deleteCorbonCopies(int docNo);
	public int updateStampImage(String emplCode, String approvalStamp);
	public String selectStampUrl(String emplCode);
    public SanctionLineVO selectSanctionLineByNo(int sanctnLineNo);
    public int updateSanctionApprove(int sanctnLineNo);
    public int countNotApprovedLines(int docNo);
    public int updateDocumentStatus(@Param("docNo") int docNo, @Param("status") String status);
	public void rejectSanctionLine(@Param("sanctnLineNo") int sanctnLineNo, @Param("returnResn") String returnResn);
	public void updateSanctionToFinal(int sanctnLineNo);
	public int getTotalDocumentCount(Map<String, Object> params);
}