<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <div class="grid-x grid-padding-y">
            <div id="community" class="cell">
                <section class="indexList">
                    <div class="grid-x">
                        <%--人気の書き込み出力、修正必要--%>
                        <div id="communityPopular" class="cell">
                            <h3><a><spring:message code="community.popular" /></a></h3>
                            <hr>
                            <ul>
                                <c:forEach items="${popular}" var="popular">
                                    <li>
                                        <a href="${contextPath}/community/view?list_idx=<c:out value="${popular.listIdx}" />&idx=<c:out value="${popular.idx}" />">[<c:out value="${locale eq 'ko_KR' ? list.cnameKr : locale eq 'ja_JP' ? list.cnameJp : list.cnameEn}" />]&nbsp;<c:out value="${popular.title}" /></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div id="communityNewPost" class="cell">
                            <h3><a><spring:message code="community.newPost" /></a></h3>
                            <hr>
                            <ul>
                                <c:forEach items="${newPosts}" var="list">
                                    <li>
                                        <a href="${contextPath}/community/view?list_idx=<c:out value="${list.listIdx}" />&idx=<c:out value="${list.idx}" />">[<c:out value="${locale eq 'ko_KR' ? list.cnameKr : locale eq 'ja_JP' ? list.cnameJp : list.cnameEn}" />]&nbsp;<c:out value="${list.title}" /></a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div id="communityList" class="cell">
                            <h3><a><spring:message code="community.allList" /></a></h3>
                            <hr>
                            <c:forEach items="${kind}" var="kinds" varStatus="kindStatus">
                                <div class="community-list">
                                    <div class="community-kind">
                                        <b><c:out value="${locale eq 'ko_KR' ? kinds.nameKr : locale eq 'ja_JP' ? kinds.nameJp : kinds.nameEn}" /></b>
                                    </div>
                                    <div class="list-box">
                                        <c:set value="1" var="i" />
                                        <c:forEach items="${list}" var="lists" varStatus="listStatus">
                                            <c:if test="${listStatus.first}"><ul></c:if>
                                            <c:if test="${kinds.idx eq lists.kindIdx}">
                                                <c:choose>
                                                    <c:when test="${i % 9 eq 0}">
                                                        <li><a href="${contextPath}/community/list?list_idx=<c:out value="${lists.idx}" />"><c:out value="${locale eq 'ko_KR' ? lists.cnameKr : locale eq 'ja_JP' ? lists.cnameJp : lists.cnameEn}" /></a></li>
                                                        </ul>
                                                        <ul>
                                                        <c:set value="${i = 1}" var="i" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li><a href="${contextPath}/community/list?list_idx=<c:out value="${lists.idx}" />"><c:out value="${locale eq 'ko_KR' ? lists.cnameKr : locale eq 'ja_JP' ? lists.cnameJp : lists.cnameEn}" /></a></li>
                                                        <c:set value="${i + 1}" var="i" />
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                            <c:if test="${listStatus.last}"></ul></c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </div>
            <%@include file="../inc/rightSection.jsp"%>
        </div>
    </div>
</div>
<%@include file="../inc/footer.jsp"%>
</body>