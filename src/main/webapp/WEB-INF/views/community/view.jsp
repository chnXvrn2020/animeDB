<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
    <c:set value="https://www.animedb.site/comment_img/" var="commentImg" />
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <div class="grid-x grid-padding-y">
            <div id="community" class="cell">
                <section class="index-community-view">
                    <h3><spring:message code="animedb.community" /> - <a href="${contextPath}/community/list?list_idx=<c:out value="${postVO.listIdx}" />"><c:out value="${locale eq 'ko_KR' ? postVO.cnameKr : locale eq 'ja_JP' ? postVO.cnameJp : postVO.cnameEn}" /></a></h3>
                    <div class="view-box">
                        <div class="view-member">
                            <div class="view-member-img">
                                <c:choose>
                                    <c:when test="${postVO.attachment eq null}">
                                        <img class="imgLandscape" src="<c:out value="${imgPath}default_image.png" />">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="imgLandscape" src="<c:out value="${imgPath}${postVO.attachment}" />" alt="image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="view-member-info">
                                <p style="text-align: center; font-weight: bold"><c:if test="${postVO.role eq 'admin'}"><img src="${communityImg}favicon.png"></c:if><c:out value="${postVO.nickname}" /></p>
                                <p style="text-align: center">(<c:out value="${postVO.userId}" />)</p>
                                <br>
                                <p><spring:message code="community.hitCnt" /> : <c:out value="${postVO.hit}" /></p>
                                <p><spring:message code="community.likePost" /> : <span id="like_cnt_fix_<c:out value="${postVO.idx}" />"><fmt:formatNumber value="${postVO.thumbs}" pattern="#,###" /></span></p>
                            </div>
                            <div class="view-ad"></div>
                        </div>
                        <div class="view-title">
                            <h3><c:out value="${postVO.title}" /></h3>
                            <div class="view-title-fr">
                                <span><fmt:formatDate value="${postVO.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd hh:mm:ss' : 'MMMM dd, yyyy hh:mm:ss'}" /></span>
                            </div>
                        </div>
                        <div class="view-content">${postVO.content}</div>
                        <div class="view-rate">
                            <button class="button" id="like_btn" data-idx="<c:out value="${postVO.idx}" />"><i class="fi-like"></i>&nbsp;<spring:message code="community.likePost" /> : <fmt:formatNumber value="${postVO.thumbs}" pattern="#,###" /></button>
                            <button class="button alert" id="dislike_btn" data-idx="<c:out value="${postVO.idx}" />"><i class="fi-dislike"></i>&nbsp;<spring:message code="community.dislikePost" /> : <fmt:formatNumber value="${postVO.dislike}" pattern="#,###" /></button>
                        </div>
                    </div>
                    <c:if test="${sessionScope.member.idx eq postVO.memberIdx}">
                        <div class="post-btn">
                            <button class="button" id="modify_btn" onclick="location.href='${contextPath}/community/modify?list_idx=<c:out value="${postVO.listIdx}" />&idx=<c:out value="${postVO.idx}" />'"><i class="fi-page-edit"></i>&nbsp;<spring:message code="animedb.modify" /></button>
                            <button class="alert button" id="delete_btn" onclick="if (confirm('<spring:message code="animedb.confirmDelete" />')) location.href='${contextPath}/community/view/delete?list_idx=<c:out value="${postVO.listIdx}" />&idx=<c:out value="${postVO.idx}" />'"><i class="fi-x"></i>&nbsp;<spring:message code="animedb.delete" /></button>
                        </div>
                    </c:if>
                    <div class="view-comment">
                        <div class="comment-cnt">
                            <span><spring:message code="admin.amountComment" /> : <fmt:formatNumber value="${totalCommentCtn}" pattern="#,###" /></span>
                        </div>
                        <div class="comment-line">
                            <c:choose>
                                <c:when test="${empty comment}">
                                    <p style="text-align: center"><spring:message code="community.noComment" /></p>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${comment}" var="comment">
                                        <div class="comment-box">
                                            <div class="comment-img">
                                                <c:when test="${comment.memberAttachment eq null}">
                                                    <img class="imgLandscape" src="<c:out value="${imgPath}default_image.png" />">
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="imgLandscape" src="<c:out value="${imgPath}${comment.memberAttachment}" />" alt="image">
                                                </c:otherwise>
                                            </div>
                                            <div class="comment-info">
                                                <p><c:out value="${comment.nickname}" />(<c:out value="${comment.userId}" />) <fmt:formatDate value="${comment.insertDate}" pattern="${locale eq 'ko_KR' || locale eq 'ja_JP' ? 'yyyy-MM-dd hh:mm:ss' : 'MMMM dd, yyyy hh:mm:ss'}" /><c:if test="${member.idx eq comment.memberIdx}"><i class="fi-x"></i><i class="fi-pencil"></i></c:if><i class="fi-comment"></i></p>
                                                <div class="comment-content">
                                                    <c:if test="${comment.commentAttachment ne null}">
                                                        <div class="comment-content-img">
                                                            <a href="<c:out value="${commentImg}${comment.commentAttachment}" />" target="_blank"><img class="imgLandscape" src="<c:out value="${commentImg}${comment.commentAttachment}" />"></a>
                                                        </div>
                                                    </c:if>
                                                    <span><c:if test="${comment.depth eq '1'}"><p><i class="fi-arrow-right"></i><c:out value="${comment.parentMember}" /></p></c:if><c:out value="${comment.commentContent}" /></span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </section>
            </div>
            <%@include file="../inc/rightSection.jsp"%>
        </div>
    </div>
</div>
<script>
    var addComma = function(num) {
        var regexp = /\B(?=(\d{3})+(?!\d))/g;
        return num.toString().replace(regexp, ',');
    }

    $(document).on('click', '#like_btn, #dislike_btn', function (e){
        var idx = $(this).attr('data-idx');
        var uid = '${postVO.userId}';
        var vote_mote = $(e.currentTarget).is('#like_btn') ? 'U' : 'D';
        var formData = "";

        formData += "idx=" + idx + "&uid=" + uid + "&mode=" + vote_mote;

        $.ajax({
            type:"POST",
            cache:"false",
            url:"${contextPath}/community/vote",
            data:formData,

            success:function (data) {
                if (data.result === "voted") {
                    $('#like_cnt_fix_' + idx).html(addComma(data.vote.U));
                    $('#like_btn').html('<i class="fi-like"></i>&nbsp;<spring:message code="community.likePost" /> : ' + addComma(data.vote.U));
                    $('#dislike_btn').html('<i class="fi-dislike"></i>&nbsp;<spring:message code="community.dislikePost" /> : ' + addComma(data.vote.D));
                } else {
                    alert(data.msg);
                    return false;
                }
            },
            error:function (){
                alert('<spring:message code="alert.serverError" />')
            }
        })
    })
</script>
<%@include file="../inc/footer.jsp"%>
</body>
