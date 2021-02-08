<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../../inc/header.jsp"%>
    <link rel="stylesheet" href="${css}foundation-admin.css">
</head>
<body>
<%@include file="../../inc/gnb.jsp"%>
<c:set value="${locale eq 'ko_KR' ? '한국어' : locale eq 'ja_JP' ? '韓国語' : 'Korean'}" var="ko_KR" />
<c:set value="${locale eq 'ko_KR' ? '일본어' : locale eq 'ja_JP' ? '日本語' : 'Japanese'}" var="ja_JP" />
<c:set value="${locale eq 'ko_KR' ? '영어' : locale eq 'ja_JP' ? '英語' : 'English'}" var="en_US" />
<c:set value="${locale eq 'ko_KR' ? 'nameKr' : locale eq 'ja_JP' ? 'nameJp' : 'nameEn'}" var="kname1" />
<c:set value="${locale eq 'ko_KR' || 'ja_JP' ? 'nameEn' : 'nameJp'}" var="kname2" />
<c:set value="${locale eq 'ko_KR' ? 'nameJp' : 'nameKr'}" var="kname3" />
<div class="main-section">
    <div class="grid-container">
        <div class="grid-x">
            <div class="admin-menu small-2">
                <ul class="vertical menu" style="background-color: #0c3d5d">
                    <li><a><spring:message code="admin.listMain" /></a></li>
                    <li><a><spring:message code="admin.listMember" /></a></li>
                    <li class="admin-active"><a href="${contextPath}/admin/community/"><spring:message code="admin.listCommunity" /></a></li>
                    <li><a><spring:message code="admin.listAnime" /></a></li>
                    <li><a><spring:message code="admin.listEnquiry" /></a></li>
                </ul>
            </div>
            <div class="admin-addKind small-10 cell">
                <h3><c:if test="${division eq 'add'}"><spring:message code="admin.addKind" /></c:if><c:if test="${division eq 'modify'}"><spring:message code="admin.modifyKind" /></c:if></h3>
                <form:form modelAttribute="kindVO" onsubmit="return validate(this);">
                    <form:label path="nameJp"><spring:message code="admin.kindNameJp" /></form:label>
                    <form:input path="nameJp" cssClass="input-group-field" />
                    <form:label path="nameKr"><spring:message code="admin.kindNameKr" /></form:label>
                    <form:input path="nameKr" cssClass="input-group-field" />
                    <form:label path="nameEn"><spring:message code="admin.kindNameEn" /></form:label>
                    <form:input path="nameEn" cssClass="input-group-field" />
                    <div class="addBtn">
                        <button class="button" type="submit"><i class="fi-check"></i> <c:if test="${division eq 'add'}"><spring:message code="admin.addBtn" /></c:if><c:if test="${division eq 'modify'}"><spring:message code="animedb.modifyBtn" /></c:if></button>
                        <button class="button alert" type="button" onclick="location.href='${contextPath}/admin/community/kind'"><i class="fi-x"></i> <spring:message code="animedb.back" /></button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script>
    function validate(frm) {
        if (formInput(frm.nameKr, '<spring:message code="alert.noLocaleInput" arguments="${ko_KR}" />')
            || formInput(frm.nameEn, '<spring:message code="alert.noLocaleInput" arguments="${en_US}" />')
            || formInput(frm.nameJp, '<spring:message code="alert.noLocaleInput" arguments="${ja_JP}" />')) return false;
        return true;
    }
</script>
<script src="${js}adminCommon.js"></script>
<%@include file="../../inc/footer.jsp"%>
</body>