<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->

<body class="link-sidebar">
  <%@include file="../../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper" >
    <%@include file="../../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
    <%@include file="../../module/navBar.jsp" %>
	    <div class="body-wrapper">
	      <div class="container-fluid">
		  <!-- 작업 영역 Start -->
		  
		  <c:set property="등록" var="stts" />
		  <c:if test="${!empty empVO }">
		  		<c:set property="수정" var="stts" />
		  </c:if>
		  
		  <!-- 퇴직날짜 변수에 담기(퇴직시 수정 불가 처리용도) -->
		  <c:set var="isRetired" value="${not empty empVO.retireDe}" />
		  
	      <!-- 컨텐츠 영역 제목 -->		  
		  <div class="card card-body py-3">
			<div class="row align-items-center">
	  			<h4 class="mb-4 mb-sm-0 card-title">인사 카드
	  			 <c:choose>
	  			 	<c:when test="${status eq 'u' }">
	  			 		<c:set value="수정" var="stts" />
	  			 	</c:when>
	  			 	<c:otherwise>
	  			 		<c:set value="등록" var="stts" />
	  			 	</c:otherwise>
	  			 </c:choose>
	  			 ${stts }
	  			 </h4>
		  	</div>
		  </div>
		  
		  
		  <!-- 컨텐츠 영역 본문1  -->
		  <div class="card">
		  	<div class="card-body">
		  		<div>
		  		
		  		</div>
		  	
		  		
		  <form id="eployeeForm">
			<input type="hidden" name="emplCode" id="emplCode" value="${empVO.emplCode }">		  
  			<h4 class="card-title mb-3">사원 정보</h4>
			<c:if test="${not empty empVO.retireDe}">
	  			<div class="text-end mb-1">
	  				<i class="ti ti-alert-circle fs-5"></i> 이미 퇴직 처리된 사원입니다. (관련 처리는 IT팀에게 문의하세요.)
	  			</div> 
			</c:if>
		  	<div class="row">
		  	
		  		<div class="mb-3 col-md-3">
				  	<img class="img-fluid rounded-4 mb-3" id="profileImg" alt="User profile picture" 
				  		src="
				  		<c:if test="${empty empVO.proflImageCours }">
				  			${pageContext.request.contextPath}/assets/images/profile/user-5.jpg
				  		</c:if>
				  		<c:if test="${!empty empVO.proflImageCours }">
				  			${empVO.proflImageCours} 
				  		</c:if>
				  		" 
				  		width="250" height="300">
				  		
				  		
		  			<input class="form-control" type="file" name="imgFile" id="imgFile">
		  		</div>
		  		<div class="mb-3 col-md-9">
		  			<input type="hidden" name="emplCode"  id="emplCode" value="${empVO.emplCode }" />
		  			<div class="row">
				  		<div class="mb-3 col-md-3">
				  			<label class="form-label" for="emplNm">이름</label>
					  		<input class="form-control form-control-sm mb-3" type="text" name="emplNm" id="emplNm" value="${empVO.emplNm }" />
				  		</div>
				  		<div class="mb-3 col-md-3">
				  			<label class="form-label" for="mbtlnum">전화번호</label>
					  		<input class="form-control form-control-sm mb-3" type="text" name="mbtlnum" id="mbtlnum" value="${empVO.mbtlnum }" />
				  		</div>
				  		<div class="mb-3 col-md-3">
				  			<label class="form-label" for="email">이메일</label>
					  		<input class="form-control form-control-sm" type="text" name="email" id="email" value="${empVO.email }" />
				  		</div>
				  		<div class="mb-3 col-md-3">
				  			 <label class="form-label" for="email">성별</label><br/>
				  			 <div class="form-check form-check-inline">
						          <input class="form-check-input" type="radio" name="sexdstn" id="sexdstn" value="M" ${empVO.sexdstn eq 'M' ? 'checked' : ''}/>
						          <label class="form-check-label" for="sexdstn">남성</label>
						      </div>
						      <div class="form-check form-check-inline">
						          <input class="form-check-input" type="radio" name="sexdstn" id="sexdstn" value="F" ${empVO.sexdstn eq 'F' ? 'checked' : ''}/>
						          <label class="form-check-label" for="sexdstn">여성</label>
						      </div>
				  		</div>
		  			</div>
		  			
		  			
		  			
		  			<div class="row">
		  				<div class="mb-3 col-md-3">
				  			<label class="form-label" for="brthdy">생년월일</label>
				  			<c:if test="${!empty empVO.brthdy }">
				  				<fmt:parseDate var="birthDate" value="${empVO.brthdy}" pattern="yyyyMMdd"/>
    							<fmt:formatDate var="formattedBirthDate" value="${birthDate}" pattern="yyyy-MM-dd"/>
				  			</c:if>
					  		<input class="form-control" type="date" name="brthdy" id="brthdy" value="${formattedBirthDate}">
				  		</div>
				  		<div class="mb-3 col-md-3">
				          	<label class="form-label" for="deptCode">부서</label>
				  			<select class="form-select mr-sm-2" name="deptCode" id="deptCode">
								<option value="" selected disabled>--부서를 선택하세요--</option>
							  	<option value="01" ${empVO.deptCode eq '01' ? 'selected' : ''}>경영지원        	</option>
								<option value="02" ${empVO.deptCode eq '02' ? 'selected' : ''}>건축기획        	</option>
								<option value="03" ${empVO.deptCode eq '03' ? 'selected' : ''}>재무           	</option>
								<option value="04" ${empVO.deptCode eq '04' ? 'selected' : ''}>자원           	</option>
								<option value="05" ${empVO.deptCode eq '05' ? 'selected' : ''}>IT           	</option>
				  			</select><br/>
			  			</div>
				  		<div class="mb-3 col-md-3">
				          	<label class="form-label" for="clsfCode">직급</label>
				  			<select class="form-select mr-sm-2" name="clsfCode" id="clsfCode">
								<option value="" selected disabled>--직급을 선택하세요--</option>
							  	<option value="01" ${empVO.clsfCode eq '01' ? 'selected' : ''}>사원        	</option>
								<option value="02" ${empVO.clsfCode eq '02' ? 'selected' : ''}>대리        	</option>
								<option value="03" ${empVO.clsfCode eq '03' ? 'selected' : ''}>과장        	</option>
								<option value="04" ${empVO.clsfCode eq '04' ? 'selected' : ''}>차장        	</option>
								<option value="05" ${empVO.clsfCode eq '05' ? 'selected' : ''}>부장        	</option>
				  			</select>
				  		</div>
				  		<div class="mb-3 col-md-3">
				  			<label class="form-label" for="encpn">입사일</label>
				  			
				  			<c:if test="${!empty empVO.encpn }">
				  				<fmt:parseDate var="encpnDate" value="${empVO.encpn}" pattern="yyyyMMdd"/>
    							<fmt:formatDate var="formattedEncpnDate" value="${encpnDate}" pattern="yyyy-MM-dd"/>
				  			</c:if>
				  			<c:set var="today" value="<%= new java.util.Date() %>" />
				  			<fmt:formatDate var="formattedToday" value="${today}" pattern="yyyy-MM-dd" />
					  		<input class="form-control" type="date" name="encpn" id="encpn" 
       						value="${empty formattedEncpnDate ? formattedToday : formattedEncpnDate}" >
				  		</div>
		  			</div>
		  			
		  			
		  			<div class="row">
		  				<div class="mb-4 col-md-4">
				  			<label class="form-label" for="zip">우편 번호</label>
				  			<button class="btn btn-sm"type="button" onclick="DaumPostcode()">우편번호 찾기</button>
		  					<input type="text" id="zip" name="zip" class="form-control" aria-label="Recipient's username" aria-describedby="basic-addon2" value="${empVO.zip }" />
		  				</div>
		  				<div class="mb-4 col-md-4">
				  			<label class="form-label" for="adres">기본 주소</label>
		  					<input class="form-control" type="text" name="adres" id="adres" value="${empVO.adres }" />
		  				</div>
		  				<div class="mb-4 col-md-4">
		  					<label class="form-label" for="detailadres">상세 주소</label>
		  					<input class="form-control" type="text" name="detailadres" id="detailadres" value="${empVO.detailadres }" />
		  				</div>
		  			</div>
		  			
		  			
		  			<div class="row">
		  				<div class="mb-6 col-md-6">
		  					<label class="form-label" for="bankCode">은행</label>
				  			<select class="form-select mr-sm-2" name="bankCode" id="bankCode">
									<option value="" selected disabled>--은행명을 선택하세요--</option>
									<option value="001" ${empVO.bankCode eq '001' ? 'selected' : ''}>한국은행        	</option>
									<option value="002" ${empVO.bankCode eq '002' ? 'selected' : ''}>산업은행        	</option>
									<option value="003" ${empVO.bankCode eq '003' ? 'selected' : ''}>기업은행        	</option>
									<option value="004" ${empVO.bankCode eq '004' ? 'selected' : ''}>국민은행        	</option>
									<option value="011" ${empVO.bankCode eq '011' ? 'selected' : ''}>농협은행        	</option>
									<option value="020" ${empVO.bankCode eq '020' ? 'selected' : ''}>우리은행        	</option>
									<option value="031" ${empVO.bankCode eq '031' ? 'selected' : ''}>대구은행        	</option>
									<option value="032" ${empVO.bankCode eq '032' ? 'selected' : ''}>부산은행        	</option>
									<option value="034" ${empVO.bankCode eq '034' ? 'selected' : ''}>광주은행        	</option>
									<option value="035" ${empVO.bankCode eq '035' ? 'selected' : ''}>제주은행        	</option>
									<option value="037" ${empVO.bankCode eq '037' ? 'selected' : ''}>전북은행        	</option>
									<option value="039" ${empVO.bankCode eq '039' ? 'selected' : ''}>경남은행        	</option>
									<option value="045" ${empVO.bankCode eq '045' ? 'selected' : ''}>새마을금고중앙회	 	</option>
									<option value="048" ${empVO.bankCode eq '048' ? 'selected' : ''}>신협중앙회      	</option>
									<option value="081" ${empVO.bankCode eq '081' ? 'selected' : ''}>KEB하나은행     	</option>
									<option value="088" ${empVO.bankCode eq '088' ? 'selected' : ''}>신한은행        	</option>
									<option value="089" ${empVO.bankCode eq '089' ? 'selected' : ''}>케이뱅크        	</option>
									<option value="090" ${empVO.bankCode eq '090' ? 'selected' : ''}>카카오뱅크      	</option>
									<option value="092" ${empVO.bankCode eq '092' ? 'selected' : ''}>토스뱅크        	</option>
				  			</select>
		  				</div>
		  				<div class="mb-6 col-md-6">
		  					<label class="form-label" for="acnutno">계좌번호</label>
					  		<input class="form-control" type="text" name="acnutno" id="acnutno" value="${empVO.acnutno }" />
		  				</div>
		  			</div>
	  			</div>
	  			
		  	</div>
		  	
		  </form>
		  	<div class="text-end">
		  	  <c:if test="${!empty empVO }">
 				  <button type="button" class="btn btn-danger" id="retireBtn"><i class="ti ti-check fs-4 me-2"></i>퇴직 처리</button>
		  	  </c:if>
 			  
 			  <button class="btn" id="dataInsertBtn">데이터 삽입</button>
 			  <button type="button" class="btn btn-primary" onclick="history.back()"><i class="ti ti-x fs-4 me-2"></i>취소</button>
 			  <button type="button" class="btn btn-primary" id="submitBtn"><i class="ti ti-send fs-4 me-2"></i>${stts }</button>
		  	</div>
		  	</div>
		  </div>
		  <!-- 컨텐츠 영역 본문1 끝  -->
		  
	  		
	  	  <div class="card">
	  	  	<div class="">
	  	  	
	  	  	</div>
	  	  </div>
	  	  	
		  <!-- 작업 영역 End -->
		  </div>
	    </div>
    </div>
    </div>
  <%@include file="../../module/footerScript.jsp" %>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/jquery.repeater/jquery.repeater.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/forms/repeater-init.js"></script>
