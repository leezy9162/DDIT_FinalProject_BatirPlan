<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@include file="../../module/head.jsp" %>

<body class="link-sidebar">
  <%@include file="../../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@include file="../../module/sideBar.jsp" %>
    <div class="page-wrapper">
      <%@include file="../../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">
          <!-- 작업 영역 Start -->
          <div class="card card-body py-3">
              <div class="row align-items-center">
                  <h4 class="mb-4 mb-sm-0 card-title">증명서 관리</h4>
              </div>
          </div>
          
          <div class="card">
            <div class="card-body">      
              <div class="d-flex justify-content-end align-items-center mb-3">
                <form id="searchForm" action="${pageContext.request.contextPath}/batirplan/hrm/certification/list" method="GET" class="d-flex align-items-center" style="width: auto;">
                  <select name="searchType" class="form-select me-2" style="width: 120px; min-width: 100px;">
                    <option value="">--검색--</option>
                    <option value="emplCode" ${param.searchType eq 'emplCode' ? 'selected' : ''}>사원번호</option>
                    <option value="emplNm" ${param.searchType eq 'emplNm' ? 'selected' : ''}>사원명</option>
                  </select>
                  <input type="text" class="form-control me-2" name="searchWord" placeholder="검색어를 입력하세요" value="${param.searchWord}" style="width: 180px; min-width: 150px;">
                  <button class="btn btn-primary" type="submit" style="width: 80px;">검색</button>
                </form>
              </div>

              <div class="table-responsive mb-4 border rounded-1">
                <table class="table text-nowrap mb-0 align-middle" >
                  <thead class="text-dark fs-4">
                    <tr>
                      <th><h6 class="fs-4 fw-semibold mb-0">사원명</h6></th>
                      <th><h6 class="fs-4 fw-semibold mb-0">사원번호</h6></th>
                      <th><h6 class="fs-4 fw-semibold mb-0">부서</h6></th>
                      <th><h6 class="fs-4 fw-semibold mb-0">직급</h6></th>
                      <th><h6 class="fs-4 fw-semibold mb-0">증명서</h6></th>
                    </tr>
                  </thead>
                  <tbody>
					  <c:choose>
					    <c:when test="${empty certifications}">
					      <tr>
					        <td colspan="5" class="text-center text-muted">선택된 데이터가 없습니다.</td>
					      </tr>
					    </c:when>
					    <c:otherwise>
					      <c:forEach var="cert" items="${certifications}">
					        <tr>
					          <td>${cert.emplNm}</td>
					          <td>${cert.emplCode}</td>
					          <td>
					            <c:choose>
					              <c:when test="${cert.deptCode eq '01'}">경영지원</c:when>
					              <c:when test="${cert.deptCode eq '02'}">건축기획</c:when>
					              <c:when test="${cert.deptCode eq '03'}">재무</c:when>
					              <c:when test="${cert.deptCode eq '04'}">자원</c:when>
					              <c:when test="${cert.deptCode eq '05'}">IT</c:when>
					              <c:otherwise>-</c:otherwise>
					            </c:choose>
					          </td>
					          <td>
					            <c:choose>
					              <c:when test="${cert.clsfCode eq '01'}">사원</c:when>
					              <c:when test="${cert.clsfCode eq '02'}">대리</c:when>
					              <c:when test="${cert.clsfCode eq '03'}">과장</c:when>
					              <c:when test="${cert.clsfCode eq '04'}">차장</c:when>
					              <c:when test="${cert.clsfCode eq '05'}">부장</c:when>
					              <c:otherwise>-</c:otherwise>
					            </c:choose>
					          </td>
					          <td>
					            <c:if test="${empty cert.retireDe}">
					              <button class="btn btn-sm btn-outline-primary" onclick="openEmployeeModal('${cert.emplCode}', 'employment')">재직 증명서</button>
					            </c:if>
					            <c:if test="${not empty cert.retireDe}">
					              <button class="btn btn-sm btn-outline-danger" onclick="openEmployeeModal('${cert.emplCode}', 'retirement')">퇴직 증명서</button>
					            </c:if>
					          </td>
					        </tr>
					      </c:forEach>
					    </c:otherwise>
					  </c:choose>
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
  <%@include file="../../module/footerScript.jsp" %>
