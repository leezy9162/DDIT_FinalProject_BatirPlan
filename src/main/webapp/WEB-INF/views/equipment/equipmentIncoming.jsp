<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                        <h4 class="mb-4 mb-sm-0 card-title">장비 입출고 관리</h4>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">

               
                        
                          <!-- ✅ 검색 필터 (테이블 우측 정렬) -->
                        <div class="d-flex justify-content-end mb-3">
						    <form action="/batirplan/equipment/incoming" method="get" class="d-flex align-items-center" onsubmit="resetSearchInput()">
						        <input type="text" id="searchInput" class="form-control me-2" style="width: 230px; height: 40px;" 
						            name="keyword" placeholder="검색어 입력">
						        <button type="submit" class="btn btn-primary" style="height: 40px;">검색</button>
						    </form>
						</div>
                        
                        
                        

                        <div class="table-responsive mb-4 border rounded-1">
                            <table class="table text-nowrap mb-0 align-middle">
                                <thead class="text-dark fs-4 text-center">
                                    <tr>
                                        <th style="width: 8%;">장비 번호</th>
                                        <th style="width: 15%;" class="text-start">장비 명</th>
                                        <th style="width: 12%;">장비 유형</th>
                                        <th style="width: 15%;">일련번호</th>
                                        <th style="width: 12%;">제조사</th>
                                        <th style="width: 10%;">구매일자</th>
                                        <th style="width: 8%;">상태</th>
                                        <th style="width: 10%;">출고 처리</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    <c:choose>
                                        <c:when test="${empty incomingEquipmentList}">
                                            <tr>
                                                <td colspan="8" class="text-center py-4">
                                                    <strong class="text-muted">현재 출고된 장비가 없습니다.</strong>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="equipment" items="${incomingEquipmentList}">
                                                <tr class="text-dark">
                                                    <td style="color: black;">${equipment.eqpmnNo}</td>
                                                    <td class="text-start" style="color: black;">${equipment.eqpmnNm}</td>
                                                    <td style="color: black;">${equipment.eqpmnTy}</td>
                                                    <td style="color: black;">${equipment.eqpmnSn}</td>
                                                    <td style="color: black;">${equipment.makrNm}</td>
                                                    <!-- 구매일자 YYYY-MM-DD 형식 변환 -->
                                                    <td style="color: black;">
                                                        <c:out value="${fn:substring(equipment.eqpmnPurchsDe, 0, 4)}-${fn:substring(equipment.eqpmnPurchsDe, 4, 6)}-${fn:substring(equipment.eqpmnPurchsDe, 6, 8)}" />
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-warning">수리 중</span>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-sm btn-primary receive-btn" data-eqpmn-no="${equipment.eqpmnNo}">출고 처리</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>

                        <!-- ✅ 페이지네이션 -->
                        <div class="d-flex justify-content-center">
						    <!-- 🔹 이전 버튼 -->
						    <c:if test="${pageInfo.hasPreviousPage}">
						        <a href="?pageNum=${pageInfo.prePage}&pageSize=${pageInfo.pageSize}&keyword=${param.keyword}" 
						           class="btn btn-outline-primary me-2">이전</a>
						    </c:if>
						
						    <!-- 🔹 페이지 숫자 버튼 -->
						    <c:forEach var="i" begin="1" end="${pageInfo.pages}">
						        <a href="?pageNum=${i}&pageSize=${pageInfo.pageSize}&keyword=${param.keyword}"
						           class="btn ${pageInfo.pageNum == i ? 'btn-primary' : 'btn-outline-primary'} me-2">${i}</a>
						    </c:forEach>
						
						    <!-- 🔹 다음 버튼 -->
						    <c:if test="${pageInfo.hasNextPage}">
						        <a href="?pageNum=${pageInfo.nextPage}&pageSize=${pageInfo.pageSize}&keyword=${param.keyword}" 
						           class="btn btn-outline-primary">다음</a>
						    </c:if>
						</div>

                    </div>
                </div>
                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 입고 처리 버튼 클릭 이벤트
    $(".receive-btn").click(function() {
        let eqpmnNo = $(this).data("eqpmn-no");

        Swal.fire({
            icon: "warning",
            title: "출고 확인",
            text: "해당 장비를 '출고'하시겠습니까?",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "출고",
            cancelButtonText: "취소"
        }).then((result) => {
            if (result.isConfirmed) {
                $.post("/batirplan/equipment/receive", { eqpmnNo: eqpmnNo }, function(response) {
                    if (response === "SUCCESS") {
                        Swal.fire({
                            icon: "success",
                            title: "출고 완료",
                            text: "장비가 출고 되었습니다.",
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
    });
    function resetSearchInput() {
        document.getElementById("searchInput").value = ""; // 검색 후 입력 필드 초기화
    }
    
});
</script>

</body>
</html>