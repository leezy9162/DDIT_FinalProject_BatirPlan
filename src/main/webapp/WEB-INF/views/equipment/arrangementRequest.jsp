<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->

<style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }
    th {
        background-color: #f8f9fa;
        font-weight: bold;
        text-align: center;
    }
    input, textarea {
        width: calc(100% - 120px); /* 버튼과 간격 고려 */
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 5px;
        display: inline-block;
    }
    textarea {
        resize: none;
    }
    .btn {
        padding: 8px 12px;
        font-size: 14px;
        font-weight: bold;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        transition: background 0.2s ease-in-out;
        margin-left: 5px;
    }
    .btn-primary {
        background-color: #635bff;
        color: white;
    }
    .btn-primary:hover {
        background-color: #635bff;
    }
    .btn-secondary {
        background-color: #635bff;
        color: white;
    }
    .modal {
        display: none;
        position: fixed;
        z-index: 999;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.4);
    }
    .modal-content {
    background-color: white;
    margin: 5% auto; 
    padding: 15px;
    width: 40%; 
    max-width: 600px; 
    border-radius: 8px;
    max-height: 70vh; /* 🔥 최대 높이 설정 */
    overflow-y: auto; /* 🔥 스크롤 가능하도록 설정 */
	}

    .close {
        float: right;
        font-size: 22px;
        cursor: pointer;
    }
    .close:hover {
        color: red;
    }
    .in-use {
        color: red;
        font-weight: bold;
    }
    
        /* 🔹 모달 내부 검색 영역 정렬 */
    .modal-search {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-top: 10px;
    }

    .modal-search input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }

    .modal-search button {
        margin-left: 10px;
        padding: 10px 15px;
        font-size: 14px;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        background-color: #635bff;
        color: white;
        cursor: pointer;
        transition: 0.3s;
    }

    .modal-search button:hover {
        background-color: #635bff;
    }
        .modal-content button {
        background-color: #635bff !important;
        color: white !important;
        border: none !important;
        padding: 8px 12px;
        font-size: 14px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: 0.3s;
    }

    .modal-content button:hover {
        background-color: #635bff !important;
    }
    
    
