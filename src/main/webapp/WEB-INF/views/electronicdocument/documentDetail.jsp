<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%@ include file="../module/head.jsp" %>

<style>
#detail {
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
#detail fieldset {
    border: 1px solid #ddd;
    padding: 0px;
    margin-bottom: 10px;
    border-radius: 8px;
}
#detail table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 8px;
}
#detail th,
#detail td {
    border: 1px solid #ddd;
    padding: 10px;
}
#detail th {
    background-color: #f8f8f8;
    font-weight: bold;
    font-size: 16px;
    text-align: center;
}
#detail .btn {
    border: 1px solid #ccc;
    border-radius: 6px;
}
#detail .btn:hover {
    background-color: #eaeaea;
    cursor: pointer;
    transition: background-color 0.2s ease-in-out;
}
.table-wrapper {
    border-radius: 8px;
    overflow: hidden;
}
#detail .close {
    float: right;
}
#detail .approval-table {
    border-collapse: collapse;
    border: 1px solid #ddd;
    width: auto;
    margin-bottom: 10px;
}
#detail .approval-th,
#detail .approval-td {
    border: 1px solid #ddd;
    text-align: center;
    padding: 0px;
}
#detail .approval-table th:first-child,
#detail .approval-table td:first-child {
    width: 20px;
}
#detail .approval-table th:nth-child(n+2),
#detail .approval-table td:nth-child(n+2) {
    width: 100px;
}
#detail .approval-vertical-header {
    writing-mode: vertical-rl;
    padding: 0px;
}
#detail .approval-signature-cell {
    height: 80px;
    padding: 0px;
}
#detail .approval-table th:first-child {
    background-color: #f8f8f8;
    font-weight: bold;
}
#rejectModal {
    position: fixed;
    transform: translate(65%, -186%); 
    background-color: #fff;
    border: 1px solid #ccc;
    width: 400px;
    height: 250px;
    max-width: 50%;
    box-shadow: 0 6px 12px rgba(0,0,0,0.15);
    z-index: 1002;
    border-radius: 8px;
}
.reject-info h5 {
  margin: 0; 
}
.disabled-modal {
  pointer-events: none;     
}
.diagonal-slash {
  position: relative;
  width: 100px;   
  height: 80px;
}
.diagonal-slash::after {
  content: "";
  position: absolute;
  top: 0; left: 0;
  width: 128%;     
  border-top: 1px solid #999; 
  transform: rotate(38.5deg);
  transform-origin: top left;
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

<div id="detail">
	<button type="button" class="close-button" onclick="closeDetailModal()">
        &times;
    </button>

    <h4>상세보기</h4>
    
    <fieldset>
        <div class="table-wrapper">
            <table>
                <tr>
                    <th>문서번호</th>
                    <td>${document.docNo}</td>
                    
                    <th>기안일자</th>
                    <td>
                        <c:if test="${not empty document.drftDe}">
                            ${fn:substring(document.drftDe, 0, 4)}-${fn:substring(document.drftDe, 4, 6)}-${fn:substring(document.drftDe, 6, 8)}
                        </c:if>
                    </td>
                    
                    <th>기안자</th>
                    <td>${document.drafterName}</td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td colspan="5">${document.sj}</td>
                </tr>
                <tr>
                    <th>진행 상태</th>
                    <td id="docSttusCell">
                        <c:choose>
                            <c:when test="${document.sttus == '01'}">기안중</c:when>
                            <c:when test="${document.sttus == '02'}">진행중</c:when>
                            <c:when test="${document.sttus == '03'}">반려</c:when>
                            <c:when test="${document.sttus == '04'}">완료</c:when>
                            <c:otherwise>${document.sttus}</c:otherwise>
                        </c:choose>
                    </td>
                    
                    <th>기한일자</th>
                    <td>
                        <c:if test="${not empty document.tmlmtDe}">
                            ${fn:substring(document.tmlmtDe, 0, 4)}-${fn:substring(document.tmlmtDe, 4, 6)}-${fn:substring(document.tmlmtDe, 6, 8)}
                        </c:if>
                    </td>
                    <th>첨부파일</th>
                    <td></td>
                </tr>
            </table>
        </div>
    </fieldset>
	
	<c:if test="${not empty sanctionLines}">
    <fieldset>
        <div class="table-wrapper">
            <table style="text-align: center;">
                <thead>
                    <tr>
                        <th>순서</th>
                        <th>결재자</th>
                        <th>상태</th>
                        <th>결재일</th>
                    </tr>
                </thead>
                <tbody id="sanctionTableBody">
                    <c:forEach var="sanction" items="${sanctionLines}">
                        <tr>
                            <td>${sanction.sanctnOrdr}</td>
                            <td>${sanction.sanctnerName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${sanction.sanctnSttus == '01'}">대기</c:when>
                                    <c:when test="${sanction.sanctnSttus == '02'}">결재완료</c:when>
                                    <c:when test="${sanction.sanctnSttus == '03'}">반려</c:when>
                                    <c:when test="${sanction.sanctnSttus == '04'}">전결</c:when>
                                    <c:otherwise>${sanction.sanctnSttus}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty sanction.sanctnDt}">
                                        ${fn:substring(sanction.sanctnDt, 0, 4)}-${fn:substring(sanction.sanctnDt, 4, 6)}-${fn:substring(sanction.sanctnDt, 6, 8)}
                                    </c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </fieldset>
    </c:if>

    <c:if test="${not empty corbonCopies}">
        <fieldset>
            <div class="table-wrapper">
                <table style="text-align: center;">
                    <thead>
                        <tr>
                            <th>참조자</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <c:forEach var="corbon" items="${corbonCopies}" varStatus="status">
                                    ${corbon.emplName}
                                    <c:if test="${!status.last}">, </c:if>
                                </c:forEach>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </c:if>

    <fieldset>
	    <div class="table-wrapper">
	        <div class="bdtCn">
	            <c:if test="${not empty sanctionLines}">
	                <table class="approval-table" style="float: right; margin: 5px 5px;">
	                    <tbody>
	                        <tr>
	                            <th rowspan="3" class="approval-vertical-header">
	                                결재
	                            </th>
	                            <c:forEach var="sanction" items="${sanctionLines}">
	                                <td class="approval-th">
	                                    <c:choose>
	                                        <c:when test="${sanction.clsfCode == '01'}">사원</c:when>
	                                        <c:when test="${sanction.clsfCode == '02'}">대리</c:when>
	                                        <c:when test="${sanction.clsfCode == '03'}">과장</c:when>
	                                        <c:when test="${sanction.clsfCode == '04'}">차장</c:when>
	                                        <c:when test="${sanction.clsfCode == '05'}">부장</c:when>
	                                        <c:when test="${sanction.clsfCode == '06'}">이사</c:when>
	                                        <c:when test="${sanction.clsfCode == '07'}">부사장</c:when>
	                                        <c:when test="${sanction.clsfCode == '08'}">사장</c:when>
	                                        <c:otherwise>기타</c:otherwise>
	                                    </c:choose>
	                                </td>
	                            </c:forEach>
	                        </tr>
	                        
	                        <tr>
							    <c:forEach var="sanction" items="${sanctionLines}">
							        <td class="approval-td approval-signature-cell">
							            <c:choose>
							                <c:when test="${sanction.sanctnSttus == '02'}">
							                    <c:choose>
							                        <c:when test="${not empty sanction.approvalStamp}">
							                            <img src="${sanction.approvalStamp}" style="width:80px; height:70px;" />
							                        </c:when>
							                        <c:otherwise>
							                            <img src="${pageContext.request.contextPath}/resources/images/default_sign.png"
							                                 alt="디폴트 결재 이미지"
							                                 style="width:80px; height:70px;" />
							                        </c:otherwise>
							                    </c:choose>
							                </c:when>
							                <c:when test="${sanction.sanctnSttus == '03'}">
					                            <img src="${pageContext.request.contextPath}/resources/images/default_fail.png"
					                                 alt="디폴트 반려 이미지"
					                                 style="width:80px; height:70px;" />
							                </c:when>
							                <c:when test="${sanction.sanctnSttus == '04'}">
									        	<img src="${pageContext.request.contextPath}/resources/images/default_all.png"
									             	 alt="디폴트 전결 이미지"
									             	 style="width:80px; height:70px;" />
										  	</c:when>
										  	<c:otherwise>
									            <c:choose>
									                <c:when test="${document.sttus == '04'}">
									                    <div class="diagonal-slash"></div>
									                </c:when>
									                <c:otherwise>
									                    &nbsp;
									                </c:otherwise>
									            </c:choose>
									        </c:otherwise>
							            </c:choose>
							        </td>
							    </c:forEach>
							</tr>
	                        <tr>
	                            <c:forEach var="sanction" items="${sanctionLines}">
	                                <td class="approval-td">
	                                    <c:choose>
	                                        <c:when test="${sanction.sanctnSttus == '02' 
										                  or sanction.sanctnSttus == '03' 
										                  or sanction.sanctnSttus == '04'}">
										        <c:choose>
										            <c:when test="${not empty sanction.sanctnDt}">
										                ${fn:substring(sanction.sanctnDt, 0, 4)}-${fn:substring(sanction.sanctnDt, 4, 6)}-${fn:substring(sanction.sanctnDt, 6, 8)}
										            </c:when>
										            <c:otherwise>
										                &nbsp;
										            </c:otherwise>
										        </c:choose>
										    </c:when>
										    <c:otherwise>
										        &nbsp;
										    </c:otherwise>
	                                    </c:choose>
	                                </td>
	                            </c:forEach>
	                        </tr>
	                    </tbody>
	                </table>
	            </c:if>
	            
	            <div style="clear: both;">
	                ${document.bdtCn}
	            </div>
	        </div>
	    </div>
	</fieldset>
	
	<div id="rejectModal" style="display:none;">
	    <div class="modal-content" style="width: 100%; height: 100%; padding:10px;">
	        <h4>반려 사유</h4>
	        <textarea id="rejectReason" rows="4" style="width:100%; height: 100%;"></textarea>
	        <div style="margin-top:10px;">
	            <button type="button" class="btn" onclick="submitReject()">확인</button>
	            <button type="button" class="btn" onclick="closeRejectModal()">취소</button>
	        </div>
	    </div>
	</div>
	
	<c:if test="${document.sttus == '03'}">
	    <fieldset>
	        <div class="reject-info" style="padding: 10px; border: 1px solid #ddd; border-radius: 6px;">
	            <c:forEach var="sanction" items="${sanctionLines}">
	                <c:if test="${sanction.sanctnSttus == '03'}">
	                    <h5 style="margin-bottom: 10px;">반려자 : ${sanction.sanctnerName}</h5>
	                    <h5>사 유 : ${sanction.returnResn}</h5>
	                </c:if>
	            </c:forEach>
	        </div>
	    </fieldset>
	</c:if>
    
    <c:set var="myLine" scope="page" value="" />
	<c:forEach var="sanction" items="${sanctionLines}">
	    <c:if test="${loginUser.memberVO.empVO.emplCode eq sanction.sanctner
             and not sanction.approved
             and sanction.prevDone}">
		    <c:set var="myLine" value="${sanction}" />
		</c:if>
	</c:forEach>
	
    <c:if test="${(document.sttus eq '01' or document.sttus eq '03') and document.drafter eq loginUser.memberVO.empVO.emplCode}">
	    <button type="button" class="btn" onclick="openEditModal(${document.docNo})">수정</button>
	</c:if>

	<c:if test="${document.sttus == '02' and not empty myLine}">
	    <button type="button" class="btn" onclick="approveSanctionAjax(${document.docNo}, ${myLine.sanctnLineNo});">
	        결재
	    </button>
	    
	    <button type="button" class="btn" onclick="openRejectModal(${document.docNo}, ${myLine.sanctnLineNo});">
	        반려
	    </button>
	</c:if>
	
	<c:set var="myLineForFinal" scope="page" value="" />
	<c:forEach var="sanction" items="${sanctionLines}">
	    <c:if test="${loginUser.memberVO.empVO.emplCode eq sanction.sanctner}">
	        <c:set var="myLineForFinal" value="${sanction}" />
	    </c:if>
	</c:forEach>
	
	<c:set var="othersAllApproved" value="true" />
	<c:forEach var="line" items="${sanctionLines}">
	    <c:if test="${line.sanctner ne loginUser.memberVO.empVO.emplCode}">
	        <c:if test="${line.sanctnSttus ne '02' and line.sanctnSttus ne '04'}">
	            <c:set var="othersAllApproved" value="false" />
	        </c:if>
	    </c:if>
	</c:forEach>
	
	<sec:authentication property="principal.memberVO.empVO" var="empl"/>
    
    <c:if test="${ 
	     document.sttus eq '02'
	     and not empty myLineForFinal
	     and othersAllApproved eq 'false'
	     and (
	       empl.clsfCode eq '05'
	       or empl.clsfCode eq '06'
	       or empl.clsfCode eq '07'
	       or empl.clsfCode eq '08'
	     )}">
	    <button type="button" class="btn" onclick="finalApproval(${document.docNo})">
	        전결
	    </button>
	</c:if>

    <button type="button" class="btn close" onclick="closeDetailModal()">닫기</button>
