<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:if test="${empty member}">
    <script>
        location.href = '${animedbUrl}';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <div class="deleteMember">
            <div class="grid-x grid-padding-y">
                <div class="small-12 notice">
                    <h3><spring:message code="member.withdrawNotice" /></h3>
                </div>
                <div class="small-12 info">
                    <p><spring:message code="member.withdrawInfo" /></p>
                </div>
                <div class="small-12 announce">
                    <spring:message code="member.withdrawAnnounce" arguments="${member.userId}" />
                </div>
                <form class="small-6 lastPwd" method="post" onsubmit="return validate(this)" action="${animedbUrl}/member/leaveId">
                    <label for="userId"><spring:message code="member.withdrawPwd" /></label>
                    <input type="text" class="input-group-field" id="userId" name="userId" value="<c:out value="${member.userId}" />" readonly>
                    <input type="password" class="input-group-field" id="passwd" name="passwd" placeholder="<spring:message code="animedb.inputPwd" />">
                    <input type="hidden" name="_csrf" value="<c:out value="${sessionScope.CSRF_TOKEN}" />">
                    <button class="button alert" id="deleteBtn"><spring:message code="member.withdraw" /></button>
                </form>
            </div>
        </div>
        <div class="deleteBtn">
            <button type="button" id="backBtn" class="button primary" onclick="location.href = '${animedbUrl}/member/profile'"><spring:message code="animedb.back" /></button>
        </div>
    </div>
</div>
<script>
    function validate(frm) {
        if (frm.passwd.value === '') {
            alert('<spring:message code="alert.inputPwd" />');
            return false;
        }
        $('#deleteBtn').prop("disabled", true).html('<img src="${animedbImg}deleting.gif">');
        $('#backBtn').prop("disabled", true);
        return true;
    }

</script>

<%@include file="../inc/footer.jsp"%>
</body>