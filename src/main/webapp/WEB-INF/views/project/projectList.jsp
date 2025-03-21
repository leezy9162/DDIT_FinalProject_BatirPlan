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
}
.table th:nth-child(1), .table td:nth-child(1) {
    width: 8%;
}
.table th:nth-child(2), .table td:nth-child(2) {
    width: 25%;
    padding-right: 0;
}
.table th:nth-child(3), .table td:nth-child(3) {
    width: 17%;
    padding-right: 0;
}
.table th:nth-child(4), .table td:nth-child(4) {
    width: 12%;
}
.table th:nth-child(5), .table td:nth-child(5) {
    width: 10%;
}
.table th:nth-child(6), .table td:nth-child(6) {
    width: 14%;
}
.table th:nth-child(7), .table td:nth-child(7) {
    width: 14%;
}
.table td:nth-child(2) {
    white-space: nowrap;          
    overflow: hidden;             
    text-overflow: ellipsis;      
    max-width: 100%;              
    display: table-cell;          
}
.table td:nth-child(3) {
    white-space: nowrap;          
    overflow: hidden;             
    text-overflow: ellipsis;      
    max-width: 100%;              
    display: table-cell;          
}
.ellipsis-text {
    display: block;               
    width: 100%;                  
    white-space: nowrap;          
    overflow: hidden;             
    text-overflow: ellipsis;
    color: #635BFF;      
}
.ellipsis-text2 {
    display: block;               
    width: 100%;                  
    white-space: nowrap;          
    overflow: hidden;             
    text-overflow: ellipsis;
}
.ellipsis-text:hover {
    text-decoration: underline;
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
		  		
		  		<sec:authentication property="principal.memberVO.empVO" var="empl"/>
		  		
		  		<div class="card card-body py-3">
		  			<div class="row align-items-center">
		  				<h4 class="mb-4 mb-sm-0 card-title">프로젝트 계획 관리</h4>
					</div>
			  	</div>
			  	
			  	<div class="card">
			  		<div class="card-body">
			  			<div class="d-flex justify-content-between align-items-center mb-3">
			  				<ul class="nav nav-tabs" role="tablist">
			  					<li class="nav-item">
			  						<a class="nav-link active" data-bs-toggle="tab" href="#home" role="tab">
				  						<span>전체</span>
						          	</a>
						      	</li>
						      	<li class="nav-item">
						      		<a class="nav-link" data-bs-toggle="tab" href="#profile" role="tab">
						              	<span>내 프로젝트</span>
						          	</a>
						      	</li>
						  	</ul>
						  	
						  	<!-- 검색 입력란 (검색어가 유지되도록 value 속성 추가) -->
						  	<div class="input-group" style="width: 30%;">
						  		<input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력해주세요" aria-label="" aria-describedby="basic-addon1" value="${fnc:escapeXml(search)}">
						      	<button class="btn btn-primary" type="button" onclick="search()">검색</button>
						  	</div>
						</div>
						
						<div class="tab-content">
							<div class="tab-pane active" id="home" role="tabpanel">
								<div class="table-responsive mb-0 border rounded-1">
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
								                	<h6 class="fs-4 fw-semibold mb-0">카테고리</h6>
								                </th>
								                <th style="text-align: center;">
								                	<h6 class="fs-4 fw-semibold mb-0">진행상태</h6>
								                </th>
								                <th style="text-align: center;">
								                	<h6 class="fs-4 fw-semibold mb-0">담당자</h6>
							                	</th>
								                <th style="text-align: center;">
								                	<h6 class="fs-4 fw-semibold mb-0">시작일</h6>
								                </th>
								                <th style="text-align: center;">
								                	<h6 class="fs-4 fw-semibold mb-0">종료일</h6>
								                </th>
								            </tr>
								        </thead>
								        <tbody>
								            <c:if test="${not empty projects}">
								                <c:forEach var="project" items="${projects}">
								                    <tr>
								                        <td style="text-align: center;">
								                        	<h6 class="fs-4 fw-semibold mb-0">${project.prjctNo}</h6>
								                        </td>
								                        <td>
								                        	<h6 class="fs-4 fw-normal mb-0">
								                        		<div class="ellipsis-text" onclick="openProjectDetail('${project.prjctNo}');" style="cursor:pointer;">
																    ${project.prjctNm}
																</div>
								                        	</h6>
								                        </td>
								                        <td>
								                        	<h6 class="fs-4 fw-normal mb-0">
								                        		<div class="ellipsis-text2">
								                        			${project.prjctCtgry}
							                        			</div>
							                        		</h6>
								                        </td>
								                        <td style="text-align: center;">
								                        	<h6 class="fs-4 fw-normal mb-0">
									                        	<c:choose>
									                        		<c:when test="${project.prjctProgrsSttus == '01'}"><span class="mb-0 badge bg-warning-subtle text-dark">계획중</span></c:when>
						                                      		<c:when test="${project.prjctProgrsSttus == '02'}"><span class="mb-0 badge bg-primary-subtle text-dark">진행중</span></c:when>
						                                      		<c:when test="${project.prjctProgrsSttus == '03'}"><span class="mb-0 badge bg-success-subtle text-dark">완료</span></c:when>
						                                      		<c:otherwise>미정</c:otherwise>
						                                    	</c:choose>
								                        	</h6>
								                        </td>
								                        <td style="text-align: center;">
								                        	<h6 class="fs-4 fw-normal mb-0">${project.charger}</h6>
								                        </td>
								                        <td style="text-align: center;">
														    <h6 class="fs-4 fw-normal mb-0">
														        ${fnc:substring(project.prjctBgnde, 0, 4)}-${fnc:substring(project.prjctBgnde, 4, 6)}-${fnc:substring(project.prjctBgnde, 6, 8)}
														    </h6>
														</td>
														<td style="text-align: center;">
														    <h6 class="fs-4 fw-normal mb-0">
														        ${fnc:substring(project.prjctEndde, 0, 4)}-${fnc:substring(project.prjctEndde, 4, 6)}-${fnc:substring(project.prjctEndde, 6, 8)}
														    </h6>
														</td>
								                    </tr>
								                </c:forEach>
								            </c:if>
								            <c:if test="${empty projects}">
							                    <tr>
							                        <td colspan="7" style="text-align: center;">
							                        	<h6 class="fs-4 fw-normal mb-0">데이터가 존재하지 않습니다.</h6>
							                        </td>
							                    </tr>
								            </c:if>
								        </tbody>
								    </table>
					            </div>
					            <!-- 전체 탭 페이지네이션 -->
								<nav class="mt-3">
								  <div class="pagination-container">
								    <ul class="pagination mb-0 justify-content-center">
								      <!-- 현재 페이지가 1보다 클 때만 이전 버튼 출력 -->
								      <c:if test="${currentPage > 1}">
								        <li class="page-item">
								          <a class="page-link" href="?page=${currentPage - 1}&search=${fnc:escapeXml(search)}">이전</a>
								        </li>
								      </c:if>
								      
								      <!-- 페이지 번호 출력 -->
								      <c:forEach var="i" begin="1" end="${totalPage}" varStatus="status">
								        <c:choose>
								          <c:when test="${i == currentPage}">
								            <li class="page-item active">
								              <span class="page-link">${i}</span>
								            </li>
								          </c:when>
								          <c:otherwise>
								            <li class="page-item">
								              <a class="page-link" href="?page=${i}&search=${fnc:escapeXml(search)}">${i}</a>
								            </li>
								          </c:otherwise>
								        </c:choose>
								      </c:forEach>
								      
								      <!-- 현재 페이지가 전체 페이지보다 작을 때만 다음 버튼 출력 -->
								      <c:if test="${currentPage < totalPage}">
								        <li class="page-item">
								          <a class="page-link" href="?page=${currentPage + 1}&search=${fnc:escapeXml(search)}">다음</a>
								        </li>
								      </c:if>
								    </ul>
								  </div>
								</nav>
					        </div>
					        <div class="tab-pane" id="profile" role="tabpanel">
					        	<div class="table-responsive mb-0 border rounded-1">
					        		<table class="table text-nowrap mb-0 align-middle">
					        			<tr>
					        				<th style="text-align: center;">
					        					<h6 class="fs-4 fw-semibold mb-0">번호</h6>
							            	</th>
							                <th>
							                	<h6 class="fs-4 fw-semibold mb-0">프로젝트명</h6>
							                </th>
							                <th>
							                	<h6 class="fs-4 fw-semibold mb-0">카테고리</h6>
							                </th>
							                <th style="text-align: center;">
							                	<h6 class="fs-4 fw-semibold mb-0">진행상태</h6>
							                </th>
							                <th style="text-align: center;">
							                	<h6 class="fs-4 fw-semibold mb-0">담당자</h6>
						                	</th>
							                <th style="text-align: center;">
							                	<h6 class="fs-4 fw-semibold mb-0">시작일</h6>
							                </th>
							                <th style="text-align: center;">
							                	<h6 class="fs-4 fw-semibold mb-0">종료일</h6>
							                </th>
							            </tr>
								        <tbody>
							            	<c:if test="${not empty projects}">
											    <c:set var="foundProject" value="false" />
											    <c:forEach var="project" items="${projects}">
											        <c:if test="${project.charger == empl.emplNm}">
											            <c:set var="foundProject" value="true" />
											            <tr>
											                <td style="text-align: center;">
											                    <h6 class="fs-4 fw-semibold mb-0">${project.prjctNo}</h6>
											                </td>
											                <td>
									                        	<h6 class="fs-4 fw-normal mb-0">
									                        		<div class="ellipsis-text" onclick="openProjectDetail('${project.prjctNo}');" style="cursor:pointer;">
																	    ${project.prjctNm}
																	</div>
									                        	</h6>
									                        </td>
											                <td>
									                        	<h6 class="fs-4 fw-normal mb-0">
									                        		<div class="ellipsis-text2">
									                        			${project.prjctCtgry}
								                        			</div>
								                        		</h6>
									                        </td>
											                <td style="text-align: center;">
									                        	<h6 class="fs-4 fw-normal mb-0">
										                        	<c:choose>
										                        		<c:when test="${project.prjctProgrsSttus == '01'}"><span class="mb-0 badge bg-warning-subtle text-dark">계획중</span></c:when>
							                                      		<c:when test="${project.prjctProgrsSttus == '02'}"><span class="mb-0 badge bg-primary-subtle text-dark">진행중</span></c:when>
							                                      		<c:when test="${project.prjctProgrsSttus == '03'}"><span class="mb-0 badge bg-success-subtle text-dark">완료</span></c:when>
							                                      		<c:otherwise>미정</c:otherwise>
							                                    	</c:choose>
									                        	</h6>
									                        </td>
											                <td style="text-align: center;">
											                    <h6 class="fs-4 fw-normal mb-0">${project.charger}</h6>
											                </td>
											                <td style="text-align: center;">
											                    <h6 class="fs-4 fw-normal mb-0">
											                        ${fnc:substring(project.prjctBgnde, 0, 4)}-${fnc:substring(project.prjctBgnde, 4, 6)}-${fnc:substring(project.prjctBgnde, 6, 8)}
											                    </h6>
											                </td>
											                <td style="text-align: center;">
											                    <h6 class="fs-4 fw-normal mb-0">
											                        ${fnc:substring(project.prjctEndde, 0, 4)}-${fnc:substring(project.prjctEndde, 4, 6)}-${fnc:substring(project.prjctEndde, 6, 8)}
											                    </h6>
											                </td>
											            </tr>
											        </c:if>
											    </c:forEach>
											
											    <c:if test="${!foundProject}">
											        <tr>
											            <td colspan="7" style="text-align: center;">
											                <h6 class="fs-4 fw-normal mb-0">데이터가 존재하지 않습니다.</h6>
											            </td>
											        </tr>
											    </c:if>
											</c:if>
											
											<c:if test="${empty projects}">
											    <tr>
											        <td colspan="7" style="text-align: center;">
											            <h6 class="fs-4 fw-normal mb-0">데이터가 존재하지 않습니다.</h6>
											        </td>
											    </tr>
											</c:if>
								        </tbody>
								    </table>
					            </div>
					        </div>
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

<script>
function openProjectDetail(prjctNo) {
    window.location = '/batirplan/project/projectpm/detail/' + prjctNo;
}

function search() {
    // 검색 입력란의 값을 가져옵니다.
    var keyword = $("#searchInput").val().trim();
    // 검색어를 URL 파라미터에 추가하여 페이지 1로 이동시킵니다.
    window.location.href = '?page=1&search=' + encodeURIComponent(keyword);
}
</script>

</html>