<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../module/head.jsp" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<style>
	.table {
	    table-layout: fixed !important; /* 테이블 레이아웃 고정 */
	    width: 100% !important;
	    word-wrap: break-word !important;
	}

	th, td {
	    text-align: center !important; /* 텍스트 가운데 정렬 */
	    vertical-align: middle !important; /* 수직 정렬 */
	    padding: 10px !important; /* 셀 안쪽 여백 */
	    white-space: normal !important; /* 자동 줄바꿈 허용 */
	    word-wrap: break-word !important;
	    overflow: hidden !important;
	    text-overflow: ellipsis !important;
	    height: auto !important; /* 높이 자동 조정 */
	    min-height: 50px !important; /* 최소 높이 설정 */
	}

	/* 버튼과 셀 내부 요소 크기 강제 조정 */
	td select,
	td button {
	    height: 36px !important; /* 동일한 높이 설정 */
	    min-height: 36px !important;
	    max-height: 36px !important;
	}

	
</style>

<body class="link-sidebar">
	
  <%@ include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@ include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
      <%@ include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">  
        
        <!--  권한 체크 -->
        <c:if test="${pageContext.request.isUserInRole('ROLE_DEPT_RESRCE') or pageContext.request.isUserInRole('ROLE_RSPNBER_RESRCE')}">
         
         <div class="card card-body py-3">
             <div class="row align-items-center">
                 <h4 class="mb-4 mb-sm-0 card-title text-start">입출고 목록 조회</h4>
             </div>

             <!--  입출고 목록 -->
             <div class="card">
                <div class="card-body">
					<!--  필터링 UI -->
					<div class="d-flex justify-content-end mb-3">
						<div class="me-2">
							<select id="filterStatus" class="form-select" onchange="filterWarehouseByStatus()">
								<option value="">전체</option>
								<option value="입고">입고</option>
								<option value="출고">출고</option>
							</select>
						</div>

						<!-- 📅 날짜 필터 -->
						<div class="me-2">
						    <input type="date" id="startDate" class="form-control">
						</div>
						<div class="me-2">
						    <input type="date" id="endDate" class="form-control">
						</div>
						    <div class="me-2">
						        <button class="btn btn-primary" onclick="applyFilters()">검색</button>
						    </div>
							<div class="me-2">
							    <button class="btn btn-primary" onclick="resetFilters()">초기화</button>
							</div>
							<div>
							    <button class="btn btn-primary" onclick="downloadFilteredData()">엑셀 다운로드</button>
							</div>
						</div>
					</div>

                    <!--  입출고 리스트 테이블 -->
                    <div class="table-responsive mb-4 border rounded-1">
                        <table class="table text-nowrap mb-0 align-middle text-center">
                            <thead class="text-dark fs-4 text-center">
                                <tr>
                                    <th style="display: none;">기록 번호</th>
                                    <th>입출고 유형</th>
                                    <th>품목명</th> <!-- ✅ 품목명 추가 -->
                                    <th>입출고 수량</th>
                                    <th>입출고 날짜</th>
									<th>비고</th>
                                </tr>
                            </thead>
                            <tbody id="wrhsdlvrListTable">
                                <c:forEach var="w" items="${wrhsdlvrList}">
                                    <tr>
                                        <td style="display: none;">${w.rcordNo}</td>
										<td>
											<c:choose>
	                                           <c:when test="${w.wrhsdlvrTy == '01'}">입고</c:when>
	                                           <c:when test="${w.wrhsdlvrTy == '02'}">출고</c:when>
	                                           <c:otherwise>${w.wrhsdlvrTy}</c:otherwise>
	                                        </c:choose>
										</td>
                                        <td>${w.prdlstNm}</td> <!-- ✅ 품목명 출력 추가 -->
										<td>${w.wrhsdlvrQy}</td>
										<td>${w.wrhsdlvrDe}</td>
										<td>
						                <c:choose>
						                    <c:when test="${empty w.rm}">특이사항 없음</c:when>
						                    <c:otherwise>${w.rm}</c:otherwise>
						                </c:choose>
						            </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
					<div id="pagingArea" class="d-flex justify-content-center mt-4">
                        <nav aria-label="Page navigation">
                            <ul class="pagination pagination-sm m-0 float-right"></ul>
                        </nav>
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
  
 <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<script>
  // 입출고 유형 필터링
  function filterWarehouseByStatus() {
      let selectedType = document.getElementById("filterStatus").value;
      let rows = document.querySelectorAll("#wrhsdlvrListTable tr");

      rows.forEach(row => {
          let typeCell = row.cells[1]; 
          let typeValue = typeCell.textContent.trim();
          row.style.display = selectedType === "" || typeValue === selectedType ? "" : "none";
      });
  }
  const rowsPerPage = 5;
  let currentPage = 1;

  // ✅ 필터 적용 (입고/출고 + 날짜)
  function applyFilters() {
      let selectedType = document.getElementById("filterStatus").value;
      let startDate = document.getElementById("startDate").value;
      let endDate = document.getElementById("endDate").value;
      let rows = document.querySelectorAll("#wrhsdlvrListTable tr");

      let filteredRows = []; // ✅ 필터링된 데이터 저장

      rows.forEach(row => {
          let typeCell = row.cells[1]; // 입고/출고 유형
          let dateCell = row.cells[4]; // 입출고 날짜
          let typeValue = typeCell.textContent.trim();
          let dateValue = dateCell.textContent.trim();

          // ✅ YYYYMMDD 형식이면 YYYY-MM-DD로 변환
          if (/^\d{8}$/.test(dateValue)) {
              dateValue = dateValue.substring(0, 4) + "-" + dateValue.substring(4, 6) + "-" + dateValue.substring(6, 8);
          }

          // ✅ 날짜 값을 Date 객체로 변환
          let rowDate = new Date(dateValue);
          if (isNaN(rowDate)) return; // 잘못된 날짜는 무시

          let start = startDate ? new Date(startDate) : null;
          let end = endDate ? new Date(endDate) : null;

          // ✅ 필터링 조건 (입고/출고 & 날짜)
          if ((selectedType === "" || typeValue === selectedType) &&
              (!start || rowDate >= start) &&
              (!end || rowDate <= end)) {
              row.style.display = "";
              filteredRows.push(row); // ✅ 필터링된 행 추가
          } else {
              row.style.display = "none";
          }
      });

      // ✅ 필터링 후 페이지네이션 적용
      showPage(1, filteredRows);
  }

  // ✅ 초기화 버튼 (전체 리스트 표시 + 페이지네이션 업데이트)
  function resetFilters() {
      document.getElementById("filterStatus").value = "";
      document.getElementById("startDate").value = "";
      document.getElementById("endDate").value = "";

      let rows = document.querySelectorAll("#wrhsdlvrListTable tr");
      
      // ✅ 모든 행 다시 표시
      rows.forEach(row => row.style.display = "");

      showPage(1, rows); // ✅ 전체 리스트 기준으로 페이지네이션 적용
  }

  // ✅ 페이지네이션 적용 (필터링된 데이터 반영)
  function showPage(page, filteredRows = null) {
      let rows = filteredRows || Array.from(document.querySelectorAll("#wrhsdlvrListTable tr")).filter(row => row.style.display !== "none"); 
      let totalPages = Math.ceil(rows.length / rowsPerPage);

      if (totalPages === 0) totalPages = 1; // 최소 1페이지는 유지
      currentPage = page > totalPages ? totalPages : page;

      // ✅ 페이지네이션에 맞게 표시할 행 결정
      rows.forEach((row, index) => {
          row.style.display = (index >= (currentPage - 1) * rowsPerPage && index < currentPage * rowsPerPage) ? "" : "none";
      });

      updatePagination(totalPages, filteredRows);
  }

  // ✅ 페이지네이션 업데이트
  function updatePagination(totalPages, filteredRows) {
      let pagination = document.querySelector("#pagingArea .pagination");
      pagination.innerHTML = "";

      if (totalPages <= 1) return; // ✅ 1페이지 이하이면 페이지네이션 숨김

      for (let i = 1; i <= totalPages; i++) {
          let li = document.createElement("li");
          li.className = "page-item" + (i === currentPage ? " active" : "");
          let a = document.createElement("a");
          a.className = "page-link";
          a.href = "#";
          a.textContent = i;
          a.setAttribute("data-page", i);
          a.onclick = (e) => { e.preventDefault(); showPage(i, filteredRows); };
          li.appendChild(a);
          pagination.appendChild(li);
      }
  }

  // ✅ 페이지 로드 시 첫 페이지 표시
  document.addEventListener("DOMContentLoaded", () => {
      let rows = Array.from(document.querySelectorAll("#wrhsdlvrListTable tr"));
      showPage(1, rows);
  });
  
  // ✅ 필터링된 데이터를 엑셀로 다운로드하는 함수
  function downloadFilteredData() {
      let rows = Array.from(document.querySelectorAll("#wrhsdlvrListTable tr")).filter(row => row.style.display !== "none");

      if (rows.length === 0) {
    	    Swal.fire({
    	        icon: "warning",
    	        title: "데이터 없음",
    	        text: "다운로드할 데이터가 없습니다.",
    	        confirmButtonText: "확인"
    	    });
    	    return;
    	}

      let data = [];
      let headers = ["입출고 유형", "품목명", "입출고 수량", "입출고 날짜", "비고"];
      data.push(headers); // ✅ 엑셀 헤더 추가

      rows.forEach(row => {
          let cells = row.querySelectorAll("td");
          let rowData = [
              cells[1].textContent.trim(),  // 입출고 유형
              cells[2].textContent.trim(),  // 품목명
              cells[3].textContent.trim(),  // 입출고 수량
              cells[4].textContent.trim(),  // 입출고 날짜
              cells[5].textContent.trim()   // 비고
          ];
          data.push(rowData);
      });

      // ✅ SheetJS를 사용하여 엑셀 워크시트 생성
      let worksheet = XLSX.utils.aoa_to_sheet(data);
      let workbook = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(workbook, worksheet, "입출고 데이터");

      // ✅ 엑셀 파일 다운로드
      XLSX.writeFile(workbook, "입출고_데이터.xlsx");
  }


</script>

</body>
</html>
