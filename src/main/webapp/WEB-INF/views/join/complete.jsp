<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:if test="${not empty member}">
    <script>
        location.href = '${animedbUrl}';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <nav aria-label="breadCrumb" role="navigation">
            <ul class="breadcrumbs">
                <li class="breadcrumb-item active">
                    <span><spring:message code="signup.accept" /></span>
                </li>
                <li class="breadcrumb-item">
                    <span><spring:message code="signup.newInfo" /></span>
                </li>
                <li class="breadcrumb-item">
                    <span class="active"><spring:message code="signup.completed" /></span>
                </li>
            </ul>
        </nav>
        <hr style="margin-top: 3%">
        <div class="joinComplete text-center">
            <spring:message code="signup.completedMessage" />
        </div>
        <div class="text-center">
            <button type="button" class="button primary" onclick="location.href='${animedbUrl}'"><i class="fi-check"></i> <spring:message code="animedb.home" /></button>
        </div>
    </div>
</div>

<%@include file="../inc/footer.jsp"%>
</body>
