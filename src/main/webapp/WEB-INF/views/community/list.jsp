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
                <section class="index-community-list">
                    <div class="grid-x">
                        <c:set value="${post.listName}" var="listName" />
                        <h3><spring:message code="animedb.community" /> - <a href="${contextPath}/community/list?list_idx=<c:out value="${postVO.listIdx}" />"><c:out value="${locale eq 'ko_KR' ? listName.cnameKr : locale eq 'ja_JP' ? listName.cnameJp : listName.cnameEn}" /></a></h3>
                        <div class="selectLang">
                            <select id="selectedLocale" name="selectedLocale">
                                <option disabled>-<spring:message code="animedb.languages" />-</option>
                                <option<c:if test="${postVO.selectedLocale eq 'all'}"> selected</c:if> value="all"><spring:message code="animedb.searchAll" /></option>
                                <option<c:if test="${postVO.selectedLocale eq 'ko_KR'}"> selected</c:if> value="ko_KR"><spring:message code="animedb.korean" /></option>
                                <option<c:if test="${postVO.selectedLocale eq 'ja_JP'}"> selected</c:if> value="ja_JP"><spring:message code="animedb.japanese" /></option>
                                <option<c:if test="${postVO.selectedLocale eq 'en_US'}"> selected</c:if> value="en_US"><spring:message code="animedb.english" /></option>
                            </select>
                        </div>
                        <table class="unstriped" border="2" bordercolor="black">
                            <colgroup>
                                <col style="width: 6%">
                                <col>
                                <col style="width: 20%">
                                <col style="width: 13%">
                                <col style="width: 7%">
                                <col style="width: 6%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th><spring:message code="animedb.number" /></th>
                                    <th><spring:message code="community.postTitle" /></th>
                                    <th><spring:message code="community.postWriter" /></th>
                                    <th><spring:message code="community.writedDate" /></th>
                                    <th><spring:message code="community.hitCnt" /></th>
                                    <th><spring:message code="community.likePost" /></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty post.list}">
                                        <tr><td colspan="6" style="text-align: center"><spring:message code="community.emptyPosts" /></td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="list" items="${post.list}" varStatus="status">
                                            <tr>
                                                <td style="text-align: center">${pager.listNo - status.index}</td>
                                                <td style="font-size: 18px"><a href="${contextPath}/community/view?list_idx=<c:out value="${postVO.listIdx}" />&idx=<c:out value="${list.idx}" />"><c:out value="${list.title}" /></a><a>[<c:out value="${list.commentCnt}" />]</a></td>
                                                <td style="font-size: 18px"><a><c:if test="${list.role eq 'admin'}"><img src="${communityImg}favicon.png"></c:if><c:out value="${list.nickname}" /></a></td>
                                                <td style="text-align: center"><fmt:formatDate value="${list.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd' : 'MMMM dd, yyyy'}" /></td>
                                                <td style="text-align: center"><fmt:formatNumber value="${list.hit}" pattern="#,###" /></td>
                                                <td style="text-align: center"><fmt:formatNumber value="${list.thumbs}" pattern="#,###" /></td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                        <div class="community-index">
                            <form:form modelAttribute="postVO" method="get">
                                <div class="community-search">
                                    <input type="hidden" name="list_idx" value="<c:out value="${postVO.listIdx}" />">
                                    <input type="hidden" name="selectedLocale" value="<c:out value="${postVO.selectedLocale}" />">
                                    <form:select path="searchBy">
                                        <form:option value=""><spring:message code="animedb.searchAll" /></form:option>
                                        <form:option value="title"><spring:message code="animedb.searchTitle" /></form:option>
                                        <form:option value="content"><spring:message code="animedb.content" /></form:option>
                                        <form:option value="userId"><spring:message code="animedb.userId" /></form:option>
                                        <form:option value="nickname"><spring:message code="member.nickname" /></form:option>
                                    </form:select>
                                    <form:input path="searchKeyword" />
                                    <button type="submit" class="button"><spring:message code="animedb.search" /></button>
                                </div>
                                <button class="button community-write-btn" type="button" onclick="location.href = '${contextPath}/community/write?list_idx=<c:out value="${postVO.listIdx}"/>'"><spring:message code="community.write" /></button>
                            </form:form>
                        </div>
                        <nav aria-label="Pagination" style="margin: 1% auto">
                            <c:url var="url" value="">
                                <c:param name="list_idx" value="${postVO.listIdx}" />
                                <c:param name="searchBy" value="${postVO.searchBy}" />
                                <c:param name="searchKeyword" value="${postVO.searchKeyword}" />
                                <c:param name="selectedLocale" value="${postVO.selectedLocale}" />
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
                                        <li class="ellipsis" onclick="var page=prompt('<spring:message code="animedb.jump2Page" />: (1-${pager.totalPage})', ${postVO.page}); if (page != null) document.location='${contextPath}/community/list${url}&page='+Math.min(${pager.totalPage})"></li>
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
                                        <li class="ellipsis" onclick="var page=prompt('<spring:message code="animedb.jump2Page" />: (1-${pager.totalPage})', ${postVO.page}); if (page != null) document.location='${contextPath}/community/list${url}&page='+Math.min(${pager.totalPage})"></li>
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
                </section>
            </div>
            <%@include file="../inc/rightSection.jsp"%>
        </div>
    </div>
</div>
<script>
    $('#selectedLocale').change(function (){
        location.href = '?list_idx=<c:out value="${postVO.listIdx}" />&searchBy=<c:out value="${postVO.searchBy}" />&searchKeyword=<c:out value="${postVO.searchKeyword}" />&selectedLocale=' + $(this).val();
    })
</script>
<%@include file="../inc/footer.jsp"%>
</body>