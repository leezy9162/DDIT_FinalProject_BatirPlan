package kr.or.batirplan.calendar.vo;

import lombok.Data;

@Data
public class CalendarVO {
    private int eventId;
    private String eventTitle;
    private String eventWriter;
    private String category;
    private String eventDescription;
    private String startTime;
    private String endTime;
    private String eventStatus;
    private String createdTime;
    private String textColor;
    private String backgroundColor;
    private String borderColor;
}
