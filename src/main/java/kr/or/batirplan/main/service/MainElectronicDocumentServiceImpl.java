package kr.or.batirplan.main.service;

import kr.or.batirplan.main.mapper.MainElectronicDocumentMapper;
import kr.or.batirplan.main.service.MainElectronicDocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class MainElectronicDocumentServiceImpl implements MainElectronicDocumentService {

    @Autowired
    private MainElectronicDocumentMapper documentMapper;

    @Override
    public List<Map<String, Object>> getRecentDocuments(String userId) {
        return documentMapper.selectRecentDocuments(userId);
    }

	@Override
	public int getUserDocumentCount(String userId) {
		return documentMapper.countUserDocuments(userId);
	}
}
