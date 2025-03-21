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
                    <a class="sidebar-link" href="/batirplan/erp/mypage" id="get-url" aria-expanded="false">
                        <iconify-icon icon="solar:user-circle-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">마이 페이지</span>
                    </a>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link" href="/batirplan/erp/electronicdocument/list" id="get-url" aria-expanded="false">
                        <iconify-icon icon="solar:notes-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">전자 문서</span>
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
                            <a class="sidebar-link" href="/batirplan/project/projectpm/list">
		                        <span class="icon-small"></span>
                                <span class="hide-menu">프로젝트 계획 관리</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/project/projectmanage/list">
		                        <span class="icon-small"></span>
                                <span class="hide-menu">프로젝트 관리</span>
                            </a>
                        </li>
                    </ul>
                </li>
                
                
                
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <iconify-icon icon="solar:user-id-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">인사</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/hrm/hrcard/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">인사 카드 관리</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/hrm/certification/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">증명서 발급</span>
                            </a>
                        </li>
                    </ul>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <iconify-icon icon="solar:link-round-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">협력 업체</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/cooperatiom/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">협력 업체 관리</span>
                            </a>
                        </li>
                    </ul>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <iconify-icon icon="solar:chat-round-money-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">재무</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/fnnr/salary/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">급여</span>
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
                            <a class="sidebar-link" href="/batirplan/warehouse/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">창고 관리</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/resrce/prdlst/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">품목 관리</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                                <span class="icon-small"></span>
                                <span class="hide-menu">발주 관리</span>
                            </a>
                            <ul aria-expanded="false" class="collapse two-level">
                                <li class="sidebar-item">
                                    <a href="/batirplan/resrce/req/list" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">발주 현황</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/resrce/req/handreq" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">수동 발주</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/resrce/req/autoreq" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">자동 발주</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                                <span class="icon-small"></span>
                                <span class="hide-menu">장비 관리</span>
                            </a>
                            <ul aria-expanded="false" class="collapse two-level">
                                <li class="sidebar-item">
                                    <a href="/batirplan/equipment/list" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">장비 관리</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/equipment/incoming" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">입출고 관리</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/equipment/arrangement/list" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">배치 신청</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/equipment/arrangement/pending" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">배치 관리</span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                                <span class="icon-small"></span>
                                <span class="hide-menu">입불출 관리</span>
                            </a>
                            <ul aria-expanded="false" class="collapse two-level">
                                <li class="sidebar-item">
                                    <a href="/batirplan/resrcem/wrhsdlvr/list" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">입불출 현황</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/resrce/stock/list" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">입고</span>
                                    </a>
                                </li>
                                <li class="sidebar-item">
                                    <a href="/batirplan/project/declaration/list" class="sidebar-link">
                                        <span class="icon-small"></span>
                                        <span class="hide-menu">불출</span>
                                    </a>
                                </li>
                                
                            </ul>
                        </li>
                    </ul>
                </li>
                
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="javascript:void(0)" aria-expanded="false">
                        <iconify-icon icon="solar:shield-check-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">서비스 관리</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/servicemanagement/authority">
                                <span class="icon-small"></span>
                                <span class="hide-menu">권한 관리</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/servicem/acntm/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">자동 아이디 발급</span>
                            </a>
                        </li>
                    </ul>
                </li>
				<li>
                    <span class="sidebar-divider lg"></span>
                </li>
                
                
                
                <li class="nav-small-cap">
                    <span class="hide-menu">커뮤니티</span>
                </li>
                <li class="sidebar-item">
                    <a class="sidebar-link has-arrow" href="#" aria-expanded="false">
                        <iconify-icon icon="solar:signpost-2-line-duotone" class="fs-7"></iconify-icon>
                        <span class="hide-menu">공지 및 문의</span>
                    </a>
                    <ul aria-expanded="false" class="collapse first-level">
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/notice/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">공지 사항</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link" href="/batirplan/inquiry/list">
                                <span class="icon-small"></span>
                                <span class="hide-menu">1:1 문의</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</aside>
<!-- Sidebar End -->
