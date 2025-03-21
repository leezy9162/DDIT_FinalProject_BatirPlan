package kr.or.batirplan.cooperationcom.web;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;

@RestController
public class JoinController {

    // 사업자등록번호 중복 검증 및 상태 조회
    @PostMapping("/join/duplicateBusinessNo")
    public ResponseEntity<Boolean> duplicateBusinessNo(@RequestParam("business_no") String businessNo) {
        // 현재는 예시로 중복 여부를 false로 반환 (실제 구현 시 DB 조회 로직 필요)
        return ResponseEntity.ok(false);
    }
}
