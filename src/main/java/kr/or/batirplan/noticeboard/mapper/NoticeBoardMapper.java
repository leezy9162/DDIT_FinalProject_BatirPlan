package kr.or.batirplan.noticeboard.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.or.batirplan.noticeboard.vo.NoticeBoardVO;

@Mapper
public interface NoticeBoardMapper {
    
    /**
     *  공지사항 목록 조회 (최신 글이 1번이 되도록 정렬)
     */
    List<NoticeBoardVO> getNoticeBoardList(
        @Param("startRow") int startRow, 
        @Param("pageSize") int pageSize
    );

    /**
     *  제목으로 공지사항 목록 조회 (최신 글이 1번)
     */
    List<NoticeBoardVO> searchNoticeBoardByTitle(
        @Param("startRow") int startRow,
        @Param("pageSize") int pageSize,
        @Param("title") String title
    );

    /**
     *  전체 공지사항 개수 조회
     */
    int getTotalNoticeBoardCount();

    /**
     *  제목으로 검색된 공지사항 개수 조회
     */
    int getSearchNoticeBoardCount(@Param("title") String title);

    /**
     *  공지사항 상세 조회 (조회수 증가 포함)
     */
    NoticeBoardVO getNoticeBoardDetail(@Param("bbscttNo") int bbscttNo);

    /**
     *  공지사항 등록
     */
    int insertNoticeBoard(NoticeBoardVO noticeBoard);

    /**
     *  공지사항 수정 (VO 전체 전달)
     */
    int updateNoticeBoard(@Param("noticeBoard") NoticeBoardVO noticeBoard);

    /**
     *  공지사항 삭제
     */
    int deleteNoticeBoard(@Param("bbscttNo") int bbscttNo);

    /**
     *  조회수 증가 (한 번만 실행)
     */
    void updateViewCount(@Param("bbscttNo") int bbscttNo);

    /**
     *  최신 글이 1번이 되도록 출력용 번호(displayNo) 부여
     */
    List<NoticeBoardVO> getNoticeBoardListWithDisplayNumber(
        @Param("startRow") int startRow,
        @Param("pageSize") int pageSize
    );

    /**
     *  최근 5개 공지사항 가져오기 (최신순 정렬)
     */
    List<NoticeBoardVO> getRecentNotices();
}
