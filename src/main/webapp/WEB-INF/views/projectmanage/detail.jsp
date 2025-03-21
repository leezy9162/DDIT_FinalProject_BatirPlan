<%@page import="kr.or.batirplan.projectmanage.vo.ProjectManagePRCSVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.batirplan.projectmanage.vo.ProjectManagePJTVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
<style id="apexcharts-css">@keyframes opaque {
  0% {
      opacity: 0
  }

  to {
      opacity: 1
  }
}

@keyframes resizeanim {
  0%,to {
      opacity: 0
  }
}

.apexcharts-canvas {
  position: relative;
  user-select: none
}

.apexcharts-canvas ::-webkit-scrollbar {
  -webkit-appearance: none;
  width: 6px
}

.apexcharts-canvas ::-webkit-scrollbar-thumb {
  border-radius: 4px;
  background-color: rgba(0,0,0,.5);
  box-shadow: 0 0 1px rgba(255,255,255,.5);
  -webkit-box-shadow: 0 0 1px rgba(255,255,255,.5)
}

.apexcharts-inner {
  position: relative
}

.apexcharts-text tspan {
  font-family: inherit
}

.legend-mouseover-inactive {
  transition: .15s ease all;
  opacity: .2
}

.apexcharts-legend-text {
  padding-left: 15px;
  margin-left: -15px;
}

.apexcharts-series-collapsed {
  opacity: 0
}

.apexcharts-tooltip {
  border-radius: 5px;
  box-shadow: 2px 2px 6px -4px #999;
  cursor: default;
  font-size: 14px;
  left: 62px;
  opacity: 0;
  pointer-events: none;
  position: absolute;
  top: 20px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  white-space: nowrap;
  z-index: 12;
  transition: .15s ease all
}

.apexcharts-tooltip.apexcharts-active {
  opacity: 1;
  transition: .15s ease all
}

.apexcharts-tooltip.apexcharts-theme-light {
  border: 1px solid #e3e3e3;
  background: rgba(255,255,255,.96)
}

.apexcharts-tooltip.apexcharts-theme-dark {
  color: #fff;
  background: rgba(30,30,30,.8)
}

.apexcharts-tooltip * {
  font-family: inherit
}

.apexcharts-tooltip-title {
  padding: 6px;
  font-size: 15px;
  margin-bottom: 4px
}

.apexcharts-tooltip.apexcharts-theme-light .apexcharts-tooltip-title {
  background: #eceff1;
  border-bottom: 1px solid #ddd
}

.apexcharts-tooltip.apexcharts-theme-dark .apexcharts-tooltip-title {
  background: rgba(0,0,0,.7);
  border-bottom: 1px solid #333
}

.apexcharts-tooltip-text-goals-value,.apexcharts-tooltip-text-y-value,.apexcharts-tooltip-text-z-value {
  display: inline-block;
  margin-left: 5px;
  font-weight: 600
}

.apexcharts-tooltip-text-goals-label:empty,.apexcharts-tooltip-text-goals-value:empty,.apexcharts-tooltip-text-y-label:empty,.apexcharts-tooltip-text-y-value:empty,.apexcharts-tooltip-text-z-value:empty,.apexcharts-tooltip-title:empty {
  display: none
}

.apexcharts-tooltip-text-goals-label,.apexcharts-tooltip-text-goals-value {
  padding: 6px 0 5px
}

.apexcharts-tooltip-goals-group,.apexcharts-tooltip-text-goals-label,.apexcharts-tooltip-text-goals-value {
  display: flex
}

.apexcharts-tooltip-text-goals-label:not(:empty),.apexcharts-tooltip-text-goals-value:not(:empty) {
  margin-top: -6px
}

.apexcharts-tooltip-marker {
  width: 12px;
  height: 12px;
  position: relative;
  top: 0;
  margin-right: 10px;
  border-radius: 50%
}

