<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
 
<style>
    .card {
        display: flex;
        flex-direction: column;
    }
    .card-body {
        flex-grow: 1;
    }
</style> 
 
<body class="link-sidebar">
  <%@include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper" >
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
    <%@include file="../module/navBar.jsp" %>
	    <div class="body-wrapper">
	      <div class="container-fluid">
	      
	      <style>
			.fc-customFilters-button {
			    background: none !important;
			    border: none !important;
			    box-shadow: none !important;
			    padding: 0 !important;
			}
		  </style>
	      
	      <div class="container">
		  <!-- 작업 영역 Start -->
          <div class="card card-body py-3">
               <div class="row align-items-center">
                   <h4 class="mb-4 mb-sm-0 card-title">내 정보 관리</h4>
               </div>
          </div>
          </div>
          
          <div class="container">
          <div class="row">
          	<div class="col-md-4">
          		<div class="card h-100">
          			<div class="card-body text-center">
					  <sec:authentication property="principal.memberVO.empVO.proflImageCours" var="profileImg" />
	                  <sec:authentication property="principal.memberVO.empVO.emplNm" var="emplName" />
	                  <sec:authentication property="principal.memberVO.empVO.deptCode" var="deptCode" />
	                  <sec:authentication property="principal.memberVO.empVO.clsfCode" var="clsfCode" />
	                  
	                  <img src="${empty profileImg ? pageContext.request.contextPath + '/assets/images/profile/user-1.jpg' : profileImg}" 
				       alt="프로필 이미지" class="img-fluid rounded-circle mb-3"
				       onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile/user-1.jpg';">
	                  
	                  <h5>${emplName}</h5>
	                  
	                  <c:choose>
	                  	<c:when test="${deptCode eq '01'}">
	                  		🏢 경영지원
	                  	</c:when>
	                  	<c:when test="${deptCode eq '02'}">
	                  		🏗️ 건축기획
	                  	</c:when>
	                  	<c:when test="${deptCode eq '03'}">
	                  		🏦 재무
	                  	</c:when>
	                  	<c:when test="${deptCode eq '04'}">
	                  		🌱 자원
	                  	</c:when>
	                  	<c:when test="${deptCode eq '05'}">
	                  		💻 IT
	                  	</c:when>
						<c:otherwise>
							소속된 부서가 없습니다.
						</c:otherwise>
	                  </c:choose>
	                  
	                  <c:choose>
	                  	<c:when test="${clsfCode eq '01'}">
	                  		사원
	                  	</c:when>
	                  	<c:when test="${clsfCode eq '02'}">
	                  		대리
	                  	</c:when>
	                  	<c:when test="${clsfCode eq '03'}">
	                  		과장
	                  	</c:when>
	                  	<c:when test="${clsfCode eq '04'}">
	                  		차장
	                  	</c:when>
	                  	<c:when test="${clsfCode eq '05'}">
	                  		부장
	                  	</c:when>
						<c:otherwise>
							부여된 직급이 없습니다.
						</c:otherwise>
	                  </c:choose>
          			</div>
          		</div>
          	</div>
          	<div class="col-md-8">
          		<div class="card h-100 d-flex flex-column">
          			<div class="card-body d-flex flex-column">
          				          			<!-- 나머지 정보가 뿌려질 영역 -->
          			  <sec:authentication property="principal.memberVO.empVO.emplCode" var="emplCode" />
          			  <sec:authentication property="principal.memberVO.empVO.brthdy" var="birthDate" />
	                  <sec:authentication property="principal.memberVO.empVO.email" var="email" />
	                  <sec:authentication property="principal.memberVO.empVO.mbtlnum" var="phone" />
	                  <sec:authentication property="principal.memberVO.empVO.zip" var="zip" />
	                  <sec:authentication property="principal.memberVO.empVO.adres" var="address" />
	                  <sec:authentication property="principal.memberVO.empVO.detailadres" var="detailAddress" />
	                  <sec:authentication property="principal.memberVO.empVO.bankCode" var="bankCode" />
	                  <sec:authentication property="principal.memberVO.empVO.acnutno" var="accountNumber" />
	                  
	                  <h6 ><i class="ti ti-id text-dark fs-6"></i> ${emplCode}</h6>
	                  <h6 class="mt-3">
					      <i class="ti ti-cake text-dark fs-6"></i>
					      <fmt:parseDate var="formattedBirthDate" value="${birthDate}" pattern="yyyyMMdd" />
					      <fmt:formatDate value="${formattedBirthDate}" pattern="yyyy-MM-dd" />
					  </h6>
	                  <h6 class="mt-3"><i class="ti ti-mail text-dark fs-6"></i> ${email}</h6>
	                  
	                  <c:set var="rawPhone" value="${phone}" />
			          <c:set var="formattedPhone" value="${fnc:substring(rawPhone, 0, 3)}-${fnc:substring(rawPhone, 3, 7)}-${fnc:substring(rawPhone, 7, 11)}" />
					  <h6 class="mt-3"><i class="ti ti-phone text-dark fs-6"></i> ${formattedPhone}</h6>
	                  
	                  <h6 class="mt-3"><i class="ti ti-map-pin text-dark fs-6"></i> ${zip} ${address} ${detailAddress}</h6>
					  <h6 class="mt-3">
					      <i class="ti ti-cash text-dark fs-6"></i>
					      <span id="currentBankCode">(
					        <c:choose>
					          <c:when test="${bankCode eq '001'}">한국은행</c:when>
					          <c:when test="${bankCode eq '002'}">산업은행</c:when>
					          <c:when test="${bankCode eq '003'}">기업은행</c:when>
					          <c:when test="${bankCode eq '004'}">국민은행</c:when>
					          <c:when test="${bankCode eq '011'}">농협은행</c:when>
					          <c:when test="${bankCode eq '020'}">우리은행</c:when>
					          <c:when test="${bankCode eq '031'}">대구은행</c:when>
					          <c:when test="${bankCode eq '032'}">부산은행</c:when>
					          <c:when test="${bankCode eq '034'}">광주은행</c:when>
					          <c:when test="${bankCode eq '035'}">제주은행</c:when>
					          <c:when test="${bankCode eq '037'}">전북은행</c:when>
					          <c:when test="${bankCode eq '039'}">경남은행</c:when>
					          <c:when test="${bankCode eq '045'}">새마을금고중앙회</c:when>
					          <c:when test="${bankCode eq '048'}">신협중앙회</c:when>
					          <c:when test="${bankCode eq '081'}">KEB하나은행</c:when>
					          <c:when test="${bankCode eq '088'}">신한은행</c:when>
					          <c:when test="${bankCode eq '089'}">케이뱅크</c:when>
					          <c:when test="${bankCode eq '090'}">카카오뱅크</c:when>
					          <c:when test="${bankCode eq '092'}">토스뱅크</c:when>
					          <c:otherwise>미등록</c:otherwise>
					        </c:choose>
					      )</span>
					      <span id="currentAccountNumber">${accountNumber}</span>
					  </h6>
          				<!-- <div class="text-end">
          					<button class="btn btn-primary">비밀번호 변경</button>
          					<button class="btn btn-primary" onclick="toggleAccountModal()">계좌번호 변경</button>
          				</div> -->
          				 <div class="mt-auto text-end">
                <button class="btn btn-primary">비밀번호 변경</button>
                <button class="btn btn-primary" onclick="toggleAccountModal()">계좌번호 변경</button>
            </div>
          				
          				
          				<div id="accountChangeSection" style="display: none; margin-top: 15px; padding: 15px; border: 1px solid #ccc; border-radius: 5px;">
						    <h4>계좌 변경</h4>
						
							<label for="bankSelect">은행 선택:</label>
							<select id="bankSelect" class="form-control">
							    <option value="001">한국은행</option>
							    <option value="002">산업은행</option>
							    <option value="003">기업은행</option>
							    <option value="004">국민은행</option>
							    <option value="011">농협은행</option>
							    <option value="020">우리은행</option>
							    <option value="031">대구은행</option>
							    <option value="032">부산은행</option>
							    <option value="034">광주은행</option>
							    <option value="035">제주은행</option>
							    <option value="037">전북은행</option>
							    <option value="039">경남은행</option>
							    <option value="045">새마을금고중앙회</option>
							    <option value="048">신협중앙회</option>
							    <option value="081">KEB하나은행</option>
							    <option value="088">신한은행</option>
							    <option value="089">케이뱅크</option>
							    <option value="090">카카오뱅크</option>
							    <option value="092">토스뱅크</option>
							</select>
						
						    <label for="accountNumber" style="margin-top: 10px;">계좌번호:</label>
						    <input type="text" id="accountNumber" class="form-control" placeholder="계좌번호 입력">
						
						   	            
          			</div>
          		</div>
          	</div>
          </div>
          </div>
          </div>
          
          
                    <div class="container mt-5">
          	<div class="card">
          	 	<div class="card-body d-flex">
          	 	          	            <div class="container">
			
			    <div id="calendar"></div>
          	 	
          	 	</div>
          	 </div>
			</div>
          </div>
          </div>
          
          </div>
     </div>     
          
          </div>
          


          
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.3/main.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 📌 일정 추가/수정 모달 -->
<div class="modal fade" id="eventModal" tabindex="-1" aria-labelledby="eventModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="eventModalLabel">일정 추가</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="eventForm">
          <input type="hidden" id="eventId">
          
          <!-- 제목 -->
          <div class="mb-3">
            <label for="eventTitle" class="form-label">제목</label>
            <input type="text" class="form-control" id="eventTitle" required>
          </div>
          
          <!-- 설명 (세로 넓이 늘림) -->
          <div class="mb-3">
            <label for="eventDescription" class="form-label">설명</label>
            <textarea class="form-control" id="eventDescription" rows="3"></textarea>
          </div>
          
          <!-- 시작일과 종료일 (한 줄에 배치) -->
          <div class="row mb-3">
            <div class="col-md-6">
              <label for="startTime" class="form-label">시작 일자</label>
              <input type="date" class="form-control" id="startTime" required>
            </div>
            <div class="col-md-6">
              <label for="endTime" class="form-label">종료 일자</label>
              <input type="date" class="form-control" id="endTime" required>
            </div>
          </div>
          
          <!-- 카테고리 -->
          <div class="mb-3">
            <label for="category" class="form-label">카테고리</label>
            <select id="category" class="form-control">
              <option value="프로젝트">프로젝트</option>
              <option value="결재">결재</option>
              <option value="공정">공정</option>
              <option value="ALL">전체</option>
            </select>
          </div>
          
          <!-- 상태 -->
          <div class="mb-3">
            <label for="eventStatus" class="form-label">상태</label>
            <select id="eventStatus" class="form-control">
              <option value="01">진행중</option>
              <option value="02">마감</option>
            </select>
          </div>
          
          <!-- 글자 색상, 배경 색상, 테두리 색상 (한 줄에 배치) -->
          <div class="row mb-3">
            <div class="col-md-4">
              <label for="textColor" class="form-label">글자 색상</label>
              <input type="color" class="form-control form-control-color" id="textColor" value="#0a0909">
            </div>
            <div class="col-md-4">
              <label for="backgroundColor" class="form-label">배경 색상</label>
              <input type="color" class="form-control form-control-color" id="backgroundColor" value="#FF0000">
            </div>
            <div class="col-md-4">
              <label for="borderColor" class="form-label">테두리 색상</label>
              <input type="color" class="form-control form-control-color" id="borderColor" value="#3788d8">
            </div>
          </div>
          
          <button type="button" class="btn btn-primary" id="saveEvent">저장</button>
          <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
        </form>
      </div>
    </div>
  </div>
