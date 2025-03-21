<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
  
<body class="link-sidebar">
	<%@include file="../module/commonTags.jsp" %>
	<div id="main-wrapper" class="main-wrapper" >
		<%@include file="../module/sideBarForCcpy.jsp" %>
		<div class="page-wrapper">
			<%@include file="../module/navBarForCcpy.jsp" %>
			<div class="body-wrapper">
				<div class="container-fluid">
				<!-- 작업 영역 Start -->
		  <sec:authentication property="principal.memberVO.ccpyVO" var="ccpy" />
	        <div class="row">
	            <!-- 📌 좌측 영역 (웰컴 카드 & 공지사항 & 이미지 카드) -->
	            <div class="col-lg-5">
	                <!-- 🔹 웰컴 카드 -->
	                <div class="card text-bg-primary">
	                    <div class="card-body">
	                        <div class="row">
	                            <div class="col-sm-7">
	                                <div class="d-flex flex-column h-100">
	                                    <div class="hstack gap-3">
	                                        <span class="d-flex align-items-center justify-content-center round-48 bg-white rounded flex-shrink-0">
	                                            <iconify-icon icon="solar:course-up-outline" class="fs-7 text-muted"></iconify-icon>
	                                        </span>
	                                        <h5 class="text-white fs-6 mb-0 text-nowrap">
	                                            Welcome Back <br> ${ccpy.ccpyNm }
	                                        </h5>
	                                    </div>
	                                    <hr>
											<ul>
											    <li>파트너십을 소중히 여기는 BâtirPlan</li>
											    <li>${ccpy.ccpyNm }님과 함께합니다.</li>
											</ul>
										</hr>
	                                    <!-- <div class="mt-4">
	                                        <ul class="list-unstyled">
	                                            <li>
	                                                <a href="/batirplan/notifications" class="text-white text-decoration-none d-flex align-items-center">
	                                                    📢 읽지 않은 알림 <span class="badge bg-light text-dark ms-2">5건</span>
	                                                </a>
	                                            </li>
	                                            <li>
	                                                <a href="/batirplan/messages" class="text-white text-decoration-none d-flex align-items-center mt-2">
	                                                    ✉️ 읽지 않은 쪽지 <span class="badge bg-light text-dark ms-2">2건</span>
	                                                </a>
	                                            </li>
	                                            <li>
	                                                <a href="/documents" class="text-white text-decoration-none d-flex align-items-center mt-2">
	                                                    📝 결재할 전자문서 <span class="badge bg-light text-dark ms-2">1건</span>
	                                                </a>
	                                            </li>
	                                        </ul>
	                                    </div> -->
	                                </div>
	                            </div>
	                            <div class="col-sm-5 text-center text-md-end">
	                                <img src="/assets/images/backgrounds/welcome-bg.png" alt="welcome" class="img-fluid mb-n7 mt-2" width="180">
	                            </div>
	                        </div>
	                    </div>
	                </div>

	                <!-- 📌 공지사항 카드 -->
	                <div class="card mt-4">
	                    <div class="card-body">
	                        <h5 class="card-title"><span>📢</span> 최근 공지사항</h5>
	                        <table class="table table-hover mt-3">
	                            <thead class="table-dark">
	                                <tr>
	                                    <th class="text-white text-center">번호</th>
		                                <th class="text-white text-center">제목</th>
		                                <th class="text-white text-center">작성일</th>
	                                </tr>
	                            </thead>
	                            <tbody id="notice-list">
	                                <!-- 공지사항 리스트가 동적으로 추가됨 -->
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	            </div> <!-- col-lg-5 끝 -->

	            <!-- 📌 우측 영역 (캘린더 + 전자결재) -->
	            <div class="col-lg-7 d-flex">
	               <!-- 🔹 캘린더 카드 -->
					<div class="card text-decoration-none w-100">
					    <div class="card-body d-flex align-items-center justify-content-center"
					         style="height: 650px !important; min-height: 650px !important;">
					        <div id="dashboardCalendar" style="width: 100%; height: 100%;"></div> 
					    </div>
					</div>
	            </div>
	        </div>
		  		<!-- 작업 영역 End -->
	  		</div>
  		</div>
	</div>
</div>
    
<%@include file="../module/footerScript.jsp" %>

<!-- FullCalendar 라이브러리 추가 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
	console.log("📌 [INFO] 공지사항 데이터 가져오기 시작");

	// 공지사항 불러오기
	fetch('/api/notices/recent')
		.then(response => response.json())
		.then(data => {
			console.log("📌 공지사항 API 응답:", data);

			let noticeList = document.getElementById("notice-list");
			if (!noticeList) {
				console.error("❌ 공지사항 리스트 요소를 찾을 수 없습니다!");
				return;
			}
			noticeList.innerHTML = "";

			if (!data || data.length === 0) {
				noticeList.innerHTML = "<tr><td colspan='3' class='text-muted text-center'>📢 최근 공지사항이 없습니다.</td></tr>";
				return;
			}

			data.forEach((notice, index) => {
				let tr = document.createElement("tr");

				// 🔹 번호
				let tdNo = document.createElement("td");
				tdNo.innerText = notice.bbscttNo;
				tdNo.classList.add("text-center");
				tr.appendChild(tdNo);

				// 🔹 제목
				let tdTitle = document.createElement("td");
				let a = document.createElement("a");
				a.href = "/batirplan/notice/detail/" + notice.bbscttNo;
				a.classList.add("text-decoration-none", "text-dark");
				a.innerText = notice.sj || "제목 없음";
				tdTitle.appendChild(a);
				tr.appendChild(tdTitle);

				// 🔹 작성일 (YYYY-MM-DD 포맷 변환)
				let tdDate = document.createElement("td");
				if (notice.writingDt) {
					let date = new Date(notice.writingDt);
					tdDate.innerText = date.toISOString().split("T")[0];
				} else {
					tdDate.innerText = "없음";
				}
				tr.appendChild(tdDate);

				// 🔹 테이블에 추가
				noticeList.appendChild(tr);
			});
		})
		.catch(error => console.error("❌ 공지사항 로딩 오류:", error));
});

document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('dashboardCalendar'); // 📌 캘린더 ID

    var calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko', // 한국어 설정
        initialView: 'dayGridMonth', // 월별 보기
        headerToolbar: {
            left: 'prev,next today', // 이전달, 다음달, 오늘 버튼 (필터 버튼 제거)
            center: 'title',
            right: '' 
        },
        titleFormat: { // "2025년 3월" 형식
            year: 'numeric',
            month: 'long'
        },
        events: function (fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: "/batirplan/erp/calendar/getEvents", // 📌 캘린더 데이터 가져오기
                method: "GET",
                success: function (events) {
                    console.log("📌 받아온 이벤트 데이터:", events);

                    // 📌 프로젝트 & 공정 일정만 필터링
                    let filteredEvents = events.filter(event => 
                        event.category === "프로젝트" || event.category === "공정"
                    );

                    let formattedEvents = filteredEvents.map(event => ({
                        id: event.eventId,
                        title: event.eventTitle,
                        start: event.startTime,
                        end: event.endTime,
                        description: event.eventDescription,
                        backgroundColor: event.backgroundColor || '#007bff', // 기본 색상 설정
                        borderColor: event.borderColor || '#0056b3'
                    }));

                    console.log("📌 필터링된 프로젝트 & 공정 일정:", formattedEvents);
                    successCallback(formattedEvents);
                },
                error: function () {
                    console.error("📌 캘린더 데이터를 불러오는 중 오류 발생!");
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