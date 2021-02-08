<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../../inc/header.jsp"%>
    <link rel="stylesheet" href="${css}foundation-admin.css">
</head>
<body>
<%@include file="../../inc/gnb.jsp"%>
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
            <div class="admin-community-view small-10 cell">
                <h3><spring:message code="admin.community" /></h3>
                <table class="unstriped" border="2" bordercolor="black">
                    <colgroup>
                        <col style="width: 15%">
                        <col>
                        <col style="width: 15%">
                        <col>
                        <col style="width: 15%">
                        <col>
                    </colgroup>
                    <tr>
                        <th><spring:message code="admin.communityJp" /></th>
                        <td><c:out value="${one.cnameJp}" /></td>
                        <th><spring:message code="admin.communityKr" /></th>
                        <td><c:out value="${one.cnameKr}" /></td>
                        <th><spring:message code="admin.communityEn" /></th>
                        <td><c:out value="${one.cnameEn}" /></td>
                    </tr>
                    <tr>
                        <th><spring:message code="admin.kindName" /></th>
                        <td><c:out value="${locale eq 'ko_KR' ? one.kindKr : locale eq 'ja_JP' ? one.kindJp : one.kindEn}" /></td>
                        <th><spring:message code="admin.maker" /></th>
                        <td><c:out value="${one.insertAdmin}" /></td>
                        <th><spring:message code="admin.makeDate" /></th>
                        <td><fmt:formatDate value="${one.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd' : 'MMMM dd, yyyy'}" /></td>
                    </tr>
                </table>
                <div class="admin-community-view-icon">
                    <a href="${contextPath}/admin/community/communityPost?idx=<c:out value="${one.idx}" />"><spring:message code="admin.amountPost" /> : <fmt:formatNumber pattern="#,###" value="${one.postCnt}" /></a>
                    <c:if test="${sessionScope.member.userId eq one.insertAdmin}">
                        <i class="fi-pencil" onclick="location.href='${contextPath}/admin/community/modifyCommunity?idx=<c:out value="${one.idx}" />'" title="<spring:message code="animedb.modify" />"></i>
                        <i class="fi-x" onclick="if (confirm('<spring:message code="animedb.confirmDelete" />')) location.href='${contextPath}/admin/community/deleteCommunity?idx=<c:out value="${one.idx}" />'" title="<spring:message code="animedb.delete" />"></i>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../inc/footer.jsp"%>
</body>