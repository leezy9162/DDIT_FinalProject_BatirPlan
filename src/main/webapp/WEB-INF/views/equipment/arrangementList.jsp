<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
                        <h4 class="mb-4 mb-sm-0 card-title">장비배치 신청 목록</h4>
                    </div>
                </div>        

                <div class="card">
                    <div class="card-body">
                        <!-- 필터 버튼 & 검색 바 (한 줄로 정렬) -->
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <!-- 승인 상태 필터 버튼 (왼쪽 정렬) -->
							<div class="nav nav-tabs" role="tablist">
							    <button type="button" class="nav-link filter-btn ${empty approvalStatus ? 'active' : ''}" data-status="">전체</button>
							    <button type="button" class="nav-link filter-btn ${approvalStatus == 'D' ? 'active' : ''}" data-status="D">대기</button>
							    <button type="button" class="nav-link filter-btn ${approvalStatus == 'Y' ? 'active' : ''}" data-status="Y">승인</button>
							    <button type="button" class="nav-link filter-btn ${approvalStatus == 'N' ? 'active' : ''}" data-status="N">미승인</button>
							</div>

                            <!-- 검색 바 (오른쪽 정렬) -->
                            <form action="/batirplan/equipment/arrangement/list" method="get" class="d-flex">
                                <select name="searchType" class="form-control w-auto me-2">
                                    <option value="">검색 유형</option>
                                    <option value="project" ${searchType == 'project' ? 'selected' : ''}>프로젝트명</option>
                                    <option value="employee" ${searchType == 'employee' ? 'selected' : ''}>신청자</option>
                                    <option value="equipment" ${searchType == 'equipment' ? 'selected' : ''}>장비명</option>
                                </select>
                                <input type="text" name="searchKeyword" class="form-control w-50 me-2" placeholder="검색어 입력" value="${searchKeyword}">
                                <button type="submit" class="btn btn-primary">검색</button>
                            </form>
                        </div>

                        <!-- 데이터 테이블 -->
                        <div class="table-responsive mb-4 border rounded-1">
                            <table class="table text-nowrap mb-0 align-middle">
                                <thead class="text-dark fs-4">
                                    <tr>
                                        <th>신청번호</th>
                                        <th>프로젝트명</th>
                                        <th>신청자</th>
                                        <th>장비명</th>
                                        <th>대여 시작일</th>
                                        <th>대여 종료일</th>
                                        <th>신청일</th>
                                        <th>승인 여부</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="arrangement" items="${arrangementList}">
                                        <tr onclick="location.href='/batirplan/equipment/arrangement/detail/${arrangement.requestNo}'" style="cursor:pointer">
                                            <td>${arrangement.requestNo}</td>
                                            <td>${arrangement.prjctNm}</td>
                                            <td>${arrangement.emplNm}</td>
                                            <td>${arrangement.eqpmnNm}</td>
                                            <td><fmt:formatDate value="${arrangement.rentalStartDate}" pattern="yyyy-MM-dd" /></td>
                                            <td><fmt:formatDate value="${arrangement.rentalEndDate}" pattern="yyyy-MM-dd" /></td>
                                            <td><fmt:formatDate value="${arrangement.requestDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${arrangement.approvalStatus == 'Y'}">
                                                        <span class="badge bg-success">승인</span>
                                                    </c:when>
                                                    <c:when test="${arrangement.approvalStatus == 'D'}">
                                                        <span class="badge bg-warning text-dark">대기</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">미승인</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- 페이지네이션 -->
                        <div class="d-flex justify-content-center">
                            <ul class="pagination">
                                <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                                    <li class="page-item ${pageInfo.pageNum == i ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&searchType=${searchType}&searchKeyword=${searchKeyword}&approvalStatus=${approvalStatus}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="d-flex justify-content-start mt-3">
						    <a href="/batirplan/equipment/arrangement/request" class="btn btn-primary">신규</a>
						</div>
                        

                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<script>
    $(document).ready(function () {
        $(".filter-btn").click(function () {
            let status = $(this).data("status");
            let urlParams = new URLSearchParams(window.location.search);
            
            // 승인 상태 변경
            urlParams.set("approvalStatus", status);
            urlParams.set("page", 1); // 페이지 초기화

            // ✅ 검색어 삭제 (searchKeyword 파라미터 제거)
            urlParams.delete("searchKeyword");

            // ✅ 검색어 입력 필드 초기화
            $("input[name='searchKeyword']").val("");

            // ✅ URL 변경하여 필터 적용
            window.location.href = window.location.pathname + "?" + urlParams.toString();
        });
    });
</script>

</body>
</html>