</style>




  
<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper" >

	<%@include file="../module/sideBar.jsp" %>
	<div class="page-wrapper">
	
		<%@include file="../module/navBar.jsp" %>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->

	<div class="card card-body py-3">
		<div class="row align-items-center">
		  <h4 class="mb-4 mb-sm-0 card-title">장비 배치 신청</h4>
		</div>
	</div>

                <!-- 신청 폼 -->
                <div class="card">
                    <div class="card-body">
                        <form action="/batirplan/equipment/arrangement/request" method="post">
                            <table>
                                <tr>
                                    <td><label for="prjctNo">프로젝트 번호</label></td>
                                    <td>
                                        <input type="text" id="prjctNo" name="prjctNo" readonly required>
                                        <button type="button" class="btn btn-primary" id="openProjectModal">선택</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for="prjctNm">프로젝트명</label></td>
                                    <td><input type="text" id="prjctNm" name="prjctNm" readonly></td>
                                </tr>
                                <tr>
                                    <td><label for="prjctLc">프로젝트 위치</label></td>
                                    <td><input type="text" id="prjctLc" name="prjctLc" readonly></td>
                                </tr>
                                <tr>
                                    <td><label for="emplCode">배치 신청자</label></td>
                                    <td>
                                        <input type="hidden" id="emplCode" name="emplCode" required>
                                        <input type="text" id="emplNm" name="emplNm" readonly required>
                                        <button type="button" class="btn btn-primary" id="openEmployeeModal">선택</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>장비 선택</label></td>
                                    <td>
                                        <input type="hidden" id="eqpmnNo" name="eqpmnNo" required>
                                        <span id="selectedEquipment">선택된 장비 없음</span>
                                        <button type="button" class="btn btn-primary" id="openEquipmentModal">선택</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for="arrangementReason">배치 신청 사유</label></td>
                                    <td><textarea id="arrangementReason" name="arrangementReason" rows="4" required></textarea></td>
                                </tr>
                                <tr>
                                    <td><label for="rentalStartDate">대여 시작일</label></td>
                                    <td><input type="date" id="rentalStartDate" name="rentalStartDate" required></td>
                                </tr>
                                <tr>
                                    <td><label for="rentalEndDate">대여 종료일</label></td>
                                    <td><input type="date" id="rentalEndDate" name="rentalEndDate" required></td>
                                </tr>
                            </table>
                            <br>
                            <button type="submit" class="btn btn-primary">신청</button>
                            <a href="/batirplan/equipment/arrangement/list" class="btn btn-secondary">취소</a>
                        </form>
                    </div>
                </div>

                <!-- 🔹 프로젝트 선택 모달 -->
                <div id="projectModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>프로젝트 검색</h3>

        <!-- ✅ 검색창과 버튼을 한 줄로 정렬 -->
        <div class="modal-search">
            <input type="text" id="searchProjectKeyword" placeholder="프로젝트명을 입력하세요">
            <button type="button" class="btn btn-primary" id="searchProjectBtn">검색</button>
        </div>

        <table id="projectResults">
            <thead>
                <tr>
                    <th>프로젝트 번호</th>
                    <th>프로젝트명</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>
                <!-- 🔹 장비 선택 모달 -->
                <div id="equipmentModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>장비 검색</h3>
        
        <!-- ✅ 검색창과 버튼을 한 줄로 정렬 -->
        <div class="modal-search">
            <input type="text" id="searchEquipmentKeyword" placeholder="장비명을 입력하세요">
            <button type="button" class="btn btn-primary" id="searchEquipmentBtn">검색</button>
        </div>

        <table id="equipmentResults">
            <thead>
                <tr>
                    <th>장비 번호</th>
                    <th>장비명</th>
                    <th>장비 유형</th>
                    <th>일련번호</th>
                    <th>제조사</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>

                <!-- 🔹 신청자 선택 모달 -->
                <div id="employeeModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h3>신청자 검색</h3>
        
        <!-- ✅ 검색창과 버튼을 한 줄로 정렬 -->
        <div class="modal-search">
            <input type="text" id="searchEmployeeKeyword" placeholder="이름, 부서, 직급을 입력하세요">
            <button type="button" class="btn btn-primary" id="searchEmployeeBtn">검색</button>
        </div>

        <table id="employeeResults">
            <thead>
                <tr>
                    <th>부서</th>
                    <th>직급</th>
                    <th>이름</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>

            </div>
        </div>
    </div>
</div>
    
