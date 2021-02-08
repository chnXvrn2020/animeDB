<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../../inc/header.jsp"%>
    <link rel="stylesheet" href="${css}foundation-admin.css">
</head>
<body>
<%@include file="../../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <div class="grid-x">
            <div class="admin-menu small-2">
                <ul class="vertical menu" style="background-color: #0c3d5d">
                    <li><a><spring:message code="admin.listMain" /></a></li>
                    <li><a><spring:message code="admin.listMember" /></a></li>
                    <li class="admin-active"><a href="${contextPath}/admin/community/"><spring:message code="admin.listCommunity" /></a></li>
                    <li><a><spring:message code="admin.listAnime" /></a></li>
                    <li><a><spring:message code="admin.listEnquiry" /></a></li>
                </ul>
            </div>
            <div class="admin-community-post-view small-10 cell">
                <c:set value="${post.listName}" var="listName" />
                <h3 style="margin-right: auto"><spring:message code="admin.communityPost" />(<c:out value="${locale eq 'ko_KR' ? listName.cnameKr : locale eq 'ja_JP' ? listName.cnameJp : listName.cnameEn}" />)</h3>
                <table class="unstriped" border="2" bordercolor="black">
                    <colgroup>
                        <col style="width: 7%">
                        <col>
                        <col style="width: 15%">
                        <col style="width: 8%">
                        <col style="width: 7%">
                        <col style="width: 8%">
                        <col style="width: 15%">
                    </colgroup>
                    <thead>
                    <tr>
                        <th><spring:message code="animedb.number" /></th>
                        <th><spring:message code="community.postTitle" /></th>
                        <th><spring:message code="community.postWriter" /></th>
                        <th><spring:message code="community.hitCnt" /></th>
                        <th><spring:message code="community.likePost" /></th>
                        <th><spring:message code="community.dislikePost" /></th>
                        <th><spring:message code="community.writedDate" /></th>
                    </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty post.list}">
                                <tr><td colspan="7" style="text-align: center"><spring:message code="community.emptyPosts" /></td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="list" items="${post.list}" varStatus="status">
                                    <tr>
                                        <td>${pager.listNo - status.index}</td>
                                        <td><a><c:out value="${list.title}" /></a></td>
                                        <td><c:out value="${list.nickname}" /></td>
                                        <td><fmt:formatNumber value="${list.hit}" pattern="#,###" /></td>
                                        <td><fmt:formatNumber value="${list.thumbs}" pattern="#,###" /></td>
                                        <td><fmt:formatNumber value="${list.dislike}" pattern="#,###" /></td>
                                        <td><fmt:formatDate value="${list.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd' : 'MMMM dd, yyyy'}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <form:form modelAttribute="postVO" method="get">
                    <div class="input-group">
                        <input type="hidden" name="idx" value="<c:out value="${postVO.listIdx}" />">
                        <form:select path="searchBy">
                            <form:option value=""><spring:message code="animedb.searchAll" /></form:option>
                            <form:option value="title"><spring:message code="animedb.searchTitle" /></form:option>
                            <form:option value="content"><spring:message code="animedb.content" /></form:option>
                            <form:option value="nickname"><spring:message code="member.nickname" /></form:option>
                        </form:select>
                        <form:input path="searchKeyword" />
                        <button type="submit" class="button"><spring:message code="animedb.search" /></button>
                    </div>
                </form:form>
                <nav aria-label="Pagination" style="margin-top: 3%">
                    <c:url var="url" value="">
                        <c:param name="idx" value="${postVO.listIdx}" />
                        <c:param name="searchBy" value="${postVO.searchBy}" />
                        <c:param name="searchKeyword" value="${postVO.searchKeyword}" />
                    </c:url>
                    <ul class="pagination text-center">
                        <c:if test="${pager.prevLink gt 0}">
                            <li class="pagination-previous" onclick="location.href='${url}&page=${pager.prevLink}'"></li>
                        </c:if>
                        <c:if test="${pager.prevLink le 0}">
                            <li class="pagination-previous disabled" onclick="return false;"></li>
                        </c:if>
                        <c:choose>
                            <c:when test="${fn:length(pager.pageLinks) eq 5 && pager.totalPage >= 7}">
                                <li><a href="${url}&page=1">1</a></li>
                                <li class="ellipsis" onclick="var page=prompt('<spring:message code="animedb.jump2Page" />: (1-${pager.totalPage})', ${postVO.page}); if (page != null) document.location='${contextPath}/admin/community/communityPost${url}&page='+Math.min(${pager.totalPage})"></li>
                                <c:forEach var="pageLink" items="${pager.pageLinks}">
                                    <c:choose>
                                        <c:when test="${pageLink eq postVO.page}">
                                            <li class="current"><span class="show-for-sr"></span>${pageLink}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${url}&page=${pageLink}">${pageLink}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="ellipsis" onclick="var page=prompt('<spring:message code="animedb.jump2Page" />: (1-${pager.totalPage})', ${postVO.page}); if (page != null) document.location='${contextPath}/admin/community/communityPost${url}&page='+Math.min(${pager.totalPage})"></li>
                                <li><a href="${url}&page=${pager.totalPage}">${pager.totalPage}</a></li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${pager.pageLinks}" var="pageLink">
                                    <c:choose>
                                        <c:when test="${pageLink eq postVO.page}">
                                            <li class="current"><span class="show-for-sr"></span>${pageLink}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${url}&page=${pageLink}">${pageLink}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${pager.nextLink le pager.totalPage}">
                            <li class="pagination-next" onclick="location.href = '${url}&page=${pager.nextLink}'"></li>
                        </c:if>
                        <c:if test="${pager.nextLink gt pager.totalPage}">
                            <li class="pagination-next disabled" onclick="return false;"></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
<%@include file="../../inc/footer.jsp"%>
</body>
