package kr.or.batirplan.fnnr.salary.web;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.batirplan.fnnr.salary.service.ISalaryService;
import kr.or.batirplan.fnnr.salary.vo.SalaryVO;

@Controller
@RequestMapping("/batirplan/fnnr/salary")
public class SalaryController {

    private final ISalaryService salaryService;

    @Autowired
    public SalaryController(ISalaryService salaryService) {
        this.salaryService = salaryService;
    }

    @GetMapping("/list")
    public String salaryPage(Model model) {
        return "salary/list";
    }

    @GetMapping("/unpaid")
    @ResponseBody
    public ResponseEntity<List<SalaryVO>> getUnpaidEmployees(
            @RequestParam(required = false, defaultValue = "202501") String salaryYm) {
        return ResponseEntity.ok(salaryService.getUnpaidEmployees(salaryYm));
    }

    @GetMapping("/paid")
    @ResponseBody
    public ResponseEntity<List<SalaryVO>> getPaidEmployees(
            @RequestParam(required = false, defaultValue = "202501") String salaryYm) {
        return ResponseEntity.ok(salaryService.getPaidEmployees(salaryYm));
    }

    @PostMapping("/pay")
    public ResponseEntity<String> processSalaryPayment(
        @RequestParam String salaryYm,
        @RequestParam List<String> emplCode // 여러 개의 직원 코드 받을 수 있도록 변경
    ) {
        boolean allPaid = true;
        for (String code : emplCode) {
            boolean isPaid = salaryService.processSalaryPayment(salaryYm, code);
            if (!isPaid) {
                allPaid = false;
            }
        }

        if (allPaid) {
            return ResponseEntity.ok("급여 지급 완료");
        } else {
            return ResponseEntity.badRequest().body("일부 직원은 이미 지급되었습니다.");
        }
    }
}

