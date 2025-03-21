<!-- Author: leezy -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Toast -->
<div class="toast toast-onload align-items-center text-bg-primary border-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="toast-body hstack align-items-start gap-6">
        <i class="ti ti-alert-circle fs-6"></i>
        <div>
            <h5 class="text-white fs-3 mb-1">안녕!</h5>
            <h6 class="text-white fs-2 mb-0">
                여기다 문구를 넣으렴!!<br/> views-module-common.jsp
            </h6>
        </div>
        <button type="button" class="btn-close btn-close-white fs-2 m-0 ms-auto shadow-none" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
</div>

<!-- Preloader -->
<div class="preloader">
    <img src="${pageContext.request.contextPath }/assets/images/logos/favicon.png" alt="loader" class="lds-ripple img-fluid" />
</div>
