<%@ page language="java" contentType="text/html;charset=UTF-8" buffer="128kb" %>
<jsp:useBean id="SessionLocaleResolver" class="org.springframework.web.servlet.i18n.SessionLocaleResolver" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<% pageContext.setAttribute("newChar", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="animedbUrl" value="https://www.animedb.site" />
<c:set value="${sessionScope.member}" var="member" />
<c:set value="${sessionScope.memberAttachment}" var="memberAttachment" />
<c:set value="${SessionLocaleResolver.resolveLocale(pageContext.request)}" var="locale" />
<c:set value="https://www.animedb.site/member_img/" var="imgPath" />
<c:set value="https://www.animedb.site/animedb_img/" var="animedbImg" />
<c:set value="https://www.animedb.site/community_img/" var="communityImg" />
<c:set value="https://www.animedb.site/css/" var="css" />
<c:set value="https://www.animedb.site/js/" var="js" />
<c:set value="https://www.animedb.site/fi/" var="fi" />
<!DOCTYPE html>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="format-detection" content="telephone=no">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title><spring:message code="animedb.title" /></title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=M+PLUS+1p">
<link rel="stylesheet" href="${css}jquery-ui.min.css">
<link rel="stylesheet" href="${css}jquery-ui.structure.min.css">
<link rel="stylesheet" href="${css}jquery-ui.theme.min.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<link rel="stylesheet" href="${fi}foundation-icons.css">
<link rel="stylesheet" href="${css}foundation-style.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="${js}jquery-3.5.1.min.js"></script>
<script src="${js}jquery-ui.min.js"></script>
<script src="${js}foundation.min.js"></script>
<script src="${js}foundation-datepicker.min.js"></script>
<script src="${js}foundation-datepicker.${fn:substringBefore(locale, '_')}.js"></script>
<script src="${js}commons.js"></script>
