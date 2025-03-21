package kr.or.batirplan.inquiry.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.batirplan.common.vo.PaginationInfoVO;
import kr.or.batirplan.inquiry.service.IInquiryAnswerService;
import kr.or.batirplan.inquiry.service.IInquiryService;
import kr.or.batirplan.inquiry.vo.InquiryAnswerVO;
import kr.or.batirplan.inquiry.vo.InquiryVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/batirplan/inquiry")
public class InquiryController {

    @Autowired
    private IInquiryService service;
    
    @Autowired
    private IInquiryAnswerService answerService;

    @GetMapping("/list")
    public String list(
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(value = "searchWord", required = false) String searchWord,
            @RequestParam(value = "searchType", required = false, defaultValue = "sj") String searchType,
            Model model) {
        
        PaginationInfoVO<InquiryVO> pagingVO = new PaginationInfoVO<>(10, 5);
        
        if (StringUtils.isNotBlank(searchWord)) {
        	
        	if (StringUtils.isBlank(searchType)) {
                searchType = "all";
            }
        	
            pagingVO.setSearchType(searchType);
            pagingVO.setSearchWord(searchWord);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchWord", searchWord);
        }
        
        pagingVO.setCurrentPage(page);
        int totalRecord = service.selectInquiryCount(pagingVO);
        pagingVO.setTotalRecord(totalRecord);
        
        List<InquiryVO> dataList = service.selectInquiryList(pagingVO);
        pagingVO.setDataList(dataList);
        
        model.addAttribute("pagingVO", pagingVO);
        return "inquiry/list";
    }

    @GetMapping("/register")
    public String registerForm(
            @RequestParam(value = "inqryNo", required = false, defaultValue = "0") int inqryNo,
            Model model) {
        
        if (inqryNo > 0) {
            InquiryVO inquiry = service.read(inqryNo);
            model.addAttribute("inquiry", inquiry);
            model.addAttribute("status", "u");
        } else {
            model.addAttribute("defaultWriter", "EMP001");
            model.addAttribute("status", "r");
        }
        
        return "inquiry/register";
    }

    @PostMapping({"/register", "/update"})
    public String saveOrUpdate(
            @ModelAttribute InquiryVO inquiry,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "inqryNo", required = false, defaultValue = "0") int inqryNo,
            RedirectAttributes redirectAttributes) {
        
        if (inquiry.getTy() == null || inquiry.getTy().trim().isEmpty()) {
            inquiry.setTy("OT");
        }
        
        if ("u".equals(status)) {
            inquiry.setInqryNo(inqryNo);
            service.update(inquiry);
            redirectAttributes.addFlashAttribute("msg", "수정이 완료되었습니다!");
        } else {
            service.register(inquiry);
            redirectAttributes.addFlashAttribute("msg", "등록이 완료되었습니다!");
        }
        
        return "redirect:/batirplan/inquiry/read?inqryNo=" + inquiry.getInqryNo();
    }

    @GetMapping("/read")
    public String read(@RequestParam("inqryNo") int inqryNo, Model model) {
        InquiryVO inquiry = service.read(inqryNo);
        if (inquiry == null) {
            return "redirect:/batirplan/inquiry/list";
        }

        List<InquiryAnswerVO> answers = answerService.getAnswers(inqryNo);

        // 현재 로그인한 사용자 정보 추가
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String loginUser = auth.getName(); // 로그인한 사용자 ID
        String userRole = auth.getAuthorities().toString(); // 사용자의 권한 정보

        model.addAttribute("inquiry", inquiry);
        model.addAttribute("answers", answers);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("userRole", userRole); // JSP에서 사용 가능하도록 추가

        return "inquiry/read";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("inqryNo") int inqryNo, RedirectAttributes redirectAttributes) {
        service.remove(inqryNo);
        redirectAttributes.addFlashAttribute("msg", "삭제가 완료되었습니다!");
        return "redirect:/batirplan/inquiry/list";
    }
}
