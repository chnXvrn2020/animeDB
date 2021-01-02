<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="grid-container">

    <nav class="top-bar" data-topbar role="navigation">
        <section id="banner" class="linkedBanner">
            <a href="${animedbUrl}"><img src="<c:out value="${animedbImg}animedb_logo.png" />"></a>
        </section>
        <section class="top-bar-left">
            <ul class="menu">
                <li><a class="button alert"><spring:message code="animedb.about" /></a></li>
                <li><a class="button alert"><spring:message code="animedb.info" /></a></li>
                <li><a class="button alert"><spring:message code="animedb.community" /></a></li>
            </ul>
        </section>
        <section class="top-bar-right">
            <div class="alertIcon">
                <a><i class="fi-sound"></i></a>
            </div>
            <div class="userLoginIcon">
                <c:if test="${empty member}">
                    <a onclick="location.href = '${animedbUrl}/member/signIn'"><i class="fi-lock"></i></a>
                </c:if>
                <c:if test="${not empty member}">
                    <a onclick="logout()"><i class="fi-unlock"></i></a>
                </c:if>
            </div>
            <div class="input-group">
                <input type="text" class="input-group-field">
                <div class="input-group-button">
                    <input type="button" class="button" value="<spring:message code="animedb.search" />">
                </div>
            </div>
            <div class="hamburgerMenu">
                <a onclick="openSlideMenu()">
                    <i class="fi-list"></i>
                </a>
            </div>
        </section>
    </nav>
</header>
<%@include file="../common/slideMenu.jsp"%>
