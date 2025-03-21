package kr.or.batirplan.resrcem.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import kr.or.batirplan.resrcem.vo.ResrcemVO;

@Mapper
public interface ResrcemMapper {
    /**
     * 전체 입출고 리스트 조회
     */
    List<ResrcemVO> selectResrcem();

    /**
     * 특정 기록 번호로 입출고 데이터 조회 (엑셀 다운로드 용)
     */
    ResrcemVO selectResrcemById(@Param("recordNo") int recordNo);
}
