<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/magnific-popup/dist/magnific-popup.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/owl.carousel/dist/assets/owl.carousel.min.css">


<body class="link-sidebar">
  <%@include file="../../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper" >
    <%@include file="../../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
    <%@include file="../../module/navBar.jsp" %>
	    <div class="body-wrapper">
	      <div class="container-fluid">
	      	
	      	
	      	<div class="card card-body py-3">
			  <div class="row align-items-center">
			    <h4 class="mb-4 mb-sm-0 card-title">정보 조회</h4>
			  </div>
			</div>
			
			<div class="shop-detail">
				<div class="card">
					<div class="px-4 py-3 border-bottom">
		              <h4 class="card-title mb-0">📦 품목 정보</h4>
		            </div>
					<div class="card-body">
						<div class="row">
							<div class="col-lg-4">
								<div class="item rounded overflow-hidden">
			                    	<img src="${prdlstVO.prdlstImageCours }" alt="matdash-img" class="img-fluid"/>
			                  	</div>
							</div>
							<div class="col-lg-8">
								<div class="shop-content mt-3">
									<span class="badge fw-medium fs-2 bg-primary-subtle text-primary">${prdlstVO.levelOneCtgryNm}</span>
									<span class="badge fw-medium fs-2 bg-primary-subtle text-primary">${prdlstVO.levelTwoCtgryNm}</span>
									<span class="badge fw-medium fs-2 bg-primary-subtle text-primary">${prdlstVO.ctgryNm}</span>
<h5 class="mt-1">
  ${prdlstVO.prdlstNm }
  <c:if test="${prdlstVO.safeInvntryQy > 0}">
    <small class="text-muted ms-2">자동 발주 품목 🔄</small>
  </c:if>
</h5>									
									<p class="text-dark mt-3">담당 업체명: ${prdlstVO.ccpyNm}</p>
									<div class="row mt-4">
										<div class="col-md-6">
											<p class="text-dark">규격(단위): ${prdlstVO.prdlstStndrd} (  ${unitList[prdlstVO.prdlstUnit - 1]}   )</p>
											<p class="text-dark">단가: ${prdlstVO.prdlstPrice}</p>
										</div>
										<div class="col-md-6">
  <p class="text-dark">현재 재고: ${prdlstVO.nowInvntryQy}</p>
  <div class="d-flex align-items-center">
    <span class="text-black me-2">안전 재고: ${prdlstVO.safeInvntryQy}</span>
  </div>
</div>

									</div>
								</div>
							</div>
													<div class="row p-0">
							<div class="d-flex justify-content-end">
								<button class="btn btn-primary m-2" onclick="location.href='/batirplan/resrce/prdlst/list'">목록</button>
								<button class="btn btn-warning m-2" onclick="modify(${prdlstVO.prdlstNo})">수정</button>
							</div>
						</div>
						</div>

					</div>
				</div>
			</div>
			
			<div class="card">
				<div class="px-4 py-3 border-bottom">
	              <h4 class="card-title mb-0">📊 이번달 입출고 내역</h4>
	            </div>
				<div class="card-body">
					<div id="dataArea">
					
					</div>
				</div>
			</div>
			

	      
		  </div>
	    </div>
    </div>
    </div>
  <%@include file="../../module/footerScript.jsp" %>
  <script src="${pageContext.request.contextPath }/assets/libs/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/plugins/meg.init.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/apps/productDetail.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/owl.carousel/dist/owl.carousel.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/jquery-validation/dist/jquery.validate.min.js"></script>



</body> 
  
</body>
<script>
$(function(){
	
});

// 자동 발주 설정 모달 열기
function openAutoReqModal() {
  let autoReqModal = new bootstrap.Modal($("#autoReqModal"));
  autoReqModal.show();
}

// 수정 페이지 이동 이벤트
function modify(prdlstNo){
  location.href = "/batirplan/resrce/prdlst/modify?prdlstNo=" + prdlstNo;
}
</script>


</html>