</div>

  <%@include file="../module/footerScript.jsp" %>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');
    var selectedCategory = "ALL"; // 기본값: 전체 보기
    
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	locale: 'ko',
        initialView: 'dayGridMonth',
        selectable: true,
        editable: true,
        eventTimeFormat: {
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        },
        
        headerToolbar: {
            left: 'customFilters',
            center: 'title',
            right: 'today prev,next'
        },

        titleFormat: { // 📌 제목을 "2025년 7월" 형식으로 변경
            year: 'numeric',
            month: 'long'
        },

        // 📌 커스텀 버튼 추가 (필터 버튼 자리)
        customButtons: {
            customFilters: {
                text: '',
                click: function () { }
            }
        },

        // 📌 일정 불러오기 (필터 적용)
        events: function (fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: "/batirplan/erp/calendar/getEvents",
                method: "GET",
                success: function (events) {
                    console.log("📌 받아온 이벤트 데이터:", events);

                    // 필터링
                    let filteredEvents = events.filter(event => {
                        return selectedCategory === "ALL" || event.category === selectedCategory;
                    });

                    // FullCalendar가 요구하는 속성명으로 변환 (start, end)
                    let formattedEvents = filteredEvents.map(event => ({
                        id: event.eventId,
                        title: event.eventTitle,
                        start: event.startTime,  // 기존 startTime 값을 start로 변경
                        end: event.endTime,      // 기존 endTime 값을 end로 변경
                        description: event.eventDescription,
                        category: event.category,
                        status: event.eventStatus,
                        textColor: event.textColor,
                        backgroundColor: event.backgroundColor,
                        borderColor: event.borderColor
                    }));

                    console.log("📌 포맷된 일정 데이터:", formattedEvents);
                    successCallback(formattedEvents);
                },
                error: function () {
                    console.error("📌 일정 데이터를 불러오는 중 오류 발생!");
                }
            });
        },

        // 📌 날짜 선택 시 모달 열기 (새 일정 추가)
        select: function (info) {
            $("#eventForm")[0].reset();
            $("#eventId").val('');
            $("#startTime").val(info.startStr);
            $("#endTime").val(info.endStr);
            $('#eventModal').modal('show');
        },

        // 📌 일정 클릭 시 모달 열기 (수정 가능)
        eventClick: function (info) {
            $("#eventId").val(info.event.id);
            $("#eventTitle").val(info.event.title);
            $("#eventDescription").val(info.event.extendedProps.description);
            $("#startTime").val(info.event.startStr);
            $("#endTime").val(info.event.endStr);
            $("#category").val(info.event.extendedProps.category);
            $("#eventStatus").val(info.event.extendedProps.status);
            $("#textColor").val(info.event.textColor);
            $("#backgroundColor").val(info.event.backgroundColor);
            $("#borderColor").val(info.event.borderColor);
            $('#eventModal').modal('show');
        },

        // 📌 일정 이동 (드래그)
        eventDrop: function (info) {
            updateEvent(info.event);
        },

        // 📌 일정 리사이즈
        eventResize: function (info) {
            updateEvent(info.event);
        }
    });

    calendar.render();
    
    $(".fc-customFilters-button").html(`
            <button class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn" data-category="ALL">전체</button>
            <button class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn" data-category="결재">결재</button>
            <button class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn" data-category="프로젝트">프로젝트</button>
            <button class="btn btn-rounded btn-outline-light text-dark me-2 filter-btn" data-category="공정">공정</button>
        `);
    

    // 📌 필터 버튼 클릭 시 카테고리 변경
    $(".filter-btn").on("click", function () {
        selectedCategory = $(this).data("category");
        calendar.refetchEvents();
    });

    // 📌 일정 저장 버튼 클릭
    $("#saveEvent").on("click", function () {
        let eventData = {
            eventId: $("#eventId").val(),
            eventTitle: $("#eventTitle").val(),
            eventDescription: $("#eventDescription").val(),
            startTime: $("#startTime").val(),
            endTime: $("#endTime").val(),
            category: $("#category").val(),
            eventStatus: $("#eventStatus").val(),
            textColor: $("#textColor").val(),
            backgroundColor: $("#backgroundColor").val(),
            borderColor: $("#borderColor").val()
        };

        let url = eventData.eventId ? "/batirplan/erp/calendar/updateEvent" : "/batirplan/erp/calendar/insertEvent";

        $.ajax({
            url: url,
            method: "POST",
            data: JSON.stringify(eventData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function () {
                calendar.refetchEvents();
                $('#eventModal').modal('hide');
            },
            error: function (xhr, status, error) {
                console.error("📌 일정 저장 오류:", error);
            }
        });
    });

    // 📌 일정 삭제 버튼 클릭
    $("#deleteEvent").on("click", function () {
	    let eventId = $("#eventId").val();
	
	    Swal.fire({
	        title: '일정을 삭제하시겠습니까?',
	        text: '삭제된 일정은 복구할 수 없습니다.',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            $.ajax({
	                url: "/batirplan/erp/calendar/deleteEvent",
	                method: "POST",
	                data: { eventId: eventId },
	                success: function () {
	                    calendar.refetchEvents();
	                    $('#eventModal').modal('hide');
	                    Swal.fire(
	                        '삭제 완료!',
	                        '일정이 성공적으로 삭제되었습니다.',
	                        'success'
	                    );
	                }
	            });
	        }
	    });
	});

    // 📌 일정 업데이트 (이동 및 리사이징)
    function updateEvent(event) {
        let eventData = {
            eventId: event.id,
            startTime: event.startStr,
            endTime: event.endStr
        };

        $.ajax({
            url: "/batirplan/erp/calendar/updateEvent",
            method: "POST",
            data: JSON.stringify(eventData),
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function () {
                calendar.refetchEvents();
            }
        });
    }
});
/* ✅ 계좌 관련 기능 */
function toggleAccountModal() {
    let section = document.getElementById("accountChangeSection");
    section.style.display = (section.style.display === "none") ? "block" : "none";
}

