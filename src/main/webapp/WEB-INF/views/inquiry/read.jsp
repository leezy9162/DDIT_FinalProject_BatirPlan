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
                            <h4 class="mb-4 mb-sm-0 card-title">문의 상세</h4>
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${not empty inquiry}">
                            <div class="card">
                                <div class="card-body">
                                	<div>
	                                    <h5 class="card-title">
	                                    	<c:out  value="${inquiry.sj}" />
	                                    </h5>
                                	</div>
                                    <div class="text-end">
                                    	<c:set var="typeText">
                                        <c:choose>
                                            <c:when test="${inquiry.ty == 'TS'}">ERP 서비스 문의</c:when>
                                            <c:when test="${inquiry.ty == 'QA'}">계정문의</c:when>
                                            <c:when test="${inquiry.ty == 'ETC'}">기타</c:when>
                                            <c:otherwise>기타</c:otherwise>
                                        </c:choose>
                                    	</c:set>
                                    	${typeText} / ${inquiry.wrter} / ${inquiry.writngDt}
                                    </div>
                                    <div class="card-body border-top p-4">
                                    		${inquiry.cn}
                                    </div>
                                    

                                    <div class="mt-4 text-end">
                                        <a href="/batirplan/inquiry/list" class="btn btn-primary">
                                        	목록
                                        </a>
                                        
                                        <sec:authentication property="principal.memberVO" var="member"/>
										<c:if test="${empty member.empVO}">
										    <sec:authentication property="principal.memberVO.ccpyVO.ccpyCode" var="loginUser"/>
										</c:if>
										<c:if test="${not empty member.empVO}">
											<sec:authentication property="principal.memberVO.empVO.emplCode" var="loginUser"/>
										</c:if>
                                        
										<c:if test="${loginUser eq inquiry.wrter}">
                                            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#updateModal">수정</button>
                                            <button type="button" class="btn btn-danger" onclick="confirmDelete(${inquiry.inqryNo})">삭제</button>
										</c:if>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p>문의 내용을 불러올 수 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- 수정 모달창 -->
                        <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-xl">
                                <div class="modal-content">
                                    <div class="modal-header d-flex align-items-center">
                                        <h4 class="modal-title">문의 수정</h4>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h4>문의 내용을 수정하세요</h4>
                                        <form id="updateForm" action="/batirplan/inquiry/register" method="post">
                                            <input type="hidden" name="status" value="u">
                                            <input type="hidden" name="inqryNo" value="${inquiry.inqryNo}">

                                            <div class="mb-3">
                                                <label for="sj" class="form-label">제목</label>
                                                <input type="text" class="form-control" id="sj" name="sj" value="${inquiry.sj}" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="cn" class="form-label">내용</label>
                                                <textarea class="form-control" id="mymce" name="cn" rows="6" required>${inquiry.cn}</textarea>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary">수정</button>
                                                <button type="button" class="btn bg-danger-subtle text-danger" data-bs-dismiss="modal">
                                                    닫기
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                    
					<!-- 답변 입력 폼 -->
					<div class="card mb-3">
						

					<!-- 답변 목록 -->
					<c:choose>
					    <c:when test="${empty answers}">
					        <div class="text-center mb-3 card-body">등록된 답변이 없습니다.</div>
					    </c:when>
					    <c:otherwise>
					        <c:forEach var="answer" items="${answers}">
							    <div class="position-relative p-4">
							    	<h5 class="card-title mb-3">답변</h5>
							        <div class="text-bg-light rounded-2 p-4">
							            <div class="mb-2">   
							                <strong>
							                	<c:out value="${answer.answrr}" />
							                </strong>  
							            </div>
							            <div class="mb-2 text-muted">
							                <small>${answer.answerRegistDt}</small>
							            </div>
							            <p class="mb-3">${answer.answerCn}</p>
							            <sec:authorize access="hasRole('ROLE_DEPT_IT')">
							                <div class="text-end">
							                    <button type="button" class="btn btn-warning btn-sm" 
							                            data-bs-toggle="modal" data-bs-target="#updateAnswerModal-${answer.answerNo}">수정
							                    </button>
							                    <button type="button" class="btn btn-danger btn-sm" onclick="deleteComment(${answer.answerNo}, ${inquiry.inqryNo})">
							                    	삭제
							                    </button>
							                </div>
							            </sec:authorize>
							        </div>
							    </div>
							</c:forEach>
					    </c:otherwise>
					</c:choose>
					
					<sec:authorize access="hasRole('ROLE_DEPT_IT')">
					        <div class="card-body">
					            <h5 class="card-title">답변 작성</h5>
					            <form action="/batirplan/inquiry/answer/add" method="post">
					                <input type="hidden" name="inqryNo" value="${inquiry.inqryNo}">
					                <textarea class="form-control mb-3" name="answerCn" placeholder="답변을 입력하세요..." required></textarea>
					                <div class="text-end">
					                    <button type="submit" class="btn btn-primary">
					                    	등록
					                    </button>
					                </div>
					            </form>
					        </div>
					 	</sec:authorize>
				</div>
					
					<!-- 댓글 수정 모달 -->
					<c:forEach var="answer" items="${answers}">
					    <div class="modal fade" id="updateAnswerModal-${answer.answerNo}" 
					         data-bs-backdrop="static" data-bs-keyboard="false"
					         aria-labelledby="updateAnswerModalLabel-${answer.answerNo}" aria-hidden="true">
					        <div class="modal-dialog">
					            <div class="modal-content">
					                <div class="modal-header">
					                    <h5 class="modal-title">댓글 수정</h5>
					                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					                </div>
					                <form action="/batirplan/inquiry/answer/update" method="post">
					                    <div class="modal-body">
					                        <input type="hidden" name="answerNo" value="${answer.answerNo}">
					                        <input type="hidden" name="inqryNo" value="${inquiry.inqryNo}">
					                        <textarea class="form-control" name="answerCn">${answer.answerCn}</textarea>
					                    </div>
					                    <div class="modal-footer">
					                        <button type="submit" class="btn btn-primary">수정</button>
					                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					                    </div>
					                </form>
					            </div>
					        </div>
					    </div>
					</c:forEach>
                </div>
                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
    
	<!-- 외부 라이브러리 스크립트 -->
	<script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js" aria-hidden="true"></script>
	<script src="${pageContext.request.contextPath }/assets/libs/sweetalert2/dist/sweetalert2.all.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/forms/sweet-alert.init.js"></script>
	
	<%@include file="../module/footerScript.jsp" %>
	
	<!-- TinyMCE 초기화 -->
	<script src="${pageContext.request.contextPath }/assets/libs/tinymce/tinymce.min.js"></script>
	<script src="${pageContext.request.contextPath }/assets/js/forms/tinymce-init.js"></script>

	<script>
	$(function(){
		tinymce.triggerSave();
	});
	
	function confirmDelete(inqryNo) {
	    Swal.fire({
	        title: '삭제 확인',
	        text: '해당 문의를 삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#d33',
	        cancelButtonColor: '#6c757d',
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            const form = document.createElement('form');
	            form.method = 'POST';
	            form.action = '/batirplan/inquiry/remove';
	
	            const input = document.createElement('input');
	            input.type = 'hidden';
	            input.name = 'inqryNo';
	            input.value = inqryNo;
	
	            form.appendChild(input);
	            document.body.appendChild(form);
	            form.submit();
	        }
	    });
	}
	
	function deleteComment(answerNo, inqryNo) {
	    Swal.fire({
	        title: '댓글 삭제 확인',
	        text: '이 댓글을 삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#d33',
	        cancelButtonColor: '#6c757d',
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed) {
	            const form = document.createElement('form');
	            form.method = 'POST';
	            form.action = '/batirplan/inquiry/answer/delete';
	
	            const inputAnswerNo = document.createElement('input');
	            inputAnswerNo.type = 'hidden';
	            inputAnswerNo.name = 'answerNo';
	            inputAnswerNo.value = answerNo;
	
	            const inputInqryNo = document.createElement('input');
	            inputInqryNo.type = 'hidden';
	            inputInqryNo.name = 'inqryNo';
	            inputInqryNo.value = inqryNo;
	
	            form.appendChild(inputAnswerNo);
	            form.appendChild(inputInqryNo);
	            document.body.appendChild(form);
	            form.submit();
	        }
	    });
	}
	
	document.addEventListener("DOMContentLoaded", function () {
	    document.querySelectorAll('.modal').forEach(modal => {
	        if (!bootstrap.Modal.getInstance(modal)) {
	            new bootstrap.Modal(modal);
	        }
	    });
	});
	</script>
</body>
</html>
