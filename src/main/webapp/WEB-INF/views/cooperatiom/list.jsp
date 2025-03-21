<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@include file="../module/head.jsp" %>
<style>
#mytable td {
  color: black !important;
}
</style>

<body class="link-sidebar">
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
                        <h4 class="mb-4 mb-sm-0 card-title">협력업체 목록</h4>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <!-- 검색 필터 폼 -->
                        <form action="/batirplan/cooperatiom/list" method="get" class="d-flex mb-4 justify-content-end">
                            <input type="text" name="ccpyNm" class="form-control w-25" placeholder="업체명" value="${ccpyNm}">
                            <input type="text" name="bizrno" class="form-control w-25 ms-2" placeholder="사업자등록번호" value="${bizrno}">
                            <select name="ccpyCl" class="form-select w-25 ms-2">
                                <option value="">전체</option>
                                <option value="01" <c:if test="${ccpyCl == '01'}">selected</c:if>>용역</option>
                                <option value="02" <c:if test="${ccpyCl == '02'}">selected</c:if>>자재</option>
                            </select>
                            <button type="submit" class="btn btn-primary ms-2">검색</button>
                        </form>

                        <!-- 데이터 테이블 -->
                        <div class="table-responsive mb-4 border rounded-1">
						    <table id="mytable" class="table table-sm text-nowrap mb-0 align-middle">
						        <thead class="text-dark fs-6">
						            <tr>
						                <th style="width: 10%;"><h6 class="fs-4 fw-semibold mb-0">협력업체 코드</h6></th>
						                <th style="width: 15%;"><h6 class="fs-4 fw-semibold mb-0">협력업체명</h6></th>
						                <th style="width: 15%;"><h6 class="fs-4 fw-semibold mb-0">사업자등록번호</h6></th>
						                <th style="width: 15%;"><h6 class="fs-4 fw-semibold mb-0">전화번호</h6></th>
						                <th style="width: 20%;"><h6 class="fs-4 fw-semibold mb-0">이메일</h6></th>
						                <th style="width: 25%;"><h6 class="fs-4 fw-semibold mb-0">주소</h6></th>
						                <th style="width: 10%;"><h6 class="fs-4 fw-semibold mb-0">업체 분류</h6></th>
						            </tr>
						        </thead>
						        <tbody>
						            <c:forEach var="cooperation" items="${list}">
						                <tr>
						                    <td class="fs-4">${cooperation.ccpyCode}</td>
						                    <td class="text-start fs-4">${cooperation.ccpyNm}</td>
						                    <td class="fs-4">${cooperation.bizrno}</td>
						                    <td class="fs-4">${cooperation.ccpyTelno}</td>
						                    <td class="fs-4 text-truncate" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						                        ${cooperation.ccpyEmail}
						                    </td>
						                    <td class="fs-4" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
						                        <c:choose>
						                            <c:when test="${fn:length(cooperation.ccpyAdres) > 11}">
						                                <span title="${cooperation.ccpyAdres}">${fn:substring(cooperation.ccpyAdres, 0, 11)}...</span>
						                            </c:when>
						                            <c:otherwise>
						                                ${cooperation.ccpyAdres}
						                            </c:otherwise>
						                        </c:choose>
						                    </td>
						                    <td class="fs-4">
						                        <c:choose>
						                            <c:when test="${cooperation.ccpyCl == '01'}">용역</c:when>
						                            <c:when test="${cooperation.ccpyCl == '02'}">자재</c:when>
						                            <c:otherwise>기타</c:otherwise>
						                        </c:choose>
						                    </td>
						                </tr>
						            </c:forEach>
						        </tbody>
						    </table>
						</div>

                        <!-- 하단 버튼 및 페이지네이션 -->
                        <div class="d-flex justify-content-between align-items-center mt-3">
                            <!-- '신규' 버튼 (왼쪽 정렬) -->
                            <a href="/batirplan/cooperatiom/register" class="btn btn-primary">신규</a>

                            <!-- 페이지네이션 (가운데 정렬) -->
                            <div class="flex-grow-1 d-flex justify-content-center">
                                <nav>
                                    <ul class="pagination mb-0">
                                        <!-- 처음 페이지 -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=1&ccpyNm=${ccpyNm}&bizrno=${bizrno}&ccpyCl=${ccpyCl}">처음</a>
                                        </li>

                                        <!-- 이전 페이지 -->
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage - 1}&ccpyNm=${ccpyNm}&bizrno=${bizrno}&ccpyCl=${ccpyCl}">이전</a>
                                        </li>

                                        <!-- 페이지 번호 -->
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}&ccpyNm=${ccpyNm}&bizrno=${bizrno}&ccpyCl=${ccpyCl}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- 다음 페이지 -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${currentPage + 1}&ccpyNm=${ccpyNm}&bizrno=${bizrno}&ccpyCl=${ccpyCl}">다음</a>
                                        </li>

                                        <!-- 마지막 페이지 -->
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?page=${totalPages}&ccpyNm=${ccpyNm}&bizrno=${bizrno}&ccpyCl=${ccpyCl}">마지막</a>
                                        </li>
                                    </ul>
                                </nav>
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

</body>
</html>