<%@include file="../module/footerScript.jsp" %>

    <script>
    $(document).ready(function() {
        /** ✅ 프로젝트 선택 모달 기능 **/
        $("#openProjectModal").click(function() {
            $("#searchProjectKeyword").val(""); // 검색어 초기화
            $("#projectResults tbody").empty(); // 결과 초기화
            $("#projectModal").show();
            loadProjectList(""); // 전체 프로젝트 목록 불러오기
        });

        $("#searchProjectBtn").click(function() {
            var keyword = $("#searchProjectKeyword").val().trim();
            loadProjectList(keyword); // 검색 결과 불러오기
        });

        function loadProjectList(keyword) {
            $.ajax({
                url: "/batirplan/equipment/arrangement/searchProject",
                data: { keyword: keyword },
                success: function(projects) {
                    var resultHtml = "";
                    projects.forEach(function(project) {
                        resultHtml += "<tr>";
                        resultHtml += "<td>" + project.prjctNo + "</td>";
                        resultHtml += "<td>" + project.prjctNm + "</td>";
                        resultHtml += "<td><button class='select-project' data-prjct-no='" + project.prjctNo + 
                                      "' data-prjct-nm='" + project.prjctNm + "' data-prjct-lc='" + project.prjctLc + 
                                      "'>선택</button></td>";
                        resultHtml += "</tr>";
                    });
                    $("#projectResults tbody").html(resultHtml);
                }
            });
        }

        $(document).on("click", ".select-project", function() {
            $("#prjctNo").val($(this).data("prjct-no"));
            $("#prjctNm").val($(this).data("prjct-nm"));
            $("#prjctLc").val($(this).data("prjct-lc"));
            $("#projectModal").hide();
        });

        /** ✅ 장비 선택 모달 기능 **/
        $("#openEquipmentModal").click(function() {
            $("#searchEquipmentKeyword").val(""); // 검색어 초기화
            $("#equipmentResults tbody").empty(); // 결과 초기화
            $("#equipmentModal").show();
            loadEquipmentList(""); // 전체 장비 목록 불러오기
        });

        $("#searchEquipmentBtn").click(function() {
            var keyword = $("#searchEquipmentKeyword").val().trim();
            loadEquipmentList(keyword); // 검색 결과 불러오기
        });

        function loadEquipmentList(keyword) {
            $.ajax({
                url: "/batirplan/equipment/searchEquipment",
                data: { keyword: keyword },
                success: function(equipments) {
                    var resultHtml = "";
                    equipments.forEach(function(equip) {
                        var disabled = equip.eqpmnSttus !== "01" ? "disabled" : "";
                        var statusText = "";

                        if (equip.eqpmnSttus === "02") {
                            statusText = " <span class='in-use'>(사용중)</span>";
                        } else if (equip.eqpmnSttus === "03") {
                            statusText = " <span class='in-use'>(수리중)</span>";
                        }

                        resultHtml += "<tr>";
                        resultHtml += "<td>" + equip.eqpmnNo + "</td>";
                        resultHtml += "<td>" + equip.eqpmnNm + statusText + "</td>";
                        resultHtml += "<td>" + equip.eqpmnTy + "</td>";
                        resultHtml += "<td>" + equip.eqpmnSn + "</td>";
                        resultHtml += "<td>" + equip.makrNm + "</td>";
                        resultHtml += "<td><button class='select-equipment' data-eqpmn-no='" + equip.eqpmnNo + 
                                      "' data-eqpmn-nm='" + equip.eqpmnNm + "' " + disabled + ">선택</button></td>";
                        resultHtml += "</tr>";
                    });
                    $("#equipmentResults tbody").html(resultHtml);
                }
            });
        }

        $(document).on("click", ".select-equipment", function() {
            $("#eqpmnNo").val($(this).data("eqpmn-no"));
            $("#selectedEquipment").text($(this).data("eqpmn-nm"));
            $("#equipmentModal").hide();
        });

        /** ✅ 신청자 모달 기능 **/
        $("#openEmployeeModal").click(function() {
            $("#searchEmployeeKeyword").val(""); // 검색어 초기화
            $("#employeeResults tbody").empty(); // 결과 초기화
            $("#employeeModal").show();
            loadEmployeeList(""); // 처음에는 전체 사원 목록을 불러옴
        });

        $("#searchEmployeeBtn").click(function() {
            var keyword = $("#searchEmployeeKeyword").val().trim();
            loadEmployeeList(keyword); // 검색 결과 가져오기
        });

        function loadEmployeeList(keyword) {
            $.ajax({
                url: "/batirplan/equipment/arrangement/searchEmployee",
                data: { keyword: keyword },
                success: function(employees) {
                    var resultHtml = "";
                    var lastDept = "";

                    employees.forEach(function(emp) {
                        resultHtml += "<tr>";
                        if (lastDept !== emp.deptNm) {
                            resultHtml += "<td>" + emp.deptNm + "</td>"; 
                            lastDept = emp.deptNm;
                        } else {
                            resultHtml += "<td></td>"; 
                        }

                        resultHtml += "<td>" + emp.clsfNm + "</td>";
                        resultHtml += "<td>" + emp.emplNm + "</td>";
                        resultHtml += "<td><button class='select-employee' data-empl-code='" + emp.emplCode + 
                                      "' data-empl-nm='" + emp.emplNm + "'>선택</button></td>";
                        resultHtml += "</tr>";
                    });

                    $("#employeeResults tbody").html(resultHtml);
                }
            });
        }

        $(document).on("click", ".select-employee", function() {
            $("#emplCode").val($(this).data("empl-code"));
            $("#emplNm").val($(this).data("empl-nm"));
            $("#employeeModal").hide();
        });

        /** ✅ 모달 닫기 기능 **/
        $(".close").click(function() {
            $(".modal").hide();
        });
    });


    </script>


</body>
</html>