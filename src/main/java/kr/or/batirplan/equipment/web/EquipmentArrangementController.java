package kr.or.batirplan.equipment.web;

import kr.or.batirplan.equipment.service.EquipmentArrangementService;
import kr.or.batirplan.equipment.vo.EquipmentArrangementVO;
import kr.or.batirplan.project.projectmanage.vo.ProjectVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/batirplan/equipment/arrangement")
@RequiredArgsConstructor
public class EquipmentArrangementController {

    private final EquipmentArrangementService arrangementService;

    // [배치 관리] 목록 조회
    @GetMapping("/list")
    public String listArrangements(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword,
            @RequestParam(required = false) String approvalStatus,
            Model model) {

        // 페이지네이션 적용
        PageHelper.startPage(page, pageSize);
        List<EquipmentArrangementVO> arrangementList = arrangementService.getEquipmentArrangementList(searchType, searchKeyword, approvalStatus);
        PageInfo<EquipmentArrangementVO> pageInfo = new PageInfo<>(arrangementList);

        model.addAttribute("arrangementList", arrangementList);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("approvalStatus", approvalStatus);

        return "equipment/arrangementList";
    }

    // [배치 관리] 상세 조회 (세부 정보 및 승인 페이지)
    @GetMapping("/detail/{requestNo}")
    public String detailArrangement(@PathVariable int requestNo, Model model) {
        EquipmentArrangementVO arrangement = arrangementService.getEquipmentArrangementDetail(requestNo);
        model.addAttribute("arrangement", arrangement);
        return "equipment/arrangementDetail";
    }

    // [배치 관리] 승인 처리 (자원 관리자만 접근)
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/approve")
    @ResponseBody
    public String approveArrangement(@RequestParam("requestNo") int requestNo,
                                     @RequestParam("eqpmnNo") int eqpmnNo) {
        arrangementService.approveEquipmentArrangement(requestNo, eqpmnNo);
        return "SUCCESS";
    }

    // [배치 신청] 페이지 이동 (신규 배치 신청)
    @GetMapping("/request")
    public String requestArrangementPage() {
        return "equipment/arrangementRequest";
    }

    // [배치 신청] 처리
    @PostMapping("/request")
    public String requestArrangement(@ModelAttribute EquipmentArrangementVO arrangement) {
        arrangementService.insertEquipmentArrangement(arrangement);
        return "redirect:/batirplan/equipment/arrangement/list";
    }
    
    
    // ✅ 프로젝트 검색 API
    @GetMapping("/searchProject")
    @ResponseBody
    public List<ProjectVO> searchProject(@RequestParam("keyword") String keyword) {
        return arrangementService.searchProject(keyword);
    }
    

    // ✅ 신청자(사원) 검색 및 전체 조회 API
    @GetMapping("/searchEmployee")
    @ResponseBody
    public List<EmployeeVO> searchEmployee(@RequestParam(value = "keyword", required = false) String keyword) {
        return arrangementService.searchEmployee(keyword);
    }

    
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @GetMapping("/pending")
    public String listPendingArrangements(Model model) {
        List<EquipmentArrangementVO> pendingList = arrangementService.getPendingEquipmentArrangementList();
        model.addAttribute("pendingList", pendingList);
        return "equipment/arrangementManage";
    }

    // [배치 관리] 거절 처리 (자원 관리자만 접근)
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/reject")
    @ResponseBody
    public String rejectArrangement(@RequestParam("requestNo") int requestNo) {
        arrangementService.rejectEquipmentArrangement(requestNo);
        return "SUCCESS";
    }
    
    
    
    // ✅ 장비 배치 관리 상세정보 페이지 API 추가
    @GetMapping("/manage/detail/{requestNo}")
    public String manageDetailArrangement(@PathVariable int requestNo, Model model) {
        EquipmentArrangementVO arrangement = arrangementService.getEquipmentArrangementDetail(requestNo);
        model.addAttribute("arrangement", arrangement);
        return "equipment/arrangementManageDetail";  // 📌 새로운 JSP 파일 연결
    }

   
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/cancelApproval")
    @ResponseBody
    public String cancelApproval(@RequestParam("requestNo") int requestNo) {
        arrangementService.cancelApproval(requestNo);  // ✅ 승인취소 API 호출
        return "SUCCESS";
    }
}

