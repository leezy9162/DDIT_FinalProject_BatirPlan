package kr.or.batirplan.projectmanage.vo;

import lombok.Data;

/**
 * 검색 조건이 하나 이상이라 추가하는 VO
 * @author leezy
 */
@Data
public class ProjectManagePJTSearchVO {
    private int currentPage;
    private String prjctNm;
    private String chargerNm;
    private String prjctProgrsSttus;
}
