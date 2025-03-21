<!-- Author: leezy -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
    <style>
        .brand-logo img {
            max-width: 100%;
            height: auto;
            transition: all 0.3s ease-in-out;
        }

        .left-sidebar.with-vertical.collapsed .brand-logo img {
            max-width: 40px;
            height: auto;
        }
    </style>
</head>

<!-- 사이드바 Start -->
<aside class="left-sidebar with-vertical">
    <div>
        <!-- 로고 이미지 영역 -->
        <div class="brand-logo d-flex align-items-center">
            <a href="/batirplan/erp/main" class="text-nowrap logo-img">
                <img src="${pageContext.request.contextPath }/assets/images/logo1.png" alt="Logo"/>
            </a>
        </div>

        <!-- Dashboard -->
        <nav class="sidebar-nav scroll-sidebar" data-simplebar>
            <ul class="sidebar-menu" id="sidebarnav">
            
                <li class="nav-small-cap">
                    <span class="hide-menu">내 정보</span>
                </li>
                <li>
                    <a href="../" id="get-url" aria-expanded="false">
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/batirplan/erp/main" id="get-url" aria-expanded="false">
                        <iconify-icon icon="solar:home-angle-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">HOME</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/batirplan/erp/ccpymypage" id="get-url" aria-expanded="false">
                        <iconify-icon icon="solar:user-circle-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">마이 페이지</span>
                    </a>
                </li>
				<li>
                    <span class="sidebar-divider lg"></span>
                </li>
                
                
                <li class="nav-small-cap">
                    <span class="hide-menu">업무</span>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <iconify-icon icon="solar:buildings-3-outline" class="fs-7"></iconify-icon>
                        <span class="hide-menu">프로젝트</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/project/list">
		                        <span class="icon-small"></span>
                                <span class="hide-menu">프로젝트 현황</span>
                            </a>
                        </li>
                    </ul>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <iconify-icon icon="solar:box-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">자원</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/forccpy/req/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">발주 확인</span>
                            </a>
                        </li>
                    </ul>
                </li>
                
                
                
                
            </ul>
        </nav>
    </div>
</aside>
<!-- Sidebar End -->
