package kr.or.batirplan.inquiry.web;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.or.batirplan.inquiry.service.IInquiryAnswerService;
import kr.or.batirplan.inquiry.vo.InquiryAnswerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/inquiry/answer")
public class InquiryAnswerController {

    @Autowired
    private IInquiryAnswerService service;

    @PostMapping("/add")
    @PreAuthorize("hasRole('ROLE_DEPT_IT')")
    public String addAnswer(
            @RequestParam(value = "inqryNo", required = false, defaultValue = "0") int inqryNo,
            @RequestParam("answerCn") String answerCn,
            RedirectAttributes redirectAttributes) {
        
        log.info("댓글 작성 요청 - inqryNo: {}, answerCn: {}", inqryNo, answerCn);

        if (inqryNo == 0) {
            redirectAttributes.addFlashAttribute("error", "문의 번호가 올바르지 않습니다.");
            return "redirect:/batirplan/inquiry/list";
        }

        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            String loggedInUser = auth.getName();
            log.info("현재 로그인 사용자: {}", loggedInUser);
            log.info("사용자 권한 목록: {}", auth.getAuthorities());

            InquiryAnswerVO answer = new InquiryAnswerVO();
            answer.setInqryNo(inqryNo);
            answer.setAnswrr(loggedInUser);
            answer.setAnswerCn(answerCn);

            log.info("댓글 정보 저장 전: {}", answer);
            service.addAnswer(answer);
            log.info("댓글 저장 완료");

            redirectAttributes.addFlashAttribute("message", "댓글이 등록되었습니다.");
        } catch (Exception e) {
            log.error("댓글 등록 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("error", "댓글 등록에 실패했습니다.");
        }
        return "redirect:/batirplan/inquiry/read?inqryNo=" + inqryNo;
    }
    
    @PostMapping("/update")
    public String updateAnswer(
            @RequestParam("answerNo") int answerNo,
            @RequestParam("answerCn") String answerCn,
            @RequestParam("inqryNo") int inqryNo,
            RedirectAttributes redirectAttributes) {
        
        InquiryAnswerVO answer = new InquiryAnswerVO();
        answer.setAnswerNo(answerNo);
        answer.setAnswerCn(answerCn);
        
        service.updateAnswer(answer);
        
        redirectAttributes.addFlashAttribute("msg", "댓글이 수정되었습니다.");
        
        return "redirect:/batirplan/inquiry/read?inqryNo=" + inqryNo;
    }
    
    @PostMapping("/delete")
    public String deleteAnswer(
            @RequestParam("answerNo") int answerNo,
            @RequestParam("inqryNo") int inqryNo,
            RedirectAttributes redirectAttributes) {
        
        try {
            service.deleteAnswer(answerNo);
            redirectAttributes.addFlashAttribute("msg", "댓글이 삭제되었습니다.");
        } catch (Exception e) {
            log.error("댓글 삭제 중 오류 발생", e);
            redirectAttributes.addFlashAttribute("error", "댓글 삭제에 실패했습니다.");
        }
        return "redirect:/batirplan/inquiry/read?inqryNo=" + inqryNo;
    }
}
