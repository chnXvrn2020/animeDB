<div class="slideMenu">
    <a class="close" onclick="closeSlideMenu()">
        <i class="fi-x"></i>
    </a>
    <c:if test="${empty member}">
        <div class="indexLogin">
            <div class="grid-x slideLoginBtn">
                <button class="small-6 button" onclick="location.href = '${animedbUrl}/signup/newSign'"><spring:message code="animedb.signUp" /></button>
                <button class="small-6 button" onclick="location.href = '${animedbUrl}/member/signIn'"><spring:message code="animedb.signIn" /></button>
            </div>
        </div>
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
    <div class="input-group">
        <input type="text" class="input-group-field">
        <div class="input-group-button">
            <input type="button" class="button" value="<spring:message code="animedb.search" />">
        </div>
    </div>
    <nav class="slideSelector">
        <a><spring:message code="animedb.about" /></a>
        <a><spring:message code="animedb.info" /></a>
        <a><spring:message code="animedb.community" /></a>
    </nav>
</div>
<script>
    function openSlideMenu() {
        $(".slideMenu").css('width', '250px');
    }

    function closeSlideMenu() {
        $(".slideMenu").css('width', '0');
    }
</script>
