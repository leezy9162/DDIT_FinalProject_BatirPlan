package kr.or.batirplan.message.service;

import com.github.pagehelper.PageInfo;
import kr.or.batirplan.message.vo.MessageReceptionVO;
import kr.or.batirplan.message.vo.MessageVO;
import kr.or.batirplan.employee.vo.EmployeeVO;

import java.util.List;
import java.util.Map;

public interface MessageService {

    // 쪽지 발송 (TB_MESSAGE, TB_MESSAGE_RECEPTION)
    void sendMessage(MessageVO message, MessageReceptionVO messageReception);

    // 보낸 쪽지함
    PageInfo<MessageVO> getSentMessages(String sender, int pageNum, int pageSize,
                                        String searchFilter, String searchKeyword);

    // 받은 쪽지함
    PageInfo<MessageReceptionVO> getReceivedMessages(String receiver, int pageNum, int pageSize,
                                                     String searchFilter, String searchKeyword);

    // 쪽지 상세 조회
    MessageVO getMessageDetail(int mssageNo);

    // 받은 쪽지 읽음 처리
    void updateMessageStatus(int mssageNo, String rcver);
    
    List<Integer> getReadMessages(String sender);

    // 보낸 쪽지 다중 삭제(휴지통 이동)
    void moveSentMessagesToTrash(String userId, List<Integer> mssageNos);

    // 받은 쪽지 다중 삭제(휴지통 이동)
    void moveReceivedMessagesToTrash(String userId, List<Integer> recptnNos);

    // 휴지통 목록 (보낸+받은 UNION)
    PageInfo<Map<String, Object>> getTrashMessages(String userId, int pageNum, int pageSize,
                                                   String searchFilter, String searchKeyword);

    // 휴지통 복구
    void restoreMessages(String userId, String boxType, List<Integer> ids);

    // 휴지통 영구삭제
    void permanentlyDeleteMessages(String userId, String boxType, List<Integer> ids);

    // 추가: 직원 검색
    List<EmployeeVO> searchEmployees(String keyword);
    
    int getUnreadMessageCount(String userId);
    
    
}