.apexcharts-tooltip-series-group {
  padding: 0 10px;
  display: none;
  text-align: left;
  justify-content: left;
  align-items: center
}

.apexcharts-tooltip-series-group.apexcharts-active .apexcharts-tooltip-marker {
  opacity: 1
}

.apexcharts-tooltip-series-group.apexcharts-active,.apexcharts-tooltip-series-group:last-child {
  padding-bottom: 4px
}

.apexcharts-tooltip-series-group-hidden {
  opacity: 0;
  height: 0;
  line-height: 0;
  padding: 0!important
}

.apexcharts-tooltip-y-group {
  padding: 6px 0 5px
}

.apexcharts-custom-tooltip,.apexcharts-tooltip-box {
  padding: 4px 8px
}

.apexcharts-tooltip-boxPlot {
  display: flex;
  flex-direction: column-reverse
}

.apexcharts-tooltip-box>div {
  margin: 4px 0
}

.apexcharts-tooltip-box span.value {
  font-weight: 700
}

.apexcharts-tooltip-rangebar {
  padding: 5px 8px
}

.apexcharts-tooltip-rangebar .category {
  font-weight: 600;
  color: #777
}

.apexcharts-tooltip-rangebar .series-name {
  font-weight: 700;
  display: block;
  margin-bottom: 5px
}

.apexcharts-xaxistooltip,.apexcharts-yaxistooltip {
  opacity: 0;
  pointer-events: none;
  color: #373d3f;
  font-size: 13px;
  text-align: center;
  border-radius: 2px;
  position: absolute;
  z-index: 10;
  background: #eceff1;
  border: 1px solid #90a4ae
}

.apexcharts-xaxistooltip {
  padding: 9px 10px;
  transition: .15s ease all
}

.apexcharts-xaxistooltip.apexcharts-theme-dark {
  background: rgba(0,0,0,.7);
  border: 1px solid rgba(0,0,0,.5);
  color: #fff
}

.apexcharts-xaxistooltip:after,.apexcharts-xaxistooltip:before {
  left: 50%;
  border: solid transparent;
  content: " ";
  height: 0;
  width: 0;
  position: absolute;
  pointer-events: none
}

.apexcharts-xaxistooltip:after {
  border-color: transparent;
  border-width: 6px;
  margin-left: -6px
}

.apexcharts-xaxistooltip:before {
  border-color: transparent;
  border-width: 7px;
  margin-left: -7px
}

.apexcharts-xaxistooltip-bottom:after,.apexcharts-xaxistooltip-bottom:before {
  bottom: 100%
}

.apexcharts-xaxistooltip-top:after,.apexcharts-xaxistooltip-top:before {
  top: 100%
}

.apexcharts-xaxistooltip-bottom:after {
  border-bottom-color: #eceff1
}

.apexcharts-xaxistooltip-bottom:before {
  border-bottom-color: #90a4ae
}

.apexcharts-xaxistooltip-bottom.apexcharts-theme-dark:after,.apexcharts-xaxistooltip-bottom.apexcharts-theme-dark:before {
  border-bottom-color: rgba(0,0,0,.5)
}

.apexcharts-xaxistooltip-top:after {
  border-top-color: #eceff1
}

.apexcharts-xaxistooltip-top:before {
  border-top-color: #90a4ae
}

.apexcharts-xaxistooltip-top.apexcharts-theme-dark:after,.apexcharts-xaxistooltip-top.apexcharts-theme-dark:before {
  border-top-color: rgba(0,0,0,.5)
}

.apexcharts-xaxistooltip.apexcharts-active {
  opacity: 1;
  transition: .15s ease all
}

.apexcharts-yaxistooltip {
  padding: 4px 10px
}

.apexcharts-yaxistooltip.apexcharts-theme-dark {
  background: rgba(0,0,0,.7);
  border: 1px solid rgba(0,0,0,.5);
  color: #fff
}

