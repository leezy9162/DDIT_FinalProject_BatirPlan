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
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath }/assets/images/logos/favicon.png" />

  <!-- Core Css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/styles.css" />

  <title>MatDash Bootstrap Admin</title>
</head>

<body>
  <!-- Preloader -->
  <div class="preloader">
    <img src="${pageContext.request.contextPath }/assets/images/logos/favicon.png" alt="loader" class="lds-ripple img-fluid" />
  </div>
  <div id="main-wrapper">
    <div class="position-relative overflow-hidden min-vh-100 w-100 d-flex align-items-center justify-content-center">
      <div class="d-flex align-items-center justify-content-center w-100">
        <div class="row justify-content-center w-100">
          <div class="col-lg-4">
            <div class="text-center">
              <img src="${pageContext.request.contextPath }/assets/images/backgrounds/maintenance.svg" alt="matdash-img" class="img-fluid" width="500">
              <h1 class="fw-semibold my-7 fs-9">세션이 만료되었습니다.</h1>
              <h4 class="fw-semibold mb-7">다시 로그인을 시도해 주세요.</h4>
              <a class="btn btn-primary" href="${pageContext.request.contextPath }/batirplan/erp/main" role="button">로그인</a>
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

  <!-- solar icons -->
  <script src="https://cdn.jsdelivr.net/npm/iconify-icon@1.0.8/dist/iconify-icon.min.js"></script>
</body>

</html>