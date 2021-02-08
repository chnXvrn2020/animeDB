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
                    <li><a href="${contextPath}/admin/community/"><spring:message code="admin.listCommunity" /></a></li>
                    <li><a><spring:message code="admin.listAnime" /></a></li>
                    <li><a><spring:message code="admin.listEnquiry" /></a></li>
                </ul>
            </div>
            <div class="small-8 admin-main">

            </div>
        </div>
    </div>
</div>
<%@include file="../../inc/footer.jsp"%>
</body>