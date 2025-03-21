package kr.or.batirplan.noticeboard.web;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import kr.or.batirplan.noticeboard.service.NoticeBoardService;
import kr.or.batirplan.noticeboard.vo.NoticeBoardVO;
import lombok.RequiredArgsConstructor;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/batirplan/notice")
@RequiredArgsConstructor
public class NoticeBoardController {

    private final NoticeBoardService noticeBoardService;
    private static final String DEFAULT_WRITER = "25030001"; //  작성자 항상 "25030001" 고정

    /**
     *  공지사항 목록 조회
     */
    @GetMapping("/list")
    public String noticeBoardList(@RequestParam(defaultValue = "1") int page,
                                  @RequestParam(defaultValue = "10") int size,
                                  @RequestParam(required = false) String title,
                                  Model model) {
        System.out.println(" [공지사항 목록 조회] page: " + page + ", title: " + title);

        Map<String, Object> result = noticeBoardService.getNoticeBoardList(page, size, title);

        List<NoticeBoardVO> noticeList = (List<NoticeBoardVO>) result.get("noticeList");
        int totalCount = (int) result.get("totalCount");
        int searchTotalPages = (int) Math.ceil((double) totalCount / size);

        model.addAttribute("noticeList", noticeList);
        model.addAttribute("currentPage", page);
        model.addAttribute("searchTotalPages", searchTotalPages);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("pageSize", size);
        model.addAttribute("title", title);

        return "noticeboard/list";
    }

    /**
     *  공지사항 상세 조회
     */
    @GetMapping("/detail/{bbscttNo}")
    public String noticeBoardDetail(@PathVariable int bbscttNo, Model model) {
        System.out.println(" [공지사항 상세보기] bbscttNo: " + bbscttNo);
        
        NoticeBoardVO notice = noticeBoardService.getNoticeBoardById(bbscttNo, true);

        if (notice == null) {
            System.out.println(" 해당 공지사항이 존재하지 않음");
            return "redirect:/batirplan/notice/list";
        }

        model.addAttribute("notice", notice);
        return "noticeboard/detail";
    }

    /**
     *  공지사항 수정 페이지
     */
    @PreAuthorize("hasAuthority('ROLE_DEPT_MNGMT')")
    @GetMapping("/edit/{bbscttNo}")
    public String editNoticeForm(@PathVariable int bbscttNo, Model model) {
        System.out.println(" [공지사항 수정 페이지] bbscttNo: " + bbscttNo);
        NoticeBoardVO notice = noticeBoardService.getNoticeBoardById(bbscttNo, false);
        
        if (notice == null) {
            System.out.println(" 해당 공지사항이 존재하지 않음");
            return "redirect:/batirplan/notice/list";
        }

        model.addAttribute("notice", notice);
        return "noticeboard/edit";
    }

    /**
     *  공지사항 수정 처리
     */
    @PreAuthorize("hasAuthority('ROLE_DEPT_MNGMT')")
    @PostMapping("/update/{bbscttNo}")
    public String updateNotice(@PathVariable int bbscttNo, 
                               @RequestParam("sj") String sj, 
                               @RequestParam("cn") String cn, 
                               @RequestParam("clCode") String clCode) {  

        System.out.println(" [공지사항 수정 실행] bbscttNo: " + bbscttNo);
        System.out.println(" 제목: " + sj);
        System.out.println(" 내용: " + cn);
        System.out.println(" 분류 코드: " + clCode);
        System.out.println(" 작성자 (고정값): " + DEFAULT_WRITER);

        NoticeBoardVO noticeBoard = new NoticeBoardVO();
        noticeBoard.setBbscttNo(bbscttNo);
        noticeBoard.setSj(sj);
        noticeBoard.setCn(cn);
        noticeBoard.setClCode(clCode);
        noticeBoard.setWriter(DEFAULT_WRITER);

        noticeBoardService.updateNoticeBoard(noticeBoard);
        return "redirect:/batirplan/notice/list";
    }

    /**
     *  공지사항 삭제 처리
     */
    @PreAuthorize("hasAuthority('ROLE_DEPT_MNGMT')")
    @PostMapping("/delete/{bbscttNo}")
    public String deleteNotice(@PathVariable int bbscttNo) {
        System.out.println(" [공지사항 삭제 실행] bbscttNo: " + bbscttNo);
        noticeBoardService.deleteNoticeBoard(bbscttNo);
        return "redirect:/batirplan/notice/list";  
    }

    /**
     *  공지사항 등록 페이지 이동
     */
    @PreAuthorize("hasAuthority('ROLE_DEPT_MNGMT')")
    @GetMapping("/register")
    public String registerNoticeForm(Model model) {
        model.addAttribute("defaultWriter", DEFAULT_WRITER);
        return "noticeboard/register";
    }

    /**
     *  공지사항 등록 처리
     */
    @PreAuthorize("hasAuthority('ROLE_DEPT_MNGMT')")
    @PostMapping("/register")
    public String createNotice(@RequestParam("sj") String sj,
                               @RequestParam("cn") String cn,
                               @RequestParam("clCode") String clCode) {  

        System.out.println(" [공지사항 등록] 제목: " + sj);
        System.out.println(" 작성자 (고정값): " + DEFAULT_WRITER);

        NoticeBoardVO noticeBoard = new NoticeBoardVO();
        noticeBoard.setSj(sj);
        noticeBoard.setCn(cn);
        noticeBoard.setClCode(clCode);
        noticeBoard.setWriter(DEFAULT_WRITER);

        noticeBoardService.createNoticeBoard(noticeBoard);
        return "redirect:/batirplan/notice/list";
    }

    /**
     *  최신 공지사항 5개 조회 API (AJAX 연동)
     */
    @RestController
    @RequestMapping("/api/notices")
    public static class NoticeBoardApiController {

        private final NoticeBoardService noticeBoardService;

        public NoticeBoardApiController(NoticeBoardService noticeBoardService) {
            this.noticeBoardService = noticeBoardService;
        }

        @GetMapping("/recent")
        public List<NoticeBoardVO> getRecentNotices() {
            return noticeBoardService.getRecentNotices();
        }
    }
}
