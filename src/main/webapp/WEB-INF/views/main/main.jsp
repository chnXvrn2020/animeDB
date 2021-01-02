<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <%--人気の書き込み、アニメ情報、ショッピング情報を出力、修正必要--%>
        <div class="grid-x grid-padding-y">
            <div id="mainIndex" class="cell">
                <section class="indexList">
                    <div class="grid-x">
                        <%--人気の書き込み出力、修正必要--%>
                        <div id="indexPopular" class="cell">
                            <h3><a><spring:message code="animedb.popular" /></a></h3>
                            <hr>
                            <ul>
                                <li>
                                    <a>人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１人気の書き込み１</a>
                                </li>
                                <li>
                                    <a>人気の書き込み２</a>
                                </li>
                                <li>
                                    <a>人気の書き込み３</a>
                                </li>
                                <li>
                                    <a>人気の書き込み４</a>
                                </li>
                                <li>
                                    <a>人気の書き込み５</a>
                                </li>
                                <li>
                                    <a>人気の書き込み６</a>
                                </li>
                                <li>
                                    <a>人気の書き込み７</a>
                                </li>
                                <li>
                                    <a>人気の書き込み８</a>
                                </li>
                                <li>
                                    <a>人気の書き込み９</a>
                                </li>
                                <li>
                                    <a>人気の書き込み１０</a>
                                </li>
                            </ul>
                        </div>
                        <%--アニメ情報出力、修正必要--%>
                        <div id="indexAnimeInfo" class="cell">
                            <h3><a><spring:message code="animedb.animeNews" /></a></h3>
                            <hr>
                            <ul>
                                <li>
                                    <a>アニメ情報１アニメ情報１アニメ情報１アニメ情報１アニメ情報１アニメ情報１</a>
                                </li>
                                <li>
                                    <a>アニメ情報２</a>
                                </li>
                                <li>
                                    <a>アニメ情報３</a>
                                </li>
                                <li>
                                    <a>アニメ情報４</a>
                                </li>
                                <li>
                                    <a>アニメ情報５</a>
                                </li>
                                <li>
                                    <a>アニメ情報６</a>
                                </li>
                                <li>
                                    <a>アニメ情報７</a>
                                </li>
                                <li>
                                    <a>アニメ情報８</a>
                                </li>
                                <li>
                                    <a>アニメ情報９</a>
                                </li>
                                <li>
                                    <a>アニメ情報１０</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </section>
            </div>
            <%--ログイン、イアルタイム検索出力、修正必要--%>
            <div id="main-right" class="small-3 cell">
                <c:if test="${empty member}">
                    <form class="indexLogin" method="post" onsubmit="return validate(this);" action="${animedbUrl}/login">
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
                </c:if>
                <c:if test="${not empty member}">
                    <div class="indexMember">
                        <div class="memberImage">
                            <c:choose>
                                <c:when test="${memberAttachment.attachment eq null}">
                                    <img src="<c:out value="${imgPath}default_image.png" />">
                                </c:when>
                                <c:otherwise>
                                    <img src="<c:out value="${imgPath}${memberAttachment.attachment}" />">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="memberInfo">
                            <p><b onclick="location.href = '${animedbUrl}/member/profile'"><c:out value="${member.nickname}" /></b><br>
                                (<c:out value="${member.userId}" />)</p>
                        </div>
                        <div class="grid-x memberBtn">
                            <button class="small-6 button"><spring:message code="animedb.myBlog" /></button>
                            <button class="small-6 button" onclick="logout()"><spring:message code="animedb.signOut" /></button>
                        </div>
                    </div>
                </c:if>
                <section class="indexRank">
                    <p><spring:message code="animedb.realTime" /></p>
                    <ol class="rankList">
                        <li>
                            <a>検索１</a>
                        </li>
                        <li>
                            <a>検索２</a>
                        </li>
                        <li>
                            <a>検索３</a>
                        </li>
                        <li>
                            <a>検索４</a>
                        </li>
                        <li>
                            <a>検索５</a>
                        </li>
                        <li>
                            <a>検索６</a>
                        </li>
                        <li>
                            <a>検索７</a>
                        </li>
                        <li>
                            <a>検索８</a>
                        </li>
                        <li>
                            <a>検索９</a>
                        </li>
                        <li>
                            <a>検索１０</a>
                        </li>
                    </ol>
                </section>
            </div>
        </div>
    </div>
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
                alert("<spring:message code="alert.serverError" />");
            }
        })
    }
</script>
<%@include file="../inc/footer.jsp"%>
</body>

