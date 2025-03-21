<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%@include file="../module/head.jsp" %>

<style>
#write {
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
    overflow-y: auto; 
}
#write form { 
	width: 100%; 
	margin: 10px auto; 
}
#write fieldset {
    border: 2px solid #ddd;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 10px;
}
#write .form-group {
    margin-bottom: 10px;
    display: flex;
   	align-items: center; 
}
#write .form-group label {
    flex: 0 0 120px; 
    font-weight: bold;
    vertical-align: middle;
}
#write .form-group input:not([type="date"]):not([type="checkbox"]) {
    flex: 1;
    padding: 5px;
    vertical-align: middle; 
}
#write .form-group input[type="date"] {
    flex: 0 0 120px; 
}
#write .form-group input[type="checkbox"] {
    flex: 0 0 auto;    
    align-self: flex-start; 
    width: 20px;
    height: 20px;
    vertical-align: middle;
}
#write .btn {
    border: 1px solid #ccc;   
    border-radius: 6px;         
}
#write .btn:hover {
    background-color: #eaeaea;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
}
#write .button-group {
    display: flex;
    align-items: center;
}
#write .button-group .btn:last-child {
    margin-left: auto;
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

<div id="write">
	<button type="button" class="close-button" onclick="cancelForm()">
        &times;
    </button>

	<h4>기안서 작성</h4>
	<form action="${pageContext.request.contextPath}/batirplan/erp/electronicdocument/create" 
          id="documentForm" method="post" onsubmit="syncEditorInputValues()">
    	<input type="hidden" name="formNo" value="${document.formNo}" />
        <input type="hidden" name="drftDe" value="${document.drftDe}" />
        <input type="hidden" name="bdtCn" id="bdtCn" />
		<input type="hidden" name="docNo" value="${document.docNo}" />
		<input type="hidden" name="sttus" id="sttusField" value="" />
    
        <fieldset>
            <div class="form-group">
                <label>기한일자</label>
                <input type="date" name="tmlmtDe" value="<c:out value='${fn:substring(document.tmlmtDe, 0, 4)}-${fn:substring(document.tmlmtDe, 4, 6)}-${fn:substring(document.tmlmtDe, 6, 8)}'/>" required />
            </div>
    
            <div class="form-group">
                <label>제목</label>
                <input type="text" name="sj" value="${document.sj}" required />
            </div>
            
            <div class="form-group">
                <label>결재자</label>
                <button type="button" class="btn" onclick="openApproverModalFromForm()">검색</button>
                	<div id="approverModalContainer"></div>
                <input type="text" id="drafterInput" name="drafter" value="${document.existingApproverNames}" required readonly/>
                <input type="hidden" id="approverCodes" name="approverCodes" value="${document.existingApproverCodes}" />
            </div>
            
            <div class="form-group">
                <label>참조자</label>
                <button type="button" class="btn" onclick="openReferenceModal()">검색</button>
                	<div id="referenceModalContainer"></div>
                <input type="text" id="referenceInput" name="reference" value="${document.existingReferenceNames}" readonly />
                <input type="hidden" id="referenceCodes" name="referenceCodes" value="${document.existingReferenceCodes}" />
            </div>
            
            <div class="form-group">
                <label>첨부파일</label>
                <input type="file" name="attachment" style="cursor: pointer;"/>
            </div>
    
            <div class="form-group">
                <label>긴급여부</label>
                <input type="hidden" id="emrgncyDocAtHidden" name="emrgncyDocAt" value="${document.emrgncyDocAt != null ? document.emrgncyDocAt : 'N'}" />
                <input type="checkbox" id="emrgncyDocAtCheckbox" onchange="updateEmrgncyValue()" />
            </div>
        </fieldset>
        
        <textarea id="editor">
		    <c:choose>
		        <c:when test="${document.docNo == 0}">
		            <c:out value="${form.formCn}" escapeXml="false" />
		        </c:when>
		        <c:otherwise>
		            <c:out value="${document.bdtCn}" escapeXml="false" />
		        </c:otherwise>
		    </c:choose>
		</textarea>
    	<br/>
    	
        <div class="button-group">
			<button type="button" class="btn" onclick="submitDocument()">저장/결재</button>
        	<button type="button" class="btn" onclick="saveDraft()">임시저장</button>
		    <button type="button" class="btn" onclick="cancelForm()">취소</button>
		</div>
		
		<sec:authentication property="principal.memberVO.empVO" var="empl"/>
		
    </form>
