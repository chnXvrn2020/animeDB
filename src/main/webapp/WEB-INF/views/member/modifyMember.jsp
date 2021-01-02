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
        <div class="modifyMember">
            <div class="grid-x grid-padding-y">
                <form class="small-8 cell" name="frm" method="post" enctype="multipart/form-data" action="${animedbUrl}/member/modify">
                    <div class="memberImage">
                        <c:choose>
                            <c:when test="${memberAttachment.attachment eq null}">
                                <img id="memberImg" src="<c:out value="${imgPath}default_image.png" />">
                            </c:when>
                            <c:otherwise>
                                <img id="memberImg" src="<c:out value="${imgPath}${memberAttachment.attachment}" />">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="imageBtn">
                        <input type="file" id="inputImage" name="memberImageFile" accept="image/jpg, image/gif, image/png">
                        <label for="inputImage" class="button alert">
                            <span><spring:message code="member.changeImg" /></span>
                        </label>
                        <input type="hidden" id="deleteImage" value="N" name="deleteImageYn">
                        <label for="deleteImage" id="delImgBtn" class="button secondary">
                            <span><spring:message code="member.deleteImg" /></span>
                        </label>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">ID</span>
                        <span class="small-6"><c:out value="${member.userId}" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.gender" /></span>
                        <span class="small-6">
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
                        <span class="small-6"><fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3"><spring:message code="member.email" /></span>
                        <span class="small-6"><c:out value="${member.email}" /></span>
                    </div>
                    <div class="grid-x info">
                        <label for="nickname" class="small-3"><spring:message code="member.nickname" /></label>
                        <div class="small-6">
                            <input type="text" class="input-group-field" id="nickname" name="nickname" value="<c:out value="${member.nickname}" />" maxlength="9" placeholder="<spring:message code="member.nicknameRule" />">
                            <p id="nicknameMsg" aria-live="assertive"></p>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <label class="small-3" for="firstName"><spring:message code="member.name" /></label>
                        <div class="small-6">
                            <div class="grid-x">
                                <div class="small-6">
                                    <input type="text" class="input-group-field" id="firstName" name="firstName" value="<c:out value="${member.firstName}" />" maxlength="10" placeholder="<spring:message code="member.firstName" />">
                                    <p id="firstNameMsg" aria-live="assertive"></p>
                                </div>
                                <div class="small-6">
                                    <input type="text" class="input-group-field" id="lastName" name="lastName" value="<c:out value="${member.lastName}" />" maxlength="10" placeholder="<spring:message code="member.lastName" />">
                                    <p id="lastNameMsg" style="margin-left: 9%" aria-live="assertive"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <label for="phone" class="small-3"><spring:message code="member.phone" /></label>
                        <div class="small-6">
                            <c:set value="${member.phone}" var="phone" />
                            <input type="text" id="phone" name="phone" value="<c:out value="${fn:replace(phone, '-', '')}" />" class="input-group-field" maxlength="12" placeholder="<spring:message code="member.phoneRule" />" onkeypress="inNumber()">
                            <p id="phoneMsg" aria-live="assertive"></p>
                        </div>
                    </div>
                    <input type="hidden" name="_csrf" value="<c:out value="${sessionScope.CSRF_TOKEN}" />">
                </form>
            </div>
        </div>
        <div class="modifyBtn">
            <button type="button" class="button primary" id="modifyMemberBtn"><i class="fi-check"></i> <spring:message code="animedb.change" /></button>
            <button type="button" class="button alert" id="backBtn" onclick="history.go(-1)"><i class="fi-x"></i> <spring:message code="animedb.back" /></button>
        </div>
    </div>
</div>
<script src="${js}common.js"></script>
<script>
    $(document).ready(function () {
        $('#inputImage').on("change", handleImgFileSelect);
        $('#nickname').blur(function () {
            checkNickname();
        });
        $('#firstName').blur(function () {
            checkFirstName();
        });
        $('#lastName').blur(function () {
            checkLastName();
        });
        $('#phone').blur(function () {
            checkPhone();
        });
        $('#delImgBtn').click(function () {
            $('#memberImg').attr("src", "<c:out value="${imgPath}default_image.png" />");
            $('#deleteImage').val('Y');
            $('#inputImage').val('');
        })
    });

    function checkNickname(){
        var nickname = $('#nickname').val();
        var obj = $('#nicknameMsg');

        if (formInput(nickname, obj, "<spring:message code="alert.noInput" />")) return false;
        if (formNickname(nickname, obj, "<spring:message code="alert.noNickname" />")) return false;

        hideMsg(obj);

        return true;
    }

    function checkFirstName() {
        var firstName = $('#firstName').val();
        var obj = $('#firstNameMsg');

        if (formInput(firstName, obj, "<spring:message code="alert.noInput" />")) return false;

        hideMsg(obj);

        return true;
    }

    function checkLastName() {
        var lastName = $('#lastName').val();
        var obj = $('#lastNameMsg');

        if (formInput(lastName, obj, "<spring:message code="alert.noInput" />")) return false;

        hideMsg(obj);

        return true;
    }

    function checkPhone() {
        var phone = $('#phone').val();
        var obj = $('#phoneMsg');

        if (formInput(phone, obj, "<spring:message code="alert.noInput" />")) return false;
        if (formPhoneNumber(phone, obj, "<spring:message code="alert.noPhone" />。")) return false;

        hideMsg(obj);

        return true;
    }

    function inNumber(){
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }

    function handleImgFileSelect(e) {
        e.preventDefault();

        var files = e.target.files;
        var limit = 2 * 1024 * 1024; //2MB

        if (files[0].size > limit) {
            alert("<spring:message code="file.2mbLimit" />");
            return;
        }

        if(!(files[0].type.match("image/jpg") || files[0].type.match("image/png") || files[0].type.match("image/gif")) ) {
            alert("<spring:message code="file.onlyImg" />");
            return;
        }

        var reader = new FileReader();
        reader.onload = function (e) {
            $('#memberImg').attr("src", e.target.result);
        }
        reader.readAsDataURL(files[0]);
    }

    function checkAll() {
        if (
            checkNickname() &
            checkFirstName() &
            checkLastName() &
            checkPhone()
        ) return true;
        else return false;
    }

    $('#modifyMemberBtn').click(function () {
        if (checkAll()) {
            $('#modifyMemberBtn').prop("disabled", true).html('<img src="${animedbImg}ajax_loader.gif">');
            $('#backBtn').prop("disabled", true);
            frm.submit();
        }
    })

</script>

<%@include file="../inc/footer.jsp"%>
</body>