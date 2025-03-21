<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
#stampModalContent {
    position: fixed;               
    top: 50%;                      
    left: 50%;                     
    transform: translate(-50%, -50%); 
    background-color: #fff;
    padding: 20px;                 
    border: 1px solid #ccc;
    width: 1000px;
    height: 800px;                  
    max-width: 50%;                
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    border-radius: 8px;            
}
#stampModalContent .form-group {
    margin-bottom: 15px;
}
#stampModalContent .form-group label {
    display: block;
    margin-bottom: 6px;
}
#stampModalContent #stampPreview {
    display: none; 
    max-width: 200px; 
    max-height: 200px;
    margin-top: 10px;
}
#stampModalContent .btn {
    padding: 6px 12px;
    margin-right: 10px;
}
.close-button {
    position: absolute;
    top: 15px; 
    right: 20px; 
    background: none;  
    border: none;      
    font-size: 22px;   
    font-weight: bold;
    cursor: pointer;
}
</style>
    
<div id="stampModalContent">
	<button type="button" class="close-button" onclick="closeStampModal()">
        &times;
    </button>

    <c:choose>
        <c:when test="${not empty stampUrl}">
		    <h3>이미 등록된 도장/서명</h3>
		    <p>현재 등록된 도장/서명 이미지입니다.</p>
		    
		    <img id="existingStampImage" src="${stampUrl}" 
		         alt="등록된 도장 이미지" style="max-width:200px; max-height:200px;"/>
		    <br/><br/>
		    
		    <button type="button" class="btn" onclick="showUpdateForm()">재등록하기</button>
		    <button type="button" class="btn" onclick="deleteStampAjax()">삭제</button>
		    <button type="button" class="btn" onclick="closeStampModal()">닫기</button>
		
		    <div id="updateForm" style="display: none; margin-top: 20px;">
		        <form id="stampForm" enctype="multipart/form-data">
		            <div class="form-group">
		                <label for="stampImage">새 도장/서명 이미지 선택</label>
		                <input type="file" id="stampImage" name="stampImage" accept="image/*" required />
		                <img id="stampPreview" alt="미리보기" />
		            </div>
		            <div class="form-group">
		                <button type="button" class="btn" onclick="uploadStampAjax()">등록</button>
		                <button type="button" class="btn" onclick="closeUpdateForm()">취소</button>
		            </div>
		        </form>
		    </div>
		</c:when>

        <c:otherwise>
            <h3>도장/서명 등록</h3>
            <form id="stampForm" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="stampImage">도장/서명 이미지 선택</label>
                    <input type="file" id="stampImage" name="stampImage" accept="image/*" required />
                    <img id="stampPreview" alt="미리보기" />
                </div>
                <div class="form-group">
                    <button type="button" class="btn" onclick="uploadStampAjax()">등록</button>
                    <button type="button" class="btn" onclick="closeStampModal()">취소</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<script>
function closeStampModal() {
    parent.$("#stampModal").fadeOut();
    parent.$("body").css("overflow", "auto");
}

function showUpdateForm(){
    $("#updateForm").fadeIn();
}

function closeUpdateForm(){
    $("#updateForm").fadeOut();
}

$('#stampImage').change(function(){
    var file = this.files[0];
    if (file) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#stampPreview').attr('src', e.target.result).show();
        }
        reader.readAsDataURL(file);
    } else {
        $('#stampPreview').hide();
    }
});

function uploadStampAjax() {
    var formData = new FormData(document.getElementById('stampForm'));
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/uploadStamp",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            Swal.fire({
                icon: "success",
                title: "등록 완료",
                text: response,
                confirmButtonText: "확인"
            });

            $.ajax({
                url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/stampRegistration",
                type: "GET",
                success: function(html) {
                    $("#stampModalContainer").html(html);
                },
                error: function() {
                    Swal.fire({
                        icon: "error",
                        title: "오류 발생!",
                        text: "도장 화면 갱신 실패",
                        confirmButtonText: "확인"
                    });
                }
            });
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "도장 등록 실패",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
}

function deleteStampAjax() {
    Swal.fire({
        icon: "warning",
        title: "삭제 확인",
        text: "정말 도장을 삭제하시겠습니까?",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        cancelButtonColor: "#6c757d",
        confirmButtonText: "삭제",
        cancelButtonText: "취소"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/deleteStamp",
                type: "POST",
                success: function(response) {
                    Swal.fire({
                        icon: "success",
                        title: "삭제 완료",
                        text: response,
                        confirmButtonText: "확인"
                    });

                    $.ajax({
                        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/stampRegistration",
                        type: "GET",
                        success: function(html) {
                            $("#stampModalContainer").html(html);
                        },
                        error: function() {
                            Swal.fire({
                                icon: "error",
                                title: "오류 발생!",
                                text: "도장 화면 갱신 실패",
                                confirmButtonText: "확인"
                            });
                        }
                    });
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: "error",
                        title: "오류 발생!",
                        text: "도장 삭제 실패",
                        confirmButtonText: "확인"
                    });
                    console.error(error);
                }
            });
        }
    });
}
</script>