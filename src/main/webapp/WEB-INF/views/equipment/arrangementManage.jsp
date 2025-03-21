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
                    <!-- 작업 영역 Start -->
                    <div class="card card-body py-3">
                        <div class="row align-items-center">
                            <h4 class="mb-4 mb-sm-0 card-title">장비배치 관리</h4>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="table-responsive mb-4 border rounded-1">
                                <table class="table text-nowrap mb-0 align-middle">
                                    <thead class="text-dark fs-4 text-center">
                                        <tr>
                                            <th><h6 class="fs-4 fw-semibold mb-0">신청번호</h6></th>
                                            <th class="text-start"><h6 class="fs-4 fw-semibold mb-0">프로젝트명</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">신청자</h6></th>
                                            <th class="text-start"><h6 class="fs-4 fw-semibold mb-0">장비명</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">대여 시작일</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">대여 종료일</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">승인 여부</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">관리</h6></th>
                                        </tr>
                                    </thead>
                                    <tbody class="text-center">
                                        <c:forEach var="arrangement" items="${pendingList}">
                                            <tr style="cursor:pointer">
                                                <td class="text-dark">${arrangement.requestNo}</td>
                                                <td class="text-start text-dark">${arrangement.prjctNm}</td>
                                                <td class="text-dark">${arrangement.emplNm}</td>
                                                <td class="text-start text-dark">${arrangement.eqpmnNm}</td>
                                                <td class="text-dark">
                                                    <fmt:formatDate value="${arrangement.rentalStartDate}" pattern="yyyy-MM-dd" />
                                                </td>
                                                <td class="text-dark">
                                                    <fmt:formatDate value="${arrangement.rentalEndDate}" pattern="yyyy-MM-dd" />
                                                </td>
                                                <td class="text-dark approval-status">
                                                    <c:choose>
                                                        <c:when test="${arrangement.approvalStatus == 'Y'}">
                                                            <span class="approved">승인</span>
                                                        </c:when>
                                                        <c:when test="${arrangement.approvalStatus == 'D'}">
                                                            <span class="pending">대기</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="not-approved">미승인</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <div class="d-flex justify-content-center">
                                                        <button class="btn btn-success btn-sm approve-btn"
                                                                data-requestno="${arrangement.requestNo}"
                                                                data-eqpmnno="${arrangement.eqpmnNo}"
                                                                data-approval-status="${arrangement.approvalStatus}">
                                                            승인
                                                        </button>
                                                        <button class="btn btn-danger btn-sm reject-btn ms-2"
                                                                data-requestno="${arrangement.requestNo}"
                                                                data-approval-status="${arrangement.approvalStatus}">
                                                            거절
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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
$(document).ready(function () {
    $(".approve-btn").click(function (event) {
        event.stopPropagation(); // ✅ 행 클릭 방지

        var btn = $(this);
        var requestNo = btn.data("requestno");
        var eqpmnNo = btn.data("eqpmnno");
        var approvalStatus = btn.data("approval-status");
        var statusText = btn.closest("tr").find(".approval-status span");

        if (approvalStatus === "Y") {
            // 승인 취소 처리
            $.ajax({
                type: "POST",
                url: "/batirplan/equipment/arrangement/cancelApproval",
                data: { requestNo: requestNo },
                success: function () {
                    btn.text("승인").removeClass("btn-danger").addClass("btn-success");
                    btn.data("approval-status", "D"); // ✅ 버튼 상태 즉시 변경
                    statusText.text("대기").removeClass("approved not-approved").addClass("pending");
                }
            });
        } else {
            // 승인 처리
            $.ajax({
                type: "POST",
                url: "/batirplan/equipment/arrangement/approve",
                data: { requestNo: requestNo, eqpmnNo: eqpmnNo },
                success: function () {
                    btn.text("승인취소").removeClass("btn-success").addClass("btn-danger");
                    btn.data("approval-status", "Y"); // ✅ 버튼 상태 즉시 변경
                    statusText.text("승인").removeClass("pending not-approved").addClass("approved");
                }
            });
        }
    });

    $(".reject-btn").click(function (event) {
        event.stopPropagation(); // ✅ 행 클릭 방지

        var btn = $(this);
        var requestNo = btn.data("requestno");
        var approvalStatus = btn.data("approval-status");
        var statusText = btn.closest("tr").find(".approval-status span");

        if (approvalStatus === "Y") {
            alert("이미 승인된 장비 배치 신청입니다.");
            return;
        }
        if (approvalStatus === "N") {
            alert("이미 거절된 장비 배치 신청입니다.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "/batirplan/equipment/arrangement/reject",
            data: { requestNo: requestNo },
            success: function () {
                btn.data("approval-status", "N"); // ✅ 버튼 상태 즉시 변경
                statusText.text("미승인").removeClass("pending approved").addClass("not-approved");
                alert("거절되었습니다.");
            }
        });
    });
});
</script>

</body>
</html>