.apexcharts-yaxistooltip:after,.apexcharts-yaxistooltip:before {
  top: 50%;
  border: solid transparent;
  content: " ";
  height: 0;
  width: 0;
  position: absolute;
  pointer-events: none
}

.apexcharts-yaxistooltip:after {
  border-color: transparent;
  border-width: 6px;
  margin-top: -6px
}

.apexcharts-yaxistooltip:before {
  border-color: transparent;
  border-width: 7px;
  margin-top: -7px
}

.apexcharts-yaxistooltip-left:after,.apexcharts-yaxistooltip-left:before {
  left: 100%
}

.apexcharts-yaxistooltip-right:after,.apexcharts-yaxistooltip-right:before {
  right: 100%
}

.apexcharts-yaxistooltip-left:after {
  border-left-color: #eceff1
}

.apexcharts-yaxistooltip-left:before {
  border-left-color: #90a4ae
}

.apexcharts-yaxistooltip-left.apexcharts-theme-dark:after,.apexcharts-yaxistooltip-left.apexcharts-theme-dark:before {
  border-left-color: rgba(0,0,0,.5)
}

.apexcharts-yaxistooltip-right:after {
  border-right-color: #eceff1
}

.apexcharts-yaxistooltip-right:before {
  border-right-color: #90a4ae
}

.apexcharts-yaxistooltip-right.apexcharts-theme-dark:after,.apexcharts-yaxistooltip-right.apexcharts-theme-dark:before {
  border-right-color: rgba(0,0,0,.5)
}

.apexcharts-yaxistooltip.apexcharts-active {
  opacity: 1
}

.apexcharts-yaxistooltip-hidden {
  display: none
}

.apexcharts-xcrosshairs,.apexcharts-ycrosshairs {
  pointer-events: none;
  opacity: 0;
  transition: .15s ease all
}

.apexcharts-xcrosshairs.apexcharts-active,.apexcharts-ycrosshairs.apexcharts-active {
  opacity: 1;
  transition: .15s ease all
}

.apexcharts-ycrosshairs-hidden {
  opacity: 0
}

.apexcharts-selection-rect {
  cursor: move
}

.svg_select_boundingRect,.svg_select_points_rot {
  pointer-events: none;
  opacity: 0;
  visibility: hidden
}

.apexcharts-selection-rect+g .svg_select_boundingRect,.apexcharts-selection-rect+g .svg_select_points_rot {
  opacity: 0;
  visibility: hidden
}

.apexcharts-selection-rect+g .svg_select_points_l,.apexcharts-selection-rect+g .svg_select_points_r {
  cursor: ew-resize;
  opacity: 1;
  visibility: visible
}

.svg_select_points {
  fill: #efefef;
  stroke: #333;
  rx: 2
}

.apexcharts-svg.apexcharts-zoomable.hovering-zoom {
  cursor: crosshair
}

.apexcharts-svg.apexcharts-zoomable.hovering-pan {
  cursor: move
}

.apexcharts-menu-icon,.apexcharts-pan-icon,.apexcharts-reset-icon,.apexcharts-selection-icon,.apexcharts-toolbar-custom-icon,.apexcharts-zoom-icon,.apexcharts-zoomin-icon,.apexcharts-zoomout-icon {
  cursor: pointer;
  width: 20px;
  height: 20px;
  line-height: 24px;
  color: #6e8192;
  text-align: center
}

.apexcharts-menu-icon svg,.apexcharts-reset-icon svg,.apexcharts-zoom-icon svg,.apexcharts-zoomin-icon svg,.apexcharts-zoomout-icon svg {
  fill: #6e8192
}

.apexcharts-selection-icon svg {
  fill: #444;
  transform: scale(.76)
}

