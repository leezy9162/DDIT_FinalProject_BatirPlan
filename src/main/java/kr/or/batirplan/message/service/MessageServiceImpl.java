package kr.or.batirplan.message.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import kr.or.batirplan.message.mapper.MessageMapper;
import kr.or.batirplan.message.vo.MessageReceptionVO;
import kr.or.batirplan.message.vo.MessageVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MessageServiceImpl implements MessageService {

    private final MessageMapper messageMapper;

    public MessageServiceImpl(MessageMapper messageMapper) {
        this.messageMapper = messageMapper;
    }

    @Override
    public void sendMessage(MessageVO message, MessageReceptionVO messageReception) {
        // TB_MESSAGE INSERT
        messageMapper.insertMessage(message);
        // TB_MESSAGE_RECEPTION INSERT (쪽지 번호를 설정)
        messageReception.setMssageNo(message.getMssageNo());
        messageMapper.insertMessageReception(messageReception);
    }

    @Override
    public PageInfo<MessageVO> getSentMessages(String sender, int pageNum, int pageSize,
                                               String searchFilter, String searchKeyword) {
        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("dsptcher", sender);
        paramMap.put("searchFilter", searchFilter);
        paramMap.put("searchKeyword", searchKeyword);

        List<MessageVO> list = messageMapper.selectSentMessages(paramMap);
        return new PageInfo<>(list);
    }

    @Override
    public PageInfo<MessageReceptionVO> getReceivedMessages(String receiver, int pageNum, int pageSize,
                                                            String searchFilter, String searchKeyword) {
        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("rcver", receiver);
        paramMap.put("searchFilter", searchFilter);
        paramMap.put("searchKeyword", searchKeyword);

        List<MessageReceptionVO> list = messageMapper.selectReceivedMessages(paramMap);
        return new PageInfo<>(list);
    }

    @Override
    public MessageVO getMessageDetail(int mssageNo) {
        return messageMapper.selectMessageDetail(mssageNo);
    }

    @Override
    public void updateMessageStatus(int mssageNo, String rcver) {
        messageMapper.updateMessageStatus(mssageNo, rcver);
    }

    @Override
    public List<Integer> getReadMessages(String sender) {
        return messageMapper.selectReadMessages(sender);
    }
    
    @Override
    public void moveSentMessagesToTrash(String userId, List<Integer> mssageNos) {
        if (mssageNos == null || mssageNos.isEmpty()) return;
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("mssageNos", mssageNos);
        messageMapper.deleteSentMessagesToTrash(paramMap);
    }

    @Override
    public void moveReceivedMessagesToTrash(String userId, List<Integer> recptnNos) {
        if (recptnNos == null || recptnNos.isEmpty()) return;
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("recptnNos", recptnNos);
        messageMapper.deleteReceivedMessagesToTrash(paramMap);
    }

    @Override
    public PageInfo<Map<String, Object>> getTrashMessages(String userId, int pageNum, int pageSize,
                                                          String searchFilter, String searchKeyword) {
        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("searchFilter", searchFilter);
        paramMap.put("searchKeyword", searchKeyword);
        List<Map<String, Object>> list = messageMapper.selectTrashMessages(paramMap);
        return new PageInfo<>(list);
    }

    @Override
    public void restoreMessages(String userId, String boxType, List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return;
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("ids", ids);
        if ("S".equals(boxType)) {
            messageMapper.restoreSentMessages(paramMap);
        } else if ("R".equals(boxType)) {
            messageMapper.restoreReceivedMessages(paramMap);
        } else {
            throw new IllegalArgumentException("Invalid boxType: " + boxType);
        }
    }

    @Override
    public void permanentlyDeleteMessages(String userId, String boxType, List<Integer> ids) {
        if (ids == null || ids.isEmpty()) return;
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("ids", ids);
        if ("S".equals(boxType)) {
            messageMapper.deleteReceptionByMessageNos(paramMap);
            messageMapper.permanentlyDeleteSentMessages(paramMap);
        } else if ("R".equals(boxType)) {
            messageMapper.permanentlyDeleteReceivedMessages(paramMap);
        } else {
            throw new IllegalArgumentException("Invalid boxType: " + boxType);
        }
    }

    @Override
    public List<EmployeeVO> searchEmployees(String keyword) {
        return messageMapper.selectEmployeesByKeyword(keyword);
    }
    
    @Override
    public int getUnreadMessageCount(String userId) {
        return messageMapper.countUnreadMessages(userId);
    }
}