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
                <!-- 작업 영역 Start -->
                <div class="card card-body py-3">
                    <div class="row align-items-center">
                        <h4 class="mb-4 mb-sm-0 card-title">장비 상세 정보</h4>
                    </div>
                </div>

                <div class="card shadow-lg">
                    <div class="card-body">
                        <div class="row text-dark">
                            <div class="col-lg-6">
                                <p class="fs-4"><strong>장비 번호:</strong> ${equipment.eqpmnNo}</p>
                                <p class="fs-4"><strong>장비명:</strong> ${equipment.eqpmnNm}</p>
                                <p class="fs-4"><strong>장비 유형:</strong> ${equipment.eqpmnTy}</p>
                                <p class="fs-4"><strong>일련번호:</strong> ${equipment.eqpmnSn}</p>
                            </div>
                            <div class="col-lg-6">
                                <p class="fs-4"><strong>제조사:</strong> ${equipment.makrNm}</p>
                                <p class="fs-4"><strong>가격:</strong> <fmt:formatNumber value="${equipment.eqpmnPc}" pattern="#,###" /> 원</p>
								<p class="fs-4"><strong>구매일자:</strong> 
								    <fmt:parseDate var="purchaseDate" value="${equipment.eqpmnPurchsDe}" pattern="yyyyMMdd"/>
								    <fmt:formatDate value="${purchaseDate}" pattern="yyyy-MM-dd"/>
								</p>
                                <p class="fs-4"><strong>위치:</strong> ${equipment.eqpmnLc}</p>
                            </div>
                        </div>

                        <!-- ✅ 상태 태그 스타일 적용 -->
                        <p class="fs-4 text-dark">
                            <strong>상태:</strong> 
                            <c:choose>
                                <c:when test="${equipment.eqpmnSttus == '01'}">
                                    <span class="badge bg-success text-white">사용 가능</span>
                                </c:when>
                                <c:when test="${equipment.eqpmnSttus == '02'}">
                                    <span class="badge bg-danger text-white">사용 중</span>
                                </c:when>
                                <c:when test="${equipment.eqpmnSttus == '03'}">
                                    <span class="badge bg-warning text-dark">수리 중</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary text-white">알 수 없음</span>
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <div class="mt-4">
                            <a href="/batirplan/equipment/list" class="btn btn-primary">
                                목록
                            </a>
                        </div>
                    </div>
                </div>
                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
</div>
<%@include file="../module/footerScript.jsp" %>
<script>
function updateStatus(eqpmnNo, status) {
    Swal.fire({
        icon: "warning",
        title: "상태 변경 확인",
        text: "상태를 변경하시겠습니까?",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "변경",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            fetch("/batirplan/equipment/updateStatus", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "eqpmnNo=" + eqpmnNo + "&status=" + status
            })
            .then(response => response.text())
            .then(result => {
                if (result === "SUCCESS") {
                    Swal.fire({
                        icon: "success",
                        title: "변경 완료",
                        text: "상태가 변경되었습니다.",
                        confirmButtonText: "확인"
                    }).then(() => {
                        location.reload();
                    });
                } else {
                    Swal.fire({
                        icon: "error",
                        title: "오류 발생",
                        text: "상태 변경 중 오류가 발생했습니다.",
                        confirmButtonText: "확인"
                    });
                }
            });
        }
    });
}
</script>

</body>
</html>