.apexcharts-theme-dark .apexcharts-menu-icon svg,.apexcharts-theme-dark .apexcharts-pan-icon svg,.apexcharts-theme-dark .apexcharts-reset-icon svg,.apexcharts-theme-dark .apexcharts-selection-icon svg,.apexcharts-theme-dark .apexcharts-toolbar-custom-icon svg,.apexcharts-theme-dark .apexcharts-zoom-icon svg,.apexcharts-theme-dark .apexcharts-zoomin-icon svg,.apexcharts-theme-dark .apexcharts-zoomout-icon svg {
  fill: #f3f4f5
}

.apexcharts-canvas .apexcharts-reset-zoom-icon.apexcharts-selected svg,.apexcharts-canvas .apexcharts-selection-icon.apexcharts-selected svg,.apexcharts-canvas .apexcharts-zoom-icon.apexcharts-selected svg {
  fill: #008ffb
}

.apexcharts-theme-light .apexcharts-menu-icon:hover svg,.apexcharts-theme-light .apexcharts-reset-icon:hover svg,.apexcharts-theme-light .apexcharts-selection-icon:not(.apexcharts-selected):hover svg,.apexcharts-theme-light .apexcharts-zoom-icon:not(.apexcharts-selected):hover svg,.apexcharts-theme-light .apexcharts-zoomin-icon:hover svg,.apexcharts-theme-light .apexcharts-zoomout-icon:hover svg {
  fill: #333
}

.apexcharts-menu-icon,.apexcharts-selection-icon {
  position: relative
}

.apexcharts-reset-icon {
  margin-left: 5px
}

.apexcharts-menu-icon,.apexcharts-reset-icon,.apexcharts-zoom-icon {
  transform: scale(.85)
}

.apexcharts-zoomin-icon,.apexcharts-zoomout-icon {
  transform: scale(.7)
}

.apexcharts-zoomout-icon {
  margin-right: 3px
}

.apexcharts-pan-icon {
  transform: scale(.62);
  position: relative;
  left: 1px;
  top: 0
}

.apexcharts-pan-icon svg {
  fill: #fff;
  stroke: #6e8192;
  stroke-width: 2
}

.apexcharts-pan-icon.apexcharts-selected svg {
  stroke: #008ffb
}

.apexcharts-pan-icon:not(.apexcharts-selected):hover svg {
  stroke: #333
}

.apexcharts-toolbar {
  position: absolute;
  z-index: 11;
  max-width: 176px;
  text-align: right;
  border-radius: 3px;
  padding: 0 6px 2px;
  display: flex;
  justify-content: space-between;
  align-items: center
}

.apexcharts-menu {
  background: #fff;
  position: absolute;
  top: 100%;
  border: 1px solid #ddd;
  border-radius: 3px;
  padding: 3px;
  right: 10px;
  opacity: 0;
  min-width: 110px;
  transition: .15s ease all;
  pointer-events: none
}

.apexcharts-menu.apexcharts-menu-open {
  opacity: 1;
  pointer-events: all;
  transition: .15s ease all
}

.apexcharts-menu-item {
  padding: 6px 7px;
  font-size: 12px;
  cursor: pointer
}

.apexcharts-theme-light .apexcharts-menu-item:hover {
  background: #eee
}

.apexcharts-theme-dark .apexcharts-menu {
  background: rgba(0,0,0,.7);
  color: #fff
}

@media screen and (min-width:768px) {
  .apexcharts-canvas:hover .apexcharts-toolbar {
      opacity: 1
  }
}

.apexcharts-canvas .apexcharts-element-hidden,.apexcharts-datalabel.apexcharts-element-hidden,.apexcharts-hide .apexcharts-series-points {
  opacity: 0
}

.apexcharts-hidden-element-shown {
  opacity: 1;
  transition: 0.25s ease all;
}
.apexcharts-datalabel,.apexcharts-datalabel-label,.apexcharts-datalabel-value,.apexcharts-datalabels,.apexcharts-pie-label {
  cursor: default;
  pointer-events: none
}

