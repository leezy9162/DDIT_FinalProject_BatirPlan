<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@include file="../module/head.jsp" %>

<style>
#approverSelectionModal .modal-content {
    background-color: white;
    width: 30%;
    margin: 10% auto;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
    position: relative;
    max-height: 500px;
    overflow-y: auto;
}
#approverSelectionModal .modal-content table {
    width: 100%;
    border-collapse: collapse;
}
#approverSelectionModal .modal-content th,
#approverSelectionModal .modal-content td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}
#approverSelectionModal .modal-content th {
    background-color: #f2f2f2;
}
#approverSelectionModal .modal-content .btn {
    padding: 8px 12px;
    cursor: pointer;
    margin: 5px;
}
#approverSelectionModal .clickable {
    cursor: pointer;
    color: blue;
    text-decoration: underline;
}
#approverSelectionModal .clickable:hover {
    font-weight: bold;
}
#approverSelectionModal .btn {
    border: 1px solid #ccc;   
    border-radius: 6px;
}
#approverSelectionModal .btn:hover {
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

<div id="approverSelectionModal" class="modal">
    <div class="modal-content">
    	<button type="button" class="close-button" onclick="closeSelectionModal()">
	        &times;
	    </button>
    
        <h4>결재자 선택</h4>
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

                <c:forEach var="employee" items="${employeeList}">
                    
                    <c:if test="${employee.deptCode ne prevDept 
                                and employee.emplCode ne loginUser.memberVO.empVO.emplCode}">
                        <c:set var="count" value="0" />
                        <c:forEach var="emp" items="${employeeList}">
                            <c:if test="${emp.deptCode eq employee.deptCode 
                                        and emp.emplCode ne loginUser.memberVO.empVO.emplCode}">
                                <c:set var="count" value="${count + 1}" />
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
                            
                            <td class="clickable" 
                                data-id="${employee.emplCode}" 
                                data-name="${employee.emplNm}">
                                ${employee.emplNm}
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </tbody>
        </table>
        
        <button type="button" class="btn" onclick="closeSelectionModal()">취소</button>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<script type="text/javascript">
$(document).on("click", ".clickable", function () {
    const emplName = $(this).data("name");
    const emplId = $(this).data("id");

    if (selectedRow !== null) {
        let isDuplicate = false;
        
        $("#approverTable tbody tr").each(function() {
            if (this !== selectedRow.get(0)) { 
                if ($(this).attr("data-approver-id") == emplId) {
                    isDuplicate = true;
                    return false; 
                }
            }
        });

        if (isDuplicate) {
            Swal.fire({
                icon: "warning",
                title: "중복 선택",
                text: "이미 선택된 결재자입니다!",
                confirmButtonText: "확인"
            });
            return;
        }

        selectedRow.find(".approver-name").val(emplName);
        selectedRow.attr("data-approver-id", emplId);
    } else {
        console.error("선택된 행이 없습니다.");
    }
    
    closeSelectionModal();
});

function closeSelectionModal() {
    $("#approverSelectionModal").fadeOut();
}
</script>