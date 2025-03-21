<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../module/head.jsp" %>

<body class="link-sidebar" onload="displayMap()"> 
<%@include file="../module/commonTags.jsp" %>

<div id="main-wrapper" class="main-wrapper">
    <%@include file="../module/sideBar.jsp" %>
    <div class="page-wrapper">
        <%@include file="../module/navBar.jsp" %>
        <div class="body-wrapper">
            <div class="container-fluid">
            
                <div class="card card-body py-3">
                    <div class="row align-items-center">
                        <h4 class="mb-4 mb-sm-0 card-title text-dark">장비 배치 상세정보</h4>
                    </div>
                </div>
            
                <div class="card">
                    <div class="card-body text-dark">

                        <!-- 📌 지도 -->
                        <div class="row">
                            <div class="col-md-12">
                                <h5 class="text-dark">📌 프로젝트 위치</h5>
                                <div id="map" style="width:100%; height:350px; border:1px solid #ccc;"></div>
                            </div>
                        </div>

                        <!-- 📌 장비 배치 상세 정보 -->
                        <div class="mt-4">
                            <h5 class="text-dark">장비 배치 상세 정보</h5>
                            <div class="row row-gap-10">
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">신청번호:</span> ${arrangement.requestNo}</div>
                                    <div class="detail-item"><span class="detail-label">프로젝트명:</span> ${arrangement.prjctNm}</div>
                                    <div class="detail-item"><span class="detail-label">프로젝트 위치:</span> ${arrangement.prjctLc}</div>
                                </div>

                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">신청자:</span> ${arrangement.emplNm}</div>
                                    <div class="detail-item"><span class="detail-label">장비명:</span> ${arrangement.eqpmnNm}</div>
                                    <div class="detail-item"><span class="detail-label">장비 유형:</span> ${arrangement.eqpmnTy}</div>
                                </div>

                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">일련번호:</span> ${arrangement.eqpmnSn}</div>
                                    <div class="detail-item"><span class="detail-label">제조사명:</span> ${arrangement.makrNm}</div>
                                    <div class="detail-item">
                                        <span class="detail-label">승인 여부:</span>
                                        <c:choose>
                                            <c:when test="${arrangement.approvalStatus == 'Y'}"><span class="status-approved">✔ 승인</span></c:when>
                                            <c:when test="${arrangement.approvalStatus == 'D'}"><span class="status-pending">⏳ 대기</span></c:when>
                                            <c:otherwise><span class="status-rejected">❌ 미승인</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- 추가 정보 그룹 (신청일 / 대여기간) -->
                            <div class="row mt-2">
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">신청일:</span> <fmt:formatDate value="${arrangement.requestDate}" pattern="yyyy-MM-dd" /></div>
                                </div>
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">대여 시작일:</span> <fmt:formatDate value="${arrangement.rentalStartDate}" pattern="yyyy-MM-dd" /></div>
                                </div>
                                <div class="col-md-4">
                                    <div class="detail-item"><span class="detail-label">대여 종료일:</span> <fmt:formatDate value="${arrangement.rentalEndDate}" pattern="yyyy-MM-dd" /></div>
                                </div>
                            </div>
                            
                            <div class="mt-4">
                                <h5 class="text-dark">배치 사유</h5>
                                <div class="arrangement-reason">
                                    <c:choose>
                                        <c:when test="${not empty arrangement.arrangementReason}">
                                            ${arrangement.arrangementReason}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">사유 없음</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <a href="/batirplan/equipment/arrangement/pending" class="btn btn-primary mt-3">목록</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="../module/footerScript.jsp" %>

<!-- 📌 스타일 조정 -->
<style>
    .detail-item {
        margin-bottom: 6px;
        font-size: 15px;
    }
    .detail-label {
        width: 120px;
        display: inline-block;
        font-weight: bold;
        color: #333;
    }
    .row-gap-10 {
        row-gap: 10px;
    }
    .status-approved { color: blue; font-weight: bold; }
    .status-pending { color: orange; font-weight: bold; }
    .status-rejected { color: red; font-weight: bold; }
</style>

<!-- 📌 Kakao Map SDK -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=126a30d2a46843ee25bc69a141aa9849&libraries=services"></script>
<script>
function displayMap() {
    var address = "${arrangement.prjctLc}";
    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(37.5665, 126.9780),
            level: 3
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var geocoder = new kakao.maps.services.Geocoder();

    geocoder.addressSearch(address, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px; font-weight:bold; color:black;">' + address + '</div>'
            });

            infowindow.open(map, marker);
            map.setCenter(coords);
        } else {
            Swal.fire({
                icon: "error",
                title: "주소 검색 실패",
                text: "주소를 찾을 수 없습니다.",
                confirmButtonText: "확인"
            });
        }
    });
}
</script>

</body>
</html>
