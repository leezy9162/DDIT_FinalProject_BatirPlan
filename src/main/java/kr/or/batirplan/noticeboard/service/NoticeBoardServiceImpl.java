package kr.or.batirplan.noticeboard.service;

import kr.or.batirplan.noticeboard.mapper.NoticeBoardMapper;
import kr.or.batirplan.noticeboard.vo.NoticeBoardVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {

    private final NoticeBoardMapper noticeBoardMapper;

    public NoticeBoardServiceImpl(NoticeBoardMapper noticeBoardMapper) {
        this.noticeBoardMapper = noticeBoardMapper;
    }

    /**
     *  공지사항 목록 조회 (페이징 적용)
     * @param page 현재 페이지 번호
     * @param pageSize 페이지당 항목 수
     * @return 공지사항 목록, 페이지 정보 포함
     */
    @Override
    public Map<String, Object> getNoticeBoardList(int page, int pageSize, String title) {
        int startRow = (page - 1) * pageSize;
        List<NoticeBoardVO> list;

        if (title != null && !title.trim().isEmpty()) {
            list = noticeBoardMapper.searchNoticeBoardByTitle(startRow, pageSize, title);
        } else {
            list = noticeBoardMapper.getNoticeBoardList(startRow, pageSize);
        }

        int totalCount;
        if (title != null && !title.trim().isEmpty()) {
            totalCount = noticeBoardMapper.getSearchNoticeBoardCount(title);
        } else {
            totalCount = noticeBoardMapper.getTotalNoticeBoardCount();
        }

        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        //  최신 게시물이 1번이 되도록 번호 재정렬
        int displayNo = totalCount - startRow;
        for (NoticeBoardVO notice : list) {
            notice.setDisplayNo(displayNo--);  //  최신 게시물이 1번이 되도록 설정
        }

        Map<String, Object> result = new HashMap<>();
        result.put("noticeList", list);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("pageSize", pageSize);

        return result;
    }


    /**
     *  공지사항 상세 조회 + 조회수 증가
     * @param bbscttNo 공지사항 번호
     * @return 상세 정보
     */
    @Transactional
    @Override
    public NoticeBoardVO getNoticeBoardById(int bbscttNo) {
        System.out.println(" Service - getNoticeBoardById 실행, bbscttNo: " + bbscttNo);

        // 공지사항 조회 + 조회수 증가를 한 번에 처리
        noticeBoardMapper.updateViewCount(bbscttNo); //  조회수 증가 로직을 먼저 실행
        NoticeBoardVO notice = noticeBoardMapper.getNoticeBoardDetail(bbscttNo); //  이후 상세 조회 실행

        if (notice == null) {
            System.out.println("존재하지 않는 게시글 (bbscttNo: " + bbscttNo + ")");
            return null;
        }

        return notice;
    }


    /**
     *  공지사항 등록
     * @param noticeBoard 등록할 공지사항 객체
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    @Override
    public int createNoticeBoard(NoticeBoardVO noticeBoard) {
        System.out.println(" Service - createNoticeBoard 실행");
        int result = noticeBoardMapper.insertNoticeBoard(noticeBoard);

        if (result > 0) {
            System.out.println(" 공지사항 등록 완료");
        } else {
            System.out.println(" 공지사항 등록 실패");
        }

        return result;
    }

    /**
     *  공지사항 수정
     * @param noticeBoard 수정할 공지사항 객체
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    @Override
    public int updateNoticeBoard(NoticeBoardVO noticeBoard) {
        System.out.println(" Service - updateNoticeBoard 실행");
        return noticeBoardMapper.updateNoticeBoard(noticeBoard);
    }

    /**
     *  공지사항 삭제
     * @param bbscttNo 삭제할 공지사항 번호
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    @Override
    public int deleteNoticeBoard(int bbscttNo) {
        System.out.println(" Service - deleteNoticeBoard 실행");
        return noticeBoardMapper.deleteNoticeBoard(bbscttNo);
    }

    /**
     *  조회수 증가 (상세보기에서만 호출되도록)
     * @param bbscttNo 조회수를 증가시킬 공지사항 번호
     */
    @Transactional
    @Override
    public void increaseViewCount(int bbscttNo) {
        System.out.println(" Service - increaseViewCount 실행 (bbscttNo: " + bbscttNo + ")");
        noticeBoardMapper.updateViewCount(bbscttNo);
    }

    /**
     *  최신 공지사항 5개 조회 추가
     * @return 최신 5개 공지사항 리스트
     */
    @Override
    public List<NoticeBoardVO> getRecentNotices() {
        System.out.println(" Service - getRecentNotices 실행 (최신 5개 공지사항 조회)");
        return noticeBoardMapper.getRecentNotices();
    }

    @Override
    public void insertNoticeBoard(NoticeBoardVO noticeBoard) {
        System.out.println(" Service - insertNoticeBoard 실행");
        noticeBoardMapper.insertNoticeBoard(noticeBoard);
    }

    @Override
    public NoticeBoardVO getNoticeBoardById(int bbscttNo, boolean increaseView) {
        System.out.println(" Service - getNoticeBoardById 실행, bbscttNo: " + bbscttNo + ", increaseView: " + increaseView);
        
        if (increaseView) {
            noticeBoardMapper.updateViewCount(bbscttNo);  //  조회수 증가
        }

        return noticeBoardMapper.getNoticeBoardDetail(bbscttNo);
    }
}
