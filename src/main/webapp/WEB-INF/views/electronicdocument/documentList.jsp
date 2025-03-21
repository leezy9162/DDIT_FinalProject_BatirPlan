<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.ckeditor.com/4.22.1/standard-all/ckeditor.js"></script>

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
    width: 34%;
    padding-right: 10px;
}
.table th:nth-child(3), .table td:nth-child(3) {
    width: 10%;
}
.table th:nth-child(4), .table td:nth-child(4) {
    width: 10%;
}
.table th:nth-child(5), .table td:nth-child(5) {
    width: 12%;
}
.table th:nth-child(6), .table td:nth-child(6) {
    width: 13%;
}
.table th:nth-child(7), .table td:nth-child(7) {
    width: 13%;
}
.table td:nth-child(2) {
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
.ellipsis-text:hover {
    text-decoration: underline;
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
        
				<!-- 작업 영역 Start -->
	          
	            <%-- 
	            <sec:authentication property="principal.memberVO.empVO" var="empl"/>
	            ${empl.emplCode }
	            ${empl.emplNm }
	            --%>
	            
	            <div class="card card-body py-3">
	            	<div class="row align-items-center">
	            		<h4 class="mb-4 mb-sm-0 card-title">내 결재 관리</h4>
       				</div>
   				</div>
    	  
  				<div class="card">
  					<div class="card-body">
  						<div class="d-flex align-items-center mb-3">
  							<!-- <label for="docType" style="margin-right: 10px;">문서 유형</label>
  							<div class="btn-group mr-3">
  								<button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton"
  								 		data-bs-toggle="dropdown" aria-expanded="false" style="margin-right: 10px;">
	    							전체
	  							</button>
	  							
	  							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
	  								<li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('전체', 'dropdownMenuButton')">전체</a></li>
			        				<li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('내 기안 문서', 'dropdownMenuButton')">내 기안 문서</a></li>
							        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('결재 대기 문서', 'dropdownMenuButton')">결재 대기 문서</a></li>
							        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('참조', 'dropdownMenuButton')">참조</a></li>
	  							</ul>
							</div>
							
							<label for="docStatus" style="margin-right: 10px;">진행 상태</label>
           					<div class="btn-group mr-3">
           						<button class="btn btn-light dropdown-toggle" type="button" id="dropdownStatusButton" data-bs-toggle="dropdown" aria-expanded="false">
		    						전체
		  						</button>
		  						
		  						<ul class="dropdown-menu" aria-labelledby="dropdownStatusButton">
								    <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('전체', 'dropdownStatusButton')">전체</a></li>
							        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('기안중', 'dropdownStatusButton')">기안중</a></li>
							        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('진행중', 'dropdownStatusButton')">진행중</a></li>
							        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('반려', 'dropdownStatusButton')">반려</a></li>
							        <li><a class="dropdown-item" href="javascript:void(0)" onclick="updateDropdownText('결재', 'dropdownStatusButton')">결재</a></li>
		  						</ul>
							</div> -->
							
							<div class="input-group ms-auto" style="width: 30%;">
								<input type="text" class="form-control" id="searchInput" placeholder="제목을 입력해주세요" value="${fnc:escapeXml(sj)}" aria-label="" aria-describedby="basic-addon1">
								<button class="btn btn-primary" type="button" onclick="search()">검색</button>
							</div>
       					</div>
       					
       					<div id="documentListContainer" class="table-responsive mb-3 border rounded-1">
       						<table class="table text-nowrap mb-0 align-middle">
       							<thead class="text-dark fs-4">
		        					<tr>
		            					<th style="text-align: center;">
		                					<h6 class="fs-4 fw-semibold mb-0">번호</h6>
		            					</th>
		            					<th>
		                					<h6 class="fs-4 fw-semibold mb-0">제목</h6>
							            </th>
							            <th style="text-align: center;">
		                					<h6 class="fs-4 fw-semibold mb-0">기안자</h6>
							            </th>
							            <th style="text-align: center;">
		                					<h6 class="fs-4 fw-semibold mb-0">결재자</h6>
							            </th>
							            <th style="text-align: center;">
		                					<h6 class="fs-4 fw-semibold mb-0">진행상태</h6>
							            </th>
		            					<th style="text-align: center;">
		                					<h6 class="fs-4 fw-semibold mb-0">기안일자</h6>
		            					</th>
							            <th style="text-align: center;">
		                					<h6 class="fs-4 fw-semibold mb-0">기한일자</h6>
							            </th>
		        					</tr>
	        					</thead>
	        					<tbody>
	        						<c:if test="${not empty documentList}">
		        						<c:forEach var="doc" items="${documentList}">
		            						<tr>
			                					<td style="text-align: center;">
			                    					<h6 class="fs-4 fw-semibold mb-0">${doc.docNo }</h6>
								                </td>
							                	<td>
												    <h6 class="fs-4 fw-normal mb-0" style="display: flex;">
												        <c:if test="${doc.emrgncyDocAt == 'Y'}">
												            <span class="badge text-bg-danger" style="display: inline-block; margin-right: 2px;">긴급</span>&nbsp; 
												        </c:if>
												        <div class="ellipsis-text" onclick="openDocumentDetailModal(${doc.docNo});" style="cursor:pointer;">
												            ${doc.sj}
												        </div>
												    </h6>
												</td>
			                					<td style="text-align: center;">
			                    					<h6 class="fs-4 fw-normal mb-0">${doc.drafterName}</h6>
								                </td>
								                <td style="text-align: center;">
						                            <h6 class="fs-4 fw-normal mb-0">
						                                <c:choose>
						                                    <c:when test="${not empty doc.displayApproverName}">
						                                        ${doc.displayApproverName}
						                                    </c:when>
						                                    <c:otherwise>--</c:otherwise>
						                                </c:choose>
						                            </h6>
						                        </td>
								                <td style="text-align: center;">
			                    					<h6 class="fs-4 fw-normal mb-0">
								                        <c:choose>
								                            <c:when test="${doc.sttus == '01'}"><span class="mb-0 badge bg-warning-subtle text-dark">기안중</span></c:when>
								                            <c:when test="${doc.sttus == '02'}"><span class="mb-0 badge bg-primary-subtle text-dark">진행중</span></c:when>
								                            <c:when test="${doc.sttus == '03'}"><span class="mb-0 badge bg-danger-subtle text-dark">반려</span></c:when>
								                            <c:when test="${doc.sttus == '04'}"><span class="mb-0 badge bg-success-subtle text-dark">결재완료</span></c:when>
								                            <c:otherwise>${doc.sttus}</c:otherwise>
								                        </c:choose>
			                    					</h6>
								                </td>
								                <td style="text-align: center;">
			                    					<h6 class="fs-4 fw-normal mb-0">${fnc:substring(doc.drftDe, 0, 4)}-${fnc:substring(doc.drftDe, 4, 6)}-${fnc:substring(doc.drftDe, 6, 8)}</h6>
								                </td>
								                <td style="text-align: center;">
			                    					<h6 class="fs-4 fw-normal mb-0">${fnc:substring(doc.tmlmtDe, 0, 4)}-${fnc:substring(doc.tmlmtDe, 4, 6)}-${fnc:substring(doc.tmlmtDe, 6, 8)}</h6>
								                </td>
		            						</tr>
			        					</c:forEach>
		        					</c:if>
		        					<c:if test="${empty documentList}">
		        						<tr>
		        							<td colspan="8" style="text-align: center;">
		                    					<h6 class="fs-4 fw-normal mb-0">데이터가 존재하지 않습니다.</h6>
							                </td>
						                </tr>
		        					</c:if>
		    					</tbody>
							</table>
						</div>
			
						<div id="documentDetailModal" class="modal" style="display: none;">
						    <div class="modal-content" id="documentDetailModalContainer"></div>
						</div>
								
						<div id="documentEditModal" class="modal" style="display:none;">
							<div class="modal-content" id="documentEditModalContainer"></div>
						</div>
					       	  
			       	  	<div style="position: relative;">
						    <!-- 왼쪽: 신규, 도장/서명 버튼 (float:left 또는 인라인 블록) -->
						    <div style="float: left;">
						        <input type="button" value="신규" onclick="openDocumentFormListModal();" class="btn btn-primary" style="margin-right: 3px;"/>
						        <div id="documentFormListModal" class="modal" style="display: none;">
						            <div class="modal-content" id="documentFormListModalContainer"></div>
						        </div>
						        <input type="button" value="도장/서명" onclick="openStampModal()" class="btn btn-primary"/>
						        <div id="stampModal" class="modal" style="display: none;">
						            <div class="modal-content" id="stampModalContainer"></div> 
						        </div>
						    </div>
						    
						    <!-- 중앙: 페이지네이션 버튼 (절대 위치 중앙, 수직 가운데 정렬) -->
						    <div style="position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%);">
						      <div class="pagination-container">
						        <ul class="pagination pagination-md m-0">
						          <c:if test="${currentPage > 1}">
						            <li class="page-item">
						              <a class="page-link" href="?page=${currentPage - 1}&sj=${fnc:escapeXml(sj)}">이전</a>
						            </li>
						          </c:if>
						          <c:forEach begin="1" end="${totalPage}" var="i">
						            <c:choose>
						              <c:when test="${i == currentPage}">
						                <li class="page-item active"><span class="page-link">${i}</span></li>
						              </c:when>
						              <c:otherwise>
						                <li class="page-item">
						                  <a class="page-link" href="?page=${i}&sj=${fnc:escapeXml(sj)}">${i}</a>
						                </li>
						              </c:otherwise>
						            </c:choose>
						          </c:forEach>
						          <c:if test="${currentPage < totalPage}">
						            <li class="page-item">
						              <a class="page-link" href="?page=${currentPage + 1}&sj=${fnc:escapeXml(sj)}">다음</a>
						            </li>
						          </c:if>
						        </ul>
						      </div>
						    </div>
						    <div style="clear: both;"></div>
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
function updateDropdownText(value, buttonId) {
    var button = document.getElementById(buttonId);
    
    if (button) {
        button.innerText = value;
    }
}

function openDocumentFormListModal(){
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/create",
        type: "GET",
        success: function(response) {
            $("#documentFormListModalContainer").html(response);
            $("#documentFormListModal").fadeIn();
            document.body.style.overflow = "hidden";
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "양식 목록을 불러오는 데 실패했습니다.",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
}

function openDocumentDetailModal(docNo) {
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/detail", 
        type: "GET",
        data: { docNo: docNo }, 
        success: function(response) {
            $("#documentDetailModalContainer").html(response); 
            $("#documentDetailModal").fadeIn();
            document.body.style.overflow = "hidden";
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "상세 정보를 불러오는 데 실패했습니다.",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
}

function initEditor() {
    if (CKEDITOR.instances.editor) {
        CKEDITOR.instances.editor.destroy(true);
    }
    
    CKEDITOR.replace('editor', {
    	extraPlugins: 'autogrow',
    	removePlugins: 'resize',
        extraAllowedContent: 'table tr td th span[*]; colgroup col[*]',
        allowedContent: true
    });
}

function openStampModal() {
    $.ajax({
        url: '${pageContext.request.contextPath}/batirplan/erp/electronicdocument/stampRegistration',
        type: 'GET',
        success: function(response) {
            $("#stampModalContainer").html(response);
            $("#stampModal").fadeIn();
            $("body").css("overflow", "hidden");
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "도장/서명 등록 페이지 로드 실패",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
}

function search() {
    var keyword = $("#searchInput").val().trim();
    // 검색 시 페이지 번호 1로 설정하고, 검색어를 URL에 쿼리 스트링으로 추가합니다.
    window.location.href = '${pageContext.request.contextPath}/batirplan/erp/electronicdocument/list?page=1&sj=' + encodeURIComponent(keyword);
}

$(document).ready(function(){
    const urlParams = new URLSearchParams(window.location.search);
    const docNoParam = urlParams.get('docNo');       
    const openModalParam = urlParams.get('openModal'); 

    if (openModalParam === 'true' && docNoParam) {
        openDocumentDetailModal(docNoParam);

        urlParams.delete('openModal'); 
        
        const newUrl = window.location.pathname + '?' + urlParams.toString();
        window.history.replaceState({}, '', newUrl);
    }
});
</script>
</html>