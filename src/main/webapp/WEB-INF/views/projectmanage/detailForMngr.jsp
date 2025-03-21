<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="../module/head.jsp" %>

<!-- main-wrapper 안에 sideBar/page-wrapper -->
<!-- page-wrapper 안에 navbar/body-wrapper -->
<!-- body-wraaper 안에 container-fluid -->
<!-- container-fluid 안에 작업하시면 됩니다. -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/assets/libs/nouislider-orxe/distribute/nouislider.min.css">
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
	    <header class="topbar">
      <div class="with-vertical">
        <!-- Navbar 시작 -->
        <nav class="navbar navbar-expand-lg p-0 w-100">
          <!-- 왼쪽: 햄버거 아이콘 -->
          <ul class="navbar-nav">
            <li class="nav-item nav-icon-hover-bg rounded-circle d-flex">
              <a class="nav-link sidebartoggler" id="headerCollapse" href="javascript:void(0)">
                <iconify-icon icon="solar:hamburger-menu-line-duotone" class="fs-6"></iconify-icon>
              </a>
            </li>
          </ul>
          
          <div class="d-block d-lg-none py-9 py-xl-0">
            <h6>든든한 파트너 바티르 플랜</h6>
          </div>
          
          <a class="navbar-toggler p-0 border-0 nav-icon-hover-bg rounded-circle">HOME</a>
        </nav>
        <!-- Navbar 끝 -->
      </div>
    </header>
		<div class="body-wrapper">
			<div class="container-fluid">
				<!-- 작업 영역 Start -->
				
  			    <div class="card card-body py-3">
			  		<div class="row align-items-center">
		  	  		<h4 class="mb-4 mb-sm-0 card-title" id="projectNm">
		  	  		
  	  				</h4>
			    	</div>
			    </div>
			    
			    <div class="card">
			    	<div class="card-body">
			    		<ul class="nav nav-underline" id="myTab" role="tablist">
						  <li class="nav-item" role="presentation">
						    <a class="nav-link active" id="home-tab" data-bs-toggle="tab" href="#home5" role="tab" aria-controls="home5" aria-expanded="true" aria-selected="false" tabindex="-1">
						      <span>정보</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile5" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1">
						      <span>진척도</span>
						    </a>
						  </li>
						  <li class="nav-item" role="presentation">
						    <a class="nav-link" id="qq-tab" data-bs-toggle="tab" href="#qq" role="tab" aria-controls="qq" aria-selected="false" tabindex="-1">
						      <span>안전 체크</span>
						    </a>
						  </li>
					  </ul>
 		    		  <div class="tab-content tabcontent-border p-3" id="myTabContent">
 		    		  	  <div role="tabpanel" class="tab-pane fade show active" id="home5" aria-labelledby="home-tab">
 		    		  	  		<div id="projectInfoAre">
 		    		  	  		
 		    		  	  		</div>
 		    		  	  </div>
 		    		  	  <div class="tab-pane fade" id="profile5" role="tabpanel" aria-labelledby="profile-tab">
							  <h5 class="text-center">프로젝트 진행 현황</h5>
							  <div id="allPrgsChart"></div>
							  <hr/>
							  <h5 class="text-center">공정별 진행 현황</h5>
							  <div id="processListContainer"></div>
							  <div class="d-felx justify-cotent-end">
							    <button class="btn btn-primary" id="updatePrgsBtn">제출</button>
							  </div>
							</div>
 		    		  	  <div role="tabpanel" class="tab-pane fade show" id="qq" aria-labelledby="qq">
 		    		  	  		<div id="safetyCheckArea">
 		    		  	  		</div>
					    		<div class="d-felx justify-cotent-end">
					    			<button class="btn btn-primary" id="safetyCheckSubmitBtn">제출</button>
					    		</div>
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
<script src="${pageContext.request.contextPath }/assets/libs/wnumb/wNumb.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/libs/nouislider-orxe/distribute/nouislider.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/plugins/nouislider-init.js"></script>
<script src="${pageContext.request.contextPath }/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/apex-chart/apex.radial.init.js"></script>
<script src="${pageContext.request.contextPath }/assets/js/apex-chart/apex.pie.init.js"></script>

<%
  int prjctNo = Integer.valueOf(request.getParameter("prjctNo"));
%>

<script type="text/javascript">

// 전역 변수로 차트 객체 선언
var chart_radial_gradient = null;
//공정 리스트 전역 변수
var globalProcessList = [];
// 프로젝트 번호 전역 변수 (서버로부터 받은 prjctNo)
var globalPrjctNo = <%= prjctNo %>;

