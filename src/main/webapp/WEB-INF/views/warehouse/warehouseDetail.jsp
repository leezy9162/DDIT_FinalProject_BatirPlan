<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../module/head.jsp" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<head>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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

          <!-- 제목 바 -->
          <div class="card w-100">
            <div class="card-body py-3">
              <div class="row align-items-center">
                <h4 class="mb-4 mb-sm-0 card-title">창고 상세보기</h4>
              </div>
            </div>
          </div>

          <!-- warehouse 객체가 null인 경우 예외 처리 -->
          <c:if test="${empty warehouse}">
            <div class="alert alert-danger mt-4">
              <strong> 창고 정보를 찾을 수 없습니다.</strong><br>
              <a href="/batirplan/warehouse/list" class="btn btn-primary mt-2">창고 목록으로 이동</a>
            </div>
          </c:if>

          <c:if test="${not empty warehouse}">
			<!-- 상세 정보 -->
			          <div class="card w-100 mt-4">
			            <div class="card-body">
			              <h5 class="card-title">${warehouse.wrHousNm}</h5>
			              <div class="text-end">
			                창고 코드: <strong>${warehouse.wrHousCode}</strong> /
			                우편번호: ${warehouse.wrHousZip}
			              </div>
						  <div class="card-body border-top p-0">
						    <div class="d-flex justify-content-between align-items-start">
						      <!-- 왼쪽: 창고 정보 -->
						      <div class="w-50">
							<br/>
							<br/>
							<br/>
						        <p><strong>위치:</strong> ${warehouse.wrHousLc} ${warehouse.wrHousDetailAdres}</p>
						        <p><strong>운영 상태:</strong> 
						          <c:choose>
						            <c:when test="${warehouse.wrHousOperSttus eq '01'}">운영 중</c:when>
						            <c:when test="${warehouse.wrHousOperSttus eq '02'}">폐쇄</c:when>
						            <c:otherwise>알 수 없음</c:otherwise>
						          </c:choose>
						        </p>
						        <p><strong>비고:</strong> ${warehouse.partclrMatter}</p>
						      </div>
						      <!-- 오른쪽: 도넛 차트 -->
						      <div class="w-50 text-center">
						        <div id="warehouseDonutChart" style="width: 80%; height: 200px;"></div>
						      </div>
						    </div>
						  </div>
							<br>	
							<div id="map" style="width:100%;height:350px;"></div>
						  <div class="mt-4">
						      <h5 class="card-title"> 창고 내 자재 목록</h5>
						      <c:choose>
						          <c:when test="${empty warehouseMaterials}">
						              <p class="text-muted">등록된 자재가 없습니다.</p>
						          </c:when>
						          <c:otherwise>
						              <table class="table table-bordered mt-3">
						                  <thead>
						                      <tr class="table-primary">
						                          <th>자재 번호</th>
						                          <th>자재명</th> <!--  자재명 추가 -->
						                          <th>규격</th> <!--  규격 추가 -->
						                          <th>단위</th> <!-- 단위 추가 -->
						                          <th>재고 수량</th>
						                          <th>최근 업데이트</th>
						                      </tr>
						                  </thead>
						                  <tbody>
						                      <c:forEach var="material" items="${warehouseMaterials}">
						                          <tr>
						                              <td>${material.prdlstNo}</td>
						                              <td>${material.prdlstNm}</td> <!--  자재명 표시 -->
						                              <td>${material.prdlstStndrd}</td> <!--  규격 표시 -->
						                              <td>${material.prdlstUnit}</td> <!--  단위 표시 -->
						                              <td>
						                                  <c:choose>
						                                      <c:when test="${material.invntryQy > 0}">${material.invntryQy} 개</c:when>
						                                      <c:otherwise>재고 없음</c:otherwise>
						                                  </c:choose>
						                              </td>
						                              <td>${material.newestUpdtDe}</td>
						                          </tr>
						                      </c:forEach>
						                  </tbody>
						              </table>
						          </c:otherwise>
						      </c:choose>
						  </div>
              <div class="text-end mt-4">
                <a href="/batirplan/warehouse/list" class="btn btn-primary me-2">목록</a>

                <!-- 수정 및 폐쇄 버튼: 자원관리팀 관리자만 활성화 -->
                <c:if test="${pageContext.request.isUserInRole('ROLE_RSPNBER_RESRCE')}">
                  <button class="btn btn-warning me-2" onclick="openEditModal()">수정</button>

				  <!-- 📌 창고 폐쇄 버튼 -->
				         <button class="btn btn-danger" id="closeWarehouseBtn" 
						    onclick="confirmCloseWarehouse('${warehouse.wrHousCode}')"
					      <c:if test="${warehouse.hasMaterials}">disabled</c:if>>폐쇄</button>
                </c:if>
              </div>
					  </div>
				  </div>


            </div>
          </div>
          </c:if>
        </div>
      </div>
    </div>
  </div>
  <%@ include file="../module/footerScript.jsp" %>

  <!-- Daum 우편번호 API -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <!-- 수정 모달 -->
  <div class="modal fade" id="editWarehouseModal" tabindex="-1" aria-labelledby="editWarehouseModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="editWarehouseModalLabel">창고 정보 수정</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form id="editWarehouseForm">
            <input type="hidden" id="editWarehouseCode" value="${warehouse.wrHousCode}">
            <input type="hidden" id="editWarehouseOperSttus" value="${warehouse.wrHousOperSttus}">
            <div class="mb-3">
              <label class="form-label">창고 이름</label>
              <input type="text" class="form-control" id="editWarehouseName" value="${warehouse.wrHousNm}" required>
            </div>
            <div class="mb-3">
              <label class="form-label">우편번호</label>
              <div class="input-group">
                <input type="text" class="form-control" id="editWarehouseZip" value="${warehouse.wrHousZip}" readonly>
                <button class="btn btn-primary" type="button" onclick="DaumPostcode()">우편번호 찾기</button>
              </div>
            </div>
            <div class="mb-3">
              <label class="form-label">상세 주소</label>
              <input type="text" class="form-control" id="editWarehouseDetailAdres" value="${warehouse.wrHousDetailAdres}">
            </div>
            <div class="mb-3">
              <label class="form-label">비고</label>
              <textarea class="form-control" id="editWarehouseNote">${warehouse.partclrMatter}</textarea>
            </div>
          </form>
        </div>

        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          <button type="button" class="btn btn-primary" onclick="saveWarehouseEdit()">저장</button>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=126a30d2a46843ee25bc69a141aa9849&libraries=services"></script>
    <script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${warehouse.wrHousLc} ${warehouse.wrHousDetailAdres}', function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">${warehouse.wrHousNm}</div>'
		        });
		        infowindow.open(map, marker);

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});    
		
      function openEditModal() {
          var modalElement = document.getElementById('editWarehouseModal');
          if (modalElement) {
              var myModal = bootstrap.Modal.getOrCreateInstance(modalElement);
              myModal.show();
          }
      }

	  function DaumPostcode() {
	      new daum.Postcode({
	          oncomplete: function(data) {
	              //  우편번호 입력 필드 업데이트
	              document.getElementById('editWarehouseZip').value = data.zonecode;

	              //  도로명 주소 입력 필드 업데이트
	              document.getElementById('editWarehouseDetailAdres').value = data.roadAddress;

	              //  자동으로 상세주소 입력 필드에 포커스
	              document.getElementById('editWarehouseDetailAdres').focus();
	          }
	      }).open();
	  }

      function saveWarehouseEdit() {
          var data = {
              wrHousCode: document.getElementById('editWarehouseCode').value,
              wrHousOperSttus: document.getElementById('editWarehouseOperSttus').value,
              wrHousNm: document.getElementById('editWarehouseName').value,
              wrHousDetailAdres: document.getElementById('editWarehouseDetailAdres').value,
              wrHousZip: document.getElementById('editWarehouseZip').value,
              partclrMatter: document.getElementById('editWarehouseNote').value
          };

          fetch("/batirplan/warehouse/update", {
              method: "POST",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify(data)
          })
          .then(response => response.json())
          .then(result => {
        	    if (result.success) {
        	        Swal.fire({
        	            icon: "success",
        	            title: "수정 완료",
        	            text: "창고 정보 수정 완료",
        	            confirmButtonText: "확인"
        	        }).then(() => {
        	            location.reload();
        	        });
        	    } else {
        	        Swal.fire({
        	            icon: "error",
        	            title: "수정 실패",
        	            text: "❌ 수정 실패: " + result.message,
        	            confirmButtonText: "확인"
        	        });
        	    }
        	})
        	.catch(error => {
        	    Swal.fire({
        	        icon: "error",
        	        title: "서버 오류",
        	        text: "❌ 서버 오류 발생",
        	        confirmButtonText: "확인"
        	    });
        	});
      }

      
      /**
       *  창고 폐쇄 요청 (AJAX)
       */
       function confirmCloseWarehouse(wrHousCode) {
    	    Swal.fire({
    	        title: '창고를 폐쇄하시겠습니까?',
    	        text: '폐쇄된 창고는 복구할 수 없습니다.',
    	        icon: 'warning',
    	        showCancelButton: true,
    	        confirmButtonText: '폐쇄',
    	        cancelButtonText: '취소'
    	    }).then((result) => {
    	        if (result.isConfirmed) {
    	            fetch(`/batirplan/warehouse/close/${wrHousCode}`, { // URL에 창고 코드 포함
    	                method: "POST",
    	                headers: { "Content-Type": "application/json" }
    	            })
    	            .then(response => {
    	                if (!response.ok) {
    	                    return response.json().then(errorData => {
    	                        throw new Error(errorData.message || "서버 오류 발생");
    	                    });
    	                }
    	                return response.json();
    	            })
    	            .then(result => {
    	                Swal.fire({
    	                    icon: "success",
    	                    title: "창고 폐쇄 완료",
    	                    text: "창고가 폐쇄되었습니다.",
    	                    confirmButtonText: "확인"
    	                }).then(() => {
    	                    location.href = "/batirplan/warehouse/list"; // 창고 목록 페이지로 이동
    	                });
    	            })
    	            .catch(error => {
    	                Swal.fire({
    	                    icon: "error",
    	                    title: "오류 발생",
    	                    text: "❌ " + error.message,
    	                    confirmButtonText: "확인"
    	                });
    	                console.error(" 오류 발생:", error);
    	            });
    	        }
    	    });
    	}
	  
	  document.addEventListener("DOMContentLoaded", function () {
	     var warehouseMaterials = [
	       <c:forEach var="material" items="${warehouseMaterials}">
	         {
	           name: "${material.prdlstNm}",
	           quantity: ${material.invntryQy}
	         },
	       </c:forEach>
	     ];

	     // 데이터 배열
	     var materialNames = warehouseMaterials.map(item => item.name);
	     var materialQuantities = warehouseMaterials.map(item => item.quantity);

	     var options = {
	       series: materialQuantities,
	       chart: {
	         type: "donut",
	         height: 300
	       },
	       labels: materialNames,
	       dataLabels: {
	         enabled: true,
	         formatter: function (val) {
	           return val.toFixed(1) + "%"; // 소수점 한 자리까지 표시
	         }
	       },
	       legend: {
	         position: "right",
	         offsetY: 10
	       },
	       colors: ["#008FFB", "#FF4560", "#00E396", "#FEB019", "#775DD0", "#F86624"]
	     };

	     var chart = new ApexCharts(document.querySelector("#warehouseDonutChart"), options);
	     chart.render();
	   });
      
  </script>

</body>
</html>
