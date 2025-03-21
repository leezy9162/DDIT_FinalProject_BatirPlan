package kr.or.batirplan.noticeboard.service;

import java.util.List;
import java.util.Map;

import kr.or.batirplan.noticeboard.vo.NoticeBoardVO;

public interface NoticeBoardService {
    
    //  게시글 목록 조회 (페이징 + 제목 검색 추가)
    Map<String, Object> getNoticeBoardList(int page, int size, String title);  
    
    //  게시글 상세보기 (조회수 증가 여부 포함)
    NoticeBoardVO getNoticeBoardById(int bbscttNo, boolean increaseView);
    
    //  기존 상세보기 메서드 (조회수 증가 없이 유지)
    default NoticeBoardVO getNoticeBoardById(int bbscttNo) {
        return getNoticeBoardById(bbscttNo, false);
    }
    
    //  게시글 등록
    int createNoticeBoard(NoticeBoardVO noticeBoard);
    
    //  게시글 수정
    int updateNoticeBoard(NoticeBoardVO noticeBoard);
    
    //  게시글 삭제
    int deleteNoticeBoard(int bbscttNo);

    //  게시글 삽입
    void insertNoticeBoard(NoticeBoardVO noticeBoard);

    //  조회수 증가 (별도 호출 가능)
    void increaseViewCount(int bbscttNo);

    // 최신 공지사항 5개 조회 추가
    List<NoticeBoardVO> getRecentNotices();
}
