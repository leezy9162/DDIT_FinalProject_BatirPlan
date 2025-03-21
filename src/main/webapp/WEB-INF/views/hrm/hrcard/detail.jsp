<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->

<style>
.card-body.text-center {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.card-body.text-center img {
    margin-bottom: 20px;
}

.card-body {
    min-height: 100%;
}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/magnific-popup/dist/magnific-popup.css">
  
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
			    <h4 class="mb-4 mb-sm-0 card-title">인사 카드</h4>
			  </div>
			</div>
			
			<div class="card bg-primary-gt text-white overflow-hidden shadow-none">
			
				<div class="card-body position-relative z-1">
                  <div class="row justify-content-between align-items-center">
                    <div class="col-sm-6">
                      <h5 class="fw-semibold mb-9 fs-5 text-white">🏗️ 든든한 건설 파트너 BatirPlan!</h5>
                      <p class="mb-9 opacity-75">
                      	<i class="ti ti-alert-circle fs-5"></i>
                      	재직 상태 철회 및 권한 설정은 IT팀에 문의하세요!
                      </p>
                    </div>
                    <div class="col-sm-5">
                      <div class="position-relative mb-n7 text-end">
                        <img src="${pageContext.request.contextPath }/assets/images/backgrounds/welcome-bg2.png" alt="matdash-img" class="img-fluid">
                      </div>
                    </div>
                  </div>
                </div>
			
			</div>
			
			<div class="row d-flex align-items-stretch">
				<div class="col-md-4 d-flex">
					<div class="card flex-fill">
						<div class="card-body text-center">
						  <c:choose>
						  	<c:when test="${empty empVO.proflImageCours }">
			                  <div class="position-relative">
			                  	<a class="image-popup-vertical-fit" href="${pageContext.request.contextPath }">
			                    	<img src="${pageContext.request.contextPath }/assets/images/profile/user-3.jpg" alt="matdash-img" class="img-fluid mb-4 rounded-circle position-relative" style="width: 200px; height: 200px; object-fit: cover;">
			                    </a>
			                  </div>
						  	</c:when>
						  	<c:otherwise>
			                  <div class="position-relative">
			                  	<a class="image-popup-vertical-fit" href="${empVO.proflImageCours }">
			                    	<img src="${empVO.proflImageCours }" alt="matdash-img" class="img-fluid mb-4 rounded-circle position-relative" style="width: 200px; height: 200px; object-fit: cover;">
			                    </a>
			                  </div>
						  	</c:otherwise>
						  </c:choose>
		                  <h5 class="fw-semibold fs-5 mb-2">${empVO.emplNm }</h5>
		                  <p class="mb-3 px-xl-5">
		                  	<c:choose>
	                           		<c:when test="${empVO.deptCode eq '01'}">
	                           			🏢 경영지원
	                           		</c:when>
	                           		<c:when test="${empVO.deptCode eq '02'}">
	                           			🏗️ 건축기획
	                           		</c:when>
	                           		<c:when test="${empVO.deptCode eq '03'}">
	                           			🏦 재무
	                           		</c:when>
	                           		<c:when test="${empVO.deptCode eq '04'}">
	                           			🌱 자원
	                           		</c:when>
	                           		<c:when test="${empVO.deptCode eq '05'}">
	                           			💻 IT
	                           		</c:when>
	                           		<c:otherwise>
	                           			기타
	                           		</c:otherwise>
	                           	</c:choose>
	                           	<c:choose>
	                           		<c:when test="${empVO.clsfCode eq '01'}">
	                           			사원
	                           		</c:when>
	                           		<c:when test="${empVO.clsfCode eq '02'}">
	                           			대리
	                           		</c:when>
	                           		<c:when test="${empVO.clsfCode eq '03'}">
	                           			과장
	                           		</c:when>
	                           		<c:when test="${empVO.clsfCode eq '04'}">
	                           			차장
	                           		</c:when>
	                           		<c:when test="${empVO.clsfCode eq '05'}">
	                           			부장
	                           		</c:when>
	                           		<c:otherwise>
	                           			기타
	                           		</c:otherwise>
	                           	</c:choose>
		                  </p>
		                </div>
					</div>
	            </div>
	            
	            <div class="col-md-8 d-flex">
	            	<div class="card flex-fill">
	            		<div class="card-body">
	            			<%-- ${empVO } --%>
	            			<h6 class="mb-4 mb-sm-0 card-title">사원 기본 정보</h4>
	            			<div class="vstack gap-3 mt-4">
		                        <div class="hstack gap-6">
		                          <i class="ti ti-briefcase text-dark fs-6"></i>
		                          <h6 class=" mb-0">${empVO.emplNm }</h6>
		                        </div>
		                        <div class="hstack gap-6">
		                          <i class="ti ti-cake text-dark fs-6"></i>
		                          <h6 class=" mb-0">
	                          		<fmt:parseDate var="encpnDate" value="${empVO.encpn}" pattern="yyyyMMdd" />
						        	<fmt:formatDate value="${encpnDate}" pattern="yyyy-MM-dd" />
		                          </h6>
		                        </div>
		                        <div class="hstack gap-6">
		                          <i class="ti ti-mail text-dark fs-6"></i>
		                          <h6 class=" mb-0">${empVO.email }</h6>
		                        </div>
		                        <div class="hstack gap-6">
		                          <i class="ti ti-phone text-dark fs-6"></i>
		                          <h6 class=" mb-0">
		                         	 ${fnc:substring(empVO.mbtlnum, 0, 3)}-${fnc:substring(empVO.mbtlnum, 3, 7)}-${fnc:substring(empVO.mbtlnum, 7, 11)}
		                          </h6>
		                        </div>
		                        <div class="hstack gap-6">
		                          <i class="ti ti-map-pin text-dark fs-6"></i>
		                          <h6 class=" mb-0">${empVO.adres } ${empVO.detailadres }</h6>
		                        </div>
		                        <div class="hstack gap-6">
		                          <i class="ti ti-cash text-dark fs-6"></i>
		                          <h6 class=" mb-0">
		                          		(
		                          		<c:choose>
		                          			<c:when test="${empVO.bankCode eq '001'}">
		                          				한국은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '002'}">
		                          				산업은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '003'}">
		                          				기업은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '004'}">
		                          				국민은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '011'}">
		                          				농협은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '020'}">
		                          				우리은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '031'}">
		                          				대구은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '032'}">
		                          				부산은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '034'}">
		                          				광주은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '035'}">
		                          				제주은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '037'}">
		                          				전북은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '039'}">
		                          				경남은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '045'}">
		                          				새마을금고중앙회
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '048'}">
		                          				신협중앙회
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '081'}">
		                          				KEB하나은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '088'}">
		                          				신한은행
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '089'}">
		                          				케이뱅크
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '090'}">
		                          				카카오뱅크
		                          			</c:when>
		                          			<c:when test="${empVO.bankCode eq '092'}">
		                          				토스뱅크
		                          			</c:when>
		                          		</c:choose>
		                          		)
		                          		${empVO.acnutno } 
                          		  </h6>
		                        </div>
		                        <div class="hstack gap-6">
		                          <i class="ti ti-calendar text-dark fs-6"></i>
		                          <h6 class=" mb-0">
		                          	입사일 - 
		                          	<fmt:parseDate var="encpnDate" value="${empVO.encpn}" pattern="yyyyMMdd" />
							        <fmt:formatDate value="${encpnDate}" pattern="yyyy-MM-dd" />
		                          </h6>
		                        </div>
		                        <c:if test="${!empty empVO.retireDe }">
		                        	<div class="hstack gap-6">
		                          		<i class="ti ti-calendar text-dark fs-6"></i>
	                          			<h6 class=" mb-0">
	                          				퇴사일 - 
				                        	<fmt:parseDate var="retireDate" value="${empVO.retireDe}" pattern="yyyyMMdd" />
								            <fmt:formatDate value="${retireDate}" pattern="yyyy-MM-dd" />
	                          			</h6>
	                        		</div>
		                        </c:if>
		                      </div>
	            			
	            			
	            			
	            			
	            			<div class="text-end">
	            				<button class="btn btn-primary" onclick="location.href='/batirplan/hrm/hrcard/modify?emplCode=${empVO.emplCode}'">수정</button>
	            				<button class="btn btn-primary" onclick="goList()">목록</button>
	            			</div>
	            		</div>
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
</body>
<script>
function goList(){
    let referrer = document.referrer;  // 이전 페이지 URL
    console.log("referrer:", referrer);

    // 만약 register 또는 modify 페이지에서 왔다면
    if(referrer.includes("/batirplan/hrm/hrcard/register") || referrer.includes("/batirplan/hrm/hrcard/modify")){
        location.href = "/batirplan/hrm/hrcard/list";
    } else {
        history.back(); 
    }
}
</script>

</html>