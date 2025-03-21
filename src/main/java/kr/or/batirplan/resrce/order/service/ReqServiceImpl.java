package kr.or.batirplan.resrce.order.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.resrce.order.mapper.ReqMapper;
import kr.or.batirplan.resrce.order.vo.AutoReqVO;
import kr.or.batirplan.resrce.order.vo.OrderVO;
import kr.or.batirplan.resrce.order.vo.ReqDetailVO;
import kr.or.batirplan.resrce.order.vo.ReqSearchVO;
import kr.or.batirplan.resrce.order.vo.ReqVO;
import kr.or.batirplan.resrce.product.vo.PrdlstVO;
import kr.or.batirplan.security.vo.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReqServiceImpl implements ReqService {
	
	@Autowired
	private ReqMapper reqMapper;

	@Override
	public List<PrdlstVO> getPrdlstByCcpyCode(String ccpyCode) {
		return reqMapper.getPrdlstByCcpyCode(ccpyCode);
	}
	
	/**
	 * 발주 요청 및 요청 상세 삽입 서비스
	 * @author leezy
	 * @param requests - 발주 요청 VO / loginUser - 로그인한 유저
	 * @return 모든 발주 요청 삽입 성공시 발주 요청 건 반환
	 */
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int reqRegister(List<ReqVO> requests, CustomUser loginUser) {
		for (ReqVO req : requests) {
			if (loginUser != null) {
				req.setReqstrCode(loginUser.getMemberVO().getEmpVO().getEmplCode());
			}
			reqMapper.insertReq(req);
			
            String newReqNo = req.getReqNo(); 
            if (req.getDetails() != null && req.getDetails().size() > 0) {
            	for (ReqDetailVO reqDet : req.getDetails()) {
            		reqDet.setReqNo(newReqNo);
            		reqMapper.insertReqDetail(reqDet);
				}
            }
		}
		return requests.size();
	}
	
	
	
	
	public List<Map<String, Object>> parseExcel(MultipartFile file) throws IOException {
	    List<Map<String, Object>> resultList = new ArrayList<>();

	    // Workbook 생성
	    Workbook workbook = null;
	    String filename = file.getOriginalFilename();
	    if (filename.endsWith(".xls")) {
	        workbook = new HSSFWorkbook(file.getInputStream()); // HSSF
	    } else {
	        workbook = new XSSFWorkbook(file.getInputStream()); // XSSF
	    }

	    // 첫 번째 시트
	    Sheet sheet = workbook.getSheetAt(0);
	    // 헤더(1행)
	    Row headerRow = sheet.getRow(0);
	    int lastCellNum = headerRow.getLastCellNum();
	    String[] headers = new String[lastCellNum];
	    for (int i = 0; i < lastCellNum; i++) {
	        Cell cell = headerRow.getCell(i);
	        headers[i] = (cell == null) ? ("COL" + i) : cell.toString().trim();
	    }

	    // 데이터(2행~)
	    int lastRowNum = sheet.getLastRowNum();
	    for (int rowIndex = 1; rowIndex <= lastRowNum; rowIndex++) {
	        Row row = sheet.getRow(rowIndex);
	        if (row == null) continue;

	        Map<String, Object> rowData = new HashMap<>();
	        for (int cn = 0; cn < lastCellNum; cn++) {
	            Cell cell = row.getCell(cn, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
	            String cellValue = (cell == null) ? "" : getCellValueAsString(cell);
	            rowData.put(headers[cn], cellValue);
	        }
	        resultList.add(rowData);
	    }

	    workbook.close();
	    return resultList;
	}

	private String getCellValueAsString(Cell cell) {
	    switch (cell.getCellType()) {
	        case STRING:
	            return cell.getStringCellValue();
	        case NUMERIC:
	            if (DateUtil.isCellDateFormatted(cell)) {
	                return new SimpleDateFormat("yyyy-MM-dd").format(cell.getDateCellValue());
	            } else {
	                double val = cell.getNumericCellValue();
	                // 정수 변환 로직 (소수점 없는 경우)
	                if (val == (long) val) {
	                    return String.valueOf((long) val);
	                } else {
	                    return String.valueOf(val);
	                }
	            }
	        case BOOLEAN:
	            return String.valueOf(cell.getBooleanCellValue());
	        case FORMULA:
	            return cell.getCellFormula();
	        case BLANK:
	        default:
	            return "";
	    }
	}

	@Override
	public List<Map<String, Object>> parseExcelFile(MultipartFile excelFile) {
		List<Map<String, Object>> serviceResult = null;
		try {
			serviceResult = parseExcel(excelFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return serviceResult;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int autoReqRegister(AutoReqVO autoReq) {
		
		int reqSetStatus = reqMapper.setSafeInvntryQyByPrdlstNo(autoReq);
		int autoReqSetStatus = reqMapper.setAutoReqByPrdlstNo(autoReq);
		
		if (reqSetStatus > 0 && autoReqSetStatus > 0) {
			return 1;
		}
		
		return 0;
	}

	@Override
	public int getReqCount(ReqSearchVO reqSearchVO) {
		return reqMapper.getReqCount(reqSearchVO);
	}

	@Override
	public List<ReqVO> getReqList(PaginationInfoVO<ReqVO> pagingVO, ReqSearchVO reqSearchVO) {
		return reqMapper.getReqList(pagingVO, reqSearchVO);
	}

	@Override
	public List<ReqDetailVO> gerReqDetailsByReqNo(String reqno) {
		return reqMapper.getReqDetailsByReqNo(reqno);
	}

	@Override
	public ReqVO gerReqInfoByReqNo(String reqno) {
		return reqMapper.gerReqInfoByReqNo(reqno);
	}

	@Override
	public OrderVO getOrderInfoByOrderNo(String orderno) {
		return reqMapper.getOrderInfoByOrderNo(orderno);
	}

	@Override
	public ReqVO getReqInfoByReqNo(String reqno) {
		return reqMapper.getReqInfoByReqNo(reqno);
	}

	
}
