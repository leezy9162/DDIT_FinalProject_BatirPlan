package kr.or.batirplan.resrcem.service;

import java.io.ByteArrayInputStream;
import java.util.List;

import kr.or.batirplan.resrcem.vo.ResrcemVO;

public interface ResrcemService {

    /**
     * 입출고 리스트 조회
     */
    List<ResrcemVO> selectResrcem();

    /**
     * 개별 입출고 기록 조회 (엑셀 다운로드용)
     */
    ResrcemVO getResrcemById(int recordNo);

	/**
	 * 개별 입출고 기록을 엑셀 파일로 변환하여 다운로드할 수 있도록 제공
	 */
	ByteArrayInputStream downloadResrcemAsExcel(int recordNo);
}
