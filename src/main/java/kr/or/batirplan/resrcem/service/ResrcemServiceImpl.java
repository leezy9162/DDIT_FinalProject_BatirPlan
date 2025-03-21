package kr.or.batirplan.resrcem.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.List;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.resrcem.mapper.ResrcemMapper;
import kr.or.batirplan.resrcem.vo.ResrcemVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ResrcemServiceImpl implements ResrcemService {
    
    @Autowired
    private ResrcemMapper mapper;

    /**
     * 입출고 리스트 전체 조회
     */
    @Override
    public List<ResrcemVO> selectResrcem() {
        List<ResrcemVO> list = mapper.selectResrcem();
        log.info("wrhsdlvrList 데이터 개수: {}", (list != null ? list.size() : 0));
        return list;
    } 

    /**
     * 특정 기록 번호로 입출고 기록 조회 (엑셀 다운로드용)
     */
    @Override
    public ResrcemVO getResrcemById(int recordNo) {
        ResrcemVO record = mapper.selectResrcemById(recordNo);
        if (record == null) {
            log.warn("recordNo {} 에 대한 데이터가 없습니다.", recordNo);
        }
        return record;
    }

    /**
     * 개별 입출고 기록을 엑셀 파일로 변환하여 다운로드할 수 있도록 제공
     */
    @Override
    public ByteArrayInputStream downloadResrcemAsExcel(int recordNo) {
        ResrcemVO record = getResrcemById(recordNo);
        if (record == null) {
            return null; // 조회된 데이터가 없으면 null 반환
        }

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("입출고 기록");

            // 헤더 행 생성
            Row headerRow = sheet.createRow(0);
            String[] headers = {"기록 번호", "창고 코드", "품목명", "구분명", "입출고 유형", "입출고 수량", "입출고 날짜", "비고"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            // 데이터 행 생성
            Row dataRow = sheet.createRow(1);
            dataRow.createCell(0).setCellValue(record.getRcordNo());
            dataRow.createCell(1).setCellValue(record.getWrhousCode());
            dataRow.createCell(2).setCellValue(record.getPrdlstNm());
            dataRow.createCell(3).setCellValue(record.getSource());  // 구분명 (프로젝트명 or 발주 상세번호)
            dataRow.createCell(4).setCellValue(record.getWrhsdlvrTy());
            dataRow.createCell(5).setCellValue(record.getWrhsdlvrQy());
            dataRow.createCell(6).setCellValue(record.getWrhsdlvrDe());
            dataRow.createCell(7).setCellValue(record.getRm());

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (Exception e) {
            log.error("엑셀 파일 생성 중 오류 발생: {}", e.getMessage(), e);
            return null;
        }
    }
}
