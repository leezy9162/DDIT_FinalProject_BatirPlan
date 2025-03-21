package kr.or.batirplan.servicemanagement.authority.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.batirplan.servicemanagement.authority.vo.MemberAuthorityVO;

@Mapper
public interface MemberAuthorityMapper {

    /**
     * 🔹 유효한 권한 목록 조회
     */
    List<String> getValidAuthorities();

    /**
     * 🔹 모든 사용자와 권한 조회
     */
    List<MemberAuthorityVO> findAllUsersWithRoles();
    
    /**
     * 🔹 특정 사용자의 모든 권한 조회
     */
    List<String> getUserRoles(@Param("mberId") String mberId);

    /**
     * 🔹 사용자가 변경할 수 있는 권한 목록 조회
     */
    List<String> getModifiableAuthorities(@Param("mberId") String mberId);  // ✅ userId → mberId 변경

    /**
     * 🔹 특정 사용자에게 권한 추가
     * @return 성공한 경우 1 반환, 실패 시 0
     */
    int addRoleToUser(@Param("mberId") String mberId, @Param("role") String role);
    
    /**
     * 🔹 특정 권한 제거
     * @return 성공한 경우 1 반환, 실패 시 0
     */
    int removeUserRole(@Param("mberId") String mberId, @Param("role") String role);

    /**
     * 🔹 특정 권한을 가진 사용자의 수 조회 (ROLE_ADMIN 보호용)
     */
    int countUsersWithRole(@Param("role") String role);

    /**
     * 🔹 전체 사용자 수 조회
     */
    int getTotalUserCount();

    /**
     * 🔹 권한별 사용자 수 조회 (XML에서 처리)
     */
    List<MemberAuthorityVO> getAuthorityStatistics(); 

    /**
     * 🔹 특정 사용자의 권한 개수 조회
     */
    int getUserRoleCount(@Param("mberId") String mberId);  // ✅ @Param 추가
    
    
    
    List<MemberAuthorityVO> searchUsersByKeyword(@Param("keyword") String keyword);

	List<MemberAuthorityVO> getUsersForPage(int page, int size);

	boolean hasNextPage(int page, int size);

}
