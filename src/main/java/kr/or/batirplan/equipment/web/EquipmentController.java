package kr.or.batirplan.equipment.web;

import kr.or.batirplan.equipment.service.EquipmentService;
import kr.or.batirplan.equipment.vo.EquipmentVO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import java.util.List;

@Controller
@RequestMapping("/batirplan/equipment")
@RequiredArgsConstructor
public class EquipmentController {

    private final EquipmentService equipmentService;

    // 장비 목록 조회
    @GetMapping("/list")
    public String listEquipment(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        PageHelper.startPage(pageNum, pageSize);
        List<EquipmentVO> equipmentList = equipmentService.getEquipmentList(keyword);
        PageInfo<EquipmentVO> pageInfo = new PageInfo<>(equipmentList);

        model.addAttribute("equipmentList", pageInfo);
        model.addAttribute("keyword", keyword);

        return "equipment/equipmentList";
    }

    // 장비 상세 조회
    @GetMapping("/detail/{eqpmnNo}")
    public String detailEquipment(@PathVariable("eqpmnNo") int eqpmnNo, Model model) {
        EquipmentVO equipment = equipmentService.getEquipmentByNo(eqpmnNo);
        model.addAttribute("equipment", equipment);
        return "equipment/equipmentDetail";
    }

    // 장비 등록 페이지 이동
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @GetMapping("/register")
    public String registerEquipmentForm() {
        return "equipment/equipmentRegister";
    }

    // 장비 등록 처리
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/register")
    public String registerEquipment(@ModelAttribute EquipmentVO equipment) {
        equipmentService.insertEquipment(equipment);
        return "redirect:/batirplan/equipment/list";
    }

    // 장비 상태 변경 (사용가능 <-> 수리중)
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/updateStatus")
    @ResponseBody
    public String updateEquipmentStatus(@RequestParam("eqpmnNo") int eqpmnNo, @RequestParam("status") String status) {
        equipmentService.updateEquipmentStatus(eqpmnNo, status);
        return "SUCCESS";
    }

    // 장비 입고 페이지 이동
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @GetMapping("/incoming")
    public String incomingEquipment(@RequestParam(defaultValue = "1") int pageNum,
                                    @RequestParam(defaultValue = "10") int pageSize,
                                    @RequestParam(required = false) String keyword,
                                    Model model) {
        PageInfo<EquipmentVO> pageInfo = equipmentService.getIncomingEquipment(pageNum, pageSize, keyword);
        model.addAttribute("incomingEquipmentList", pageInfo.getList());
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("keyword", keyword);
        return "equipment/equipmentIncoming";
    }

    // 장비 입고 처리 (수리중 -> 사용가능 변경)
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/receive")
    @ResponseBody
    public String receiveEquipment(@RequestParam("eqpmnNo") int eqpmnNo) {
        equipmentService.receiveEquipment(eqpmnNo);
        return "SUCCESS";
    }

    // 일련번호 중복 체크 API
    @GetMapping("/checkSerialNumber")
    public ResponseEntity<String> checkSerialNumber(@RequestParam("eqpmnSn") String eqpmnSn) {
        boolean exists = equipmentService.isSerialNumberExists(eqpmnSn);
        return ResponseEntity.ok(exists ? "DUPLICATE" : "AVAILABLE");
    }

    // 장비 검색 API (배치 신청 모달에서 호출)
    @GetMapping("/searchEquipment")
    @ResponseBody
    public List<EquipmentVO> searchEquipment(@RequestParam("keyword") String keyword) {
        return equipmentService.searchEquipment(keyword);
    }
}
