package kr.or.batirplan.servicemanagement.authority.service;

import kr.or.batirplan.servicemanagement.authority.mapper.MemberAuthorityMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class MemberAuthorityService {

    private final MemberAuthorityMapper memberAuthorityMapper;

    public MemberAuthorityService(MemberAuthorityMapper memberAuthorityMapper) {
        this.memberAuthorityMapper = memberAuthorityMapper;
    }

    /**
     * 사용자의 권한 추가 (중복 방지)
     */
    @Transactional
    public boolean addRole(String mberId, String role) {
        log.info("[권한 추가 요청] mberId: {}, role: {}", mberId, role);

        // 현재 사용자 권한 조회
        List<String> existingRoles = memberAuthorityMapper.getUserRoles(mberId);

        if (existingRoles.contains(role)) {
            log.warn("[권한 추가 실패] 이미 존재하는 권한: {} - {}", mberId, role);
            return false; // 중복 권한이므로 추가하지 않음
        }

        // 권한 추가
        memberAuthorityMapper.addRoleToUser(mberId, role);
        log.info("[권한 추가 완료] mberId: {}, role: {}", mberId, role);
        return true;
    }

    /**
     * 사용자의 권한 제거 (최소 1개 유지)
     */
    @Transactional
    public boolean removeRole(String mberId, String role) {
        log.info("[권한 삭제 요청] mberId: {}, role: {}", mberId, role);

        int roleCount = memberAuthorityMapper.getUserRoleCount(mberId);
        if (roleCount <= 1) {
            log.warn("[권한 삭제 실패] 최소 1개의 권한이 필요합니다: {} - {}", mberId, role);
            return false;
        }

        // 권한 삭제
        memberAuthorityMapper.removeUserRole(mberId, role);
        log.info("[권한 삭제 완료] mberId: {}, role: {}", mberId, role);
        return true;
    }
}
