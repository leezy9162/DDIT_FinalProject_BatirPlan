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
                            <h4 class="mb-4 mb-sm-0 card-title">급여 지급 관리</h4>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                        <h4 class="card-title">미지급 사원</h4>
                        
                            <!-- 검색 영역 -->
                            <div class="d-flex justify-content-end align-items-center mb-3">
                                <form id="searchForm" class="d-flex align-items-center">
                                    <input type="month" id="salaryYm" name="salaryYm" class="form-control form-control-sm" style="width: 180px; min-width: 150px;">
                                    <button class="btn btn-sm btn-primary" type="button" onclick="loadSalaryData()">조회</button>
                                </form>
                            </div>

                            <!-- 미지급 사원 목록 -->
                            <div class="table-responsive mb-4 border rounded-1">
                                <table class="table text-nowrap mb-0 align-middle">
                                    <thead class="text-dark fs-4">
                                        <tr>
                                            <th><input type="checkbox" id="selectAll" class="form-check-input"></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">사원명</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">직급</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">급여</h6></th>
                                        </tr>
                                    </thead>
                                    <tbody id="unpaidList">
                                    	<tr> 
                                    		<td colspan="4" class="text-center">
                                    				선택된 데이터가 없습니다.
                               				</td>
                                    	</tr>
                                    </tbody>
                                </table>
                            </div>
                            <button class="btn btn-primary mb-3" onclick="processPayment()">지급 처리</button>

                            <!-- 지급된 사원 목록 -->
                            <h4 class="card-title mb-3">지급 사원</h4>
                            <div class="table-responsive mb-4 border rounded-1">
                                <table class="table text-nowrap mb-0 align-middle">
                                    <thead class="text-dark fs-4">
                                        <tr>
                                            <th><h6 class="fs-4 fw-semibold mb-0">사원명</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">직급</h6></th>
                                            <th><h6 class="fs-4 fw-semibold mb-0">급여</h6></th>
                                        </tr>
                                    </thead>
                                    <tbody id="paidList">
                                    	<tr>
                                    		<td colspan="3" class="text-center">
                                    			선택된 데이터가 없습니다.
                                    		</td>
                                    	</tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
    <%@include file="../module/footerScript.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
    $(document).ready(function () {
        // ✅ 전체 선택 체크박스 이벤트
        $(document).on("change", "#selectAll", function () {
            $(".payCheckbox").prop("checked", this.checked); // 전체 체크박스 변경
        });

        // ✅ 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
        $(document).on("change", ".payCheckbox", function () {
            let total = $(".payCheckbox").length;
            let checked = $(".payCheckbox:checked").length;
            $("#selectAll").prop("checked", total === checked); // 모든 항목 선택 시 체크 ON
        });
    });
    
    function loadSalaryData() {
        let salaryYm = $("#salaryYm").val(); // YYYY-MM 형식의 값

        if (!salaryYm) {
            Swal.fire({
                icon: "warning",
                title: "급여 연월 선택",
                text: "급여 연월을 선택하세요!",
                confirmButtonText: "확인"
            });
            return;
        }

        salaryYm = salaryYm.replace("-", ""); // 2025-01 -> 202501 형식 변환

        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/fnnr/salary/unpaid",
            type: "GET",
            data: { salaryYm: salaryYm },
            success: function(data) {
                let tableBody = $("#unpaidList");
                tableBody.empty(); // 기존 데이터 삭제

                if (data.length === 0) {
                    tableBody.append("<tr><td colspan='4' class='text-center'>미지급된 사원이 없습니다.</td></tr>");
                    return;
                }

                let unpaidList = "";
                $.each(data, function(index, salary) {
                    unpaidList += "<tr>";
                    unpaidList += "<td><input type='checkbox' class='payCheckbox form-check-input' value='" + salary.emplCode + "'></td>";
                    unpaidList += "<td>" + salary.emplName + "</td>";
                    unpaidList += "<td>" + salary.clsfNm + "</td>";
                    unpaidList += "<td>" + salary.pymntAmount.toLocaleString() + " 원</td>";
                    unpaidList += "</tr>";
                });
                tableBody.html(unpaidList);
            },
            error: function(xhr) {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "미지급 급여 데이터를 불러오는 중 오류가 발생했습니다. 상태 코드: " + xhr.status,
                    confirmButtonText: "확인"
                });
            }
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/fnnr/salary/paid",
            type: "GET",
            data: { salaryYm: salaryYm },
            success: function(data) {
                let tableBody = $("#paidList");
                tableBody.empty(); // 기존 데이터 삭제

                if (data.length === 0) {
                    tableBody.append("<tr><td colspan='3'>지급된 사원이 없습니다.</td></tr>");
                    return;
                }

                let paidList = "";
                $.each(data, function(index, salary) {
                    paidList += `<tr>
                        <td>\${salary.emplName}</td>
                        <td>\${salary.clsfNm}</td>
                        <td>\${salary.pymntAmount.toLocaleString()} 원</td>
                    </tr>`;
                });
                tableBody.html(paidList);
            },
            error: function(xhr) {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생",
                    text: "지급된 급여 데이터를 불러오는 중 오류가 발생했습니다. 상태 코드: " + xhr.status,
                    confirmButtonText: "확인"
                });
            }
        });
    }

    function processPayment() {
        let salaryYm = $("#salaryYm").val().replace("-", ""); // YYYY-MM → YYYYMM 변환
        if (!salaryYm) {
            Swal.fire({
                icon: "warning",
                title: "급여 연월 선택",
                text: "급여 연월을 선택하세요!",
                confirmButtonText: "확인"
            });
            return;
        }

        let selectedEmployees = [];
        let selectedNames = [];

        $("input.payCheckbox:checked").each(function () {
            selectedEmployees.push($(this).val()); // 직원 코드
            selectedNames.push($(this).closest("tr").find("td:eq(1)").text()); // 직원명 추출
        });

        if (selectedEmployees.length === 0) {
            Swal.fire({
                icon: "warning",
                title: "직원 선택",
                text: "급여 지급할 직원을 선택하세요!",
                confirmButtonText: "확인"
            });
            return;
        }

        // FormData 사용 (배열을 올바르게 전송하기 위함)
        let formData = new FormData();
        formData.append("salaryYm", salaryYm);
        selectedEmployees.forEach(code => {
            formData.append("emplCode", code); // 배열 형태로 전달
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/fnnr/salary/pay",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                Swal.fire({
                    icon: "success",
                    title: "급여 지급 완료",
                    text: "급여 지급 완료: " + selectedNames.join(", "), // 직원명으로 출력
                    confirmButtonText: "확인"
                }).then(() => {
                    loadSalaryData(); // 지급 후 데이터 새로고침
                });
            },
            error: function (xhr) {
                Swal.fire({
                    icon: "error",
                    title: "급여 지급 실패",
                    text: "급여 지급 실패: " + xhr.responseText,
                    confirmButtonText: "확인"
                });
            }
        });
    }
    </script>
</body>
</html>
