package kr.or.batirplan.main.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

@Mapper
public interface MainElectronicDocumentMapper {
    /**
     * 📌 최근 전자결재 문서 목록 조회 (XML Mapper에서 실행됨)
     */
    List<Map<String, Object>> selectRecentDocuments(@Param("userId") String userId);
    
    int countUserDocuments(@Param("userId") String userId);
}
