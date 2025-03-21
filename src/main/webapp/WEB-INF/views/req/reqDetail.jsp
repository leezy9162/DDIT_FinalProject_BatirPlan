<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@include file="../module/head.jsp" %>

<style>
/* 전체 카드 및 테이블 스타일 */
.card {
    border-radius: 12px;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
}

/* 상단 카드 스타일 */
.card-header {
    background-color: #f8f9fa;
    padding: 15px 20px;
    border-bottom: 2px solid #dee2e6;
    font-weight: bold;
    font-size: 18px;
}

/* 테이블 스타일 */
.table {
    width: 100%;
    border-collapse: collapse;
    font-size: 16px;
    text-align: left;
}
#mytable td{
    color: black !important;
}
.table thead {
    background-color: #f4f4f4;
    font-weight: bold;
}
.table tbody tr:hover {
    background-color: #f9f9f9;
}

/* 요청 상태 배지 스타일 */
.badge {
    padding: 6px 12px;
    font-size: 14px;
    font-weight: bold;
    border-radius: 6px;
}

/* 요청 중 (하늘색) */
.badge-warning {
    background-color: #0dcaf0; /* 하늘색 */
    color: white;
}

/* 발주 승인 & 승인됨 (보라색) */
.badge-primary {
    background-color: #6f42c1; /* 보라색 */
    color: white;
}

/* 반려 & 완료 (핑크색) */
.badge-danger {
    background-color: #ff69b4; /* 핑크색 */
    color: white;
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

                    <!-- 상단 카드 -->
                    <div class="card card-body py-3">
                        <div class="row align-items-center">
                            <h4 class="mb-4 mb-sm-0 card-title">${reqInfo.reqNo }</h4>
                        </div>
                    </div>

                    <!-- 상세 정보 -->
                    <div class="card mt-3">
                        <div class="px-4 py-3 border-bottom">
                            <h4 class="card-title mb-0">📊 요청 내역</h4>
                        </div>
                        <div class="card-body">
                        	<h4>요청 정보</h4>
                        	<p class="text-black"><strong>날짜: </strong>${reqInfo.reqDate }</p>
                        	<p class="text-black"><strong>요청자: </strong>${reqInfo.reqstrNm }</p>
                        	<hr/>
                        	<h4 class="card-title">${reqInfo.suplrNm }</h4>
                            <table class="table" id="mytable">
                                <thead>
                                    <tr>
                                        <th>요청 상세 번호</th>
                                        <th>품목 이름</th>
                                        <th>요청 수량</th>
                                        <th>단가</th>
                                        <th>합계 금액</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:set var="totalPrice" value="0" />
                                    <c:forEach var="detail" items="${detailList}">
                                        <tr>
                                            <td>
                                            	${detail.reqDeNo}
												<c:choose>
											        <c:when test="${detail.reqDeSttus eq '1'}">
											            <span class="badge badge-warning ms-2">요청 중</span>  <%-- 하늘색 --%>
											        </c:when>
											        <c:when test="${detail.reqDeSttus eq '2'}">
											            <span class="badge badge-primary ms-2">승인됨</span>  <%-- 보라색 --%>
											        </c:when>
											        <c:when test="${detail.reqDeSttus eq '3'}">
											            <span class="badge badge-danger ms-2">완료</span>  <%-- 핑크색 --%>
											        </c:when>
											        <c:when test="${detail.reqDeSttus eq '4'}">
											            <span class="badge badge-danger ms-2">반려</span>  <%-- 핑크색 --%>
											        </c:when>
											        <c:otherwise>
											            <span class="badge badge-secondary ms-2">알 수 없음</span>
											        </c:otherwise>
											    </c:choose>                                            
                                            </td>
                                            <td>${detail.prdlstNm}</td>
                                            <td>${detail.reqQty}</td>
                                            <td>${detail.unitPrice}</td>
                                            <td>${detail.totalPrice}</td>
                                            <c:set var="totalPrice" value="${totalPrice + detail.totalPrice}" />
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                	  <tr>
									    <th colspan="4" class="text-end">총 금액 </th>
									    <th class="text-end"><span>${totalPrice}</span></th>
									  </tr>
                                </tfoot>
                            </table>
                            
		                    <!-- 하단 버튼 -->
		                    <div class="d-flex justify-content-end mt-3">
		                        <button class="btn btn-primary m-2" onclick="goToList()">목록</button>
		                    </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>

    <%@include file="../module/footerScript.jsp" %>

    <script>
        function goToList() {
            location.href = "/batirplan/resrce/req/list";
        }
    </script>

</body>
</html>