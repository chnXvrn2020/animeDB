<div id="main-right" class="cell">
    <c:if test="${empty member}">
        <form class="indexLogin" method="post" onsubmit="return validate(this);" action="${contextPath}/login">
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
                        <img class="imgLandscape" src="<c:out value="${imgPath}default_image.png" />">
                    </c:when>
                    <c:otherwise>
                        <img class="imgLandscape" src="<c:out value="${imgPath}${memberAttachment.attachment}" />" alt="image">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="memberInfo">
                <p><c:if test="${member.role eq 'admin'}"><img src="${communityImg}favicon.png"></c:if><b onclick="location.href = '${animedbUrl}/member/profile'"><c:out value="${member.nickname}" /></b><br>
                    (<c:out value="${member.userId}" />)</p>
            </div>
            <div class="grid-x memberBtn">
                <button class="small-6 button"><spring:message code="animedb.myBlog" /></button>
                <button class="small-6 button" onclick="logout()"><spring:message code="animedb.signOut" /></button>
                <c:if test="${member.role eq 'admin'}">
                    <button class="button" style="width: 100%" onclick="location.href = '${contextPath}/admin'"><spring:message code="animedb.admin" /></button>
                </c:if>
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
</script>