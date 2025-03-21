<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
  
<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper" >

	<%@include file="../module/sideBar.jsp" %>
	<div class="page-wrapper">
	
		<%@include file="../module/navBar.jsp" %>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->

				<div class="card card-body py-3">
      				<div class="row align-items-center">
      					<h4 class="mb-4 mb-sm-0 card-title">입찰공고 목록</h4>
   					</div>
				</div>
				
				<div class="card">
					<div class="card-body wizard-content">
						<div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>공고 번호</th>
                                        <th>프로젝트 번호</th>
                                        <th>공정 번호</th>
                                        <th>공고 제목</th>
                                        <th>작성자</th>
                                        <th>시작일</th>
                                        <th>종료일</th>
                                        <th>진행 상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${not empty bids}">
                                        <c:forEach var="bid" items="${bids}">
                                            <tr>
                                                <td>${bid.pblancNo}</td>
                                                <td>${bid.prjctNo}</td>
                                                <td>${bid.procsNo }</td>
                                                <td>
                                                    <a href="/batirplan/project/bid/detail/${bid.pblancNo}" class="text-primary">
                                                        ${bid.pblancSj}
                                                    </a>
                                                </td>
                                                <td>${bid.pblancWrterName}</td>
                                                <td>${fnc:substring(bid.pblancBgnde, 0, 10)}</td>
                                                <td>${fnc:substring(bid.pblancEndde, 0, 10)}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${bid.progrsSttus eq '01'}">진행중</c:when>
                                                        <c:when test="${bid.progrsSttus eq '02'}">마감</c:when>
                                                        <c:otherwise>미정</c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty bids}">
                                        <tr>
                                            <td colspan="8" style="text-align:center;">데이터가 존재하지 않습니다.</td>
                                        </tr>
                                    </c:if>
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

</body>
</html>