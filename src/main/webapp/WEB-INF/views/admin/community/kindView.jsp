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
                    <li class="admin-active"><a href="${contextPath}admin/community/"><spring:message code="admin.listCommunity" /></a></li>
                    <li><a><spring:message code="admin.listAnime" /></a></li>
                    <li><a><spring:message code="admin.listEnquiry" /></a></li>
                </ul>
            </div>
            <div class="admin-kind-view small-10 cell">
                <h3><spring:message code="admin.communityKind" /></h3>
                <table class="unstriped" border="2" bordercolor="black">
                    <colgroup>
                        <col style="width: 30%">
                        <col>
                    </colgroup>
                    <tr>
                        <th><spring:message code="admin.kindNameJp" /></th>
                        <td><c:out value="${one.nameJp}" /></td>
                    </tr>
                    <tr>
                        <th><spring:message code="admin.kindNameKr" /></th>
                        <td><c:out value="${one.nameKr}" /></td>
                    </tr>
                    <tr>
                        <th><spring:message code="admin.kindNameEn" /></th>
                        <td><c:out value="${one.nameEn}" /></td>
                    </tr>
                    <tr>
                        <th><spring:message code="admin.maker" /></th>
                        <td><c:out value="${one.insertAdmin}" /></td>
                    </tr>
                    <tr>
                        <th><spring:message code="admin.makeDate" /></th>
                        <td><fmt:formatDate value="${one.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd hh:mm:ss' : 'MMMM dd, yyyy hh:mm:ss'}" /></td>
                    </tr>
                    <tr>
                        <th><spring:message code="animedb.community" /></th>
                        <td>
                            <c:choose>
                                <c:when test="${empty list}">
                                    <spring:message code="admin.emptyCommunity" />
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${list}" var="list">
                                        <p><a href="${contextPath}/admin/community/viewCommunity?idx=<c:out value="${list.idx}" />"><c:out value="${locale eq 'ko_KR' ? list.cnameKr : locale eq 'ja_JP' ? list.cnameJp : list.cnameEn}" /></a></p>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
                <c:if test="${sessionScope.member.userId eq one.insertAdmin}">
                    <div class="admin-kind-view-icon">
                        <i class="fi-pencil" onclick="location.href='${contextPath}/admin/community/modifyKind?idx=<c:out value="${one.idx}" />'" title="<spring:message code="animedb.modify" />"></i>
                        <i class="fi-x" onclick="if (confirm('<spring:message code="animedb.confirmDelete" />')) location.href='${contextPath}/admin/community/deleteKind?idx=<c:out value="${one.idx}" />'" title="<spring:message code="animedb.delete" />"></i>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<%@include file="../../inc/footer.jsp"%>
</body>