</div>

<%@ include file="../module/footerScript.jsp" %>

<script>
$(document).ready(function() {
    $("#documentDetailModalContainer").scrollTop(0);
});

function closeDetailModal() {
    $("#documentDetailModal").fadeOut(function() {
        document.body.style.overflow = "";
        $("#documentDetailModalContainer").removeClass("disabled-modal");
    });
}

function openEditModal(docNo) {
    $("#documentDetailModal").fadeOut(0, function() {
        $.ajax({
            url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/editModal?docNo=" + docNo,
            type: "GET",
            success: function(response) {
                $("#documentEditModalContainer").html(response);

                if (typeof initEditor === "function") {
                    initEditor();
                }

                $("#documentEditModal").fadeIn(0);
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: "error",
                    title: "오류 발생!",
                    text: "수정 폼을 불러오는 데 실패했습니다.",
                    confirmButtonText: "확인"
                });
                console.error(error);
            }
        });
    });
}

function approveSanctionAjax(docNo, sanctnLineNo) {
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/approveAjax",
        type: "POST",
        dataType: "json",
        data: {
            docNo: docNo,
            sanctnLineNo: sanctnLineNo
        },
        success: function(res) {
            if (!res.success) {
                Swal.fire({
                    icon: "error",
                    title: "결재 실패",
                    text: res.message,
                    confirmButtonText: "확인"
                });
                return;
            }

            Swal.fire({
                icon: "success",
                title: "결재 완료!",
                text: res.message,
                confirmButtonText: "확인"
            }).then(() => {
                window.location.href = 
                    "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/list"
                    + "?docNo=" + docNo
                    + "&openModal=true";
            });
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "결재 처리 중 오류 발생: " + error,
                confirmButtonText: "확인"
            });
        }
    });
}

