package kr.or.batirplan.calendar.web;

import kr.or.batirplan.calendar.service.ICalendarService;
import kr.or.batirplan.calendar.vo.CalendarVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/batirplan/erp/calendar")
public class CalendarRestController {

    @Autowired
    private ICalendarService service;

    // 📌 일정 추가
    @PostMapping("/insertEvent")
    public int insertEvent(@RequestBody CalendarVO event) {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        event.setEventWriter(userId);
        return service.insertEvent(event);
    }

    // 📌 일정 조회 (내가 속한 프로젝트 & 결재 포함)
    @GetMapping("/getEvents")
    public List<CalendarVO> getEvents() {
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        return service.getEvents(userId);
    }

    // 📌 일정 수정
    @PostMapping("/updateEvent")
    public int updateEvent(@RequestBody CalendarVO event) {
        return service.updateEvent(event);
    }

    // 📌 일정 삭제
    @PostMapping("/deleteEvent")
    public int deleteEvent(@RequestParam("eventId") int eventId) {
        return service.deleteEvent(eventId);
    }
    
    @GetMapping("/getAllProjects")
    public List<CalendarVO> getAllProjects() {
        return service.getAllProjects();
    }
    
    @GetMapping("/getProjectRelatedEvents")
    public List<CalendarVO> getProjectRelatedEvents(@RequestParam("prjctNo") int prjctNo) {
        return service.getProjectRelatedEvents(prjctNo);
    }
    
    
}
