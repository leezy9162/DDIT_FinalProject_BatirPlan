package kr.or.batirplan.calendar.service;

import kr.or.batirplan.calendar.mapper.ICalendarMapper;
import kr.or.batirplan.calendar.vo.CalendarVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CalendarServiceImpl implements ICalendarService {

    @Autowired
    private ICalendarMapper mapper;

    @Override
    public int insertEvent(CalendarVO event) {
        return mapper.insertEvent(event);
    }

    @Override
    public List<CalendarVO> getEvents(String userId) {
        // 🔹 로그인한 사용자가 추가한 일정만 조회
        List<CalendarVO> events = mapper.getMyEvents(userId);
        // 🔹 로그인한 사용자가 속한 프로젝트 일정 추가
        List<CalendarVO> myProjects = mapper.getMyProjects(userId);
        // 🔹 로그인한 사용자가 속한 결재 일정 추가
        List<CalendarVO> myApprovals = mapper.getMyApprovals(userId);
        
        List<CalendarVO> myProcesses = mapper.getMyProcesses(userId);
        
        List<CalendarVO> myEquipmentEvents = mapper.getMyEquipmentEvents(userId);
        
        
        events.addAll(myProjects);
        events.addAll(myApprovals);
        events.addAll(myProcesses);  
        events.addAll(myEquipmentEvents);
        

        return events;
    }

    @Override
    public int updateEvent(CalendarVO event) {
        return mapper.updateEvent(event);
    }

    @Override
    public int deleteEvent(int eventId) {
        return mapper.deleteEvent(eventId);
    }
    
    @Override
    public List<CalendarVO> getAllProjects() {
        return mapper.getAllProjects();
    }

    @Override
    public List<CalendarVO> getProjectRelatedEvents(int prjctNo) {
        return mapper.getProjectRelatedEvents(prjctNo);
    }
   
    
}