var checkedItems = [];


$(function(){
    var param = <%= prjctNo %>;
    getDetailData(param);
    
    $("#updatePrgsBtn").on("click", function(){
    	updatePrgs();
    })
    
    $("#safetyCheckSubmitBtn").on("click", function() {
        sendCheckedSafetyItems();
    });
});

function getDetailData(param){
    $.ajax({
        url: "/batirplan/project/projectmanage/getDetailData?prjctNo=" + param,
        type: "GET",
        dataType: "json",
        success: function(res){
            console.log(res);
            
            var project = res.project; // 가독성을 위해 변수에 담아 사용
            var infoHtml = "";

            infoHtml += "<h5>프로젝트 정보</h5>";
            infoHtml += "<p>담당자: " + project.chargerNm + "</p>";
            infoHtml += "<p>현장 담당자: " + project.sptMngrNm + "</p>";
            infoHtml += "<p>프로젝트 위치: " + project.prjctLc + "</p>";
            infoHtml += "<p>일정: " + project.prjctBgnde + project.prjctEndde + "</p>";
            infoHtml += "<p>예산: " + project.prjctBudget + "</p>";
            infoHtml += "<p>프로젝트 내용: " + project.prjctCn + "</p>";

            // 3. 위에서 만든 HTML을 지정된 영역에 삽입
            $("#projectInfoAre").html(infoHtml);
            
            // 전체 진척도 차트 생성
            renderAllPrgs(res.project.allPrgs);
            $("#projectNm").text(res.project.prjctNm);
            // 서버에서 받아온 공정 리스트를 전역 변수에 저장
            globalProcessList = res.processList;
            // 공정별 슬라이더 생성 (전역 배열 사용)
            createSliders(globalProcessList);
            createSafetyCheckList(globalProcessList);
        },
        error: function(err){
            console.log(err);
        }
    });
}

function createSliders(processList){
    var container = document.getElementById("processListContainer");
    container.innerHTML = ""; // 기존 내용 초기화

    processList.forEach(function(item, index){
        var itemDiv = document.createElement("div");
        itemDiv.style.marginBottom = "30px";

        var htmlStr =
            "<h5>" + item.procsNm +
            " ( <span id='prgText-" + index + "'>" + item.procsPrgs + "</span>% )" +
            "</h5>" +
            "<div id='slider-" + index + "' style='margin-top: 10px;'></div>";

        itemDiv.innerHTML = htmlStr;
        container.appendChild(itemDiv);

        // noUiSlider 초기화
        var sliderElement = document.getElementById("slider-" + index);
        noUiSlider.create(sliderElement, {
            start: [item.procsPrgs],
            connect: [true, false],
            range: { min: 0, max: 100 },
            step: 10,
            tooltips: true
        });

        // 슬라이더 값 변경 시 표시 업데이트
        sliderElement.noUiSlider.on("update", function(values, handle){
            var newVal = Math.round(values[handle]);
            document.getElementById("prgText-" + index).textContent = newVal;
        });

        
        
        // 슬라이더 변경 완료 -> 평균 재계산 -> 차트 업데이트
        sliderElement.noUiSlider.on("change", function(values, handle){
            var finalVal = Math.round(values[handle]);
            console.log("공정번호:", item.procsNo, "새 진척도:", finalVal);
            item.procsPrgs = finalVal;
            var avg = getAverageProgress(processList);
            updateAllPrgs(avg);
        });
    });
}

function getAverageProgress(processList){
    var sum = 0;
    for(var i=0; i<processList.length; i++){
        sum += parseInt(processList[i].procsPrgs, 10);
    }
    return Math.round(sum / processList.length);
}

function renderAllPrgs(chartValue){
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

    chart_radial_gradient = new ApexCharts(
        document.querySelector("#allPrgsChart"),
        options_gradient
    );
    chart_radial_gradient.render();
}

function updateAllPrgs(newValue){
    if(chart_radial_gradient){
        chart_radial_gradient.updateSeries([newValue]);
    }
}

