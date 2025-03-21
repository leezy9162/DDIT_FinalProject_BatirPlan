<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->

<style>
.table {
    table-layout: fixed;
    width: 100%;
}
.table th, .table td {
    vertical-align: middle;
    padding: 13px;
    word-wrap: break-word;
    word-break: break-word;
    white-space: normal;
}
.table th {
    background-color: #ffffff;
}
.table th:nth-child(1), .table td:nth-child(1) {
    width: 8%;
}
.table th:nth-child(2), .table td:nth-child(2) {
    width: 30%;
}
.table th:nth-child(3), .table td:nth-child(3) {
    width: 30%;
}
.table th:nth-child(4), .table td:nth-child(4) {
    width: 11%;
}
.table th:nth-child(5), .table td:nth-child(5) {
    width: 10%;
}
.table th:nth-child(6), .table td:nth-child(6) {
    width: 11%;
}
</style>
  
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
		  				<h4 class="mb-4 mb-sm-0 card-title">기초 품목 신고</h4>
					</div>
			  	</div>
			  	
			  	<div class="card">
			  		<div class="card-body">
						<div class="row">
							<div class="d-flex justify-content-end">
			  					<div class="input-group mb-3" style="width: 30%;">
					  				<input type="text" class="form-control" placeholder="검색어를 입력해주세요" aria-label="" aria-describedby="basic-addon1">
					      			<button class="btn bg-info-subtle text-dark" type="button">검색</button>
					  			</div>
							</div>
						</div>
			  			
						<div class="table-responsive mb-4 border rounded-1">
							<table class="table text-nowrap mb-0 align-middle">
								<thead class="text-dark fs-4">
									<tr>
										<th style="text-align: center;">
											<h6 class="fs-4 fw-semibold mb-0">번호</h6>
						            	</th>
						                <th>
						                	<h6 class="fs-4 fw-semibold mb-0">프로젝트명</h6>
						                </th>
						                <th>
						                	<h6 class="fs-4 fw-semibold mb-0">신고서 제목</h6>
						                </th>
						                <th style="text-align: center;">
						                	<h6 class="fs-4 fw-semibold mb-0">작성일</h6>
						                </th>
						                <th style="text-align: center;">
						                	<h6 class="fs-4 fw-semibold mb-0">승인여부</h6>
					                	</th>
						                <th style="text-align: center;">
						                	<h6 class="fs-4 fw-semibold mb-0">승인일</h6>
						                </th>
						            </tr>
						        </thead>
						        <tbody>
						            <c:if test="${not empty declarations}">
						                <c:forEach var="declaration" items="${declarations}">
						                    <tr>
						                        <td style="text-align: center;">
						                        	<h6 class="fs-4 fw-semibold mb-0">${declaration.dclrtNo}</h6>
						                        </td>
						                        <td>
						                        	<h6 class="fs-4 fw-normal mb-0">${declaration.prjctNm}</h6>
						                        </td>
						                        <td>
						                        	<h6 class="fs-4 fw-normal mb-0">
						                        	<a href="/batirplan/project/declaration/detail/${declaration.dclrtNo}"
						                        	   class="text-primary"
						                        	   onmouseover="this.style.textDecoration='underline'"
													   onmouseout="this.style.textDecoration='none'">
						                        		${declaration.dclrtSj}
						                        	</a>
						                        	</h6>
						                        </td>
						                        <td style="text-align: center;">
												    <h6 class="fs-4 fw-normal mb-0">
												        <fmt:formatDate value="${declaration.writngDt}" pattern="yyyy-MM-dd" />
												    </h6>
												</td>
						                        <td style="text-align: center;">
						                        	<h6 class="fs-4 fw-normal mb-0">
							                        	<c:choose>
							                        		<c:when test="${declaration.confmAt == 'N'}">미승인</c:when>
				                                      		<c:when test="${declaration.confmAt == 'Y'}">승인 완료</c:when>
				                                      		<c:otherwise>미정</c:otherwise>
				                                    	</c:choose>
						                        	</h6>
						                        </td>
						                        <td style="text-align: center;">
						                        	<h6 class="fs-4 fw-normal mb-0">${declaration.confmDt}</h6>
						                        </td>
						                    </tr>
						                </c:forEach>
						            </c:if>
						            <c:if test="${empty declarations}">
					                    <tr>
					                        <td colspan="6" style="text-align: center;">
					                        	<h6 class="fs-4 fw-normal mb-0">데이터가 존재하지 않습니다.</h6>
					                        </td>
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