</body>

<!-- cardForm script -->
<script type="text/javascript">
$(function(){
	// 입력 단계시 필요한 Element 가져오기
	let imgFile = $("#imgFile");
	let profileImg = $("#profileImg");
	let submitBtn = $("#submitBtn");

	
	var isRetired = ${isRetired}; // JSP EL로 boolean 값 전달 (true/false)
    if(isRetired) {
        $("#eployeeForm :input").prop("disabled", true);
        $("#submitBtn").hide();
        $("#retireBtn").hide();
    }
	
	// 프로필 이미지 파일 업로드시 발생하는 이벤트 바인딩
	imgFile.on("change", function(event) {
	    let file = event.target.files[0]; // 선택한 파일 데이터
	    
	    if (isImageFile(file)) { // 이벤트를 발생시킨 파일이 이미지라면?
	        let reader = new FileReader();
	        reader.onload = function(e) {
	            profileImg.attr("src", e.target.result);
	        };
	        reader.readAsDataURL(file); // 파일 데이터를 base64 형태의 인코딩된 값으로 변환
	    } else { // 이벤트를 발생시킨 파일이 이미지가 아니라면?
	        Swal.fire({
	            icon: "warning",
	            title: "이미지 파일 필요",
	            text: "이미지 파일을 선택해주세요!",
	            confirmButtonText: "확인"
	        });
	    }
	});
	
	// 인사카드 등록 이벤트 바인딩
	submitBtn.on("click", function(){
		console.log("submitBtn Event In...");
	    // ID를 기준으로 값 가져오기
	    let emplCode = $("#emplCode").val();   				// 프로필 사진 파일 (Multipart)
	    let imgFile = $("#imgFile")[0].files[0];   				// 프로필 사진 파일 (Multipart)
	    let emplNm = $("#emplNm").val();
	    let deptCode = $("#deptCode").val();
	    let clsfCode = $("#clsfCode").val();
	    let brthdy = $("#brthdy").val().replace(/-/g, ""); 		// 하이픈 제거
	    let email = $("#email").val();
	    let mbtlnum = $("#mbtlnum").val().replace(/-/g, ""); 	// 하이픈 제거
	    let sexdstn = $('input[name="sexdstn"]:checked').val(); // 선택된 성별 값 가져오기
	    let zip = $("#zip").val().replace(/-/g, ""); 			// 하이픈 제거
	    let adres = $("#adres").val();
	    let detailadres = $("#detailadres").val();
	    let bankCode = $("#bankCode").val();
	    let acnutno = $("#acnutno").val().replace(/-/g, ""); 	// 하이픈 제거
	    let encpn = $("#encpn").val().replace(/-/g, ""); 		// 하이픈 제거
		
	    
	    if(true){
		    // 필요한 요소 가져오기
		    let formData = new FormData();
		    let btnText = $('#submitBtn').text(); 
		    
		    
		    if (imgFile) {
		        formData.append("emplProfile", imgFile);  			// 이미지 파일 추가
		    }
		    formData.append("emplCode", emplCode);
		    formData.append("emplNm", emplNm);
		    formData.append("deptCode", deptCode);
		    formData.append("clsfCode", clsfCode);
		    formData.append("email", email);
		    formData.append("brthdy", brthdy);
		    formData.append("mbtlnum", mbtlnum);
		    formData.append("sexdstn", sexdstn);
		    formData.append("zip", zip);
		    formData.append("adres", adres);
		    formData.append("detailadres", detailadres);
		    formData.append("bankCode", bankCode);
		    formData.append("acnutno", acnutno);
		    formData.append("encpn", encpn);
			
		    if(btnText === '수정'){
		    	/* 사원 수정 버튼일때 */
		    	$.ajax({
		    	    url: "/batirplan/hrm/hrcard/modify",
		    	    type: "post",
		    	    data: formData,
		    	    contentType: false,
		    	    processData: false,
		    	    success: function(res, textStatus, jqXHR) {
		    	        let statusCode = jqXHR.status;

		    	        if (statusCode === 200) {
		    	            console.log(res);
		    	            Swal.fire({
		    	                icon: "success",
		    	                title: "수정 완료",
		    	                text: "사원정보 수정이 완료되었습니다!",
		    	                confirmButtonText: "확인"
		    	            }).then(() => {
		    	                location.href = "/batirplan/hrm/hrcard/detail?emplCode=" + res;
		    	            });
		    	        } else {
		    	            Swal.fire({
		    	                icon: "error",
		    	                title: "수정 실패",
		    	                text: "사원정보 수정 실패, 다시 시도해주세요!",
		    	                confirmButtonText: "확인"
		    	            });
		    	        }
		    	    },
		    	    error: function(error, status, thrown) {
		    	        console.log("error: " + error.status);
		    	        console.log("status: " + status);
		    	        console.log("thrown: " + thrown);

		    	        Swal.fire({
		    	            icon: "error",
		    	            title: "서버 오류 발생",
		    	            text: "서버 에러 발생, IT팀에게 문의해주세요!",
		    	            confirmButtonText: "확인"
		    	        });
		    	    }
		    	});
		    } else {
		    	/* 사원 등록 버튼일때 */
		    	$.ajax({
		    	    url: "/batirplan/hrm/hrcard/form",
		    	    type: "post",
		    	    data: formData,
		    	    contentType: false,
		    	    processData: false,
		    	    success: function(res, textStatus, jqXHR) {
		    	        let statusCode = jqXHR.status;

		    	        if (statusCode === 200) {
		    	            console.log(res);
		    	            Swal.fire({
		    	                icon: "success",
		    	                title: "회원가입 완료",
		    	                html: `회원가입이 완료되었습니다!<br><strong>\${res}번 사원번호</strong>가 부여되었습니다.`,
		    	                confirmButtonText: "확인"
		    	            }).then(() => {
		    	                location.href = "/batirplan/hrm/hrcard/detail?emplCode=" + res;
		    	            });
		    	        } else {
		    	            Swal.fire({
		    	                icon: "error",
		    	                title: "사원 등록 실패",
		    	                text: "사원 등록 실패, 다시 시도해주세요!",
		    	                confirmButtonText: "확인"
		    	            });
		    	        }
		    	    },
		    	    error: function(error, status, thrown) {
		    	        console.log("error: " + error.status);
		    	        console.log("status: " + status);
		    	        console.log("thrown: " + thrown);

		    	        Swal.fire({
		    	            icon: "error",
		    	            title: "서버 오류 발생",
		    	            text: "서버 에러 발생, IT팀에게 문의해주세요!",
		    	            confirmButtonText: "확인"
		    	        });
		    	    }
		    	});
		    }
	    } else {
	    	return;
	    }
	});
	
	$("#retireBtn").on("click", function(){
		let emplCode = $("#emplCode").val();
		let emplNm = $("#emplNm").val();
				
		Swal.fire({
		    title: '확인',
		    text: emplNm + " 사원을 퇴직 처리 하시겠습니까?",
		    icon: 'warning',
		    showCancelButton: true,  // 취소 버튼 표시
		    confirmButtonText: '확인',
		    cancelButtonText: '취소'
		}).then((result) => {
			
		    if (result.isConfirmed) {
		        console.log('확인 클릭!');
				console.log("퇴직 처리 실행");
				
				// FormData 객체 생성 후 emplCode 추가
		        let formData = new FormData();
		        formData.append("emplCode", emplCode);
				
		        $.ajax({
		            url: "/batirplan/hrm/hrcard/retire",
		            type: "post",
		            data: formData,
		            contentType: false,  
		            processData: false,  
		            success: function(res) {
		                console.log(res);
		                
		                Swal.fire({
	                        title: '성공!',
		                    text: emplNm + " (" + res + ") 사원이 퇴직처리 되었습니다.",
	                        icon: 'success',
	                        confirmButtonText: '확인'
	                    }).then(() => {
	                        window.location.href = "/batirplan/hrm/hrcard/detail?emplCode=" + res;
	                    });
		            },
		            error: function(e) {
		                console.log(e);
		                Swal.fire({
		                    icon: "error",
		                    title: "서버 오류 발생",
		                    text: "서버 에러 발생, IT팀에게 문의해주세요!",
		                    confirmButtonText: "확인"
		                });
		            }
		        });		        
		    } else {
		        console.log('취소 클릭!');
		    }
		});
		
		return;
		
		/* if(confirm(emplNm + " 사원을 퇴직 처리 하시겠습니까?")){
			console.log("퇴직 처리 실행");
			
			 // FormData 객체 생성 후 emplCode 추가
	        let formData = new FormData();
	        formData.append("emplCode", emplCode);
			
	        $.ajax({
	            url: "/batirplan/hrm/hrcard/retire",
	            type: "post",
	            data: formData,
	            contentType: false,  
	            processData: false,  
	            success: function(res) {
	                console.log(res);
	                
	                Swal.fire({
	                    icon: "success",
	                    title: "퇴직 처리 완료",
	                    text: emplNm + " (" + res + ") 사원이 퇴직처리 되었습니다.",
	                    confirmButtonText: "확인"
	                }).then(() => {
	                    location.href = "/batirplan/hrm/hrcard/detail?emplCode=" + res;
	                });
	            },
	            error: function(e) {
	                console.log(e);
	                Swal.fire({
	                    icon: "error",
	                    title: "서버 오류 발생",
	                    text: "서버 에러 발생, IT팀에게 문의해주세요!",
	                    confirmButtonText: "확인"
	                });
	            }
	        });
		} */
	});
	
	
	$("#dataInsertBtn").on("click", function(){
	    // 사원 코드 (예시)
	    $("#emplCode").val("EMP001");
	    
	    // 이름
	    $("#emplNm").val("홍길동");
	    
	    // 부서 (예: 건축기획: 02)
	    $("#deptCode").val("02");
	    
	    // 직급 (예: 과장: 03)
	    $("#clsfCode").val("03");
	    
	    // 생년월일 (YYYY-MM-DD 형식)
	    $("#brthdy").val("1980-12-12");
	    
	    // 이메일
	    $("#email").val("hong@example.com");
	    
	    // 전화번호 (하이픈 없이)
	    $("#mbtlnum").val("01012345678");
	    
	    // 성별 - 남성 선택 (radio 버튼)
	    $('input[name="sexdstn"][value="M"]').prop("checked", true);
	    
	    // 상세 주소
	    $("#detailadres").val("123-45");
	    
	    // 은행 코드 (예: 국민은행: 004)
	    $("#bankCode").val("004");
	    
	    // 계좌번호 (하이픈 없이)
	    $("#acnutno").val("111222333444");
	    
	    // 입사일 (YYYY-MM-DD 형식)
	    $("#encpn").val("2023-01-01");
	});

})


//Sub------------------------------------------------------------------------------------------------
// 이미지 파일인지 체크하는 함수
function isImageFile(file){
	var ext = file.name.split(".").pop().toLowerCase();
	return ($.inArray(ext,["jpg","jpeg", "gif", "png"])===-1)? false : true;
}
//daum 주소 찾기 API 
function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zip').value = data.zonecode;
            document.getElementById("adres").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailadres").focus();
        }
    }).open();
}
</script>
</html>