.apexcharts-pie-label-delay {
  opacity: 0;
  animation-name: opaque;
  animation-duration: .3s;
  animation-fill-mode: forwards;
  animation-timing-function: ease
}

.apexcharts-annotation-rect,.apexcharts-area-series .apexcharts-area,.apexcharts-area-series .apexcharts-series-markers .apexcharts-marker.no-pointer-events,.apexcharts-gridline,.apexcharts-line,.apexcharts-line-series .apexcharts-series-markers .apexcharts-marker.no-pointer-events,.apexcharts-point-annotation-label,.apexcharts-radar-series path,.apexcharts-radar-series polygon,.apexcharts-toolbar svg,.apexcharts-tooltip .apexcharts-marker,.apexcharts-xaxis-annotation-label,.apexcharts-yaxis-annotation-label,.apexcharts-zoom-rect {
  pointer-events: none
}

.apexcharts-marker {
  transition: .15s ease all
}

.resize-triggers {
  animation: 1ms resizeanim;
  visibility: hidden;
  opacity: 0;
  height: 100%;
  width: 100%;
  overflow: hidden
}

.contract-trigger:before,.resize-triggers,.resize-triggers>div {
  content: " ";
  display: block;
  position: absolute;
  top: 0;
  left: 0
}

.resize-triggers>div {
  height: 100%;
  width: 100%;
  background: #eee;
  overflow: auto
}

.contract-trigger:before {
  overflow: hidden;
  width: 200%;
  height: 200%
}

.apexcharts-bar-goals-markers{
  pointer-events: none
}

.apexcharts-bar-shadows{
  pointer-events: none
}

