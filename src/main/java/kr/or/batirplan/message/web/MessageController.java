package kr.or.batirplan.message.web;

import com.github.pagehelper.PageInfo;
import kr.or.batirplan.message.service.MessageService;
import kr.or.batirplan.message.vo.MessageReceptionVO;
import kr.or.batirplan.message.vo.MessageVO;
import kr.or.batirplan.employee.vo.EmployeeVO;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.apache.commons.text.StringEscapeUtils;


import java.util.*;

/**
 * 전체 쪽지 기능 Controller
 */
@Controller
@RequestMapping("/batirplan/message")
public class MessageController {

    private final MessageService messageService;

    public MessageController(MessageService messageService) {
        this.messageService = messageService;
    }

    /**
     * 1. 쪽지 보내기 페이지
     */
    @GetMapping("/send")
    public String sendMessagePage(Model model) {
        // (필요하다면 초기 전체 직원 목록도 전달 가능)
        // List<EmployeeVO> employeeList = messageService.searchEmployees("");
        // model.addAttribute("employeeList", employeeList);
        return "message/sendMessage";
    }

    // 쪽지 보내기 처리
    @PostMapping("/send")
    public String sendMessage(MessageVO message, MessageReceptionVO messageReception) {
        String sender = SecurityContextHolder.getContext().getAuthentication().getName();
        message.setDsptcher(sender);
        messageService.sendMessage(message, messageReception);
        return "redirect:/batirplan/message/sent";
    }

    // AJAX: 직원 검색
    @GetMapping("/employeeSearch")
    @ResponseBody
    public List<EmployeeVO> employeeSearch(@RequestParam(value = "keyword", required = false) String keyword) {
        // keyword가 없거나 빈 값이면 전체 직원 조회
        if (keyword == null || keyword.trim().isEmpty()) {
            return messageService.searchEmployees("");  // 빈 문자열로 전체 직원 반환
        }
        return messageService.searchEmployees(keyword);
    }

