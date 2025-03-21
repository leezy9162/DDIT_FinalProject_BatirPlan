<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@include file="../module/head.jsp" %>

<style>
#form {
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
#form .table-wrapper {
	border: 1px solid #ddd;
    border-radius: 8px;
    overflow: hidden;
}
#form table {
    width: 100%;
}
#form th, 
#form td {
    border: 1px solid #ddd;
    padding: 15px;               
}
#form th {
    background-color: #f8f8f8;
    font-weight: bold;
    font-size: 16px;
    text-align: center;
}
#form tbody tr:hover {
    background-color: #eaeaea;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
}
#form .btn {
    border: 1px solid #ccc;   
    border-radius: 6px;         
}
#form .btn:hover {
    background-color: #eaeaea;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
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

<div id="form">
	<button type="button" class="close-button" onclick="closeDocumentFormListModal()">
        &times;
    </button>

    <h4>기안서 작성</h4>
    <div class="table-wrapper">
	    <table>
	        <thead>
	            <tr>
	                <th>양식번호</th>
	                <th>양식명</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="form" items="${formList}" varStatus="status">
	                <tr class="select-form" data-form-no="${form.formNo}">
	                    <td style="text-align: center;">${form.formNo}</td>
	                    <td>${form.formNm}</td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
    </div>
    <div style="text-align:right; margin-top:10px;">
        <button type="button" class="btn" onclick="closeDocumentFormListModal()">취소</button>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<script>
$(document).ready(function(){
    $(".select-form").click(function(){
        var formNo = $(this).data("form-no");

        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/createForm?formNo=" + formNo,
            type: "GET",
            success: function(response) {
                $("#documentFormListModalContainer").html(response);
                $("#documentFormListModal").fadeIn(0);
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생!",
                    text: "양식 작성 페이지를 불러오는 데 실패했습니다.",
                    confirmButtonText: "확인"
                });
                console.error(error);
            }
        });
    });
});

function closeDocumentFormListModal() {
    $("#documentFormListModal").fadeOut(function() {
    	document.body.style.overflow = "";
    });
}
</script>