package kr.or.batirplan.electronicdocument.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class FieldSelectorVO {
	private String selectorType;  // "id" or "class"
    private String selectorName;  // "positionCell" or "deptCell"
    private String fieldLabel;    // "직급", "소속" 등
}