</div>

<%@include file="../module/footerScript.jsp" %>

<script type="text/javascript">
if (typeof window.selectedApprovers === 'undefined') {
    window.selectedApprovers = {};
}

function initEditor() {
    if (CKEDITOR.instances.editor) {
        CKEDITOR.instances.editor.destroy(true);
    }
    
    CKEDITOR.replace('editor', {
        extraPlugins: 'autogrow',
        removePlugins: 'resize',
        extraAllowedContent: 'table tr td th span[*]; colgroup col[*]',
        allowedContent: true
    });
    
    CKEDITOR.instances.editor.on('instanceReady', function() {
        var editorBody = CKEDITOR.instances.editor.document.getBody();

        var todayDate = '${todayDate}';  

        var deptCode = '${empl.deptCode}';   
        var emplName = '${empl.emplNm}';     
        var clsfCode = '${empl.clsfCode}';   
        
        var deptName = convertDeptCodeToName(deptCode);
        var positionName = convertClsfCodeToName(clsfCode);

        var deptCell = editorBody.find('.deptCell');
        for (var i = 0; i < deptCell.count(); i++) {
        	deptCell.getItem(i).setText(deptName);
       	}

        var nameCell = editorBody.find('.empNameCell');
        for (var i = 0; i < nameCell.count(); i++) {
        	nameCell.getItem(i).setText(emplName);
       	}

        var positionCell = editorBody.find('.positionCell');
        for (var i = 0; i < positionCell.count(); i++) {
        	positionCell.getItem(i).setText(positionName);
       	}

        var dateSpan = editorBody.find('.todaySpan');
        for (var i = 0; i < dateSpan.count(); i++) {
        	dateSpan.getItem(i).setText(todayDate);
       	}
    });
}

function convertDeptCodeToName(deptCode) {
    switch(deptCode) {
        case '01': return '경영지원';
        case '02': return '건축기획';
        case '03': return '재무';
        case '04': return '자원';
        case '05': return 'IT';
    }
}

function convertClsfCodeToName(clsfCode) {
    switch(clsfCode) {
        case '01': return '사원';
        case '02': return '대리';
        case '03': return '과장';
        case '04': return '차장';
        case '05': return '부장';
        case '06': return '이사';
        case '07': return '부사장';
        case '08': return '사장';
    }
}

function syncEditorInputValues() {
    document.getElementById('bdtCn').value = CKEDITOR.instances.editor.getData();
}

function updateEmrgncyValue() {
    document.getElementById("emrgncyDocAtHidden").value = document.getElementById("emrgncyDocAtCheckbox").checked ? "Y" : "N";
}

function submitDocument() {
    let html = CKEDITOR.instances.editor.getData();
    
    syncEditorInputValues();
    document.getElementById('sttusField').value = '02';
    
    const approverCodes = document.getElementById("approverCodes").value.trim();
    if (!approverCodes) {
        Swal.fire({
            icon: "warning",
            title: "입력 필요",
            text: "결재자를 지정해주세요.",
            confirmButtonText: "확인"
        });
        return; 
    }
      
    const docNo = document.querySelector("input[name='docNo']").value;
    const form = document.getElementById("documentForm");
      
    if (!docNo || docNo === '0') {
        form.action = "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/create";
    } else {
        form.action = "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/submit?docNo=" + docNo;
    }
    
    if (form.checkValidity()) {
        form.requestSubmit();
    } else {
        form.reportValidity();
    }
}

