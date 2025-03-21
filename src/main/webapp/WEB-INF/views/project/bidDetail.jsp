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
                        <h4 class="mb-4 mb-sm-0 card-title">입찰공고 상세보기</h4>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body wizard-content">
                        <h5 class="card-title">공고 정보</h5>
                        <table class="table table-bordered">
                            <tr>
                                <th>공고 번호</th>
                                <td>${bid.pblancNo}</td>
                            </tr>
                            <tr>
                                <th>프로젝트 번호</th>
                                <td>${bid.prjctNo}</td>
                            </tr>
                            <tr>
                                <th>공고 제목</th>
                                <td>${bid.pblancSj}</td>
                            </tr>
                            <tr>
                                <th>작성자</th>
                                <td>${bid.pblancWrter}</td>
                            </tr>
                            <tr>
                                <th>공고 내용 (수요 조건)</th>
                                <td>${bid.demandCndCn}</td>
                            </tr>
                            <tr>
                                <th>공고 금액</th>
                                <td><fmt:formatNumber value="${bid.pblancAmount}" /></td>
                            </tr>
                            <tr>
                                <th>시작일</th>
                                <td>${fnc:substring(bid.pblancBgnde, 0, 10)}</td>
                            </tr>
                            <tr>
                                <th>종료일</th>
                                <td>${fnc:substring(bid.pblancEndde, 0, 10)}</td>
                            </tr>
                            <tr>
                                <th>진행 상태</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${bid.progrsSttus eq '01'}">진행중</c:when>
                                        <c:when test="${bid.progrsSttus eq '02'}">마감</c:when>
                                        <c:otherwise>미정</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>

                        <!-- 견적서 목록 -->
                        <h5 class="card-title mt-4">견적서 목록</h5>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>견적서 번호</th>
                                    <th>제목</th>
                                    <th>업체명</th>
                                    <th>대표자명</th>
                                    <th>작성일</th>
                                    <th>승인</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty quotationList}">
                                        <c:forEach var="quotation" items="${quotationList}">
                                            <tr>
                                                <td>${quotation.prqudoNo}</td>
                                                <td><a href="/batirplan/project/bid/quotation/detail/${quotation.prqudoNo}">${quotation.prqudoSj}</a></td>
                                                <td>${quotation.cmpnyNm}</td>
                                                <td>${quotation.rprsntvNm}</td>
                                                <td>${quotation.writngDt}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${quotation.confmAt == 'Y'}">
                                                            <button class="btn btn-success" disabled>승인 완료</button>
                                                        </c:when>
                                                        <c:when test="${approvedQuotationExists}">
                                                            <button class="btn btn-primary" disabled>승인 불가</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-success approve-btn" data-prqudo-no="${quotation.prqudoNo}">승인</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="text-center">제출된 견적서가 없습니다.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>

                        <div class="mt-3">
                            <!-- 뒤로가기 버튼 -->
                            <button class="btn btn-secondary" onclick="window.history.back()">뒤로가기</button>
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
$(".approve-btn").on("click", function() {
    var prqudoNo = $(this).data("prqudo-no");

    $.ajax({
        url: '/batirplan/project/bid/quotation/approve/' + prqudoNo,
        type: 'POST',
        success: function(response) {
            if (response.success) {
                Swal.fire({
                    icon: "success",
                    title: "승인 완료",
                    text: "견적서가 승인되었습니다.",
                    confirmButtonText: "확인"
                }).then(() => {
                    if (response.prjctNo && response.prjctNo !== 0) {
                        window.location.href = '/batirplan/project/projectpm/detail/' + response.prjctNo;
                    } else {
                        location.reload(); // prjctNo가 유효하지 않으면 현재 페이지를 새로고침
                    }
                });
            } else {
                Swal.fire({
                    icon: "warning",
                    title: "승인 불가",
                    text: response.message || "이미 승인된 견적서가 있습니다.",
                    confirmButtonText: "확인"
                });
            }
        },
        error: function() {
            Swal.fire({
                icon: "error",
                title: "오류 발생",
                text: "견적서 승인 중 오류가 발생했습니다.",
                confirmButtonText: "확인"
            });
        }
    });
});
</script>

</body>
</html>