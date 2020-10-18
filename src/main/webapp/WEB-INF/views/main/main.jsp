<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:set var="member" value="${sessionScope.member}" />
<div class="main-section">
    <div class="grid-container">
        <%--人気の書き込み、アニメ情報、ショッピング情報を出力、修正必要--%>
        <div class="grid-x grid-padding-y">
            <div class="small-9 cell">
                <section class="indexList">
                    <div class="grid-x">
                        <%--人気の書き込み出力、修正必要--%>
                        <div class="small-6 cell">
                            <h3><a>人気の書き込み集め</a></h3>
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
                        <div class="small-6 cell">
                            <h3><a>アニメ情報</a></h3>
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
                <section class="indexShop">
                    <%--ショッピング情報出力、修正必要--%>
                    <div class="cell">
                        <h3><a>ショッピング情報</a></h3>
                        <hr>
                    </div>
                </section>
            </div>
            <%--ログイン、イアルタイム検索出力、修正必要--%>
            <div class="small-3 cell">
                <c:if test="${empty member}">
                    <form class="indexLogin" method="post" onsubmit="return validate(this);" action="${contextPath}/login">
                        <div class="loginInput">
                            <input class="input-group-field" type="text" id="uid" name="id" placeholder="ID入力">
                            <input class="input-group-field" type="password" id="pwd" name="pw" placeholder="パスワード入力">
                        </div>
                        <div class="grid-y loginBtn">
                            <button class="button" id="loginBtn">ログイン</button>
                        </div>
                        <div class="rememberBtn">
                            <input type="checkbox" class="check-box-table-cell" id="rememberMe" name="rememberMe" value="true">
                            <label for="rememberMe">ログイン状態を保持する</label>
                        </div>
                        <hr>
                        <div class="text-center memberOption">
                            <a href="${contextPath}/join/new_join">新規登録</a>
                            <a>ID・パスワードを忘れた</a>
                        </div>
                    </form>
                </c:if>
                <c:if test="${not empty member}">
                    <div class="indexMember">
                        <div class="memberImage">
                            <%--イメージなし時とある時の分岐の設定必要--%>
                            <img src="${contextPath}/assets/images/img/profile_image.png">
                        </div>
                        <div class="memberInfo">
                            <p><b>${member.nickname}</b><br>
                                (${member.userId})</p>
                        </div>
                        <div class="grid-x memberBtn">
                            <button class="small-6 button">通知</button>
                            <button class="small-6 button" onclick="location.href='${contextPath}/member/profile'">プロフィール</button>
                            <button class="small-12 button" onclick="logout()">ログアウト</button>
                        </div>
                    </div>
                </c:if>
                <section class="indexRank">
                    <p>リアルタイム検索</p>
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
            alert('IDをご入力ください。');
            return false;
        }
        if (frm.pw.value === '') {
            alert('パスワードをご入力ください。');
            return false;
        }
        $('#loginBtn').html('<img src="${contextPath}/assets/images/img/login-ing.gif">')
        return true;
    }

    function logout() {
        $.ajax({
            url : "${contextPath}/logout",
            success : function (data) {
                if (data.result === 'Y') {
                    alert(data.msg);
                    location.reload();
                } else {
                    alert(data.msg);
                }
            },
            error : function () {
                alert("サーバーエラーが発生しました。E");
            }
        })
    }
</script>
<%@include file="../inc/footer.jsp"%>
</body>

