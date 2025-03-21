<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../module/head.jsp" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<body class="link-sidebar">
  <%@ include file="../module/commonTags.jsp" %>
  <div id="main-wrapper" class="main-wrapper">
    <%@ include file="../module/sideBar.jsp" %>
    <div class="page-wrapper"> 
      <%@ include file="../module/navBar.jsp" %>
      <div class="body-wrapper">
        <div class="container-fluid">  
         <div class="card card-body py-3">
             <div class="row align-items-center">
                 <h4 class="mb-4 mb-sm-0 card-title text-start">권한 관리</h4>
             </div>
         </div>

         <!-- 🔹 사용자 권한 목록 -->
         <div class="card">
            <div class="card-body">
                <h4 class="mb-4 text-start">사용자 권한 목록</h4>

                <!-- 🔹 검색 필터 -->
                <div class="row mb-3">
                    <div class="col-md-12 text-end d-flex justify-content-end">
                        <input type="text" id="searchId" class="form-control w-auto me-2" placeholder="사원명 검색">
                        <button class="btn btn-primary me-2" onclick="applyFilter()">검색</button>
                        <button class="btn btn-primary" onclick="resetFilter()">초기화</button>
                    </div>
                </div>

                <div class="table-responsive mb-4 border rounded-1">
                    <table class="table text-nowrap mb-0 align-middle text-center">
                        <thead class="text-dark fs-4 text-center">
                            <tr>
                                <th>사원명</th>
                                <th>현재 권한</th>
                                <th>권한 추가</th>
                                <th>권한 삭제</th>
                            </tr>
                        </thead>
						<tbody id="userTable">
						    <c:forEach var="user" items="${users}">
						        <tr data-id="${user.mberId}">
						            <td>${user.emplName}</td> <%-- ✅ 사원명 표시 --%>
						            <td id="currentRole_${user.mberId}" 
						                data-role="${user.mberAuthor}" 
						                class="role-cell">
						                <script>
						                    document.addEventListener("DOMContentLoaded", function () {
						                        let roleCell = document.getElementById("currentRole_${user.mberId}");
						                        let roles = roleCell.getAttribute("data-role").split(", ");
						                        if (roles.length > 4) {
						                            roleCell.innerHTML = roles.slice(0, 4).join(", ") + " ...";
						                            roleCell.setAttribute("title", roles.join(", "));
						                        } else {
						                            roleCell.innerHTML = roles.join(", ");
						                        }
						                    });
						                </script>
						            </td>
						            <td>
						                <div class="d-flex align-items-center">
						                    <select class="form-select me-2" id="addRoles_${user.mberId}" data-id="${user.mberId}">
						                        <option value="">추가할 권한 선택</option>
						                    </select>
						                    <button type="button" class="btn btn-success btn-sm add-product" onclick="addUserRoles('${user.mberId}')"><i class="fs-5 ti ti-circle-plus"></i></button>
						                </div>
						            </td>
						            <td>
						                <div class="d-flex align-items-center">
						                    <select class="form-select me-2" id="removeRoles_${user.mberId}" data-id="${user.mberId}">
						                        <option value="">삭제할 권한 선택</option>
						                    </select>
						                    <button type="button" class="btn btn-danger btn-sm remove-product" onclick="removeUserRoles('${user.mberId}')"><i class="fs-5 ti ti-circle-minus"></i></button>
						                </div>
						            </td>
						        </tr>
						    </c:forEach>
						</tbody>
                    </table>
                </div>
            </div>
         </div>    
      </div>
    </div>
  </div>

  <%@ include file="../module/footerScript.jsp" %>

  <script>
	document.addEventListener("DOMContentLoaded", function () {
	    console.log("✅ 문서 로드 완료! `loadModifiableAuthorities()` 실행");
	    loadModifiableAuthorities();
	});

	function loadModifiableAuthorities() {
	    document.querySelectorAll('select.form-select').forEach(select => {
	        let userId = select.getAttribute("data-id");
	        if (!userId) {
	            console.error("🚨 userId를 찾을 수 없음. data-id 확인 필요.");
	            return;
	        }

	        // 추가할 권한 불러오기
	        fetch(`/batirplan/servicemanagement/authority/modifiable/user?mberId=\${userId}`)
	            .then(response => response.json())
	            .then(data => {
	                let addSelect = document.getElementById(`addRoles_\${userId}`);
	                if (!addSelect) return;

	                addSelect.innerHTML = "<option value=''>추가할 권한 선택</option>";
	                data.forEach(role => {
	                    addSelect.innerHTML += `<option value="\${role}">\${role}</option>`;
	                });
	            })
	            .catch(error => console.error(`🚨 [\${userId}] 추가할 권한 목록 로드 중 오류 발생:`, error));

	        // 삭제할 권한 불러오기
	        fetch(`/batirplan/servicemanagement/authority/getUserRoles?mberId=\${userId}`)
	            .then(response => response.json())
	            .then(data => {
	                let removeSelect = document.getElementById(`removeRoles_\${userId}`);
	                if (!removeSelect) return;

	                removeSelect.innerHTML = "<option value=''>삭제할 권한 선택</option>";
	                data.forEach(role => {
	                    removeSelect.innerHTML += `<option value="\${role}">\${role}</option>`;
	                });
	            })
	            .catch(error => console.error(`🚨 [\${userId}] 삭제할 권한 목록 로드 중 오류 발생:`, error));
	    });
	}
	function applyFilter() {
	    let searchName = document.getElementById("searchId").value.trim().toLowerCase();
	    let rows = document.querySelectorAll("#userTable tr");

	    rows.forEach(row => {
	        let userName = row.querySelector("td:first-child").innerText.toLowerCase();
	        if (!searchName || userName.includes(searchName)) {
	            row.style.display = "";
	        } else {
	            row.style.display = "none";
	        }
	    });
	}



	// ✅ 초기화 버튼 클릭 시 전체 리스트 표시
	function resetFilter() {
	    document.getElementById("searchId").value = "";  // 검색창 초기화
	    let rows = document.querySelectorAll("#userTable tr");

	    rows.forEach(row => {
	        row.style.display = "";
	    });
	}

	function addUserRoles(mberId) {
	    let selectedRole = document.getElementById(`addRoles_\${mberId}`).value;
	    if (!selectedRole) {
	        Swal.fire({
	            icon: 'error',
	            title: '추가할 권한을 선택하세요.',
	            confirmButtonText: '확인'
	        });
	        return;
	    }

	    fetch("/batirplan/servicemanagement/authority/addUserRole", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: `mberId=\${mberId}&role=\${selectedRole}`
	    })
	    .then(response => response.text())
	    .then(data => {
	        Swal.fire({
	            icon: 'success',
	            title: '권한 추가 완료',
	            text: data,
	            confirmButtonText: '확인'
	        });
	        loadModifiableAuthorities();
	    })
	    .catch(error => {
	        Swal.fire({
	            icon: 'error',
	            title: '오류 발생',
	            text: "추가 중 오류 발생",
	            confirmButtonText: '확인'
	        });
	        console.error("추가 중 오류 발생:", error);
	    });
	}

	function removeUserRoles(mberId) {
	    let selectedRole = document.getElementById(`removeRoles_\${mberId}`).value;
	    if (!selectedRole) {
	        Swal.fire({
	            icon: 'error',
	            title: '삭제할 권한을 선택하세요.',
	            confirmButtonText: '확인'
	        });
	        return;
	    }

	    fetch("/batirplan/servicemanagement/authority/removeUserRole", {
	        method: "POST",
	        headers: { "Content-Type": "application/x-www-form-urlencoded" },
	        body: `mberId=\${mberId}&role=\${selectedRole}`
	    })
	    .then(response => response.text())
	    .then(data => {
	        Swal.fire({
	            icon: 'success',
	            title: '권한 삭제 완료',
	            text: data,
	            confirmButtonText: '확인'
	        });
	        loadModifiableAuthorities();
	    })
	    .catch(error => {
	        Swal.fire({
	            icon: 'error',
	            title: '오류 발생',
	            text: "삭제 중 오류 발생",
	            confirmButtonText: '확인'
	        });
	        console.error("삭제 중 오류 발생:", error);
	    });
	}

  </script>
</body>
</html>
