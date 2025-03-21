<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@include file="../module/head.jsp" %>

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
                        <h4 class="mb-4 mb-sm-0 card-title">장비 목록</h4>
                    </div>
                </div>

                <!-- 데이터 테이블 -->
                <div class="card">
                    <div class="card-body">

                        <!-- ✅ 검색 필터 (테이블 우측 정렬) -->
                        <div class="d-flex justify-content-end mb-3">
						    <form action="/batirplan/equipment/list" method="get" class="d-flex align-items-center" onsubmit="resetSearchInput()">
						        <input type="text" id="searchInput" class="form-control me-2" style="width: 230px; height: 40px;" 
						            name="keyword" placeholder="검색어 입력">
						        <button type="submit" class="btn btn-primary" style="height: 40px;">검색</button>
						    </form>
						</div>

                        <div class="table-responsive mb-4 border rounded-1">
                            <table class="table text-nowrap mb-0 align-middle">
                                <thead class="text-dark fs-4 text-center">
                                    <tr>
                                        <th style="width: 8%; color: black;">장비 번호</th>
                                        <th style="width: 15%; color: black;" class="text-start">장비 명</th>
                                        <th style="width: 12%; color: black;">장비 유형</th>
                                        <th style="width: 15%; color: black;">일련번호</th>
                                        <th style="width: 12%; color: black;">제조사</th>
                                        <th style="width: 10%; color: black;">구매일자</th>
                                        <th style="width: 8%; color: black;">상태</th>
                                        <th style="width: 10%; color: black;">관리</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center" style="color: black;">
                                    <c:forEach var="equipment" items="${equipmentList.list}">
                                        <tr onclick="goToDetail(${equipment.eqpmnNo})" style="cursor:pointer;">
                                            <td style="color: black;">${equipment.eqpmnNo}</td>
                                            <td class="text-start" style="color: black;">${equipment.eqpmnNm}</td>
                                            <td style="color: black;">${equipment.eqpmnTy}</td>
                                            <td style="color: black;">${equipment.eqpmnSn}</td>
                                            <td style="color: black;">${equipment.makrNm}</td>
                                            <td style="color: black;">
                                                <c:out value="${fn:substring(equipment.eqpmnPurchsDe, 0, 4)}-${fn:substring(equipment.eqpmnPurchsDe, 4, 6)}-${fn:substring(equipment.eqpmnPurchsDe, 6, 8)}" />
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${equipment.eqpmnSttus == '01'}">
                                                        <span class="badge bg-success text-white">사용 가능</span>
                                                    </c:when>
                                                    <c:when test="${equipment.eqpmnSttus == '02'}">
                                                        <span class="badge bg-danger text-white">사용 중</span>
                                                    </c:when>
                                                    <c:when test="${equipment.eqpmnSttus == '03'}">
                                                        <span class="badge bg-warning text-white">수리 중</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-success" onclick="event.stopPropagation(); processIncoming(${equipment.eqpmnNo}, '${equipment.eqpmnSttus}')">
                                                    수리 처리
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

       
                       <!-- ✅ 신규 등록 버튼 + 페이지네이션 같은 줄에 배치 -->
						<div class="d-flex justify-content-between align-items-center mt-3">
						    <!-- 왼쪽 정렬: 신규 등록 버튼 -->
						    <button class="btn btn-primary" onclick="location.href='/batirplan/equipment/register'">신규 등록</button>
						
						    <!-- 가운데 정렬: 페이지네이션 -->
						    <div class="d-flex justify-content-center flex-grow-1">
						        <ul class="pagination mb-0">
						            <c:if test="${equipmentList.hasPreviousPage}">
						                <li class="page-item">
						                    <a class="page-link" href="?pageNum=${equipmentList.prePage}&keyword=${param.keyword}">이전</a>
						                </li>
						            </c:if>
						            <c:forEach var="i" begin="1" end="${equipmentList.pages}">
						                <li class="page-item ${equipmentList.pageNum == i ? 'active' : ''}">
						                    <a class="page-link" href="?pageNum=${i}&keyword=${param.keyword}">${i}</a>
						                </li>
						            </c:forEach>
						            <c:if test="${equipmentList.hasNextPage}">
						                <li class="page-item">
						                    <a class="page-link" href="?pageNum=${equipmentList.nextPage}&keyword=${param.keyword}">다음</a>
						                </li>
						            </c:if>
						        </ul>
						    </div>
						</div>
                </div>
                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
</div>


<%@include file="../module/footerScript.jsp" %>



<!-- ✅ JavaScript 기능 -->
<script>
function goToDetail(eqpmnNo) {
    location.href = "/batirplan/equipment/detail/" + eqpmnNo;
}

function processIncoming(eqpmnNo, currentStatus) {
    if (currentStatus === '03') {
        Swal.fire({
            icon: "info",
            title: "입고 불가",
            text: "이미 입고된 장비입니다.",
            confirmButtonText: "확인"
        });
        return;
    }

    if (currentStatus === '02') {
        Swal.fire({
            icon: "warning",
            title: "입고 불가",
            text: "사용 중인 장비는 입고 처리할 수 없습니다.",
            confirmButtonText: "확인"
        });
        return;
    }

    Swal.fire({
        icon: "question",
        title: "입고 확인",
        text: "해당 장비를 '입고' 하시겠습니까?",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "입고",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch("/batirplan/equipment/updateStatus", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "eqpmnNo=" + eqpmnNo + "&status=03"
            })
            .then(response => response.text())
            .then(result => {
                if (result === "SUCCESS") {
                    Swal.fire({
                        icon: "success",
                        title: "입고 완료",
                        text: "입고 처리가 완료되었습니다.",
                        confirmButtonText: "확인"
                    }).then(() => {
                        location.reload();
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "오류 발생",
                        text: "처리 중 오류가 발생했습니다.",
                        confirmButtonText: "확인"
                    });
                }
            });
        }
    });
    
    function resetSearchInput() {
        document.getElementById("searchInput").value = ""; // 검색 후 입력 필드 초기화
    }
    
}
</script>

</body>
</html>
