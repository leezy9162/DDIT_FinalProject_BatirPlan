<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr" data-bs-theme="light" data-color-theme="Blue_Theme" data-layout="vertical">

<head>
  <!-- Required meta tags -->
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- Favicon icon-->
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath }/assets/images/logos/batirplan_logo.png" />

  <!-- Core Css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/styles.css" />

  <title>든든한 파트너 BatirPlan</title>
</head>
<style>
    .btn-group {
        display: flex;
        justify-content: center; /* 버튼 그룹을 가운데로 정렬 */
        width: 100%;
    }
    .btn-group .btn {
        margin: 0 10px; /* 각 버튼 간격을 조금 추가 */
    }
</style>

<body class="link-sidebar">
  <!-- Preloader -->
  <div class="preloader">
    <img src="../assets/images/logos/favicon.png" alt="loader" class="lds-ripple img-fluid" />
  </div>
  <div id="main-wrapper">
    <div class="position-relative overflow-hidden radial-gradient min-vh-100 w-100">
      <div class="position-relative z-index-5">
        <div class="row gx-0">

          <div class="col-lg-6 col-xl-5 col-xxl-4">
            <div class="min-vh-100 bg-body row justify-content-center align-items-center p-5">
              <div class="col-12 auth-card">
                <a href="../default-sidebar/index.html" class="text-nowrap logo-img d-block w-100">
                  <img src="${pageContext.request.contextPath }/assets/images/logos/batirplan_logo.png" class="dark-logo" alt="Logo-Dark" />
                </a>
                <p class="mb-9">건설의 시작과 끝을 함께하는 든든한 파트너, BatirPlan</p>
                <div class="position-relative text-center my-4">
                  <p class="mb-0 fs-4 px-3 d-inline-block bg-body text-dark z-index-5 position-relative">
                    sign in
                  </p>
                  <span class="border-top w-100 position-absolute top-50 start-50 translate-middle"></span>
                </div>
                
                
                <!-- spring security 에서는 /login경로에 post로 보내면 알아서 mapping 됨-->
                <form action="/login" method="post">
	                <div class="mb-3">
			        	<label for="username" class="form-label">Username</label>
			        	<input type="text" class="form-control" id="username" name="username" required />
			        </div>
                    <div class="mb-4">
        				<label for="password" class="form-label">Password</label>
        				<input type="password" class="form-control" id="password" name="password" required />
    				</div>
                  	<div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <div class="form-check">
                      <input class="form-check-input primary" type="checkbox" value="" id="flexCheckChecked" checked />
                      <label class="form-check-label text-dark" for="flexCheckChecked">
                        자동으로 로그인 하기
                      </label>
                    </div>
                    <a class="text-primary fw-medium" href="./authentication-forgot-password.html">아이디 찾기</a>
                  </div>
                  <input type="submit" class="btn btn-primary w-100 py-8 mb-4 rounded-2">
                  <a href="./index.html" class="btn btn-primary w-100 py-8 mb-4 rounded-2">Sign In</a>
                </form>
                
                
                
                
              </div>
            </div>
          </div>

          <div class="col-lg-6 col-xl-7 col-xxl-8 position-relative overflow-hidden bg-dark d-none d-lg-block">
            <div class="circle-top"></div>
            <div class="d-lg-flex align-items-center z-index-5 position-relative h-n80">
              <div class="row justify-content-center w-100">
                <div class="col-lg-6">
                  <h2 class="text-white fs-10 mb-3 lh-sm">
                    Welcome to
                    <br />
                    BatirPlan
                  </h2>
                  <span class="opacity-75 fs-4 text-white d-block mb-3">바티르 플랜은 바티르앤코의 ERP 시스템 입니다.
                    <br />
                    사원은 사번을, 협력 업체는 협력 업체 발급 받은 번호로 로그인 해주세요.
                  </span>
                  <a href="/batirplan/security/loginInfo" class="btn btn-primary">Learn More</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="dark-transparent sidebartoggler"></div>
  <!-- Import Js Files -->
  <script src="${pageContext.request.contextPath }/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/libs/simplebar/dist/simplebar.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/theme/app.init.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/theme/theme.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/theme/app.min.js"></script>
  <script src="${pageContext.request.contextPath }/assets/js/theme/sidebarmenu-default.js"></script>

  <!-- solar icons -->
  <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>

</html>