function updatePrgs() {
    var simplifiedList = [];
    // slider-로 시작하는 id를 가진 모든 요소 순회
    document.querySelectorAll("[id^='slider-']").forEach(function(sliderElement, index) {
        // noUiSlider 인스턴스에서 현재 값을 읽음
        var currentVal = Math.round(sliderElement.noUiSlider.get());
        // globalProcessList의 순서와 slider 순서가 동일하다고 가정
        var procsNo = globalProcessList[index].procsNo;
        simplifiedList.push({
            procsNo: procsNo,
            procsPrgs: currentVal
        });
    });
    console.log(simplifiedList);

    $.ajax({
        url: "/batirplan/project/projectmanage/updateProgress", // 컨트롤러 URL
        type: "POST",
        data: JSON.stringify(simplifiedList),  // 배열만 JSON으로
        contentType: "application/json; charset=UTF-8",
        success: function(res) {
            console.log("업데이트 성공:", res);
            // SweetAlert2로 성공 알림
            Swal.fire({
                icon: 'success',
                title: '진척도 업데이트 성공',
                text: '진척도가 성공적으로 업데이트되었습니다!'
            }).then(() => {
                // SweetAlert 확인 후 필요한 작업 (예: 화면 갱신)
                getDetailData(globalPrjctNo);
            });
        },
        error: function(err) {
            console.log("업데이트 실패:", err);
            // SweetAlert2로 오류 알림
            Swal.fire({
                icon: 'error',
                title: '업데이트 실패',
                text: '업데이트 중 오류가 발생했습니다.'
            });
        }
    });
}


function createSafetyCheckList(processList) {
    var container = document.querySelector("#safetyCheckArea");
    container.innerHTML = ""; // 기존 내용 초기화

    processList.forEach(function(process) {
        var processDiv = document.createElement("div");
        processDiv.style.border = "1px solid #ccc";
        processDiv.style.marginBottom = "20px";
        processDiv.style.padding = "10px";

        var processTitle = document.createElement("h5");
        processTitle.innerText = process.procsNm + " - 안전 체크리스트";
        processDiv.appendChild(processTitle);

        if (process.saftyList && process.saftyList.length > 0) {
            process.saftyList.forEach(function(safetyItem) {
                var label = document.createElement("label");
                label.style.display = "block";
                
                var checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                // 체크박스마다 식별 정보를 data-속성으로 저장
                checkbox.dataset.procsNo = process.procsNo;
                checkbox.dataset.procsChkStNo = safetyItem.procsChkStNo;

                label.appendChild(checkbox);
                var labelText = document.createTextNode(" " + safetyItem.procsChklstDetailCn);
                label.appendChild(labelText);

                processDiv.appendChild(label);
            });
        } else {
            var noSafety = document.createElement("p");
            noSafety.innerText = "안전 체크리스트가 없습니다.";
            processDiv.appendChild(noSafety);
        }

        container.appendChild(processDiv);
    });
}


function sendCheckedSafetyItems() {
    // 1. 체크된 항목 수집
    var checkedItems = [];
    document.querySelectorAll('#safetyCheckArea input[type="checkbox"]:checked')
        .forEach(function(checkbox) {
            var procsNo = checkbox.dataset.procsNo;
            var procsChkStNo = checkbox.dataset.procsChkStNo;
            
            // 필요한 데이터만 모아 배열에 담는다.
            checkedItems.push({
                procsNo: procsNo,
                procsChkStNo: procsChkStNo
            });
        });

    console.log("체크된 안전 체크 항목:", checkedItems);

    // 2. 체크된 항목(checkbox) 삭제
    var allCheckboxes = document.querySelectorAll('#safetyCheckArea input[type="checkbox"]');
    allCheckboxes.forEach(function(checkbox) {
        // 체크된 항목이면 삭제
        if (checkbox.checked) {
            var label = checkbox.parentElement;
            label.remove();
        }
    });

    // 3. 남은 체크박스가 하나도 없으면 SweetAlert로 알림
    var remainCheckBoxes = document.querySelectorAll('#safetyCheckArea input[type="checkbox"]');
    if (remainCheckBoxes.length === 0) {
        Swal.fire({
            icon: 'success',
            title: '금일 안전 체크를 완료하였습니다.',
            text: '더 이상 체크할 항목이 없습니다.'
        });
    }

    // 4. 서버로 전송
    /*
    $.ajax({
        url: "/batirplan/project/projectmanage/updateSafetyCheck",
        type: "POST",
        data: JSON.stringify(checkedItems),
        contentType: "application/json; charset=UTF-8",
        success: function(res) {
            console.log("안전 체크 업데이트 성공:", res);
            alert("안전 체크가 성공적으로 업데이트되었습니다!");
        },
        error: function(err) {
            console.log("안전 체크 업데이트 실패:", err);
            alert("업데이트 중 오류가 발생했습니다.");
        }
    });
    */
}

</script>
</body>
</html>