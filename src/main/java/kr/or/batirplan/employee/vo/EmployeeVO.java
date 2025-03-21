package kr.or.batirplan.employee.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EmployeeVO {
	 private String emplCode;
	 private String emplNm;
	 private String deptCode;
	 private String deptNm;
	 private String clsfCode;
	 private String clsfNm;
	 private String brthdy;
	 private String email;
	 private String mbtlnum;
	 private String sexdstn;
	 private String zip;
	 private String adres;
	 private String detailadres;
	 private String bankCode;
	 private String acnutno;
	 private String acntSttusCode;
	 private String proflImageCours;
	 private String encpn;
	 private String retireDe;
	 private String hffcSttus;
	 private String mberId;
	 private String approvarStamp;
	 
	 private MultipartFile emplProfile;
}