package kr.or.batirplan.attachmentfile.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.batirplan.attachmentfile.vo.AttachmentFileVO;

@Mapper
public interface IAttachmentFileMapper {
    int insertFile(AttachmentFileVO fileVO);
}
