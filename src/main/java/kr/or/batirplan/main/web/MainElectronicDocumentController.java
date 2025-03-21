package kr.or.batirplan.main.web;

import kr.or.batirplan.main.service.MainElectronicDocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import kr.or.batirplan.security.vo.CustomUser;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/batirplan/main/electronicdocument")
public class MainElectronicDocumentController {

    @Autowired
    private MainElectronicDocumentService documentService;

    /**
     * ✅ 최근 전자결재 문서 목록 조회 API
     */
    @GetMapping("/recent")
    @ResponseBody
    public List<Map<String, Object>> getRecentDocuments(@AuthenticationPrincipal CustomUser loginUser) {
        String userId = loginUser.getMemberVO().getEmpVO().getEmplCode();
        return documentService.getRecentDocuments(userId);
    }
    
    @GetMapping("/count")
    @ResponseBody
    public int getUserDocumentCount(@AuthenticationPrincipal CustomUser loginUser) {
        String userId = loginUser.getMemberVO().getEmpVO().getEmplCode();
        return documentService.getUserDocumentCount(userId);
    }

}