function validateAccount() {
    let accountNumber = document.getElementById("accountNumber").value.replace(/-/g, "");

    fetch("/batirplan/erp/account/validate", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ accountNumber })
    })
    .then(response => response.json())
    .then(data => {
        Swal.fire({
            icon: data.valid ? "success" : "error",
            title: data.valid ? "유효한 계좌번호" : "유효하지 않은 계좌번호",
            text: data.valid ? "입력하신 계좌번호는 유효합니다!" : "입력하신 계좌번호는 유효하지 않습니다!",
            confirmButtonText: "확인"
        });
    })
    .catch(error => {
        console.error("계좌 검증 오류:", error);
        Swal.fire({
            icon: "error",
            title: "오류 발생",
            text: "계좌 검증 중 오류가 발생했습니다.",
            confirmButtonText: "확인"
        });
    });
}

function updateAccount() {
    let bankCode = document.getElementById("bankSelect").value;
    let accountNumber = document.getElementById("accountNumber").value.replace(/-/g, "");

    fetch("/batirplan/erp/account/update", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ bankCode, accountNumber })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            Swal.fire({
                icon: "success",
                title: "변경 완료",
                text: "계좌 정보가 변경되었습니다.",
                confirmButtonText: "확인"
            }).then(() => {
                // 변경된 계좌 정보를 화면에 반영
                document.getElementById("currentBankCode").innerText = bankCode;
                document.getElementById("currentAccountNumber").innerText = accountNumber;

                toggleAccountModal(); // 변경 폼 닫기
            });
        } else {
            Swal.fire({
                icon: "error",
                title: "변경 실패",
                text: "계좌 정보 변경에 실패했습니다.",
                confirmButtonText: "확인"
            });
        }
    })
    .catch(error => {
        console.error("계좌 변경 오류:", error);
        Swal.fire({
            icon: "error",
            title: "오류 발생",
            text: "계좌 변경 중 오류가 발생했습니다.",
            confirmButtonText: "확인"
        });
    });
}
</script>

</body>
</html>