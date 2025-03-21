package kr.or.batirplan.calendar.service;

import kr.or.batirplan.calendar.vo.CalendarVO;
import java.util.List;

public interface ICalendarService {
    int insertEvent(CalendarVO event);
    List<CalendarVO> getEvents(String userId);
    int updateEvent(CalendarVO event);
    int deleteEvent(int eventId);
    List<CalendarVO> getAllProjects();
    List<CalendarVO> getProjectRelatedEvents(int prjctNo);
}