.apexcharts-rangebar-goals-markers{
  pointer-events: none
}</style> 
<body class="link-sidebar">
<%@include file="../module/commonTags.jsp" %>
<div id="main-wrapper" class="main-wrapper" >

	<%@include file="../module/sideBar.jsp" %>
	<div class="page-wrapper">
	
		<%@include file="../module/navBar.jsp" %>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->
  			    <div class="card card-body py-3">
			  		<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title">
		  	  			${prjctInfo.prjctNm } 
		  	  			<span class="badge  bg-primary-subtle text-primary ms-2">
		  	  				${prjctInfo.prjctCtgry }
	  	  				</span>
  	  				</h4>
			    	</div>
			    </div>
			    
			    <div class="card">
			    	<div class="card-body">
						<h4 class="card-title">🎯 현황</h4>			    		
			    		<ul class="nav nav-underline" id="myTab" role="tablist">
						  <li class="nav-item" role="presentation">
						    <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home5" role="tab" aria-controls="home5" aria-expanded="true" aria-selected="false" tabindex="-1">
						      <span>프로젝트</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile5" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">
						      <span>공정</span>
						    </a>
						  </li>
					  </ul>
					  
					  <div class="tab-content tabcontent-border p-3" id="myTabContent">
			      		  <div role="tabpanel" class="tab-pane fade show active" id="home5" aria-labelledby="home-tab">
			      		  		<div class="row">
				      		  		<div class="col-md-4">
				      		  			<h6>기본 정보</h6>
				      		  			<p class="text-black"><i class="ti ti-man text-primary fs-4"></i>${prjctInfo.chargerNm }(담당자)</p>
				      		  			<p class="text-black"><i class="ti ti-man text-primary fs-4"></i>${prjctInfo.sptMngrNm }(현장)</p>
				      		  			<p class="text-black"><i class="ti ti-map text-primary fs-4"></i>${prjctInfo.prjctLc }</p>
				      		  			<p class="text-black"><i class="ti ti-calendar text-primary fs-4"></i>${prjctInfo.prjctBgnde } ~ ${prjctInfo.prjctEndde }</p>
				      		  			<p class="text-black"><i class="ti ti-cash text-primary fs-4"></i>${prjctInfo.prjctBudget } 원</p>
				      		  		</div>
				      		  		<div class="col-md-4">
				      		  			<h6>진척도</h6>
											<div id="allPrgsChart"></div>													      		  		
					      		  			<div class="row text-center">
					      		  				<h6>프로젝트 달성률</h6>
					      		  			</div>
				      		  		</div>
				      		  		<div class="col-md-4">
				      		  			<!-- 뭘 넣냐? -->
				      		  		</div>
			      		  		</div>
			      		  </div>
					  	  <div class="tab-pane fade" id="profile5" role="tabpanel" aria-labelledby="profile-tab">
					  	  		<div class="row">
					  	  			<div class="col-md-6 mb-3">
										<h6>공정별 진척도</h6>
										<c:forEach items="${processList}" var="process">
											${process.procsNm}
											<div class="progress mb-2" style="height: 20px">
							                    <div class="progress-bar text-bg-primary" style="width: ${process.procsPrgs }%" role="progressbar">
							                      ${process.procsPrgs }%
							                    </div>
							                  </div>
										</c:forEach>
								</div>
								<div class="col-md-6 mb-3">
									<h6>예산분배 현황</h6>
									<div id="budgetChart">
									
									</div>
								</div>
					  	  		</div>
								<div class="row">
								  <c:forEach items="${processList}" var="processInfo" varStatus="status">
								    <div class="col-md-6">
								    	<div class="animate__animated animate__fadeInLeft" style="animation-delay: ${status.index * 0.3}s;">
								    		<h6>${processInfo.procsNm} (<fmt:formatDate value="${processInfo.procsBgnde}" pattern="yyyyMMdd" /> ~ <fmt:formatDate value="${processInfo.procsEndde}" pattern="yyyyMMdd" />)</h6>
								    		<p>
												${processInfo.procsCn}					    		
								    		</p>
								    	</div>
								    </div>
								  </c:forEach>
								</div>
					  	  </div>
					  </div>
					  
			    	</div>
			    </div>
				
				<!-- 📌 캘린더 추가 (현재 프로젝트에 속한 일정만 표시) -->
				<div class="container mt-5">
					<div class="card">
						<div class="card-body d-flex">
							<div class="container">
								<div id="calendar"></div>
							</div>
						</div>
					</div>
				</div>
				
				
				
		  		<!-- 작업 영역 End -->
	  		</div>
  		</div>
	</div>
</div>
    
<%@include file="../module/footerScript.jsp" %>
<script src="${pageContext.request.contextPath }/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/apex-chart/apex.radial.init.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/apex-chart/apex.pie.init.js"></script>
<%
  ProjectManagePJTVO prjctInfo = (ProjectManagePJTVO) request.getAttribute("prjctInfo");
  int allPrgs = (int) prjctInfo.getAllPrgs();
  
%>

<script>
  // JSP에서 넘어오는 값 (예: 20, 75 등)
  var chartValue = <%= allPrgs %>;
  
  var options_gradient = {
		    series: [chartValue],
		    chart: {
		      fontFamily: "inherit",
		      height: 270,
		      type: "radialBar",
		      toolbar: {
		        show: false,
		      },
		    },
		    plotOptions: {
		      radialBar: {
		        startAngle: -135,
		        endAngle: 225,
		        hollow: {
		          margin: 0,
		          size: "70%",
		          background: "#fff",
		          image: undefined,
		          imageOffsetX: 0,
		          imageOffsetY: 0,
		          position: "front",
		          dropShadow: {
		            enabled: true,
		            top: 3,
		            left: 0,
		            blur: 4,
		            opacity: 0.24,
		          },
		        },
		        track: {
		          background: "#fff",
		          strokeWidth: "67%",
		          margin: 0, // margin is in pixels
		          dropShadow: {
		            enabled: true,
		            top: -3,
		            left: 0,
		            blur: 4,
		            opacity: 0.35,
		          },
		        },

		        dataLabels: {
		          show: true,
		          name: {
		            offsetY: -10,
		            show: true,
		            color: "#615dff",
		            fontSize: "17px",
		          },
		          value: {
		            formatter: function (val) {
		              return parseInt(val);
		            },
		            color: "#6610f2",
		            fontSize: "36px",
		            show: true,
		          },
		        },
		      },
		    },
		    fill: {
		      type: "gradient",
		      gradient: {
		        shade: "dark",
		        type: "horizontal",
		        shadeIntensity: 0.5,
		        gradientToColors: ["#615dff"],
		        inverseColors: true,
		        opacityFrom: 1,
		        opacityTo: 1,
		        stops: [0, 100],
		      },
		    },
		    stroke: {
		      lineCap: "round",
		    },
		    labels: ["Percent"],
		  };

		  var chart_radial_gradient = new ApexCharts(
		    document.querySelector("#allPrgsChart"),
		    options_gradient
		  );
		  chart_radial_gradient.render();