function openApproverModalFromForm() {
    $("#write").addClass("disabled-modal");
    $("#write").css("overflow", "hidden");
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/approverList",
        type: "GET",
        success: function(response) {
            $("#approverModalContainer").html(response); 
            $("#approverModalContainer .modal").fadeIn(function() {
                if (typeof repopulateApproverTable === "function") {
                    repopulateApproverTable();
                }
            });
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "결재자 목록을 불러오는 데 실패했습니다.",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
}

function openReferenceModal() {
    $("#write").css("overflow", "hidden");
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/referenceList",
        type: "GET",
        success: function(response) {
            $("#referenceModalContainer").html(response);
            setTimeout(function(){
                $("#referenceModal").fadeIn();
            }, 100);
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "참조자 목록을 불러오는 데 실패했습니다.",
                confirmButtonText: "확인"
            });
            console.error(error);
        }
    });
}

function cancelForm() {
    if (typeof CKEDITOR !== "undefined" && CKEDITOR.instances && CKEDITOR.instances.editor) {
        CKEDITOR.instances.editor.destroy(true);
    }

    const docNo = document.querySelector("input[name='docNo']").value;

    if (!docNo || docNo === "0") {
        $("#write").fadeOut(0, function() {
            $("#documentEditModal").hide();
        });

        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/create",
            type: "GET",
            success: function(response) {
                $("#documentFormListModalContainer").html(response);
            },
            error: function() {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생!",
                    text: "양식 목록 불러오기 실패",
                    confirmButtonText: "확인"
                });
            }
        });
        return;
    }

    $("#write").fadeOut(0, function() {
        $("#documentEditModal").css("display", "none");

        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/detail",
            type: "GET",
            data: { docNo: docNo },
            success: function(detailHtml) {
                $("#documentDetailModalContainer").html(detailHtml);
                $("#documentDetailModal").fadeIn(0, function() {
                    document.body.style.overflow = "hidden";
                });
            },
            error: function() {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생!",
                    text: "상세 정보를 다시 불러오는 데 실패했습니다.",
                    confirmButtonText: "확인"
                });
            }
        });
    });
}

function saveDraft() {
    syncEditorInputValues();
    document.getElementById('sttusField').value = '01';

    const tmlmtDeInput = document.querySelector("input[name='tmlmtDe']");
    tmlmtDeInput.removeAttribute("required");
    
    const drafterInput = document.getElementById("drafterInput");
    drafterInput.removeAttribute("required");

    const form = document.getElementById("documentForm");
    const titleValue = form.sj.value.trim();
    
    if (!titleValue) {
        Swal.fire({
            icon: "warning",
            title: "입력 필요",
            text: "제목은 필수입니다.",
            confirmButtonText: "확인"
        });
        return; 
    }
    
    form.action = "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/draft";
    form.requestSubmit();
}

$(document).ready(function(){
	let existingCodes = window.parent.$("#referenceCodes").val();
	if(existingCodes) {
		let codeArr = existingCodes.split(", ");
		
        $("#referenceTable .reference-checkbox").each(function() {
        	let code = $(this).val();
        	if(codeArr.indexOf(code) !== -1) {
        		$(this).prop("checked", true);
            }
       	});
    }
});

function updateEmrgncyValue() {
    if ($("#emrgncyDocAtCheckbox").is(":checked")) {
        $("#emrgncyDocAtHidden").val("Y");
    } else {
        $("#emrgncyDocAtHidden").val("N");
    }
}

$(document).ready(function() {
    initEditor();
    
    let today = new Date().toISOString().split('T')[0];
    $("input[name='tmlmtDe']").attr("min", today);
    
    if ($("#emrgncyDocAtHidden").val() === "Y") {
        $("#emrgncyDocAtCheckbox").prop("checked", true);
    }
});
</script>