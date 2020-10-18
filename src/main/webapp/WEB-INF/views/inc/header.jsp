<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<% pageContext.setAttribute("newChar", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>アニメの全て！　アニメDB</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=M+PLUS+1p">
<link rel="stylesheet" href="${contextPath}/assets/css/jquery-ui.min.css">
<link rel="stylesheet" href="${contextPath}/assets/css/jquery-ui.structure.min.css">
<link rel="stylesheet" href="${contextPath}/assets/css/jquery-ui.theme.min.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<link rel="stylesheet" href="${contextPath}/assets/fi/foundation-icons.css">
<link rel="stylesheet" href="${contextPath}/assets/css/foundation-style.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="${contextPath}/assets/js/jquery-3.5.1.min.js"></script>
<script src="${contextPath}/assets/js/jquery-ui.min.js"></script>
<script src="${contextPath}/assets/js/layout.js"></script>
<script src="${contextPath}/assets/js/foundation.min.js"></script>
<script src="https://ajaxzip3.github.io/ajaxzip3.js" charset="UTF-8"></script>
<script src="${contextPath}/assets/js/jquery.autoKana.js"></script>