<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<body class="link-sidebar" onload="displayMap()"> <!-- ✅ 두 개를 함께 적용 -->
<%@include file="../module/commonTags.jsp" %>

<div id="main-wrapper" class="main-wrapper">
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
        <%@include file="../module/navBar.jsp" %>
        <div class="body-wrapper">
            <div class="container-fluid">
            
                <div class="card card-body py-3">
                    <div class="row align-items-center">
                        <h4 class="mb-4 mb-sm-0 card-title">장비 배치 상세정보</h4>
                    </div>
                </div>
            
                <div class="card">
                    <div class="card-body">

                        <!-- 📌 지도 & 캘린더 -->
                        <div class="row">
                            <div class="col-md-6">
                                <h5>📌 프로젝트 위치</h5>
                                <div id="map" style="width:100%; height:523px; border:1px solid #ccc;"></div>
                            </div>
                            <div class="col-md-6">
                                <h5>📅 신청자의 장비 배치 일정</h5>
                                <div id="calendar" style="width:100%; height:400px; border:1px solid #ccc;"></div>
                            </div>
                        </div>

                        <!-- 📌 장비 배치 상세 정보 -->
                        <div class="mt-4">
                            <h5>장비 배치 상세 정보</h5>
                            <div class="row row-gap-10">
                                <!-- 첫 번째 그룹 -->
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">신청번호:</span> ${arrangement.requestNo}</div>
                                    <div class="detail-item"><span class="detail-label">프로젝트명:</span> ${arrangement.prjctNm}</div>
                                    <div class="detail-item"><span class="detail-label">프로젝트 위치:</span> ${arrangement.prjctLc}</div>
                                </div>

                                <!-- 두 번째 그룹 -->
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">신청자:</span> ${arrangement.emplNm}</div>
                                    <div class="detail-item"><span class="detail-label">장비명:</span> ${arrangement.eqpmnNm}</div>
                                    <div class="detail-item"><span class="detail-label">장비 유형:</span> ${arrangement.eqpmnTy}</div>
                                </div>

                                <!-- 세 번째 그룹 -->
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">일련번호:</span> ${arrangement.eqpmnSn}</div>
                                    <div class="detail-item"><span class="detail-label">제조사명:</span> ${arrangement.makrNm}</div>
                                    <div class="detail-item">
                                        <span class="detail-label">승인 여부:</span>
                                        <c:choose>
                                            <c:when test="${arrangement.approvalStatus == 'Y'}"><span class="status-approved">✔ 승인</span></c:when>
                                            <c:when test="${arrangement.approvalStatus == 'D'}"><span class="status-pending">⏳ 대기</span></c:when>
                                            <c:otherwise><span class="status-rejected">❌ 미승인</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- 추가 정보 그룹 (신청일 / 대여기간) -->
                            <div class="row mt-2">
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">신청일:</span> <fmt:formatDate value="${arrangement.requestDate}" pattern="yyyy-MM-dd" /></div>
                                </div>
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">대여 시작일:</span> <fmt:formatDate value="${arrangement.rentalStartDate}" pattern="yyyy-MM-dd" /></div>
                                </div>
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">대여 종료일:</span> <fmt:formatDate value="${arrangement.rentalEndDate}" pattern="yyyy-MM-dd" /></div>
                                </div>
                            </div>
                            
                            <div class="mt-4">
                                <h5>배치 사유</h5>
                                <div class="arrangement-reason">
                                    <c:choose>
                                        <c:when test="${not empty arrangement.arrangementReason}">
                                            ${arrangement.arrangementReason}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">사유 없음</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            

                            <a href="/batirplan/equipment/arrangement/list" class="btn btn-primary mt-3">목록</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<!-- 📌 스타일 조정 -->
<style>
    .detail-item {
        margin-bottom: 6px; /* ✅ 간격 줄이기 */
        font-size: 15px;
    }
    .detail-label {
        width: 120px; /* ✅ 레이블 일정한 크기로 정렬 */
        display: inline-block;
        font-weight: bold;
        color: #333;
    }
    .row-gap-10 {
        row-gap: 10px; /* ✅ 그룹 간 간격 조정 */
    }
</style>

<!-- 📌 Kakao Map SDK -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=126a30d2a46843ee25bc69a141aa9849&libraries=services"></script>
<script>
function displayMap() {
    var address = "${arrangement.prjctLc}";
    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.9780),
            level: 3
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px; font-weight:bold; color:black;">' + address + '</div>'
            });

            infowindow.open(map, marker);
            map.setCenter(coords);
        } else {
            Swal.fire({
                icon: "error",
                title: "주소 검색 실패",
                text: "주소를 찾을 수 없습니다.",
                confirmButtonText: "확인"
            });
        }
    });
}
</script>

<!-- 📌 FullCalendar -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');
    var emplCode = "${arrangement.emplCode}"; // 신청자의 사원 코드

    var calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        initialView: 'dayGridMonth',
        height: "auto", // 캘린더 크기 자동 조절
        headerToolbar: { left: 'prev,next today', center: 'title', right: '' },
        eventTimeFormat: { hour: '2-digit', minute: '2-digit', hour12: false },

        // 📌 장비 신청 일정만 가져오기
        events: function (fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: "/batirplan/erp/calendar/getEvents",
                method: "GET",
                data: { userId: emplCode },
                success: function(events) {
                    var filteredEvents = events.filter(event => event.category === "장비"); 
                    var formattedEvents = filteredEvents.map(event => ({
                        id: event.eventId,
                        title: event.eventTitle,
                        start: event.startTime,
                        end: event.endTime,
                        textColor: event.textColor,
                        backgroundColor: event.backgroundColor,
                        borderColor: event.borderColor
                    }));
                    successCallback(formattedEvents);
                },
                error: function() {
                    failureCallback([]);
                }
            });
        }
    });

    calendar.render();
    
    setTimeout(() => {
        document.querySelector('.fc-toolbar-title').style.marginLeft = '-130px'; // 값 조정 가능
    }, 100);

    
});
</script>

</body>
</html>
