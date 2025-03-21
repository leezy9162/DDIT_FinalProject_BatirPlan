<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../module/head.jsp" %>
<body class="link-sidebar">
  <%@ include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@ include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
      <%@ include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

          <!-- 작업 영역 Start -->
          <div class="card card-body py-3">
            <h4 class="mb-0 card-title">
              <i class="fa-solid fa-pencil" style="color: #1E90FF;"></i> 쪽지 쓰기
            </h4>
          </div>

          <div class="card">
            <div class="card-body">
              <!-- 쪽지쓰기 폼 -->
              <form action="${pageContext.request.contextPath}/batirplan/message/send" method="POST">
                <!-- 수신자 선택 영역 -->
                <div class="form-group mb-3">
                  <label for="rcverName">수신자:</label>
                  <div class="input-group" style="width: 50%;">
                    <input type="text" id="rcverName" name="rcverName" class="form-control" placeholder="수신자 이름" readonly required>
                    <input type="hidden" id="rcver" name="rcver">
                    <button type="button" class="btn btn-secondary" onclick="openSelectionModal()">수신자 선택</button>
                  </div>
                </div>

                <!-- 쪽지 내용 입력 -->
                <div class="form-group mb-3">
                  <label for="cn">내용:</label>
                  <textarea id="cn" name="cn" class="form-control" rows="5" placeholder="쪽지 내용을 입력하세요." required></textarea>
                </div>

                <!-- 버튼 영역 -->
                <div class="d-flex justify-content-start mt-3">
                  <button type="submit" class="btn btn-primary me-2">보내기</button>
                  <button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
                </div>
              </form>
            </div>
          </div>
          <!-- 작업 영역 End -->
        </div>
      </div>
    </div>
  </div>
  <%@ include file="../module/footerScript.jsp" %>

  <!-- 수신자 선택 모달 -->
  <div id="approverSelectionModal" class="modal" style="display:none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5);">
    <div class="modal-content" style="background-color: #fff; margin: 10% auto; padding: 20px; border-radius: 8px; width: 80%; max-width: 600px;">
      <h4>수신자 선택</h4>

      <!-- 검색 입력란 -->
      <div class="mb-2">
        <input type="text" id="employeeSearchKeyword" placeholder="수신자를 입력해주세요" class="form-control">
        <button type="button" class="btn btn-outline-primary mt-2" onclick="searchEmployee()">검색</button>
      </div>

      <!-- 직원 목록 테이블 (스크롤 적용) -->
      <div style="max-height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 5px;">
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>부서</th>
              <th>직급</th>
              <th>이름</th>
            </tr>
          </thead>
          <tbody id="employeeTableBody">
            <c:set var="prevDept" value=""/>
            <c:forEach var="employee" items="${employeeList}">
              <tr class="employeeRow clickable" data-id="${employee.emplCode}" data-name="${employee.emplNm}">
                <c:choose>
                  <c:when test="${employee.deptNm ne prevDept}">
                    <td>${employee.deptNm}</td>
                    <c:set var="prevDept" value="${employee.deptNm}"/>
                  </c:when>
                  <c:otherwise>
                    <td></td> <!-- 부서 중복 제거 -->
                  </c:otherwise>
                </c:choose>
                <td>${employee.clsfNm}</td>
                <td>${employee.emplNm}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <button type="button" class="btn btn-secondary" onclick="closeSelectionModal()">취소</button>
    </div>
  </div>

  <!-- 직원 검색 및 목록 로딩 스크립트 -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    function openSelectionModal() {
        $('#employeeSearchKeyword').val(''); // 검색어 초기화
        $('#employeeTableBody').empty(); // 기존 목록 초기화
        fetchEmployeeList(); // 전체 직원 목록 불러오기
        document.getElementById("approverSelectionModal").style.display = "block";
    }

    function closeSelectionModal() {
        document.getElementById("approverSelectionModal").style.display = "none";
    }

    $(document).on('click', '.employeeRow', function(){
        var empCode = $(this).data('id');
        var empName = $(this).data('name');
        $('#rcver').val(empCode);
        $('#rcverName').val(empName);
        closeSelectionModal();
    });

    function fetchEmployeeList() {
        $.ajax({
            url: '${pageContext.request.contextPath}/batirplan/message/employeeSearch',
            type: 'GET',
            data: { keyword: '' },
            dataType: 'json',
            success: function(data) {
                updateEmployeeTable(data);
            },
            error: function() {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "직원 목록을 불러오는 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    }

    function searchEmployee() {
        var keyword = $('#employeeSearchKeyword').val();
        if (keyword.trim() === "") {
            fetchEmployeeList();
            return;
        }
        $.ajax({
            url: '${pageContext.request.contextPath}/batirplan/message/employeeSearch',
            type: 'GET',
            data: { keyword: keyword },
            dataType: 'json',
            success: function(data) {
                updateEmployeeTable(data);
            },
            error: function() {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "직원 검색 중 오류가 발생했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    }

    function updateEmployeeTable(data) {
        var tbody = $('#employeeTableBody');
        tbody.empty();
        var prevDept = "";
        if (data.length === 0) {
            tbody.append('<tr><td colspan="3" class="text-center">검색 결과가 없습니다.</td></tr>');
        } else {
            $.each(data, function(index, emp){
                var row = $('<tr class="employeeRow clickable" style="cursor:pointer;"></tr>')
                    .attr('data-id', emp.emplCode)
                    .attr('data-name', emp.emplNm);
                if (prevDept !== emp.deptNm) {
                    row.append('<td>' + emp.deptNm + '</td>');
                    prevDept = emp.deptNm;
                } else {
                    row.append('<td></td>');
                }
                row.append('<td>' + emp.clsfNm + '</td>');
                row.append('<td>' + emp.emplNm + '</td>');
                tbody.append(row);
            });
        }
    }
  </script>
</body>
</html>
