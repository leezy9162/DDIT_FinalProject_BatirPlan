package kr.or.batirplan.employee.web;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;
import kr.or.batirplan.employee.service.IMypageService;
import kr.or.batirplan.employee.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/erp")
public class MypageController {

    @Autowired
    private IMypageService mypageService;

    @GetMapping("/mypage")
    public String getMypage(HttpSession session) {
        // 세션에 로그인한 사용자 정보가 있는지 확인
        if (session.getAttribute("loginUser") == null) {
            log.info("세션에 로그인한 사용자 정보 없음. 사용자 정보 조회 시작");

            // Spring Security에서 현재 로그인한 사용자 ID 가져오기
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.getPrincipal() instanceof User) {
                String username = ((User) authentication.getPrincipal()).getUsername();
                log.info("현재 로그인한 사용자 ID: " + username);

                // DB에서 사용자 정보 조회
                EmployeeVO employee = mypageService.getEmployeeById(username);
                if (employee != null) {
                    session.setAttribute("loginUser", employee);
                    log.info("세션에 사용자 정보 저장 완료: " + employee.getEmplNm());
                } else {
                    log.warn("사용자 정보를 찾을 수 없음!");
                }
            }
        }
        return "erp/mypage";
    }

    // 계좌번호 유효성 검사 API
    @PostMapping("/account/validate")
    @ResponseBody
    public Map<String, Boolean> validateAccount(@RequestBody Map<String, String> request) {
        String accountNumber = request.get("accountNumber");
        accountNumber = accountNumber.replaceAll("-", "");

        boolean isValid = accountNumber.matches("\\d{10,14}");

        Map<String, Boolean> response = new HashMap<>();
        response.put("valid", isValid);
        return response;
    }

    // 계좌번호 업데이트 API
    @PostMapping("/account/update")
    @ResponseBody
    public Map<String, Boolean> updateAccount(@RequestBody Map<String, String> request, HttpSession session) {
        // 세션에서 로그인한 사용자 정보 가져오기
        EmployeeVO employee = (EmployeeVO) session.getAttribute("loginUser");

        if (employee == null) {
            log.error("세션에 로그인한 사용자 정보 없음 (loginUser가 null)");
            Map<String, Boolean> response = new HashMap<>();
            response.put("success", false);
            return response;
        }

        log.info("세션에서 가져온 사용자 정보: " + employee.getEmplNm() + " (" + employee.getEmplCode() + ")");

        String emplCode = employee.getEmplCode();
        String bankCode = request.get("bankCode");
        String accountNumber = request.get("accountNumber").replaceAll("-", "");

        boolean updateSuccess = mypageService.updateEmployeeAccount(emplCode, bankCode, accountNumber);

        Map<String, Boolean> response = new HashMap<>();
        response.put("success", updateSuccess);
        return response;
    }
}
