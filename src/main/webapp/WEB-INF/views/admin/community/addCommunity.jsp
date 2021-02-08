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
            <div class="admin-add-community cell small-10">
                <h3><c:if test="${division eq 'add'}"><spring:message code="admin.addCommunity" /></c:if><c:if test="${division eq 'modify'}"><spring:message code="admin.modifyCommunity" /></c:if></h3>
                <form:form modelAttribute="listVO" onsubmit="return validate(this);">
                    <form:label path="kindIdx"><spring:message code="admin.kind" /></form:label>
                    <form:select path="kindIdx" cssClass="input-group-field">
                        <form:option value="0" disabled="true"><spring:message code="admin.selectKind" /></form:option>
                        <form:options items="${kind}" itemLabel="${locale eq 'ko_KR' ? 'nameKr' : locale eq 'ja_JP' ? 'nameJp' : 'nameEn'}" itemValue="idx" />
                    </form:select>
                    <form:label path="cnameJp"><spring:message code="admin.communityJp" /></form:label>
                    <form:input path="cnameJp" cssClass="input-group-field" />
                    <form:label path="cnameKr"><spring:message code="admin.communityKr" /></form:label>
                    <form:input path="cnameKr" cssClass="input-group-field" />
                    <form:label path="cnameEn"><spring:message code="admin.communityEn" /></form:label>
                    <form:input path="cnameEn" cssClass="input-group-field" />
                    <div class="addBtn">
                        <button class="button" type="submit"><i class="fi-check"></i> <c:if test="${division eq 'add'}"><spring:message code="admin.addBtn" /></c:if><c:if test="${division eq 'modify'}"><spring:message code="animedb.modifyBtn" /></c:if></button>
                        <button class="button alert" type="button" onclick="location.href='${contextPath}/admin/community/communityList'"><i class="fi-x"></i> <spring:message code="animedb.back" /></button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script>
    function validate(frm) {
        if (frm.kindIdx.value <= 0) {
            alert('<spring:message code="admin.selectKind" />'); return false;
        }
        if (formInput(frm.cnameKr, '<spring:message code="alert.noLocaleInput" arguments="${ko_KR}" />')
            || formInput(frm.cnameEn, '<spring:message code="alert.noLocaleInput" arguments="${en_US}" />')
            || formInput(frm.cnameJp, '<spring:message code="alert.noLocaleInput" arguments="${ja_JP}" />')) return false;
        return true;
    }
</script>
<script src="${js}adminCommon.js"></script>
<%@include file="../../inc/footer.jsp"%>
</body>