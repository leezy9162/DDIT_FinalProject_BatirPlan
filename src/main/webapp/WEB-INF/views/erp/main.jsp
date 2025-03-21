<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
  
<body class="link-sidebar">
  <%@include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper" >
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
    <%@include file="../module/navBar.jsp" %>
	<div class="body-wrapper">
	    <div class="container-fluid">
			<div class="row">
			    <!-- 좌측: 웰컴 카드 -->
				<!-- 웰컴 카드 & 이미지 카드 한 줄 배치 -->
				<div class="row d-flex align-items-stretch">
				    <!-- 웰컴 카드 -->
				    <div class="col-lg-6 d-flex">
				        <div class="card text-bg-primary flex-fill">
				            <div class="card-body d-flex flex-column">
				                <div class="row">
				                    <div class="col-sm-7">
				                        <div class="d-flex flex-column h-100">
				                            <div class="hstack gap-3">
				                                <span class="d-flex align-items-center justify-content-center round-48 bg-white rounded flex-shrink-0">
				                                    <iconify-icon icon="solar:course-up-outline" class="fs-7 text-muted"></iconify-icon>
				                                </span>
				                                <sec:authentication property="principal.memberVO.empVO.emplNm" var="userName"/>
				                                <h5 class="text-white fs-6 mb-0 text-nowrap">
				                                    Welcome Back <br>${userName}
				                                </h5>
				                            </div>
				                            <div class="mt-4 flex-grow-1">
				                                <ul class="list-unstyled">
				                                    <li>
				                                        <a href="/batirplan/message/received" class="text-white text-decoration-none d-flex align-items-center mt-2">
				                                            ✉️ 읽지 않은 쪽지 <span id="unreadCount" class="badge bg-light text-dark ms-2">0건</span>
				                                        </a>
				                                    </li>
				                                    <li>
													    <a href="/batirplan/erp/electronicdocument/list" class="text-white text-decoration-none d-flex align-items-center mt-2">
													        📝 전자문서 <span id="documentCount" class="badge bg-light text-dark ms-2">0건</span>
													    </a>
													</li>
				                                </ul>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="col-sm-5 text-center text-md-end">
				                        <img src="/assets/images/backgrounds/welcome-bg.png" alt="welcome" class="img-fluid mb-n7 mt-2" style="max-height: 180px;">
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>

				    <!-- 이미지 카드 -->
				    <div class="col-lg-6 d-flex">
				        <div class="row w-100">
				            <div class="col-md-6 d-flex">
				                <div class="card overflow-hidden shadow-none flex-fill">
				                    <div class="card-body p-0 h-100 d-flex align-items-center">
				                        <img src="/assets/images/logo.png" class="d-block w-100" alt="Static Image"
				                             style="height: 100%; object-fit: cover;">
				                    </div>
				                </div>
				            </div>
				            <div class="col-md-6 d-flex">
				                <div class="card overflow-hidden shadow-none flex-fill">
				                    <div id="imageSlider" class="carousel slide h-100 d-flex align-items-center"
				                         data-bs-ride="carousel" data-bs-interval="2000">
				                        <div class="carousel-inner h-100">
				                            <div class="carousel-item active h-100">
				                                <img src="/assets/images/main1.jpg" class="d-block w-100" alt="Slide 1"
				                                     style="height: 100%; object-fit: cover;">
				                            </div>
				                            <div class="carousel-item h-100">
				                                <img src="/assets/images/main2.jpg" class="d-block w-100" alt="Slide 2"
				                                     style="height: 100%; object-fit: cover;">
				                            </div>
				                        </div>
				                    </div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>

			<!-- 공지사항 & 전자결재 한 줄 배치 (여백 조정) -->
			<div class="row mt-4 d-flex align-items-stretch">
			    <!-- 공지사항 -->
				<!-- 공지사항 -->
				    <div class="col-lg-6 d-flex">
				        <div class="card flex-fill">
				            <div class="card-body d-flex flex-column">
				                <h5 class="card-title"><span>📢</span> 최근 공지사항</h5>
				                <div class="table-responsive flex-grow-1">
				                    <table class="table table-hover mt-3">
				                        <thead class="table-dark">
				                            <tr>
				                                <th class="text-white text-center">번호</th>
				                                <th class="text-white text-center">제목</th>
				                                <th class="text-white text-center">작성일</th>
				                            </tr>
				                        </thead>
				                        <tbody id="notice-list" class="text-center"></tbody> <!-- 🔹 행 가운데 정렬 -->
				                    </table>
				                </div>
				            </div>
				        </div>
				    </div>

			    <!-- 전자결재 (공지사항과 높이 맞춤) -->
			    <div class="col-lg-6 d-flex">
			        <div class="card flex-fill">
			            <div class="card-body d-flex flex-column">
			                <h5 class="card-title"><span>📝</span> 전자결재 목록</h5>
			                <div class="table-responsive flex-grow-1">
			                    <table class="table table-hover mt-3">
			                        <thead class="table-dark">
			                            <tr>
			                                <th class="text-white text-center">제목</th>
			                                <th class="text-white text-center">기안일</th>
			                                <th class="text-white text-center">상태</th>
			                                <th class="text-white text-center">역할</th>
			                            </tr>
			                        </thead>
			                        <tbody id="approval-list"></tbody>
			                    </table>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>


	                <!-- 🔹 전자결재 카드 (캘린더 아래 배치) -->
	                <div class="card mt-4">
						<div class="col-lg-12">
					              <div class="card w-100" style="padding: 20px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
					                <div class="card-body">
					                  <h5 class="card-title">📅 프로젝트 캘린더</h5>
					                  <div id="dashboardCalendar" style="height: 500px;"></div>
					                </div>
					              </div>
					            </div>
					          </div>
					        </div> <!-- container-fluid 끝 -->
					      </div> <!-- body-wrapper 끝 -->
					    </div> <!-- page-wrapper 끝 -->
	                </div>
	            </div>
	        </div> <!-- row 끝 -->
			
			

			      <!-- -------------------------------------------- -->
			      <!-- Projects -->
			      <!-- -------------------------------------------- -->
			      <div class="col-md-6">
			        
			      </div>
			    </div>
			  </div>
			</div>
	    </div> <!-- container-fluid 끝 -->
	</div> <!-- body-wrapper 끝 -->
		  <!-- 작업 영역 Start -->
		  <sec:authentication property="principal.memberVO" var="mem"/>
		  <sec:authentication property="principal.memberVO.empVO" var="empl"/>

		  <!-- 작업 영역 End -->
		  </div>
	    </div>
    </div>
    </div>
  <%@include file="../module/footerScript.jsp" %>
  <!-- 📌 공지사항 & 전자결재 불러오기 JS -->
  <script>
      document.addEventListener("DOMContentLoaded", function() {
          console.log("📌 [INFO] 페이지 로드 완료, 데이터 가져오기 시작");

          // 📌 공지사항 불러오기
          fetch('/api/notices/recent') 
              .then(response => response.json())
              .then(data => {
                  console.log("📌 공지사항 API 응답:", data); // ✅ 공지사항 데이터 확인

                  let noticeList = document.getElementById("notice-list");
                  if (!noticeList) {
                      console.error("❌ 공지사항 리스트 요소를 찾을 수 없습니다!");
                      return;
                  }
                  noticeList.innerHTML = "";

                  if (!data || data.length === 0) {
                      noticeList.innerHTML = "<tr><td class='text-muted'>📢 최근 공지사항이 없습니다.</td></tr>";
                      return;
                  }
				  data.forEach((notice, index) => {
				      let tr = document.createElement("tr");

				      // 🔹 번호
				      let tdNo = document.createElement("td");
				      tdNo.innerText = notice.bbscttNo; // 공지사항 번호 추가
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
				          let formattedDate = date.toISOString().split("T")[0]; // YYYY-MM-DD 형식
				          tdDate.innerText = formattedDate;
				      } else {
				          tdDate.innerText = "없음"; // 기본값 설정
				      }
				      tr.appendChild(tdDate);

				      // 🔹 테이블에 추가
				      noticeList.appendChild(tr);
				  });
              })
              .catch(error => console.error("❌ 공지사항 로딩 오류:", error));

          // 📌 전자결재 리스트 불러오기 (기안자, 결재자, 참조자 포함)
          fetch('/batirplan/main/electronicdocument/recent')
              .then(response => response.json())
              .then(data => {
                  console.log("📌 전자결재 API 응답:", data); // ✅ API 데이터 확인 (디버깅용)

                  let approvalList = document.getElementById("approval-list");
                  if (!approvalList) {
                      console.error("❌ 전자결재 리스트 요소를 찾을 수 없습니다!");
                      return;
                  }
                  approvalList.innerHTML = "";

                  if (!data || data.length === 0) {
                      approvalList.innerHTML = "<tr><td colspan='4' class='text-muted'>📌 조회된 문서가 없습니다.</td></tr>";
                      return;
                  }

				  data.forEach(doc => {
				      console.log("📄 문서 데이터:", doc);  

				      let tr = document.createElement("tr");

				      // 🔹 제목 (클릭 시 상세 페이지 이동)
				      let tdTitle = document.createElement("td");
				      let a = document.createElement("a");
				      a.href = "/batirplan/erp/electronicdocument/list?docNo=" + doc.DOCNO;
				      a.classList.add("text-decoration-none", "text-dark");

				      // 🔹 제목 길이 제한 (10자 이상이면 ... 처리)
				      let maxLength =10; // 원하는 최대 길이 (예: 20자)
				      let fullTitle = doc.TITLE || "제목 없음";
				      let displayTitle = fullTitle.length > maxLength ? fullTitle.substring(0, maxLength) + "..." : fullTitle;

				      a.innerText = displayTitle;
				      a.title = fullTitle; // 마우스 오버 시 전체 제목 표시

				      tdTitle.appendChild(a);
				      tr.appendChild(tdTitle);
                      // 🔹 기안일 (YYYY-MM-DD 포맷으로 변환)
                      let tdDate = document.createElement("td");
                      if (doc.DRAFTDATE && typeof doc.DRAFTDATE === "string" && doc.DRAFTDATE.length === 8) {
                          let formattedDate = `\${doc.DRAFTDATE.substring(0, 4)}-\${doc.DRAFTDATE.substring(4, 6)}-\${doc.DRAFTDATE.substring(6, 8)}`;
                          tdDate.innerText = formattedDate;
                      } else {
                          console.warn("⚠️ 기안일 없음 또는 포맷 오류:", doc.DRAFTDATE);
                          tdDate.innerText = "없음"; // ✅ 기본값 설정
                      }

                      // 🔹 상태
  					let tdStatus = document.createElement("td");
  					            if (doc.STATUS === "01") {
  					                tdStatus.innerText = "기안 중";
  					            } else if (doc.STATUS === "02") {
  					                tdStatus.innerText = "진행 중";
  					            } else if (doc.STATUS === "03") {
  					                tdStatus.innerText = "반려";
  					            } else {
  					                tdStatus.innerText = "완료";
  					            }	

  						// 🔹 역할 (기안자 / 결재자 변환)
  						let tdRole = document.createElement("td");
  								   if (doc.USERROLE === "기안자") {
  								         tdRole.innerText = "기안자";
  								    } else if (doc.USERROLE === "결재자") {
  								           tdRole.innerText = "결재자";
  								    } else {
  								         tdRole.innerText = "참조자"; // 그 외의 경우 대비
  								           }				

                      // 🔹 테이블에 추가 (올바르게 삽입되었는지 확인)
                      console.log("✅ 테이블 추가 - 기안일:", tdDate.innerText);
                      
                      tr.appendChild(tdTitle);
                      tr.appendChild(tdDate);
                      tr.appendChild(tdStatus);
                      tr.appendChild(tdRole);
                      approvalList.appendChild(tr);
                  });

                  console.log("✅ 최종적으로 테이블에 추가된 요소들:", approvalList.innerHTML);
              })
              .catch(error => console.error("❌ 전자결재 로딩 오류:", error));
     
      
      $.ajax({
          url: "/batirplan/message/unreadCount",
          type: "GET",
          success: function (count) {
              $("#unreadCount").text(count + "건");
          },
          error: function () {
              console.error("읽지 않은 쪽지 개수를 불러오는 데 실패했습니다.");
          }
      });
      
      $(document).ready(function () {
    	    $.ajax({
    	        url: "/batirplan/main/electronicdocument/count", // 📌 전자문서 개수 가져오는 API
    	        type: "GET",
    	        success: function (count) {
    	            $("#documentCount").text(count + "건"); // ✅ 개수 업데이트
    	        },
    	        error: function () {
    	            console.error("전자문서 개수를 불러오는 데 실패했습니다.");
    	        }
    	    });
    	});
      
      // 🔹 메인 페이지 캘린더 (전체 프로젝트 일정 가져오기)
      var calendarEl = document.getElementById('dashboardCalendar');
      if (calendarEl) {
          var calendar = new FullCalendar.Calendar(calendarEl, {
              locale: 'ko', 
              initialView: 'dayGridMonth',
              headerToolbar: {
                  left: 'prev,next today',
                  center: 'title',
                  right: ''
              },
              titleFormat: { year: 'numeric', month: 'long' },

              events: function (fetchInfo, successCallback, failureCallback) {
                  $.ajax({
                      url: "/batirplan/erp/calendar/getAllProjects", // ✅ 전체 프로젝트 일정 API 호출
                      method: "GET",
                      success: function (events) {
                          console.log("📌 전체 프로젝트 일정 데이터:", events);

                          let filteredEvents = events.filter(event => event.category === "프로젝트");

                          let formattedEvents = filteredEvents.map(event => ({
                              id: event.eventId,
                              title: event.eventTitle,
                              start: event.startTime,
                              end: event.endTime,
                              description: event.eventDescription,
                              backgroundColor: event.backgroundColor || '#007bff',
                              borderColor: event.borderColor || '#0056b3'
                          }));

                          console.log("📌 필터링된 프로젝트 일정:", formattedEvents);
                          successCallback(formattedEvents);
                      },
                      error: function () {
                          console.error("📌 캘린더 데이터를 불러오는 중 오류 발생!");
                      }
                  });
              }
          });

          calendar.render();
      } else {
          console.warn("⚠️ 캘린더를 표시할 요소를 찾을 수 없습니다.");
      }
  });
      
  </script>
</body>
</html>