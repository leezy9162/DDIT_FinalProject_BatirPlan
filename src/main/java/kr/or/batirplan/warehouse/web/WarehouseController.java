package kr.or.batirplan.warehouse.web;

import kr.or.batirplan.warehouse.service.IWarehouseService;
import kr.or.batirplan.warehouse.service.WarehouseProductService;
import kr.or.batirplan.warehouse.vo.WarehouseVO;
import kr.or.batirplan.warehouse.vo.WarehouseProductVO;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/batirplan/warehouse")
public class WarehouseController {

	@Autowired
    private IWarehouseService warehouseService;
	@Autowired
    private WarehouseProductService warehouseProductService;

    /**
     * 📌 창고 목록 조회 (자원관리팀만 조회 가능)
     */
    @PreAuthorize("hasRole('ROLE_DEPT_RESRCE')")
    @GetMapping("/list")
    public String getWarehouseList(@RequestParam(required = false) String wrHousNm,
                                   @RequestParam(required = false) String wrHousOperSttus,
                                   @RequestParam(required = false) String wrHousLc,
                                   Model model) {
        log.info("📌 창고 목록 조회 요청: wrHousNm={}, wrHousOperSttus={}, wrHousLc={}",
                 wrHousNm, wrHousOperSttus, wrHousLc);

        List<WarehouseVO> warehouses = warehouseService.getWarehouseList(wrHousNm, wrHousOperSttus, wrHousLc);
        model.addAttribute("warehouses", warehouses);
        return "warehouse/warehouseList";
    }

    /**
     * 📌 창고 상세 조회 (자원관리팀만 가능)
     * 창고 내 자재 목록도 함께 조회
     */
    @PreAuthorize("hasRole('ROLE_DEPT_RESRCE')")
    @GetMapping("/detail/{wrHousCode}")
    public String getWarehouseDetail(@PathVariable String wrHousCode, Model model) {
        log.info("📌 창고 상세 조회 요청: wrHousCode={}", wrHousCode);

        // 1️⃣ 창고 기본 정보 조회
        WarehouseVO warehouse = warehouseService.getWarehouseByCode(wrHousCode);
        if (warehouse == null) {
            log.error("❌ 창고 코드 '{}'에 대한 정보 없음", wrHousCode);
            return "error/404";
        }

        // 2️⃣ 창고 내 자재 목록 조회
        List<WarehouseProductVO> warehouseMaterials = warehouseProductService.getMaterialsByWarehouse(wrHousCode);

        // 3️⃣ 창고 내 자재가 하나라도 있으면 hasMaterials = true
        boolean hasMaterials = warehouseMaterials.stream().anyMatch(m -> m.getInvntryQy() > 0);

        // 4️⃣ JSP에 데이터 전달
        model.addAttribute("warehouse", warehouse);
        model.addAttribute("warehouseMaterials", warehouseMaterials);
        model.addAttribute("hasMaterials", hasMaterials); // 창고에 자재가 있는지 여부

        return "warehouse/warehouseDetail";
    }

    /**
     * 📌 창고 등록 (자원관리팀 관리자만 가능)
     */
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<?> registerWarehouse(@RequestBody WarehouseVO warehouseVO) {
        log.info("📌 창고 등록 요청: {}", warehouseVO);

        try {
            warehouseService.insertWarehouse(warehouseVO);
            String insertedWrHousCode = warehouseService.getLastInsertedWarehouseCode();
            if (insertedWrHousCode == null || insertedWrHousCode.isEmpty()) {
                throw new Exception("등록된 창고 코드 조회 실패");
            }

            return ResponseEntity.ok(Map.of("success", true, "message", "창고가 등록되었습니다.", "wrHousCode", insertedWrHousCode));
        } catch (Exception e) {
            log.error("❌ 창고 등록 중 오류 발생: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", "창고 등록에 실패했습니다.", "error", e.getMessage()));
        }
    }

    /**
     * 📌 창고 정보 수정 (자원관리팀 관리자만 가능)
     */
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<?> updateWarehouse(@RequestBody WarehouseVO warehouseVO) {
        log.info("📌 창고 정보 수정 요청: {}", warehouseVO);
        warehouseService.updateWarehouse(warehouseVO);
        return ResponseEntity.ok(Map.of("success", true, "message", "창고 정보가 수정되었습니다."));
    }

    /**
     * 📌 창고 폐쇄 (자원관리팀 관리자만 가능)
     * 창고 내 자재가 존재하면 폐쇄 불가능
     */
    @PreAuthorize("hasRole('ROLE_RSPNBER_RESRCE')")
    @PostMapping("/close/{wrHousCode}")
    @ResponseBody
    public ResponseEntity<?> closeWarehouse(@PathVariable String wrHousCode) {
        log.info("📌 창고 폐쇄 요청: wrHousCode={}", wrHousCode);

        WarehouseVO warehouse = warehouseService.getWarehouseByCode(wrHousCode);
        if (warehouse == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("success", false, "message", "창고 정보를 찾을 수 없습니다."));
        }

        // 📌 창고 내 자재 개수 확인
        boolean hasMaterials = warehouseService.hasMaterialsInWarehouse(wrHousCode);
        if (hasMaterials) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("success", false, "message", "자재가 남아 있어 폐쇄할 수 없습니다."));
        }

        // 📌 자재가 없을 경우 폐쇄 진행
        warehouseService.closeWarehouse(wrHousCode);
        return ResponseEntity.ok(Map.of("success", true, "message", "창고가 폐쇄되었습니다."));
    }
    
    @GetMapping(value = "/warehouse/detail/custom-map.js", produces = "application/javascript")
    public ResponseEntity<String> getCustomMapScript() {
        String scriptContent = "console.log('Custom Map Script Loaded');";
        return ResponseEntity.ok().contentType(MediaType.valueOf("application/javascript")).body(scriptContent);
    }

}
