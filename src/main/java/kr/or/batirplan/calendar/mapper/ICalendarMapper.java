package kr.or.batirplan.calendar.mapper;

import kr.or.batirplan.calendar.vo.CalendarVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ICalendarMapper {
    int insertEvent(CalendarVO event);
    List<CalendarVO> getMyEvents(String userId);
    int updateEvent(CalendarVO event);
    int deleteEvent(int eventId);
    List<CalendarVO> getMyProjects(String userId);
    List<CalendarVO> getMyApprovals(String userId);
    List<CalendarVO> getMyProcesses(String userId);
    List<CalendarVO> getAllProjects();
    List<CalendarVO> getMyEquipmentEvents(String userId);
    List<CalendarVO> getProjectRelatedEvents(@Param("prjctNo") int prjctNo);
}
