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
                 	<div class="card">
                    	<div class="card-body">
                     		<sec:authentication property="principal.memberVO" var="member"/>
                     	
						<c:if test="${empty member.empVO}">
						    <sec:authentication property="principal.memberVO.ccpyVO.ccpyCode" var="writer"/>
						</c:if>
						<c:if test="${not empty member.empVO}">
							<sec:authentication property="principal.memberVO.empVO.emplCode" var="writer"/>
						</c:if>
                     	
                         <h5 class="card-title fw-semibold mb-4">
                             ${status eq 'u' ? '문의 수정' : '새로운 문의 등록'}
                         </h5>
			
                         <form id="inquiryForm" method="post">
                             <c:if test="${status eq 'u'}">
                                 <input type="hidden" name="inqryNo" value="${inquiry.inqryNo}" />
                             </c:if>

                             <input type="hidden" name="progrsSttus" value="${inquiry.progrsSttus ne null ? inquiry.progrsSttus : '01'}" />

                             <div class="mb-3">
                                 <label for="ty" class="form-label">유형</label>
                                 <select class="form-control" id="ty" name="ty" required>
                                     <option value="" disabled ${empty inquiry.ty ? 'selected' : ''}>선택하세요</option>
                                     <option value="TS" ${inquiry.ty eq 'TS' ? 'selected' : ''}>ERP 서비스 문의</option>
                                     <option value="QA" ${inquiry.ty eq 'QA' ? 'selected' : ''}>계정문의</option>
                                     <option value="OT" ${inquiry.ty eq 'OT' ? 'selected' : ''}>기타</option>
                                 </select>
                             </div>

                             <div class="mb-3">
                                 <label for="sj" class="form-label">제목</label>
                                 <input type="text" class="form-control" id="sj" name="sj" value="${inquiry.sj}" required>
                             </div>

                             <input type="hidden" class="form-control" id="wrter" name="wrter" value="${empty inquiry.wrter ? writer:inquiry.wrter}">

                             <div class="mb-3">
                                 <label for="cn" class="form-label">내용</label>
                                 <textarea class="form-control" id="mymce" name="cn" rows="4" required>
                                     ${inquiry.cn}
                                 </textarea>
                             </div>

                             <button type="button" class="btn btn-primary" onclick="submitForm();">
                                 ${status eq 'u' ? '수정하기' : '등록하기'}
                             </button>
                             <a href="/batirplan/inquiry/list" class="btn btn-secondary">취소</a>
                         </form>
                     </div>
                 </div>
             </div>
            <!-- 작업 영역 End -->
        </div>
    </div>
</div>

    <%@include file="../module/footerScript.jsp" %>

    <!-- 외부 라이브러리 스크립트 -->
    <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js" aria-hidden="true"></script>
    <script src="${pageContext.request.contextPath }/assets/libs/sweetalert2/dist/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath }/assets/js/forms/sweet-alert.init.js"></script>

    <!-- TinyMCE 초기화 -->
    <script src="${pageContext.request.contextPath }/assets/libs/tinymce/tinymce.min.js"></script>
    <script src="${pageContext.request.contextPath }/assets/js/forms/tinymce-init.js"></script>

    <script>
        function submitForm() {
            tinymce.triggerSave();

            let formData = $("#inquiryForm").serialize();
            let actionUrl = "${status eq 'u' ? '/batirplan/inquiry/update' : '/batirplan/inquiry/register'}";

            $.ajax({
                type: "POST",
                url: actionUrl,
                data: formData,
                success: function(response) {
                    Swal.fire({
                        title: '성공!',
                        text: "${status eq 'u' ? '문의가 성공적으로 수정되었습니다.' : '문의가 성공적으로 등록되었습니다.'}",
                        icon: 'success',
                        confirmButtonText: '확인'
                    }).then(() => {
                        window.location.href = "/batirplan/inquiry/list";
                    });
                },
                error: function(error) {
                    Swal.fire({
                        title: '오류!',
                        text: '처리 중 오류 발생!',
                        icon: 'error',
                        confirmButtonText: '확인'
                    });
                    console.error("오류 상세:", error);
                }
            });
        }
    </script>
</body>
</html>
