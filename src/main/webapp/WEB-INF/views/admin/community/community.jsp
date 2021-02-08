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
            <div class="small-10">
                <div class="grid-x cell">
                    <div class="admin-community small-8">
                        <h3><spring:message code="admin.communityStatus" /></h3>
                        <div class="admin-community-table">
                            <table border="1" bordercolor="black">
                                <c:forEach items="${statusCnt}" var="cnt">
                                    <tr>
                                        <td><spring:message code="admin.amountCommunity" /></td>
                                        <td><spring:message code="admin.amountKind" /></td>
                                    </tr>
                                    <tr>
                                        <td><a href="${contextPath}/admin/community/communityList"><fmt:formatNumber pattern="#,###" value="${cnt.list_cnt}" /></a></td>
                                        <td><a href="${contextPath}/admin/community/kind"><fmt:formatNumber pattern="#,###" value="${cnt.kind_cnt}" /></a></td>
                                    </tr>
                                    <tr>
                                        <td><spring:message code="admin.amountPost" /></td>
                                        <td><spring:message code="admin.amountComment" /></td>
                                    </tr>
                                    <tr>
                                        <td><a><fmt:formatNumber pattern="#,###" value="${cnt.post_cnt}" /></a></td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td><spring:message code="admin.requestCommunity" /></td>
                                        <td><spring:message code="admin.reportedPost" /></td>
                                    </tr>
                                    <tr>
                                        <td>0</td>
                                        <td>0</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <div class="admin-community-quickBtn small-4">
                        <button class="button"><spring:message code="admin.notice" /></button>
                        <button class="button" onclick="location.href = '${contextPath}/admin/community/communityList'"><spring:message code="admin.community" /></button>
                        <button class="button" onclick="location.href = '${contextPath}/admin/community/kind'"><spring:message code="admin.communityKind" /></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../../inc/footer.jsp"%>
</body>