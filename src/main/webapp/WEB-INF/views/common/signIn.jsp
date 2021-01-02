<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <form class="indexSignIn" method="post" onsubmit="return validate(this);" action="${animedbUrl}/login">
            <div class="loginInput">
                <input class="input-group-field" type="text" id="uid" name="id" placeholder="<spring:message code="animedb.inputId" />">
                <input class="input-group-field" type="password" id="pwd" name="pw" placeholder="<spring:message code="animedb.inputPwd" />">
            </div>
            <div class="grid-y loginBtn">
                <button class="button" id="loginBtn"><spring:message code="animedb.signIn" /></button>
            </div>
            <div class="rememberBtn">
                <input type="checkbox" class="check-box-table-cell" id="rememberMe" name="rememberMe" value="true">
                <label for="rememberMe"><spring:message code="animedb.stayLoggedIn" /></label>
            </div>
            <hr>
            <div class="text-center memberOption">
                <a href="${animedbUrl}/signup/newSign"><spring:message code="animedb.signUp" /></a>
                <a><spring:message code="animedb.findMember" /></a>
            </div>
        </form>
    </div>
    <%@include file="../common/slideMenu.jsp"%>
</div>
<script>
    function validate(frm) {
        if (frm.id.value === '') {
            alert('<spring:message code="alert.inputId" />');
            return false;
        }
        if (frm.pw.value === '') {
            alert('<spring:message code="alert.inputPwd" />');
            return false;
        }
        $('#loginBtn').html('<img src="${animedbImg}signin.gif">')
        return true;
    }

    function logout() {
        $.ajax({
            url : "${animedbUrl}/logout",
            success : function (data) {
                if (data.result === 'Y') {
                    alert(data.msg);
                    location.reload();
                } else {
                    alert(data.msg);
                }
            },
            error : function () {
                alert("<spring:message code="alert.serverError" />。");
            }
        })
    }
</script>
<%@include file="../inc/footer.jsp"%>
</body>