package kr.or.batirplan.servicemanagement.authority.vo;

import lombok.Data;
import java.util.List;

@Data
public class MemberAuthorityVO {
    private String emplName; // ✅ 추가: 사원명
    private String mberId;
    private String departmentName;
    private String classOfPosition;
    private String mberAuthor;
    private List<String> subRoles;  // ✅ 기존: 보조 역할 리스트
}
