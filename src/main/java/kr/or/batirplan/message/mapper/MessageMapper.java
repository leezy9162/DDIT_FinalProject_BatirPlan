package kr.or.batirplan.message.mapper;

import kr.or.batirplan.message.vo.MessageVO;
import kr.or.batirplan.message.vo.MessageReceptionVO;
import kr.or.batirplan.employee.vo.EmployeeVO;  // EmployeeVO import
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageMapper {

    // 쪽지 INSERT
    void insertMessage(MessageVO message);

    // 수신 INSERT
    void insertMessageReception(MessageReceptionVO messageReception);

    // 보낸 쪽지함 목록 조회
    List<MessageVO> selectSentMessages(Map<String, Object> paramMap);

    // 받은 쪽지함 목록 조회
    List<MessageReceptionVO> selectReceivedMessages(Map<String, Object> paramMap);

    // 쪽지 상세 조회
    MessageVO selectMessageDetail(int mssageNo);

    // 받은 쪽지 읽음 처리
    void updateMessageStatus(@Param("mssageNo") int mssageNo, @Param("rcver") String rcver);
    
    List<Integer> selectReadMessages(@Param("sender") String sender);

    // 보낸 쪽지 -> 휴지통 이동
    void deleteSentMessagesToTrash(Map<String, Object> paramMap);

    // 받은 쪽지 -> 휴지통 이동
    void deleteReceivedMessagesToTrash(Map<String, Object> paramMap);

    // 휴지통 목록 (보낸+받은 UNION)
    List<Map<String, Object>> selectTrashMessages(Map<String, Object> paramMap);

    // 휴지통 복구 (보낸/받은)
    void restoreSentMessages(Map<String, Object> paramMap);
    void restoreReceivedMessages(Map<String, Object> paramMap);

    // 자식(TB_MESSAGE_RECEPTION) 먼저 삭제
    void deleteReceptionByMessageNos(Map<String, Object> paramMap);

    // 보낸 쪽지 영구삭제
    void permanentlyDeleteSentMessages(Map<String, Object> paramMap);

    // 받은 쪽지 영구삭제
    void permanentlyDeleteReceivedMessages(Map<String, Object> paramMap);

    // 추가: 직원 검색 (EmployeeVO 사용)
    List<EmployeeVO> selectEmployeesByKeyword(@Param("keyword") String keyword);

    // 받은 쪽지 중 읽지 않은 개수 조회
    int countUnreadMessages(@Param("userId") String userId);
}
