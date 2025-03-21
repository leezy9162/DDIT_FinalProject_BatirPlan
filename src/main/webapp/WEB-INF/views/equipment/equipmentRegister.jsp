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
                        <h4 class="mb-4 mb-sm-0 card-title">장비 등록</h4>
                    </div>
                </div>

                <div class="card">
                    <div class="card-body">
                        <form id="registerForm" action="/batirplan/equipment/register" method="post">
                            <div class="row g-3">
                                <!-- 장비명 -->
                                <div class="col-md-6">
                                    <label for="eqpmnNm" class="form-label">장비명</label>
                                    <input type="text" class="form-control" id="eqpmnNm" name="eqpmnNm" required>
                                </div>

                                <!-- 장비 유형 -->
                                <div class="col-md-6">
                                    <label for="eqpmnTy" class="form-label">장비 유형</label>
                                    <select class="form-select" id="eqpmnTy" name="eqpmnTy" required>
                                        <option value="중장비">중장비</option>
                                        <option value="중형장비">중형장비</option>
                                        <option value="소형장비">소형장비</option>
                                        <option value="특수장비">특수장비</option>
                                        <option value="기타">기타</option>
                                    </select>
                                </div>

                                <!-- 일련번호 -->
                                <div class="col-md-6">
                                    <label for="eqpmnSn" class="form-label">일련번호</label>
                                    <input type="text" class="form-control" id="eqpmnSn" name="eqpmnSn" required>
                                    <div id="serialNumberError" class="text-danger mt-1" style="display:none;">이미 존재하는 일련번호입니다.</div>
                                </div>

                                <!-- 제조사 -->
                                <div class="col-md-6">
                                    <label for="makrNm" class="form-label">제조사</label>
                                    <input type="text" class="form-control" id="makrNm" name="makrNm" required>
                                </div>

                                <!-- 가격 -->
                                <div class="col-md-6">
                                    <label for="eqpmnPc" class="form-label">가격</label>
                                    <input type="number" class="form-control" id="eqpmnPc" name="eqpmnPc" required>
                                </div>

                                <!-- 구매일자 -->
                                <div class="col-md-6">
                                    <label for="eqpmnPurchsDe" class="form-label">구매일자 (YYYYMMDD)</label>
                                    <input type="text" class="form-control" id="eqpmnPurchsDe" name="eqpmnPurchsDe" required>
                                </div>

                                <!-- 위치 -->
                                <div class="col-md-6">
                                    <label for="eqpmnLc" class="form-label">위치</label>
                                    <input type="text" class="form-control" id="eqpmnLc" name="eqpmnLc" required>
                                </div>

                                <!-- 장비 상태 (고정) -->
                                <div class="col-md-6">
                                    <label class="form-label">장비 상태</label>
                                    <div class="form-control bg-light">사용 가능</div>
                                    <input type="hidden" name="eqpmnSttus" value="01"> <!-- 사용가능(01) 고정 -->
                                </div>
                            </div>

                            <!-- 버튼 -->
                            <div class="mt-4 d-flex justify-content-start">
                                <button type="submit" class="btn btn-primary me-2">등록</button>
                                <a href="/batirplan/equipment/list" class="btn btn-primary me-2">취소</a>
                            </div>
                        </form>
                    </div>
                </div>        

                <!-- 작업 영역 End -->
            </div>
        </div>
    </div>
</div>
    
<%@include file="../module/footerScript.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 일련번호 중복 체크
    $("#eqpmnSn").blur(function() {
        let eqpmnSn = $(this).val();
        if (eqpmnSn.trim() === "") return;

        $.get("/batirplan/equipment/checkSerialNumber", { eqpmnSn: eqpmnSn }, function(response) {
            if (response === "DUPLICATE") {
                Swal.fire({
                    icon: "error",
                    title: "중복된 일련번호",
                    text: "이미 존재하는 일련번호입니다. 다른 번호를 입력하세요.",
                    confirmButtonText: "확인"
                }).then(() => {
                    $("#eqpmnSn").val("").focus();
                });
            }
        });
    });

    // 구매일자(YYYYMMDD) 유효성 검사
    $("#registerForm").submit(function(event) {
        let purchsDate = $("#eqpmnPurchsDe").val();
        let regex = /^\d{8}$/; // 8자리 숫자 (YYYYMMDD)

        if (!regex.test(purchsDate)) {
            Swal.fire({
                icon: "warning",
                title: "유효하지 않은 입력",
                text: "구매일자는 YYYYMMDD 형식으로 입력해야 합니다.",
                confirmButtonText: "확인"
            });
            event.preventDefault();
        }
    });
});
</script>

</body>
</html>