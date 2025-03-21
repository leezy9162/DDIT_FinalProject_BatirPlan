package kr.or.batirplan.main.service;

import java.util.List;
import java.util.Map;

public interface MainElectronicDocumentService {
    List<Map<String, Object>> getRecentDocuments(String userId);
    
    int getUserDocumentCount(String userId);
}
