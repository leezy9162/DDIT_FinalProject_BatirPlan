package kr.or.batirplan.common.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.batirplan.electronicdocument.vo.FieldSelectorVO;

/**
 * 양식별로 추출해야 할 필드 정보를 등록해두는 Config 클래스 예시
 */
public class FieldMappingConfig {

    // formNo -> List<FieldSelectorVO> 매핑
    public static final Map<Integer, List<FieldSelectorVO>> FORM_FIELD_MAP = new HashMap<>();

    // static 블록에서 초기화
    static {
        // 4번 양식
        List<FieldSelectorVO> form1Fields = new ArrayList<>();
        form1Fields.add(new FieldSelectorVO("class", "deptCell", "소속"));
        form1Fields.add(new FieldSelectorVO("class", "empNameCell", "성명"));
        form1Fields.add(new FieldSelectorVO("class", "positionCell", "직급"));
        form1Fields.add(new FieldSelectorVO("id", "typeCell", "종류"));
        form1Fields.add(new FieldSelectorVO("id", "reasonCell", "사유"));
        form1Fields.add(new FieldSelectorVO("id", "periodCell", "기간"));
        form1Fields.add(new FieldSelectorVO("id", "emergencyCell", "비상연락망"));

        FORM_FIELD_MAP.put(4, form1Fields);

        // 5번 양식
        List<FieldSelectorVO> form2Fields = new ArrayList<>();
        form2Fields.add(new FieldSelectorVO("id", "someUniqueId", "특정필드A"));
        form2Fields.add(new FieldSelectorVO("class", "someClass", "특정필드B"));

        FORM_FIELD_MAP.put(5, form2Fields);
        
        // 6번 양식
        List<FieldSelectorVO> form3Fields = new ArrayList<>();
        form3Fields.add(new FieldSelectorVO("class", "deptCell", "소속"));
        form3Fields.add(new FieldSelectorVO("class", "positionCell", "직급"));
        form3Fields.add(new FieldSelectorVO("class", "empNameCell", "작성자"));
        form3Fields.add(new FieldSelectorVO("class", "todaySpan", "작성일자"));
        form3Fields.add(new FieldSelectorVO("id", "proNameCell", "프로젝트명"));
        form3Fields.add(new FieldSelectorVO("id", "managerCell", "담당자"));
        form3Fields.add(new FieldSelectorVO("id", "startDateCell", "시작일"));
        form3Fields.add(new FieldSelectorVO("id", "endDateCell", "종료일"));
        form3Fields.add(new FieldSelectorVO("id", "categoryCell", "카테고리"));
        form3Fields.add(new FieldSelectorVO("id", "participationCell", "참여인원"));
        form3Fields.add(new FieldSelectorVO("id", "proContentCell", "프로젝트 내용"));
        form3Fields.add(new FieldSelectorVO("id", "budgetCell", "프로젝트 예산"));
        form3Fields.add(new FieldSelectorVO("id", "locationCell", "위치"));
        form3Fields.add(new FieldSelectorVO("id", "expectationCell", "기대효과"));
        
        FORM_FIELD_MAP.put(6, form3Fields);
    }

    // 인스턴스화 방지 (유틸성 클래스)
    private FieldMappingConfig() {
    }
}