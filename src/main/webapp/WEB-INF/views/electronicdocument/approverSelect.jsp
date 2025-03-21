<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@include file="../module/head.jsp" %>

<style>
#approverModal .modal-content {
    position: fixed;
    top: 35%;                      
    left: 50%;                     
    transform: translate(-50%, -50%);
    background-color: white;
    width: 70%;
    margin: 10% auto;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
    max-height: 600px;
    z-index : 1;
    overflow-y: auto;
}
#approverModal .modal-content table {
    width: 100%;
    border-collapse: collapse;
}
#approverModal .modal-content th,
#approverModal .modal-content td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}
#approverModal .modal-content th {
    background-color: #f2f2f2;
}
#approverModal .modal-content .btn {
    padding: 8px 12px;
    margin: 5px;
}
#approverModal input.approver-name {
    border: none;           
    background: transparent; 
    text-align: center;      
    width: 50%;             
}
#approverModal .button-group {
    display: flex;
    width: 100%;
    margin-top: 10px; 
}
#approverModal .btn-wrapper {
    flex: 1;
}
#approverModal .btn-wrapper:first-child {
    text-align: left;
}
#approverModal .btn-wrapper:nth-child(2) {
    text-align: center;
}
#approverModal .btn-wrapper:last-child {
    text-align: right;
}
#approverModal .btn-add {
    width: 200px;
}
.disabled-modal {
    pointer-events: none;  /* 부모 영역의 모든 클릭/포커스 등을 막음 */
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

<div id="approverModal">
    <div class="modal-content">
    	<button type="button" class="close-button" onclick="closeApproverModal()">
	        &times;
	    </button>
    
        <h4>결재자 입력</h4>
        <table id="approverTable">
            <thead>
                <tr>
                    <th>순서</th>
                    <th>이름</th>
                    <th>검색</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <tr data-row="1" data-approver-id="">
                    <td class="row-number">1</td>
                    <td><input type="text" class="approver-name" readonly /></td>
                    <td><button type="button" class="btn search-btn">검색</button></td>
                    <td><button type="button" class="btn delete-btn" disabled>삭제</button></td>
                </tr>
            </tbody>
        </table>
        <div class="button-group">
        	<div class="btn-wrapper">
        		<button type="button" class="btn" onclick="applyApproversToParent()">확인</button>
		  	</div>
		  	<div class="btn-wrapper">
		    	<button type="button" class="btn btn-add" onclick="addApproverRow()">행 추가</button>
		  	</div>
		  	<div class="btn-wrapper">
		    	<button type="button" class="btn" onclick="closeApproverModal()">취소</button>
		  	</div>
		</div>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<script type="text/javascript">
let selectedRow = null;

$(document).on("click", ".search-btn", function () {
    selectedRow = $(this).closest("tr");
    
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/employeeList",
        type: "GET",
        success: function(response) {
            if ($("#approverSelectionModal").length === 0) {
                $("body").append(response);
            }
            setTimeout(function() {
                $("#approverSelectionModal").fadeIn();
                $("#approverSelectionModal .modal-content").scrollTop(0);
            }, 100);
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "결재자 선택 모달을 불러오는 데 실패했습니다.",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
});

function addApproverRow() {
    const table = $("#approverTable tbody");
    const rowCount = table.find("tr").length + 1;
    const newRow = $(`
        <tr data-row="${rowCount}" data-approver-id="">
            <td class="row-number">${rowCount}</td>
            <td><input type="text" class="approver-name" readonly /></td>
            <td><button type="button" class="btn search-btn">검색</button></td>
            <td><button type="button" class="btn delete-btn">삭제</button></td>
        </tr>
    `);
    table.append(newRow);
    updateRowNumbers();
}

$(document).on("click", ".delete-btn", function () {
    let row = $(this).closest("tr");

    if (row.attr("data-row") === "1") {
        Swal.fire({
            icon: "warning",
            title: "삭제 불가",
            text: "첫 번째 행은 삭제할 수 없습니다.",
            confirmButtonText: "확인"
        });
        return;
    }

    row.remove();
    updateRowNumbers();
});

function updateRowNumbers() {
    $("#approverTable tbody tr").each(function (index) {
        $(this).attr("data-row", index + 1);
        $(this).find(".row-number").text(index + 1);
    });
}

function applyApproversToParent() {
    let approverNames = [];
    let approverCodes = [];
    
    $("#approverTable tbody tr").each(function() {
        let name = $(this).find(".approver-name").val().trim();
        let code = $(this).attr("data-approver-id");
        if (name !== "" && code !== "") {
            approverNames.push(name);
            approverCodes.push(code);
        }
    });
    $("#drafterInput").val(approverNames.join("-"));
    $("#approverCodes").val(approverCodes.join("-"));
    closeApproverModal();
}

function repopulateApproverTable() {
	const drafterVal = $("#drafterInput").val().trim();
    const approverCodesVal = $("#approverCodes").val().trim();
    const tbody = $("#approverTable tbody");
    tbody.empty(); 

    if (drafterVal && approverCodesVal) {
        const nameArr = drafterVal.split("-");
        const codeArr = approverCodesVal.split("-");
        
        for (let i = 0; i < nameArr.length; i++) {
            const rowNum = i + 1;
            
            let $tr = $("<tr>")
                .attr("data-row", rowNum)
                .attr("data-approver-id", codeArr[i]);
            
            let $tdNumber = $("<td>").addClass("row-number").text(rowNum);
            
            let $input = $("<input>")
                .attr("type", "text")
                .addClass("approver-name")
                .prop("readonly", true)
                .val(nameArr[i]);
            let $tdName = $("<td>").append($input);
            
            let $btnSearch = $("<button>")
                .attr("type", "button")
                .addClass("btn search-btn")
                .text("검색");
            let $tdSearch = $("<td>").append($btnSearch);
            
            let $btnDelete = $("<button>")
                .attr("type", "button")
                .addClass("btn delete-btn")
                .text("삭제");
            
            if (rowNum == 1) {
                $btnDelete.prop("disabled", true);
            }
            let $tdDelete = $("<td>").append($btnDelete);
            
            $tr.append($tdNumber, $tdName, $tdSearch, $tdDelete);
            tbody.append($tr);
        }
    } else {
        let $tr = $("<tr>").attr("data-row", "1").attr("data-approver-id", "");
        let $tdNumber = $("<td>").addClass("row-number").text("1");
        let $input = $("<input>")
            .attr("type", "text")
            .addClass("approver-name")
            .prop("readonly", true);
        let $tdName = $("<td>").append($input);
        let $btnSearch = $("<button>")
            .attr("type", "button")
            .addClass("btn search-btn")
            .text("검색");
        let $tdSearch = $("<td>").append($btnSearch);
        let $btnDelete = $("<button>")
            .attr("type", "button")
            .addClass("btn delete-btn")
            .prop("disabled", true)
            .text("삭제");
        let $tdDelete = $("<td>").append($btnDelete);
        $tr.append($tdNumber, $tdName, $tdSearch, $tdDelete);
        tbody.append($tr);
    }
}

function closeApproverModal() {
    $("#approverModal").fadeOut();
    $("#write").removeClass("disabled-modal");
    $("#write").css("overflow", "auto");
    $("#modalContent").css("overflow", "auto");
}
</script>