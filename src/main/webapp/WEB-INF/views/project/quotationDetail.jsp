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
      					<h4 class="mb-4 mb-sm-0 card-title">견적서 상세보기</h4>
   					</div>
				</div>

				<div class="card">
					<div class="card-body wizard-content">
						<h5 class="card-title">견적서 정보</h5>
                        <table class="table table-bordered">
                            <tr>
                                <th>견적서 번호</th>
                                <td>${quotation.prqudoNo}</td>
                            </tr>
                            <tr>
                                <th>업체명</th>
                                <td>${quotation.cmpnyNm}</td>
                            </tr>
                            <tr>
                                <th>대표자명</th>
                                <td>${quotation.rprsntvNm}</td>
                            </tr>
                            <tr>
                                <th>사업자번호</th>
                                <td>${quotation.bizrno}</td>
                            </tr>
                            <tr>
                                <th>업체 전화번호</th>
                                <td>${quotation.cmpnyTelno}</td>
                            </tr>
                            <tr>
                                <th>휴대폰 번호</th>
                                <td>${quotation.mbtlnum}</td>
                            </tr>
                            <tr>
                                <th>견적서 제목</th>
                                <td>${quotation.prqudoSj}</td>
                            </tr>
                            <tr>
                                <th>견적서 내용</th>
                                <td>${quotation.prqudoCn}</td>
                            </tr>
                            <tr>
                                <th>작성일</th>
                                <td>${quotation.writngDt}</td>
                            </tr>
                            <tr>
                                <th>승인 상태</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${quotation.confmAt eq 'Y'}">승인됨</c:when>
                                        <c:otherwise>미승인</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>

                        <div class="mt-3">
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

</body>
</html>