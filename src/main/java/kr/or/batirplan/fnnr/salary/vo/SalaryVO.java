package kr.or.batirplan.fnnr.salary.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SalaryVO {
    private String salaryYm;
    private String emplCode;
    private String emplName;
    private String clsfNm;
    private double pymntAmount;
}
