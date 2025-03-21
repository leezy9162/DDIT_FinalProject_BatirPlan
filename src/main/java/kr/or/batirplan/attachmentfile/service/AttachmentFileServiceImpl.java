package kr.or.batirplan.attachmentfile.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.batirplan.attachmentfile.mapper.IAttachmentFileMapper;
import kr.or.batirplan.attachmentfile.vo.AttachmentFileVO;

@Service
public class AttachmentFileServiceImpl implements IAttachmentFileService {

 @Autowired
 private IAttachmentFileMapper attachmentFileMapper;

 @Override
 public int insertFile(AttachmentFileVO fileVO) {
     // fileNo가 비어 있으면 직접 생성
     if (fileVO.getFileNo() == null || fileVO.getFileNo().trim().isEmpty()) {
         long fileNoLong = System.currentTimeMillis(); 
         fileNoLong += (long)(Math.random() * 1000); 
         fileVO.setFileNo(String.valueOf(fileNoLong));
     }

     return attachmentFileMapper.insertFile(fileVO);
 }
}
