<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<body class="link-sidebar">
  <%@include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
      <%@include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">  
        	<div class="card card-body py-3">
            	<div class="row align-items-center">
                	<h4 class="mb-4 mb-sm-0 card-title">공지 사항</h4>
                </div>
			</div>
			
			<!-- 테이블 영역 시작  -->
			<div class="card">
				<div class="card-body">
				
				<!-- 검색 바 -->
				<form action="${pageContext.request.contextPath}/batirplan/notice/list" method="get" class="d-flex mb-4 justify-content-end">
                	<input type="text" name="title" class="form-control w-25" placeholder="제목으로 검색" value="${title}">
                	<button type="submit" class="btn btn-primary ms-2">검색</button>
              	</form>
				
				<!-- 데이터 테이블 -->
				<div class="table-responsive mb-4 border rounded-1">
					<table class="table text-nowrap mb-0 align-middle">
				  		<thead class="text-dark fs-4">
				    		<tr>
				      			<th>
				        			<h6 class="fs-4 fw-semibold mb-0">번호</h6>
			      				</th>
					      		<th>
				        			<h6 class="fs-4 fw-semibold mb-0">제목</h6>
				      			</th>
							    <th>
							      <h6 class="fs-4 fw-semibold mb-0">작성일</h6>
							    </th>
							    <th>
							      <h6 class="fs-4 fw-semibold mb-0">조회수</h6>
							    </th>
			    			</tr>
				  		</thead>
				  		<tbody>
				  			<c:forEach var="notice" items="${noticeList}" varStatus="status">
                      			<tr>
                          			<td>
                          				<div class="d-flex align-items-center">
							              	<span class="fw-normal">${notice.displayNo}</span>
							          	</div>
                          			</td>
                          			<td class="text-start">
                              			<a href="/batirplan/notice/detail/${notice.bbscttNo}" data-bbscttNo="${notice.bbscttNo}">
                                  			${notice.sj}
                              			</a>
                         			</td>
                          			<td>
                              			<fmt:formatDate value="${notice.writingDt}" pattern="yyyy/MM/dd" />
                          			</td>
                          			<td>
                          				${notice.rdCnt}
                          			</td>
                      			</tr>
                  			</c:forEach>
                  			
                  			
				  		<%-- <c:forEach var="inquiry" items="${pagingVO.dataList}">
									<tr>
							<td>
						 	<div class="d-flex align-items-center">
						       <span class="fw-normal">${inquiry.inqryNo}</span>
							</div>
						</td>
						 <td class="title-column">
						     <a href="${pageContext.request.contextPath}/batirplan/inquiry/read?inqryNo=${inquiry.inqryNo}">${inquiry.sj}</a>
						</td>
						<td class="type-column">
						    <c:choose>
						<c:when test="${inquiry.ty == 'TS'}">ERP 서비스 문의</c:when>
						<c:when test="${inquiry.ty == 'QA'}">계정문의</c:when>
						<c:otherwise>기타</c:otherwise>
						</c:choose>
						</td>
						<td>${inquiry.wrter}</td>
						<td>${inquiry.writngDt}</td>
						<td class="nowrap-column">
							<c:if test="${inquiry.answerStatus eq '답변완료' }">
						<span class="badge bg-primary-subtle text-primary">답변 완료</span>
						</c:if>
						<c:if test="${inquiry.answerStatus eq '답변대기' }">
						<span class="badge bg-success-subtle text-success">답변 대기</span>
						</c:if>
						    </td>
						</tr>
						</c:forEach> --%>
				    </tbody>
				  </table>
				  
				</div>				
				  <div class="d-flex justify-content-between align-items-center mt-3">
                  	<!--  '신규' 버튼 (왼쪽 정렬) -->
                	<c:if test="${pageContext.request.isUserInRole('ROLE_DEPT_MNGMT')}">
                  		<a href="/batirplan/notice/register" class="btn btn-primary">신규</a>
                	</c:if>

                	<!--  페이지네이션 (가운데 정렬) -->
                	<div class="flex-grow-1 d-flex justify-content-center">
                  	<nav>
                    <ul class="pagination mb-0">
                      <!-- 처음 페이지 -->
                      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                          <a class="page-link" href="?page=1&size=${pageSize}&title=${title}">처음</a>
                      </li>

                      <!-- 이전 페이지 -->
                      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                          <a class="page-link" href="?page=${currentPage - 1}&size=${pageSize}&title=${title}">이전</a>
                      </li>

                      <!-- 페이지 번호 -->
                      <c:forEach var="pageNum" begin="1" end="${searchTotalPages}">
                          <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                              <a class="page-link" href="?page=${pageNum}&size=${pageSize}&title=${title}">${pageNum}</a>
                          </li>
                      </c:forEach>

                      <!-- 다음 페이지 -->
                      <li class="page-item ${currentPage == searchTotalPages ? 'disabled' : ''}">
                          <a class="page-link" href="?page=${currentPage + 1}&size=${pageSize}&title=${title}">다음</a>
                      </li>

                      <!-- 마지막 페이지 -->
                      <li class="page-item ${currentPage == searchTotalPages ? 'disabled' : ''}">
                          <a class="page-link" href="?page=${searchTotalPages}&size=${pageSize}&title=${title}">마지막</a>
                      		</li>
                    	</ul>
                  	</nav>
                	</div>
              	  </div>
				
				
				
				
				
				
				</div>
			</div>
			
			
         <%--  <!-- 🔹 공지사항 목록 바 (공지사항 목록과 가로 길이 동일하게 조정) -->
          <div class="card w-100 notice-container">  
            <div class="card-body p-3">
              <div class="row align-items-center">
                <div class="col-12">
                  <div class="d-sm-flex align-items-center justify-content-between">
                    <h4 class="mb-0 card-title">공지사항 목록</h4>
                    <nav aria-label="breadcrumb">
                      <ol class="breadcrumb">
                        <li class="breadcrumb-item d-flex align-items-center">
                          <a class="text-muted text-decoration-none d-flex" href="./">
                            <iconify-icon icon="solar:home-2-line-duotone" class="fs-6"></iconify-icon>
                          </a>
                        </li>
                        <li class="breadcrumb-item" aria-current="page">
                          <span class="badge fw-medium fs-2 bg-primary-subtle text-primary">
                            Form Input Grid
                          </span>
                        </li>
                      </ol>
                    </nav>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="card w-100 notice-container mt-4">  
            <div class="card-body">

              <!-- 검색 폼 -->
              <form action="${pageContext.request.contextPath}/batirplan/notice/list" method="get" class="d-flex mb-4 justify-content-end">
                <input type="text" name="title" class="form-control w-25" placeholder="제목으로 검색" value="${title}">
                <button type="submit" class="btn btn-primary ms-2">검색</button>
              </form>

              <!-- 날짜 형식 변경을 위해 fmt 라이브러리 사용 -->
              <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

              <!-- 공지사항 목록 -->
              <table class="table table-striped text-center w-100">  <!-- ✅ 가로 크기 맞춤 -->
                <thead class="table-dark">
                  <tr>
                    <th>번호</th>
                    <th class="text-start">제목</th> <!-- 제목 좌측 정렬 -->
                    <th>작성일</th>
                    <th>조회수</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="notice" items="${noticeList}" varStatus="status">
                      <tr>
                          <td>${notice.displayNo}</td>

                          <td class="text-start">
                              <a href="/batirplan/notice/detail/${notice.bbscttNo}" data-bbscttNo="${notice.bbscttNo}">
                                  ${notice.sj}
                              </a>
                          </td>

                          <td>
                              <fmt:formatDate value="${notice.writingDt}" pattern="yyyy/MM/dd" />
                          </td>
                          <td>${notice.rdCnt}</td>
                      </tr>
                  </c:forEach>
                </tbody>
              </table>

              <div class="d-flex justify-content-between align-items-center mt-3">
                <!-- 📌 '신규' 버튼 (왼쪽 정렬) -->
                <c:if test="${pageContext.request.isUserInRole('ROLE_DEPT_MNGMT')}">
                  <a href="/batirplan/notice/register" class="btn btn-primary">신규</a>
                </c:if>

                <!-- 📌 페이지네이션 (가운데 정렬) -->
                <div class="flex-grow-1 d-flex justify-content-center">
                  <nav>
                    <ul class="pagination mb-0">
                      <!-- 처음 페이지 -->
                      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                          <a class="page-link" href="?page=1&size=${pageSize}&title=${title}">처음</a>
                      </li>

                      <!-- 이전 페이지 -->
                      <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                          <a class="page-link" href="?page=${currentPage - 1}&size=${pageSize}&title=${title}">이전</a>
                      </li>

                      <!-- 페이지 번호 -->
                      <c:forEach var="pageNum" begin="1" end="${searchTotalPages}">
                          <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                              <a class="page-link" href="?page=${pageNum}&size=${pageSize}&title=${title}">${pageNum}</a>
                          </li>
                      </c:forEach>

                      <!-- 다음 페이지 -->
                      <li class="page-item ${currentPage == searchTotalPages ? 'disabled' : ''}">
                          <a class="page-link" href="?page=${currentPage + 1}&size=${pageSize}&title=${title}">다음</a>
                      </li>

                      <!-- 마지막 페이지 -->
                      <li class="page-item ${currentPage == searchTotalPages ? 'disabled' : ''}">
                          <a class="page-link" href="?page=${searchTotalPages}&size=${pageSize}&title=${title}">마지막</a>
                      </li>
                    </ul>
                  </nav>
                </div> --%>
              </div>

            </div>
          </div> <!-- ✅ 카드 닫는 태그 -->
          
        </div>
      </div>
    </div>
  </div>
  <%@include file="../module/footerScript.jsp" %>
</body>
</html>
