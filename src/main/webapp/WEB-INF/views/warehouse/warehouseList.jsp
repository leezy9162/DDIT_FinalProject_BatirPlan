<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../module/head.jsp" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<head>
  <style>
    body {
        color: black !important;
    }
    h4, h5, p, strong, label, table, th, td, button, select, input, textarea {
        color: black !important;
    }
    .btn {
        color: white !important;
    }
  </style>
</head>

<body class="link-sidebar">
  <%@ include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@ include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
      <%@ include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">  
         <div class="card card-body py-3">
             <div class="row align-items-center">
                 <h4 class="mb-4 mb-sm-0 card-title">창고 목록 조회</h4>
             </div>
			</div>
             <!-- 🔹 창고 목록 -->
             <div class="card">
                <div class="card-body">
					<!-- 🔹 검색 및 필터 (우측 정렬) -->
					<div class="d-flex justify-content-end mb-3">
					    
					    <!-- 운영 상태 필터 -->
					    <div class="me-2">
					        <select id="filterStatus" class="form-select" onchange="filterWarehouseByStatus()">
					            <option value="" ${empty param.wrHousOperSttus ? 'selected' : ''}>운영 상태</option>
					            <option value="01" ${param.wrHousOperSttus == '01' ? 'selected' : ''}>운영 중</option>
					            <option value="02" ${param.wrHousOperSttus == '02' ? 'selected' : ''}>폐쇄</option>
					        </select>
					    </div>

					    <!-- 창고명 검색 -->
					    <div class="me-2">
					        <input type="text" id="searchWarehouseName" class="form-control" placeholder="창고명 검색" value="${param.wrHousNm}">
					    </div>

					    <!-- 검색 버튼 -->
					    <button class="btn btn-primary me-2" onclick="searchWarehouseByName()">검색</button>

					    <!-- 초기화 버튼 -->
					    <button class="btn btn-primary" onclick="resetFilters()">초기화</button>

					</div>
                    <!-- 🔹 창고 리스트 테이블 -->
                    <div class="table-responsive mb-4 border rounded-1">
                        <table class="table text-nowrap mb-0 align-middle text-center">
                            <thead class="text-dark fs-4 text-center">
                                <tr>
                                    <th>창고 코드</th>
                                    <th>창고명</th>
                                    <th>위치</th>
                                    <th>운영 상태</th>
                                </tr>
                            </thead>
                            <tbody id="warehouseTable">
                                <c:forEach var="warehouse" items="${requestScope.warehouses}">
                                    <tr>
                                        <td>
                                            <a href="/batirplan/warehouse/detail/${warehouse.wrHousCode}" class="warehouse-link">
                                                ${warehouse.wrHousCode}
                                            </a>
                                        </td>
                                        <td>${warehouse.wrHousNm}</td>
                                        <td>${warehouse.wrHousDetailAdres}</td>
										<td>
										    <c:choose>
										        <c:when test="${warehouse.wrHousOperSttus == '01'}">
										            <span class="badge text-bg-success">운영 중</span>
										        </c:when>
										        <c:when test="${warehouse.wrHousOperSttus == '02'}">
										            <span class="badge text-bg-danger">폐쇄</span>
										        </c:when>
										    </c:choose>
										</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- 🔹 등록 버튼: 자원관리팀 관리자만 보이도록 설정 -->
                    <c:if test="${pageContext.request.isUserInRole('ROLE_RSPNBER_RESRCE')}">
                        <div class="d-flex justify-content-start mt-3">
                            <button class="btn btn-primary me-2" id="openWarehouseModalBtn">신규</button>
                        </div>
                    </c:if>
                </div>
             </div>    
          </div>
        </div>
      </div>
    </div>
  </div>

  <%@ include file="../module/footerScript.jsp" %>

  <!-- 🔹 창고 등록 모달 -->
    <div class="modal fade" id="warehouseModal" tabindex="-1" aria-labelledby="warehouseModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">창고 등록</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="warehouseForm">
              <div class="mb-3">
                <label class="form-label">창고명</label>
                <input type="text" class="form-control" id="warehouseName" required>
              </div>
              <div class="mb-3">
                <label class="form-label">우편번호</label>
                <div class="input-group">
                  <input type="text" class="form-control" id="warehouseZip" readonly>
                  <button class="btn btn-primary" type="button" onclick="DaumPostcode()">우편번호 찾기</button>
                </div>
              </div>
              <div class="mb-3">
                <label class="form-label">상세 주소</label>
                <input type="text" class="form-control" id="warehouseDetailAdres">
              </div>
              <div class="mb-3">
                <label class="form-label">운영 상태</label>
                <select class="form-select" id="warehouseStatus">
                  <option value="01">운영 중</option>
                  <option value="02">폐쇄</option>
                </select>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn btn-primary" id="registerWarehouse">등록</button>
          </div>
        </div>
      </div>
    </div>


	<!-- 🔹 Daum 주소 API (필수) -->
	 <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	 <script>
	   function DaumPostcode() {
	       new daum.Postcode({
	           oncomplete: function(data) {
	               document.getElementById('warehouseZip').value = data.zonecode;
	               document.getElementById('warehouseDetailAdres').value = data.address;
	           }
	       }).open();
	   }


    document.addEventListener("DOMContentLoaded", function () {
        var registerButton = document.getElementById("openWarehouseModalBtn");
        if (registerButton) {
            registerButton.addEventListener("click", function () {
                var modalElement = document.getElementById('warehouseModal');
                var myModal = new bootstrap.Modal(modalElement);
                myModal.show();
            });
        }

        document.querySelector("#registerWarehouse").addEventListener("click", function () {
            var data = {
                wrHousNm: document.getElementById('warehouseName').value,
				wrHousDetailAdres: document.getElementById('warehouseDetailAdres').value, // 📌 상세 주소 추가
                wrHousZip: document.getElementById('warehouseZip').value,
				wrHousOperSttus: document.getElementById('warehouseStatus').value, 
                partclrMatter: document.getElementById('warehouseNote').value
            };

            fetch("/batirplan/warehouse/register", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                Swal.fire({
                    icon: "success",
                    title: "창고 등록 완료",
                    text: "✅ 창고가 등록되었습니다.",
                    confirmButtonText: "확인"
                }).then(() => {
                    location.reload();
                });
            })
            .catch(error => {
                Swal.fire({
                    icon: "error",
                    title: "등록 실패",
                    text: "❌ 등록 실패: " + error.message,
                    confirmButtonText: "확인"
                });
            });
        });
    });
	/**
	     * 📌 창고명 검색
	     */
	    function searchWarehouseByName() {
	        let warehouseName = document.getElementById("searchWarehouseName").value.trim();
	        let currentParams = new URLSearchParams(window.location.search);

	        if (warehouseName) {
	            currentParams.set("wrHousNm", warehouseName);
	        } else {
	            currentParams.delete("wrHousNm");
	        }

	        window.location.search = currentParams.toString();
	    }

	    /**
	     * 📌 운영 상태 필터링
	     */
	    function filterWarehouseByStatus() {
	        let warehouseStatus = document.getElementById("filterStatus").value;
	        let currentParams = new URLSearchParams(window.location.search);

	        if (warehouseStatus) {
	            currentParams.set("wrHousOperSttus", warehouseStatus);
	        } else {
	            currentParams.delete("wrHousOperSttus");
	        }

	        window.location.search = currentParams.toString();
	    }
		/**
		 * 📌 필터 초기화 (전체 리스트 출력)
		 */
		function resetFilters() {
		    window.location.search = ""; // 모든 필터 제거 후 전체 리스트 출력
		}
  </script>
</body>
</html>