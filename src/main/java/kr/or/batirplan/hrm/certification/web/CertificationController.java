package kr.or.batirplan.hrm.certification.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;

import kr.or.batirplan.employee.vo.EmployeeVO;
import kr.or.batirplan.hrm.certification.service.ICertificationService;
import kr.or.batirplan.hrm.certification.vo.CertificationVO;
import kr.or.batirplan.hrm.hrcard.service.HrCardService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/batirplan/hrm/certification")
@RequiredArgsConstructor
public class CertificationController {

    @Autowired
    private ICertificationService certificationService;
    
    @Autowired
    private HrCardService hrCardService;
    
    private final Gson gson;
    
    
    @GetMapping("/list")
    public String list(@RequestParam(value = "searchWord", required = false, defaultValue = "") String searchWord, Model model) {
        System.out.println("검색어: " + searchWord);
        List<CertificationVO> list = searchWord.isEmpty() ? List.of() : certificationService.searchEmployees(searchWord);
        model.addAttribute("certifications", list);
        model.addAttribute("searchWord", searchWord);

        return "hrm/certification/list";
    }
    
    
    @GetMapping("/getempl")
    @ResponseBody
    public String getData(@RequestParam String emplCode) {
    	EmployeeVO employeeVO = hrCardService.getEmployeeByEmplCode(emplCode);
    	return gson.toJson(employeeVO);
    }

}