<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<body class="link-sidebar" style="overflow-x: hidden;">
    <%@include file="../module/commonTags.jsp" %>
    <div id="main-wrapper" class="main-wrapper">
        <%@include file="../module/sideBar.jsp" %>
        <div class="page-wrapper">
            <%@include file="../module/navBar.jsp" %>
            <div class="body-wrapper">
                <div class="container-fluid">
                	<!-- 작업 영역 Start -->
                    <div class="card card-body py-3">
                        <div class="row align-items-center">
                            <h4 class="mb-4 mb-sm-0 card-title">1:1 문의 게시판</h4>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-end align-items-center mb-3">
                                <form id="searchForm" action="${pageContext.request.contextPath}/batirplan/inquiry/list" method="GET" class="d-flex align-items-center" style="width: auto;">
                                    <input type="hidden" id="page" name="page">
                                    <select name="searchType" class="form-select me-2" style="width: 120px; min-width: 100px;">
                                        <option value="">--검색--</option>
                                        <option value="sj" ${searchType eq 'sj' ? 'selected' : ''}>제목</option>
                                        <option value="wrter" ${searchType eq 'wrter' ? 'selected' : ''}>작성자명</option>
                                        <option value="cn" ${searchType eq 'cn' ? 'selected' : ''}>내용</option>
                                    </select>
                                    <input type="text" class="form-control me-2" name="searchWord" placeholder="검색어를 입력하세요" value="${searchWord}" style="width: 180px; min-width: 150px;">
                                    <button class="btn btn-primary" type="submit" style="width: 80px;">검색</button>
                                </form>
                            </div>
                            <div class="table-responsive mb-4 border rounded-1">
								  <table class="table mb-0 align-middle">
								    <thead class="text-dark fs-4">
								      <tr>
								        <th style="white-space: nowrap;">
								          <h6 class="fs-4 fw-semibold mb-0">번호</h6>
								        </th>
								        <th>
								          <h6 class="fs-4 fw-semibold mb-0">제목</h6>
								        </th>
								        <th style="white-space: nowrap;">
								          <h6 class="fs-4 fw-semibold mb-0">작성자</h6>
								        </th>
								        <th>
								          <h6 class="fs-4 fw-semibold mb-0">작성일시</h6>
								        </th>
								        <th>
								          <h6 class="fs-4 fw-semibold mb-0">답변 상태</h6>
								        </th>
								      </tr>
								    </thead>
								    <tbody>
								    <c:forEach var="inquiry" items="${pagingVO.dataList}">
								        <tr>
								        	<td>
									        	<div class="d-flex align-items-center">
									              <span class="fw-normal">${inquiry.inqryNo}</span>
									          	</div>
								          	</td>
								            <td class="title-column">
								            	[
								            	<c:choose>
								                    <c:when test="${inquiry.ty == 'TS'}">ERP 서비스 문의</c:when>
								                    <c:when test="${inquiry.ty == 'QA'}">계정문의</c:when>
								                    <c:otherwise>기타</c:otherwise>
								                </c:choose>
								            	]
								            
								                <a href="${pageContext.request.contextPath}/batirplan/inquiry/read?inqryNo=${inquiry.inqryNo}">${inquiry.sj}</a>
								            </td>
								            <td>${inquiry.wrter}</td>
								            <td>
								            	${inquiry.writngDt}
								            </td>
								            <td class="nowrap-column">
								            	<c:if test="${inquiry.answerStatus eq '답변완료' }">
								            		<span class="badge bg-primary-subtle text-primary">답변 완료</span>
								            	</c:if>
								            	<c:if test="${inquiry.answerStatus eq '답변대기' }">
								            		<span class="badge bg-success-subtle text-success">답변 대기</span>
								            	</c:if>
								            </td>
								        </tr>
								    </c:forEach>
								    </tbody>
								  </table>
								</div>
                            <div id="pagingArea" class="d-flex justify-content-center mt-4">
                                <nav aria-label="Page navigation">
                                    ${pagingVO.pagingHTML}
                                </nav>
                            </div>
                            <div class="mt-3">
                                <sec:authorize access="(hasRole('ROLE_EMPL') or hasRole('ROLE_CCPY')) and !hasRole('ROLE_DEPT_IT')">
                                    <a href="/batirplan/inquiry/register" class="btn btn-success">신규</a>
                                </sec:authorize>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
    <%@include file="../module/footerScript.jsp" %>
</body>
<script type="text/javascript">
$(function(){
	let pagingArea = $("#pagingArea");
	let searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		let pageNo = $(this).data("page");	// 페이지 번호
		// 검색 영역 안에 들어있는 form을 활용해서 서버 전달
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});
</script>
</html>
