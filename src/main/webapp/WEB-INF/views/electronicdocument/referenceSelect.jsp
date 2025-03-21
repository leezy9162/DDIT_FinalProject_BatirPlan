<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@include file="../module/head.jsp" %>

<style>
#referenceModal .modal-content {
	background-color: white;
   	width: 60%;
   	margin: 10% auto;
   	padding: 20px;
   	border-radius: 8px;
   	text-align: center;
   	position: relative;
   	max-height: 500px;
   	overflow-y: auto;
}
#referenceModal .modal-content table {
	width: 100%;
   	border-collapse: collapse;
}
#referenceModal .modal-content th,
#referenceModal .modal-content td {
	border: 1px solid #ddd;
   	padding: 8px;
   	text-align: center;
}
#referenceModal .modal-content th {
	background-color: #f2f2f2;
}
#referenceModal .modal-content .btn {
	padding: 8px 12px;
  	cursor: pointer;
  	margin: 5px;
}
#referenceModal .button-group {
	display: flex;
	justify-content: space-between;
	align-items: center;
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

<div id="referenceModal" class="modal">
    <div class="modal-content">
    	<button type="button" class="close-button" onclick="closeReferenceModal()">
	        &times;
	    </button>
    
        <h4>참조자 선택</h4>
        <table id="referenceTable">
            <thead>
                <tr>
                    <th>부서</th>
                    <th>직급</th>
                    <th>이름</th>
                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="prevDept" value=""/>

                <c:forEach var="employee" items="${employeeList}">
                    <c:if test="${employee.deptCode ne prevDept
                                and employee.emplCode ne loginUser.memberVO.empVO.emplCode}">
                        <c:set var="count" value="0" />
                        <c:forEach var="emp" items="${employeeList}">
                            <c:if test="${emp.deptCode eq employee.deptCode
                                        and emp.emplCode ne loginUser.memberVO.empVO.emplCode}">
                                <c:set var="count" value='${count + 1}' />
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <c:if test="${employee.emplCode ne loginUser.memberVO.empVO.emplCode}">
                        <tr>
                            <c:if test="${employee.deptCode ne prevDept}">
                                <td rowspan="${count}" style="font-weight: bold;">
                                    <c:choose>
                                        <c:when test="${employee.deptCode == '01'}">경영지원</c:when>
                                        <c:when test="${employee.deptCode == '02'}">건축기획</c:when>
                                        <c:when test="${employee.deptCode == '03'}">재무</c:when>
                                        <c:when test="${employee.deptCode == '04'}">자원</c:when>
                                        <c:when test="${employee.deptCode == '05'}">IT</c:when>
                                        <c:otherwise>기타</c:otherwise>
                                    </c:choose>
                                </td>
                                <c:set var="prevDept" value="${employee.deptCode}" />
                            </c:if>

                            <td>
                                <c:choose>
                                    <c:when test="${employee.clsfCode == '01'}">사원</c:when>
                                    <c:when test="${employee.clsfCode == '02'}">대리</c:when>
                                    <c:when test="${employee.clsfCode == '03'}">과장</c:when>
                                    <c:when test="${employee.clsfCode == '04'}">차장</c:when>
                                    <c:when test="${employee.clsfCode == '05'}">부장</c:when>
                                    <c:when test="${employee.clsfCode == '06'}">이사</c:when>
                                    <c:when test="${employee.clsfCode == '07'}">부사장</c:when>
                                    <c:when test="${employee.clsfCode == '08'}">사장</c:when>
                                    <c:otherwise>기타</c:otherwise>
                                </c:choose>
                            </td>

                            <td>${employee.emplNm}</td>

                            <td>
                                <input type="checkbox"
                                       class="reference-checkbox"
                                       value="${employee.emplCode}"
                                       data-name="${employee.emplNm}" />
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>

        <div class="button-group" style="margin-top:10px;">
            <button type="button" class="btn" onclick="applyReferences()">확인</button>
            <button type="button" class="btn" onclick="closeReferenceModal()">취소</button>
        </div>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<script type="text/javascript">
function applyReferences() {
	var selectedNames = [];
	var selectedCodes = [];
	
	$("#referenceTable .reference-checkbox:checked").each(function(){
		selectedNames.push($(this).data("name"));
	    selectedCodes.push($(this).val());
    });
	if (window.parent && window.parent.$) {
		window.parent.$("#referenceInput").val(selectedNames.join(", "));
	    window.parent.$("#referenceCodes").val(selectedCodes.join(", "));
    }
	closeReferenceModal();
}
	
$(document).ready(function(){
	var existingCodes = "";
	
	if(window.parent && window.parent.$) {
		existingCodes = window.parent.$("#referenceCodes").val();
	}
	if(existingCodes) {
		var codeArr = existingCodes.split(", ");
			
		$("#referenceTable .reference-checkbox").each(function(){
			var code = $(this).val();
			
			if(codeArr.indexOf(code) !== -1) {
				$(this).prop("checked", true);
            }
        });
    }
});
	
function closeReferenceModal() {
	$("#referenceModal").fadeOut();
	$("#write").css("overflow", "auto");
}
</script>