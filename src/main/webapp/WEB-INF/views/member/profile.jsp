<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:if test="${empty member}">
    <script>
        location.href = '${animedbUrl}';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <div class="memberProfile">
            <div class="grid-x grid-padding-y">
                <div class="small-8 cell">
                    <div class="grid-x memberImage">
                        <c:choose>
                            <c:when test="${memberAttachment.attachment eq null}">
                                <img src="<c:out value="${imgPath}default_image.png" />">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:out value="${imgPath}${memberAttachment.attachment}" />">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">ID</span>
                        <span class="small-4"><c:out value="${member.userId}" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.nickname" /></span>
                        <span class="small-4"><c:out value="${member.nickname}" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.name" /></span>
                        <div class="small-4">
                            <div class="grid-x">
                                <div class="small-3">
                                    <span><c:out value="${member.firstName}" /></span><br>
                                </div>
                                <div class="small-3">
                                    <span><c:out value="${member.lastName}" /></span><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.gender" /></span>
                        <span class="small-4">
                            <c:if test="${member.gender eq 'male'}">
                                <spring:message code="member.male" />
                            </c:if>
                            <c:if test="${member.gender eq 'female'}">
                                <spring:message code="member.female" />
                            </c:if>
                        </span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.birthday" /></span>
                        <span class="small-4"><fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.email" /></span>
                        <span class="small-4"><c:out value="${member.email}" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.phone" /></span>
                        <span class="small-4"><c:out value="${member.phone}" /></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="memberProfileBtn">
            <button class="button primary" type="button" onclick="location.href = '${animedbUrl}/member/modify'"><spring:message code="member.changeMember" /></button>
            <button class="button alert" type="button"><spring:message code="member.changePwd" /></button>
            <button class="button secondary" type="button" onclick="location.href = '${animedbUrl}/member/leaveId'"><spring:message code="member.withdraw" /></button>
        </div>
    </div>
</div>

<%@include file="../inc/footer.jsp"%>
</body>