</body>

<!-- 모달 추가 -->
<div class="modal fade" id="emplCertificationModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			<div class="modal-body" id="certificationBody">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" onclick="printCertificate()">출력</button>
				<button type="button" class="btn btn-secondary" onclick="closeModal()" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
function openEmployeeModal(emplCode, type) {
  var modal = new bootstrap.Modal(document.getElementById("emplCertificationModal"));
  // 재직입니까? 퇴직입니까? type에 따른 title 설정
	let title = type === 'employment' ? '재직' : '퇴직'; 
  	let bgColor = type === 'employment' ? 'bg-primary' : 'bg-danger';
  
  $.ajax({
    url: "/batirplan/hrm/certification/getempl?emplCode=" + emplCode,
    type: "GET",
    contentType: "application/json",
    success: function(res) {
      var data = (typeof res === 'string') ? JSON.parse(res) : res;
      
      // 생년월일 (yyyy-mm-dd) 형태 설정
      let dateStr = `\${data.brthdy}`;
      dateStr = dateStr.substring(0,4) + "-" + dateStr.substring(4,6) + "-" +	 dateStr.substring(6);
      
      // 연락처 (000-0000-0000) 형태 설정
      let phoneStr = `\${data.mbtlnum}`;
      phoneStr = phoneStr.substring(0,3) + "-" + phoneStr.substring(3,7) + "-" + phoneStr.substring(7);
      var html = `
    	  <div class="card">
			<div class="card-header \${bgColor}">
				<div class="card-title">
					<h3  class="text-white text-center">
						<font id="certificationTitle">\${title}</font>&nbsp;증명서
					</h3>
				</div>
			</div>
			<div class="card-body">
				<table class="table table-bordered pt-3">
					<tr>
						<th>사원명</th>
						<td>\${data.emplNm}</td>
					</tr>
					<tr>
						<th>사원번호</th>
						<td>\${data.emplCode}</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>\${dateStr}</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>\${data.email}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>\${phoneStr}</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>\${data.adres} \${data.detailadres}</td>
					</tr>
					<tr>
						<th>퇴사일</th>
						<td>\${data.retireDe ? data.retireDe : '재직 중'}</td>
					</tr>
					<tr>
					  <td colspan="2">
					  
					  	<div style="margin-top:100px">
					    <!-- 상단 안내 문구 -->
					    <h6 class="fw-normal text-center mt-9">
					      위의 내용이 사실임을 증명합니다.
					    </h6>
						</div>
					    <!-- 같은 가로줄(row)에 이미지와 문구를 배치 -->
					    <div class="row align-items-end" style="margin-top:260px">
					      <!-- 왼쪽 컬럼: 이미지(가운데 정렬) -->
					      <div class="d-flex justify-content-center">
					        <img src="/resources/images/stamp.png" alt="도장" style="width: 80px;">
					        
					      </div>
					      <div class="d-flex justify-content-center">
					      	<h6 class="fw-normal">(주)바티르앤코 대표이사 이지용</h6>
					      </div>
					      <!-- 오른쪽 컬럼: 텍스트(오른쪽 정렬) -->
					      <div class="text-end">
					        <p class="mb-0">
					          발행일: <span id="issuedDate">2025-02-20</span>
					        </p>
					      </div>
					    </div>
					  </td>
					</tr>

				</table>
			</div>
		</div>
      `;
      
      $("#certificationBody").html(html);
      modal.show();
    },
    error: function(e) {
        console.log(e);
        Swal.fire({
            icon: "error",
            title: "오류 발생",
            text: "데이터를 불러오는 중 오류가 발생했습니다.",
            confirmButtonText: "확인"
        });
    }
  });
}

//모달 닫기 함수 추가
function closeModal() {
    var modalElement = document.getElementById("emplCertificationModal");
    var modalInstance = bootstrap.Modal.getOrCreateInstance(modalElement);
    modalInstance.hide();
}

function printCertificate() {
    var printContents = document.getElementById('certificationBody').innerHTML;
    var originalContents = document.body.innerHTML;

    document.body.innerHTML = printContents;

    setTimeout(() => {
        window.print();
        window.location.reload();
    }, 500);
}
</script>
</html>
