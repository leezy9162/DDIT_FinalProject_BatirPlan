<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ✅ 모달 스타일 -->
<style>
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        width: 50%;
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
    }
    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-weight: bold;
    }
    .modal-content table {
        width: 100%;
        text-align: center;
    }
    .clickable:hover {
        cursor: pointer;
        background-color: #f5f5f5;
    }
</style>



<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper">

    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
        <%@include file="../module/navBar.jsp" %>
        <div class="body-wrapper">
            <div class="container-fluid">
            
            <div class="card card-body py-3">
				<div class="row align-items-center">
				  <h4 class="mb-4 mb-sm-0 card-title">협력업체 등록</h4>
				</div>
			</div>

                <div class="card">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/batirplan/cooperatiom/register" method="post">
                            <input type="hidden" name="ccpyCode" />

                            <div class="row g-3">
                                <!-- 협력업체명 -->
                                <div class="col-md-6">
                                    <label class="form-label">협력업체명</label>
                                    <input type="text" name="ccpyNm" class="form-control" required />
                                </div>

                                <!-- 사업자등록번호 -->
                                <div class="col-md-6">
                                    <label class="form-label">사업자등록번호</label>
                                    <div class="input-group">
                                        <input type="text" name="bizrno" id="bizrno" class="form-control" required />
                                        <button type="button" id="checkBizBtn" class="btn btn-outline-secondary">검증</button>
                                    </div>
                                    <small id="result" class="text-danger"></small>
                                </div>

                                <!-- 전화번호 -->
                                <div class="col-md-6">
                                    <label class="form-label">전화번호</label>
                                    <input type="text" name="ccpyTelno" class="form-control" required />
                                    <small id="phoneResult" class="text-danger"></small>
                                </div>

                                <!-- 이메일 -->
                                <div class="col-md-6">
                                    <label class="form-label">이메일</label>
                                    <input type="email" name="ccpyEmail" class="form-control" required />
                                    <small id="emailResult" class="text-danger"></small>
                                </div>

                                <!-- 주소 검색 -->
                                <div class="col-md-6">
                                    <label class="form-label">주소</label>
                                    <div class="input-group">
                                        <input type="text" id="ccpyAdres" name="ccpyAdres" class="form-control" placeholder="주소 검색" readonly required />
                                        <button type="button" class="btn btn-outline-secondary" onclick="searchAddress()">검색</button>
                                    </div>
                                </div>

                                <!-- 상세주소 -->
                                <div class="col-md-6">
                                    <label class="form-label">상세주소</label>
                                    <input type="text" id="ccpyDetailAdres" name="ccpyDetailAdres" class="form-control" required />
                                </div>

                                <!-- 업체 분류 -->
                                <div class="col-md-6">
                                    <label class="form-label">업체 분류</label>
                                    <div>
                                        <input type="radio" name="ccpyCl" value="01" required> 용역
                                        <input type="radio" name="ccpyCl" value="02" required> 자재
                                    </div>
                                </div>

                                <!-- 담당자 -->
                                <div class="col-md-6">
                                    <label class="form-label">담당자</label>
                                    <div class="input-group">
                                        <input type="text" id="chargerName" class="form-control" readonly />
                                        <input type="hidden" id="charger" name="charger" />
                                        <button type="button" class="btn btn-outline-secondary" onclick="openModal()">선택</button>
                                    </div>
                                </div>

                                <!-- 은행 코드 -->
                                <div class="col-md-6">
                                    <label class="form-label">은행 코드</label>
                                    <select name="bankCode" class="form-select" required>
                                         <option value="">선택하세요</option>
					                    <option value="001">한국은행</option>
					                    <option value="002">산업은행</option>
					                    <option value="003">기업은행</option>
					                    <option value="004">국민은행</option>
					                    <option value="011">농협은행</option>
					                    <option value="020">우리은행</option>
					                    <option value="031">대구은행</option>
					                    <option value="032">부산은행</option>
					                    <option value="034">광주은행</option>
					                    <option value="035">제주은행</option>
					                    <option value="037">전북은행</option>
					                    <option value="039">경남은행</option>
					                    <option value="045">새마을금고중앙회</option>
					                    <option value="048">신협중앙회</option>
					                    <option value="081">KEB하나은행</option>
					                    <option value="088">신한은행</option>
					                    <option value="089">케이뱅크</option>
					                    <option value="090">카카오뱅크</option>
					                    <option value="092">토스뱅크</option>
                                    </select>
                                </div>

                                <!-- 계좌번호 -->
                                <div class="col-md-6">
                                    <label class="form-label">계좌번호</label>
                                    <input type="text" name="acnutno" class="form-control" required />
                                    <small id="accountResult" class="text-danger"></small>
                                </div>
                            </div>                            
                             <!-- 등록 버튼 -->
							<div class="mt-4 text-start">
							    <button type="submit" class="btn btn-primary">등록</button>
							    <button class="btn" id="dataInsertBtn">데이터 삽입</button>
							</div>
                        </form>
                           <div id="approverSelectionModal" class="modal">
					            <div class="modal-header">
					                <h4>담당자 선택</h4>
					                <button type="button" class="close-button" onclick="closeModal()">×</button>
					            </div>
					            <div class="modal-content">
					                <table>
					                    <thead>
					                        <tr>
					                            <th>부서</th>
					                            <th>직급</th>
					                            <th>이름</th>
					                        </tr>
					                    </thead>
					                    <tbody>
					                        <c:set var="prevDept" value="" />
					                        <c:set var="deptCount" value="0" />
					                        <c:set var="firstRow" value="true" />
					                        <c:forEach var="employee" items="${employeeList}">
					                            <c:if test="${prevDept ne employee.deptNm}">
					                                <c:set var="deptCount" value="0" />
					                                <c:forEach var="emp" items="${employeeList}">
					                                    <c:if test="${emp.deptNm eq employee.deptNm}">
					                                        <c:set var="deptCount" value="${deptCount + 1}" />
					                                    </c:if>
					                                </c:forEach>
					                                <c:set var="firstRow" value="true" />
					                            </c:if>
					                            <tr onclick="selectEmployee('${employee.emplCode}', '${employee.emplNm}')">
					                                <c:if test="${firstRow}">
					                                    <td rowspan="${deptCount}" style="font-weight: bold;">${employee.deptNm}</td>
					                                    <c:set var="firstRow" value="false" />
					                                </c:if>
					                                <td>${employee.clsfNm}</td>
					                                <td class="clickable">${employee.emplNm}</td>
					                            </tr>
					                            <c:set var="prevDept" value="${employee.deptNm}" />
					                        </c:forEach>
					                    </tbody>
					                </table>
					            </div>
					        </div>
                        
                        
                        
                   </div>
                </div>
            </div>
        </div>
    </div>
