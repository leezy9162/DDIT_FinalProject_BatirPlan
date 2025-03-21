package kr.or.batirplan.cooperationcom.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import kr.or.batirplan.cooperationcom.service.ICooperationService;
import kr.or.batirplan.cooperationcom.vo.CooperationcomVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import java.util.List;

@Controller
@RequestMapping("/batirplan/cooperatiom")
public class CooperationController {

    @Autowired
    private ICooperationService cooperationService;

    // 등록 페이지
    @GetMapping("/register")
    public String registerPage(Model model) {
        List<EmployeeVO> employeeList = cooperationService.getEmployeeList();
        model.addAttribute("employeeList", employeeList);
        return "cooperatiom/register";  // JSP 경로: /WEB-INF/views/cooperatiom/register.jsp
    }

    // 등록 처리
    @PostMapping("/register")
    public String registerCooperation(@ModelAttribute CooperationcomVO cooperationVO) {
        cooperationService.insertCooperation(cooperationVO);
        return "redirect:/batirplan/cooperatiom/list";
    }
    
    // 협력업체 리스트 조회 (검색 필터 + 페이지네이션)
    @GetMapping("/list")
    public String listPage(
            @RequestParam(required=false) String ccpyNm,
            @RequestParam(required=false) String bizrno,
            @RequestParam(required=false) String ccpyCl,
            @RequestParam(defaultValue="1") int page,
            Model model) {
        int pageSize = 10;
        int offset = (page - 1) * pageSize;
        List<CooperationcomVO> list = cooperationService.selectCooperationList(ccpyNm, bizrno, ccpyCl, offset, pageSize);
        int totalCount = cooperationService.selectCooperationCount(ccpyNm, bizrno, ccpyCl);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        model.addAttribute("list", list);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("ccpyNm", ccpyNm);
        model.addAttribute("bizrno", bizrno);
        model.addAttribute("ccpyCl", ccpyCl);
        return "cooperatiom/list";  
    }
}