    /**
     * 2. 보낸 쪽지함
     */
    @GetMapping("/sent")
    public String getSentMessages(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "searchFilter", required = false) String searchFilter,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            Model model) {
        String sender = SecurityContextHolder.getContext().getAuthentication().getName();
        PageInfo<MessageVO> pageInfo = messageService.getSentMessages(sender, pageNum, pageSize, searchFilter, searchKeyword);
        
        // 각 메시지의 내용이 30자 이상이면 잘라내어 "..."를 붙인 결과를 Map에 저장 (키: 메시지 번호)
        Map<Integer, String> truncatedMap = new HashMap<>();
        for (MessageVO message : pageInfo.getList()) {
            String content = message.getCn();
            if (content != null && content.length() > 30) {
                truncatedMap.put(message.getMssageNo(), content.substring(0, 30) + "...");
            } else {
                truncatedMap.put(message.getMssageNo(), content);
            }
        }
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("truncatedMap", truncatedMap);
        model.addAttribute("searchFilter", searchFilter);
        model.addAttribute("searchKeyword", searchKeyword);
        return "message/sentMessages";
    }


    @PostMapping("/deleteFromSent")
    public String deleteFromSent(@RequestParam("mssageNo") List<Integer> mssageNos) {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        messageService.moveSentMessagesToTrash(userId, mssageNos);
        return "redirect:/batirplan/message/sent";
    }

    /**
     * 3. 받은 쪽지함
     */
    @GetMapping("/received")
    public String getReceivedMessages(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "searchFilter", required = false) String searchFilter,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            Model model) {
        String receiver = SecurityContextHolder.getContext().getAuthentication().getName();
        PageInfo<MessageReceptionVO> pageInfo = messageService.getReceivedMessages(receiver, pageNum, pageSize, searchFilter, searchKeyword);
        
        // 받은 쪽지의 경우, 각 메시지 내용이 30자 이상이면 잘라낸 결과를 Map에 저장 (키: 쪽지 번호)
        Map<Integer, String> truncatedMap = new HashMap<>();
        for (MessageReceptionVO message : pageInfo.getList()) {
            String content = message.getCn();
            if (content != null && content.length() > 30) {
                truncatedMap.put(message.getMssageNo(), content.substring(0, 30) + "...");
            } else {
                truncatedMap.put(message.getMssageNo(), content);
            }
        }
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("truncatedMap", truncatedMap);
        model.addAttribute("searchFilter", searchFilter);
        model.addAttribute("searchKeyword", searchKeyword);
        return "message/receivedMessages";
    }


    @PostMapping("/deleteFromReceived")
    public String deleteFromReceived(@RequestParam("recptnNo") List<Integer> recptnNos) {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        messageService.moveReceivedMessagesToTrash(userId, recptnNos);
        return "redirect:/batirplan/message/received";
    }

    /**
     * 4. 쪽지 상세보기
     */
    @GetMapping("/detail")
    public String getMessageDetail(
            @RequestParam("mssageNo") int mssageNo,
            @RequestParam(value="boxType", required=false) String boxType,
            @RequestParam(value="recptnNo", required=false) Integer recptnNo,
            Model model) {
        String rcver = SecurityContextHolder.getContext().getAuthentication().getName();
        messageService.updateMessageStatus(mssageNo, rcver);
        MessageVO message = messageService.getMessageDetail(mssageNo);

        // 줄바꿈 변환
        if (message.getCn() != null) {
            String formattedContent = StringEscapeUtils.escapeHtml4(message.getCn()); // XSS 방지
            formattedContent = formattedContent.replace("\n", "<br/>"); // 줄바꿈 변환
            model.addAttribute("formattedContent", formattedContent);
        } else {
            model.addAttribute("formattedContent", "");
        }

        model.addAttribute("message", message);
        model.addAttribute("boxType", boxType);
        model.addAttribute("recptnNo", recptnNo);
        return "message/messageDetail";
    }
    
    @PostMapping("/updateReadStatus")
    @ResponseBody
    public String updateReadStatus(@RequestParam("mssageNo") int mssageNo,
                                   @RequestParam("rcver") String rcver) {
        try {
            System.out.println("updateReadStatus called: mssageNo=" + mssageNo + ", rcver=" + rcver);
            messageService.updateMessageStatus(mssageNo, rcver);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @GetMapping("/checkReadStatus")
    @ResponseBody
    public List<Integer> checkReadStatus() {
        String sender = SecurityContextHolder.getContext().getAuthentication().getName();
        return messageService.getReadMessages(sender);
    }
    
    
    

    /**
     * 5. 휴지통
     */
    @GetMapping("/trash")
    public String getTrashMessages(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            @RequestParam(value = "searchFilter", required = false) String searchFilter,
            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
            Model model) {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        PageInfo<Map<String, Object>> pageInfo = messageService.getTrashMessages(userId, pageNum, pageSize, searchFilter, searchKeyword);
        
        // 각 행(Map)에서 "CONTENT" 값을 확인하여 30자 이상이면 잘라내고 "truncatedContent"에 저장
        for (Map<String, Object> row : pageInfo.getList()) {
            Object contentObj = row.get("CONTENT");
            if (contentObj != null) {
                String content = contentObj.toString();
                if (content.length() > 30) {
                    row.put("truncatedContent", content.substring(0, 30) + "...");
                } else {
                    row.put("truncatedContent", content);
                }
            }
        }
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("searchFilter", searchFilter);
        model.addAttribute("searchKeyword", searchKeyword);
        return "message/trashMessages";
    }


    @PostMapping("/restoreMultiple")
    public String restoreMultiple(@RequestParam("selectedRows") List<String> selectedRows) {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        Map<String, List<Integer>> boxTypeMap = new HashMap<>();
        boxTypeMap.put("S", new ArrayList<>());
        boxTypeMap.put("R", new ArrayList<>());
        for (String row : selectedRows) {
            String[] parts = row.split("_");
            String type = parts[0];
            int uniqueId = Integer.parseInt(parts[1]);
            boxTypeMap.get(type).add(uniqueId);
        }
        if (!boxTypeMap.get("S").isEmpty()) {
            messageService.restoreMessages(userId, "S", boxTypeMap.get("S"));
        }
        if (!boxTypeMap.get("R").isEmpty()) {
            messageService.restoreMessages(userId, "R", boxTypeMap.get("R"));
        }
        return "redirect:/batirplan/message/trash";
    }

    @PostMapping("/permanentDeleteMultiple")
    public String permanentlyDeleteMultiple(@RequestParam("selectedRows") List<String> selectedRows) {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        Map<String, List<Integer>> boxTypeMap = new HashMap<>();
        boxTypeMap.put("S", new ArrayList<>());
        boxTypeMap.put("R", new ArrayList<>());
        for (String row : selectedRows) {
            String[] parts = row.split("_");
            String type = parts[0];
            int uniqueId = Integer.parseInt(parts[1]);
            boxTypeMap.get(type).add(uniqueId);
        }
        if (!boxTypeMap.get("S").isEmpty()) {
            messageService.permanentlyDeleteMessages(userId, "S", boxTypeMap.get("S"));
        }
        if (!boxTypeMap.get("R").isEmpty()) {
            messageService.permanentlyDeleteMessages(userId, "R", boxTypeMap.get("R"));
        }
        return "redirect:/batirplan/message/trash";
    }
    
    
    @GetMapping("/unreadCount")
    @ResponseBody
    public int getUnreadMessageCount() {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        return messageService.getUnreadMessageCount(userId);
    }
    
}