</script>


<%
  // request에서 넘어온 processList를 가져온다고 가정
  List<ProjectManagePRCSVO> processList = (List<ProjectManagePRCSVO>) request.getAttribute("processList");
%>

<script type="text/javascript">
  // 파이 차트에 들어갈 레이블과 데이터 배열
  var labels = [];
  var data = [];

<%
  // processList를 순회하며, 각 공정명과 pblanc_amount를 JS 배열에 추가
  for(ProjectManagePRCSVO process : processList) {
%>
  labels.push("<%= process.getProcsNm() %>");         // 문자열로 레이블 추가
  data.push(<%= process.getPblancAmount() %>);        // 숫자로 데이터 추가
<%
  }
%>

  var options_simple = {
    series: data,   // 실제 데이터
    chart: {
      fontFamily: "inherit",
      type: "pie"
    },
    colors: [
      "var(--bs-primary)",
      "var(--bs-secondary)",
      "#ffae1f",
      "#fa896b",
      "#39b69a"
    ],
    labels: labels, // 레이블
    responsive: [
      {
        breakpoint: 480,
        options: {
          chart: {
            width: 200
          },
          legend: {
            position: "bottom"
          }
        }
      }
    ],
    legend: {
      labels: {
        colors: "#a1aab2"
      }
    }
  };

  // budgetChart라는 ID를 가진 div에 차트 렌더링
  var chart_pie_simple = new ApexCharts(
    document.querySelector("#budgetChart"),
    options_simple
  );
  chart_pie_simple.render();
</script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');
    var prjctNo = ${prjctInfo.prjctNo}; // 현재 프로젝트 번호

    var calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        initialView: 'dayGridMonth',
        selectable: true,
        editable: false,
        eventTimeFormat: { hour: '2-digit', minute: '2-digit', hour12: false },
        headerToolbar: { left: 'prev,next today', center: 'title', right: '' },

        // 📌 특정 프로젝트의 일정만 가져옴
        events: function (fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: "/batirplan/erp/calendar/getProjectRelatedEvents",
                method: "GET",
                data: { prjctNo: prjctNo },
                success: function (events) {
                    let formattedEvents = events.map(event => ({
                        id: event.eventId,
                        title: event.eventTitle,
                        start: event.startTime,
                        end: event.endTime,
                        description: event.eventDescription,
                        category: event.category,
                        status: event.eventStatus,
                        textColor: event.textColor,
                        backgroundColor: event.backgroundColor,
                        borderColor: event.borderColor
                    }));
                    successCallback(formattedEvents);
                },
                error: function () {
                    console.error("📌 일정 데이터를 불러오는 중 오류 발생!");
                }
            });
        }
    });

    calendar.render();
    
    setTimeout(() => {
        document.querySelector('.fc-toolbar-title').style.marginLeft = '-130px'; // 값 조정 가능
    }, 100);
    
});
</script>



</body>
</html>