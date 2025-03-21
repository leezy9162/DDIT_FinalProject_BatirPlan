package kr.or.batirplan.servicemanagement.authority.web;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import kr.or.batirplan.servicemanagement.authority.mapper.MemberAuthorityMapper;
import kr.or.batirplan.servicemanagement.authority.vo.MemberAuthorityVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/servicemanagement/authority")
@RequiredArgsConstructor
public class MemberAuthorityController {

    private final MemberAuthorityMapper memberAuthorityMapper;

    /**
     * 🔹 권한 관리 페이지 (JSP 뷰 반환)
     * 권한 체크: ROLE_DEPT_IT 또는 ROLE_RSPNBER_IT 권한이 있어야 접근 가능
     */
    @PreAuthorize("hasAnyRole('ROLE_DEPT_IT', 'ROLE_RSPNBER_IT')")
    @GetMapping
    public String authorityManagementPage(Model model) {
        log.info("📌 [Controller] 권한 관리 페이지 접근");

        List<MemberAuthorityVO> users = memberAuthorityMapper.findAllUsersWithRoles();
        model.addAttribute("users", users);

        List<String> allAuthorities = memberAuthorityMapper.getValidAuthorities();
        model.addAttribute("allAuthorities", allAuthorities);

        return "erp/authorityManagement";
    }

    /**
     * 🔹 특정 사용자의 권한 추가 (API)
     */
    @PostMapping("/addUserRole")
    @ResponseBody
    @Transactional
    public ResponseEntity<String> addUserRole(@RequestParam String mberId, @RequestParam String role) {
        log.info("⚙️ [API] 사용자 '{}'의 권한 '{}' 추가 요청", mberId, role);

        if (!isValidAuthority(role)) {
            return ResponseEntity.badRequest().body("❌ 유효하지 않은 권한: " + role);
        }

        List<String> currentRoles = memberAuthorityMapper.getUserRoles(mberId);
        if (currentRoles.contains(role)) {
            return ResponseEntity.ok("⚠️ 이미 보유한 권한입니다.");
        }

        int result = memberAuthorityMapper.addRoleToUser(mberId, role);
        if (result > 0) {
            return ResponseEntity.ok("✅ 권한 추가 성공");
        } else {
            return ResponseEntity.status(500).body("❌ 권한 추가 실패 (DB 오류)");
        }
    }

    /**
     * 🔹 특정 사용자의 권한 삭제 (API)
     */
    @PostMapping("/removeUserRole")
    @ResponseBody
    @Transactional
    public ResponseEntity<String> removeUserRole(@RequestParam String mberId, @RequestParam String role) {
        log.info("⚙️ [API] 사용자 '{}'의 권한 '{}' 삭제 요청", mberId, role);

        List<String> currentRoles = memberAuthorityMapper.getUserRoles(mberId);
        if (!currentRoles.contains(role)) {
            return ResponseEntity.ok("⚠️ 해당 권한이 없습니다.");
        }

        if (currentRoles.size() == 1) {
            return ResponseEntity.badRequest().body("⚠️ 최소 1개의 권한이 필요합니다.");
        }

        int result = memberAuthorityMapper.removeUserRole(mberId, role);
        if (result > 0) {
            return ResponseEntity.ok("✅ 권한 삭제 성공");
        } else {
            return ResponseEntity.status(500).body("❌ 권한 삭제 실패 (DB 오류)");
        }
    }

    /**
     * 🔹 특정 사용자의 모든 권한 조회 (API)
     */
    @GetMapping("/getUserRoles")
    @ResponseBody
    public ResponseEntity<List<String>> getUserRoles(@RequestParam String mberId) {
        log.info("📌 [API] 사용자 '{}'의 모든 권한 조회", mberId);
        List<String> roles = memberAuthorityMapper.getUserRoles(mberId);
        return ResponseEntity.ok(roles != null ? roles : Collections.emptyList());
    }

    /**
     * 🔹 특정 사용자가 변경할 수 있는 권한 목록 조회 (API)
     */
    @GetMapping("/modifiable/user")
    @ResponseBody
    public ResponseEntity<List<String>> getModifiableAuthorities(@RequestParam String mberId) {
        log.info("📌 [API] '{}'의 변경 가능한 권한 목록 조회", mberId);
        List<String> modifiableAuthorities = memberAuthorityMapper.getModifiableAuthorities(mberId);
        return ResponseEntity.ok(modifiableAuthorities != null ? modifiableAuthorities : Collections.emptyList());
    }

    /**
     * 🔹 특정 사용자의 삭제 가능한 권한 목록 조회 (API)
     */
    @GetMapping("/removable/user")
    @ResponseBody
    public ResponseEntity<List<String>> getRemovableAuthorities(@RequestParam String mberId) {
        log.info("📌 [API] '{}'의 삭제 가능한 권한 목록 조회", mberId);
        List<String> removableAuthorities = memberAuthorityMapper.getUserRoles(mberId);
        return ResponseEntity.ok(removableAuthorities != null ? removableAuthorities : Collections.emptyList());
    }

    /**
     * 🔹 유효한 권한 코드인지 확인
     */
    private boolean isValidAuthority(String roleCode) {
        List<String> validAuthorities = memberAuthorityMapper.getValidAuthorities();
        return validAuthorities != null && validAuthorities.contains(roleCode);
    }

    /**
     * 🔹 특정 사용자의 권한 및 정보 검색 API
     */
    @GetMapping("/search")
    @ResponseBody
    public ResponseEntity<List<MemberAuthorityVO>> searchUsers(@RequestParam String keyword) {
        log.info("🔍 [API] 사용자 검색 요청: '{}'", keyword);

        // keyword에 해당하는 사용자 목록 조회
        List<MemberAuthorityVO> users = memberAuthorityMapper.searchUsersByKeyword(keyword);

        if (users == null || users.isEmpty()) {
            return ResponseEntity.ok(Collections.emptyList());
        }

        return ResponseEntity.ok(users);
    }
    
    @GetMapping("/getUsersForPage")
    public ResponseEntity<Map<String, Object>> getUsersForPage(
            @RequestParam int page, 
            @RequestParam int size) {

        // 해당 페이지와 크기에 맞는 사용자 데이터를 가져오는 로직
        List<MemberAuthorityVO> users = memberAuthorityMapper.getUsersForPage(page, size);
        
        // 페이지에 더 많은 데이터가 있는지 확인하는 로직 (다음 페이지 존재 여부)
        boolean hasNextPage = memberAuthorityMapper.hasNextPage(page, size);

        Map<String, Object> response = new HashMap<>();
        response.put("users", users);
        response.put("hasNextPage", hasNextPage);

        return ResponseEntity.ok(response);
    }

}
