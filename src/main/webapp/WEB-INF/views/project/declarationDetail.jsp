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
		  				<h4 class="mb-4 mb-sm-0 card-title">상세보기</h4>
					</div>
			  	</div>
			  	
			  	<div class="card">
			  		<div class="card-body">
				        <c:if test="${not empty error}">
				            <div class="alert alert-danger">${error}</div>
				        </c:if>
				        <c:if test="${not empty declaration}">
				            <div>
				                <h4>제목 : ${declaration.dclrtSj}</h4>
				                <p>신고일 : <fmt:formatDate value="${declaration.writngDt}" pattern="yyyy-MM-dd" /></p>
				                <p>총합 금액 : <fmt:formatNumber value="${declaration.totalAmount}" />원</p>
				                <p>승인 여부 : 
								    <c:choose>
								        <c:when test="${declaration.confmAt == 'N'}">미승인</c:when>
								        <c:when test="${declaration.confmAt == 'Y'}">승인완료</c:when>
								        <c:otherwise>${declaration.confmAt}</c:otherwise>
								    </c:choose>
								</p>
				                <c:if test="${not empty declaration.confmDt}">
								    <p>승인일 : <fmt:formatDate value="${declaration.confmDt}" pattern="yyyy-MM-dd" /></p>
								</c:if>
				            </div>
				            <hr/>
				            <h4>신고 품목 리스트</h4>
				            <table class="table table-bordered">
				                <thead>
				                    <tr>
				                        <th>품목명</th>
				                        <th>단가</th>
				                        <th>수량</th>
				                        <th>금액</th>
				                    </tr>
				                </thead>
				                <tbody>
				                    <c:forEach var="item" items="${productList}">
				                        <tr>
				                            <td>${item.prdlstNm}</td>
				                            <td><fmt:formatNumber value="${item.prdlstPrice}" /></td>
				                            <td>${item.prdlstQy}</td>
				                            <td><fmt:formatNumber value="${item.prdlstPrice * item.prdlstQy}" /></td>
				                        </tr>
				                    </c:forEach>
				                </tbody>
				            </table>
				        </c:if>
				        <button type="button" class="btn btn-primary" onclick="window.history.back();">목록</button>
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