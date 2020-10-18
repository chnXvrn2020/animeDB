<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="q" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:set value="${sessionScope.member}" var="member" />
<c:if test="${empty member}">
    <script>
        location.href = '${contextPath}/';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <div class="deleteMember">
            <div class="grid-x grid-padding-y">
                <div class="small-12 notice">
                    <h3>会員解除のご案内</h3>
                </div>
                <div class="small-12 info">
                    <p>会員解除をする前に是非ご確認ください。</p>
                </div>
                <div class="small-12 announce">
                    <p>お使いのID（${member.userId}）を解除した後、再使用及び復旧ができませんので<br>
                        是非、慎重にお考え、お選びください。</p>

                    <p>解除の後であってもコミュニティなどのサビースにご掲載になられた書き込み及びコメントは削除されませんので<br>
                        削除を願う書き込み及びコメントは必ず解除前にご削除ください。
                    </p>

                    <p>解除の後、ご使いのID（${member.userId}）を用いって再び新規登録はできません。</p>
                </div>
                <form class="small-6 lastPwd" method="post" onsubmit="return validate(this)" action="${contextPath}leaveId">
                    <label for="userId">確認のため、もう一度パスワードをご入力ください。</label>
                    <input type="text" class="input-group-field" id="userId" name="userId" value="${member.userId}" readonly>
                    <input type="password" class="input-group-field" id="passwd" name="passwd" placeholder="パスワード入力">
                    <input type="hidden" name="_csrf" value="${sessionScope.CSRF_TOKEN}">
                    <button class="button alert" id="deleteBtn">会員解除</button>
                </form>
            </div>
        </div>
        <div class="deleteBtn">
            <button type="button" id="backBtn" class="button primary" onclick="history.go(-1)">戻る</button>
        </div>
    </div>
</div>
<script>
    function validate(frm) {
        if (frm.passwd.value === '') {
            alert('パスワードをご入力ください。');
            return false;
        }
        $('#deleteBtn').prop("disabled", true).html('<img src="${contextPath}/assets/images/img/deleting.gif">');
        $('#backBtn').prop("disabled", true);
        return true;
    }

</script>

<%@include file="../inc/footer.jsp"%>
</body>