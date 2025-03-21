<!-- Author: leezy -->
<!-- JSP파일 Body 영역이 시작하기 전에 @include 해주세요. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 태그 라이브러리는 여기에 넣어주세요. -->
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fnc" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- HTML5 문서 -->
<!DOCTYPE html>
<!-- 설정  -->
<html lang="ko" dir="ltr" data-bs-theme="light" data-color-theme="Blue_Theme" data-layout="vertical">

<!-- head Start -->
<head>
  <!-- meta tags -->
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!-- Favicon icon-->
  <!-- BatirPlan 로고 이미지로 변경 필요 -->
  <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath }/assets/images/logo1.png" />

  <!-- Core Css -->
  <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/styles.css" />

  <title>든든한 파트너 바티르 플랜</title>
  
  <!-- JQuery CDN -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<!-- head End -->