function openRejectModal(docNo, sanctnLineNo) {
	$("#rejectModal").fadeIn();
    
    $("#documentDetailModalContainer").addClass("disabled-modal");
    
    $("#rejectModal").data("docNo", docNo);
    $("#rejectModal").data("sanctnLineNo", sanctnLineNo);
    
    $("#documentDetailModalContainer").css("overflow", "hidden");
}

function closeRejectModal() {
    $("#rejectModal").fadeOut();
    
    $("#documentDetailModalContainer").removeClass("disabled-modal");
    
    $("#rejectReason").val(""); 
    
    $("#documentDetailModalContainer").css("overflow", "auto");
}

function submitReject() {
    var docNo = $("#rejectModal").data("docNo");
    var sanctnLineNo = $("#rejectModal").data("sanctnLineNo");
    var reason = $("#rejectReason").val().trim();

    if (!reason) {
        Swal.fire({
            icon: "warning",
            title: "입력 필요",
            text: "반려 사유를 입력해주세요.",
            confirmButtonText: "확인"
        });
        return;
    }

    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/reject",
        type: "POST",
        dataType: "json",
        data: {
            docNo: docNo,
            sanctnLineNo: sanctnLineNo,
            returnResn: reason
        },
        success: function(res) {
            if (res.success) {
                Swal.fire({
                    icon: "success",
                    title: "반려 완료",
                    text: res.message,
                    confirmButtonText: "확인"
                }).then(() => {
                    window.location.href = 
                        "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/list"
                        + "?docNo=" + docNo
                        + "&openModal=true";
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "반려 실패",
                    text: res.message,
                    confirmButtonText: "확인"
                });
            }
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "반려 처리 중 오류 발생: " + error,
                confirmButtonText: "확인"
            });
        }
    });
}

function finalApproval(docNo) {
    $.ajax({
        url: "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/finalApproval",
        type: "POST",
        dataType: "json",
        data: { docNo: docNo },
        success: function(res) {
            if (res.success) {
                Swal.fire({
                    icon: "success",
                    title: "전결 완료",
                    text: res.message,
                    confirmButtonText: "확인"
                }).then(() => {
                    window.location.href = 
                        "${pageContext.request.contextPath}/batirplan/erp/electronicdocument/list"
                        + "?docNo=" + docNo
                        + "&openModal=true";
                });
            } else {
                Swal.fire({
                    icon: "error",
                    title: "전결 실패",
                    text: res.message,
                    confirmButtonText: "확인"
                });
            }
        },
        error: function(xhr, status, error) {
            Swal.fire({
                icon: "error",
                title: "오류 발생!",
                text: "전결 처리 중 오류 발생: " + error,
                confirmButtonText: "확인"
            });
        }
    });
}
</script>