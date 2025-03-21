package kr.or.batirplan.resrcem.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;
import kr.or.batirplan.resrcem.service.ResrcemService;
import kr.or.batirplan.resrcem.vo.ResrcemVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@PreAuthorize("hasRole('ROLE_DEPT_RESRCE')")
@RequestMapping("/batirplan/resrcem/wrhsdlvr")
public class ResrcemController {

    @Autowired
    private ResrcemService service;

    /**
     * 📌 입출고 목록 조회
     */
    @GetMapping("/list")
    public String getWrhsdlvrList(Model model) {
        List<ResrcemVO> wrhsdlvrList = service.selectResrcem();
        model.addAttribute("wrhsdlvrList", wrhsdlvrList);
        return "resrcem/wrhsdlvrList";
    }

    /**
     * 📥 개별 항목 엑셀 다운로드
     * - recordNo가 있으면 해당 항목 다운로드
     * - recordNo가 없으면 전체 다운로드
     */
    @GetMapping("/excelDownload")
    public void downloadExcel(@RequestParam(value = "recordNo", required = false) Integer recordNo, HttpServletResponse response) {
        try {
            // 데이터 조회 (recordNo가 있으면 개별 조회, 없으면 전체 조회)
            List<ResrcemVO> wrhsdlvrList;
            if (recordNo != null) {
                ResrcemVO data = service.getResrcemById(recordNo);
                if (data == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "해당 데이터가 존재하지 않습니다.");
                    return;
                }
                wrhsdlvrList = List.of(data); // 단일 항목을 리스트로 변환
            } else {
                wrhsdlvrList = service.selectResrcem(); // 전체 데이터 조회
            }

            // 엑셀 파일 생성
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("입출고 기록");

            // 스타일 설정 (헤더)
            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            Font headerFont = workbook.createFont();
            headerFont.setBold(true);
            headerStyle.setFont(headerFont);

            // 헤더 생성
            Row headerRow = sheet.createRow(0);
            String[] headers = {"기록번호", "입출고 유형", "구분명", "입출고 수량", "입출고 날짜", "비고"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // 데이터 행 추가
            int rowNum = 1;
            for (ResrcemVO data : wrhsdlvrList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(data.getRcordNo());
                row.createCell(1).setCellValue("01".equals(data.getWrhsdlvrTy()) ? "입고" : "출고");
                row.createCell(2).setCellValue(data.getSource());
                row.createCell(3).setCellValue(data.getWrhsdlvrQy());
                row.createCell(4).setCellValue(data.getWrhsdlvrDe());
                row.createCell(5).setCellValue(data.getRm());
            }

            // 컬럼 자동 너비 조정
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // **파일명 한글 깨짐 방지 (UTF-8 인코딩)**
            String fileName = (recordNo != null) ? "입출고_기록_" + recordNo + ".xlsx" : "입출고_전체기록.xlsx";
            String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8).replaceAll("\\+", "%20");

            // 엑셀 파일 응답 처리
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=" + encodedFileName);
            
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (IOException e) {
            log.error("엑셀 다운로드 오류", e);
        }
    }
}