</div>
    
<%@include file="../module/footerScript.jsp" %>
    <script>
        // 주소 검색 함수 (카카오/Daum 우편번호 API)
        function searchAddress() {
            new daum.Postcode({
                oncomplete: function(data) {
                    let roadAddr = data.roadAddress;
                    let jibunAddr = data.jibunAddress;
                    document.getElementById("ccpyAdres").value = roadAddr ? roadAddr : jibunAddr;
                    document.getElementById("ccpyDetailAdres").focus();
                }
            }).open();
        }
        
        $("#dataInsertBtn").on("click", function(){
            // 협력업체명
            $("input[name='ccpyNm']").val("건설혜란");
            // 전화번호
            $("input[name='ccpyTelno']").val("0425316334");
            // 이메일
            $("input[name='ccpyEmail']").val("cadnblue032@naver.com");
            // 업체 분류 (라디오 버튼, 예: 용역)
            $("input[name='ccpyCl'][value='01']").prop("checked", true);
            // 은행 코드 (예: 국민은행)
            $("select[name='bankCode']").val("004");
            // 계좌번호
            $("input[name='acnutno']").val("45900204205445");
        });
        
        // 사업자등록번호 검증 관련 변수
        var timeoutId;
        // "사업자등록번호 검증" 버튼 클릭 시 실행
        $(document).on("click", "#checkBizBtn", function () {
            var businessNumber = $("#bizrno").val();
            if(businessNumber === "") {
                $("#result").text("사업자등록번호를 입력하세요").css('color', 'red');
                return;
            }
            if(isNaN(businessNumber)) {
                $("#result").text("사업자번호는 숫자만 입력하세요").css('color', 'red');
                return;
            }
            if(businessNumber.length !== 10) {
                $("#result").text("10자리 사업자등록번호를 입력하세요").css('color', 'red');
                return;
            }
            // 검증 함수 호출
            checkBusinessNoStatus(businessNumber);
        });
        
        // 사업자등록번호 상태조회 함수 (AJAX로 중복 및 국세청 API 호출)
        function checkBusinessNoStatus(businessNumber) {
            $.ajax({
                url: "/join/duplicateBusinessNo",
                type: "POST",
                data: { business_no: businessNumber },
                success: function (isDuplicated) {
                    if (isDuplicated) {
                        $("#result").text("이미 사용 중인 사업자등록번호입니다").css('color', 'red');
                    } else {
                        var data = { "b_no": [businessNumber] };
                        $.ajax({
                            url: "http://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=jGlK3WVTAO%2BOykobHUzZy5n5R7Nal6k%2Fl6T2ZipmwTjzbWoQXfR99PylTPsD%2B2nbYP%2BKpkt%2BYHZAQrd1ckpeDQ%3D%3D",
                            type: "POST",
                            data: JSON.stringify(data),
                            dataType: "JSON",
                            contentType: "application/json",
                            accept: "application/json",
                            success: function (result) {
                                var taxType = result.data[0].tax_type;
                                if (taxType === "국세청에 등록되지 않은 사업자등록번호입니다.") {
                                    $("#result").text(taxType).css('color', 'red');
                                } else {
                                    $("#result").text("유효한 사업자등록번호입니다.").css('color', 'blue');
                                }
                            },
                            error: function (result) {
                                console.log(result.responseText);
                            }
                        });
                    }
                },
                error: function (error) {
                    console.log(error.responseText);
                }
            });
        }
        
        // 전화번호 유효성 검사
        $(document).on("blur", "input[name='ccpyTelno']", function(){
           var phone = $(this).val();
           var phoneRegex = /^[0-9]+$/;
           if(!phoneRegex.test(phone)) {
               $("#phoneResult").text("전화번호는 숫자만 입력하세요").css("color", "red");
               $(this).focus();
           } else if(phone.length > 15) {
               $("#phoneResult").text("전화번호가 너무 깁니다").css("color", "red");
               $(this).focus();
           } else {
               $("#phoneResult").text("");
           }
        });
        
        // 이메일 유효성 검사
        $(document).on("blur", "input[name='ccpyEmail']", function(){
           var email = $(this).val();
           var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
           if(!emailRegex.test(email)){
               $("#emailResult").text("유효한 이메일 주소를 입력하세요").css("color", "red");
               $(this).focus();
           } else {
               $("#emailResult").text("");
           }
        });
        
        // 계좌번호 유효성 검사
        $(document).on("blur", "input[name='acnutno']", function(){
           var account = $(this).val();
           var accountRegex = /^[0-9]+$/;
           if(!accountRegex.test(account)) {
               $("#accountResult").text("계좌번호는 숫자만 입력하세요").css("color", "red");
               $(this).focus();
           } else if(account.length > 20) {
               $("#accountResult").text("계좌번호가 너무 깁니다").css("color", "red");
               $(this).focus();
           } else {
               $("#accountResult").text("");
           }
        });
        
        // 담당자 선택 모달 관련 함수
        function openModal() {
            document.getElementById("approverSelectionModal").style.display = "block";
        }
        function closeModal() {
            document.getElementById("approverSelectionModal").style.display = "none";
        }
        // 화면에는 사원이름만 보이고, 실제 전송되는 값은 hidden 필드에 저장
        function selectEmployee(emplCode, emplNm) {
            document.getElementById("chargerName").value = emplNm;
            document.getElementById("charger").value = emplCode;
            closeModal();
        }
    </script>

</body>
</html>