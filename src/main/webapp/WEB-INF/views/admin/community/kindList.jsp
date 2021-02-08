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
            <div class="admin-kind small-10 cell">
                <h3><spring:message code="admin.communityKind" /></h3>
                <i class="fi-plus" title="<spring:message code="animedb.add" />" onclick="location.href = '${contextPath}/admin/community/addKind'"></i>
                <table class="hover unstriped" border="2" bordercolor="black">
                    <colgroup>
                        <col style="width: 10%">
                        <col>
                        <col style="width: 15%">
                        <col style="width: 15%">
                        <col style="width: 20%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th><spring:message code="animedb.number" /></th>
                            <th><spring:message code="admin.kindName" /></th>
                            <th><spring:message code="admin.amountCommunity" /></th>
                            <th><spring:message code="admin.maker" /></th>
                            <th><spring:message code="admin.makeDate" /></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty kind.list}">
                                <tr><td colspan="5" style="text-align: center"><spring:message code="admin.emptyKind" /></td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="list" items="${kind.list}" varStatus="status">
                                    <tr>
                                        <td style="text-align: center">${pager.listNo - status.index}</td>
                                        <td><a href="${contextPath}/admin/community/viewKind?idx=<c:out value="${list.idx}" />"><c:out value="${locale eq 'ko_KR' ? list.nameKr : locale eq 'ja_JP' ? list.nameJp : list.nameEn}" /></a></td>
                                        <td style="text-align: center"><c:out value="${list.listCnt}" /></td>
                                        <td style="text-align: center"><c:out value="${list.insertAdmin}" /></td>
                                        <td style="text-align: center"><fmt:formatDate value="${list.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd' : 'MMMM dd, yyyy'}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <form:form modelAttribute="kindVO" onsubmit="return validate(this);" method="get">
                    <div class="input-group">
                        <form:select path="searchBy">
                            <form:option value=""><spring:message code="animedb.searchAll" /></form:option>
                            <form:option value="name"><spring:message code="animedb.searchName" /></form:option>
                            <form:option value="admin"><spring:message code="animedb.searchMaker" /></form:option>
                        </form:select>
                        <form:input path="searchKeyword" />
                        <button type="submit" class="button"><spring:message code="animedb.search" /></button>
                    </div>
                </form:form>
                <nav aria-label="Pagination" style="margin-top: 3%">
                    <c:url var="url" value="">
                        <c:param name="searchBy" value="${kindVO.searchBy}" />
                        <c:param name="searchKeyword" value="${kindVO.searchKeyword}" />
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
                                <li class="ellipsis" onclick="var page=prompt('<spring:message code="animedb.jump2Page" />: (1-${pager.totalPage})', ${kindVO.page}); if (page != null) document.location='${contextPath}/admin/community/kind${url}&page='+Math.min(${pager.totalPage})"></li>
                                <c:forEach var="pageLink" items="${pager.pageLinks}">
                                    <c:choose>
                                        <c:when test="${pageLink eq kindVO.page}">
                                            <li class="current"><span class="show-for-sr"></span>${pageLink}</li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="${url}&page=${pageLink}">${pageLink}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <li class="ellipsis" onclick="var page=prompt('<spring:message code="animedb.jump2Page" />: (1-${pager.totalPage})', ${kindVO.page}); if (page != null) document.location='${contextPath}/admin/community/kind${url}&page='+Math.min(${pager.totalPage})"></li>
                                <li><a href="${url}&page=${pager.totalPage}">${pager.totalPage}</a></li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${pager.pageLinks}" var="pageLink">
                                    <c:choose>
                                        <c:when test="${pageLink eq kindVO.page}">
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
<script>
    function validate(frm) {
        if (formInput(frm.searchKeyword, '<spring:message code="animedb.noSearchKeyword" />')) return false;

        return true;
    }
</script>
<script src="${js}adminCommon.js"></script>
<%@include file="../../inc/footer.jsp"%>
</body>