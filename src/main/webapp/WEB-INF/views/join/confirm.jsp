<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <%@include file="../inc/header.jsp"%>
    <c:set var="now" value="<%=new java.util.Date()%>" />
    <fmt:formatDate value="${now}" var="sysYear" pattern="yyyy" />
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:if test="${not empty member}">
    <script>
        location.href = '${animedbUrl}';
    </script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <nav aria-label="breadCrumb" role="navigation">
            <ul class="breadcrumbs">
                <li class="breadcrumb-item active">
                    <span><spring:message code="signup.accept" /></span>
                </li>
                <li class="breadcrumb-item">
                    <span class="active"><spring:message code="signup.newInfo" /></span>
                </li>
                <li class="breadcrumb-item">
                    <span><spring:message code="signup.completed" /></span>
                </li>
            </ul>
        </nav>
        <hr style="margin-top: 3%">
        <form class="newMember" name="joinFrm" method="post" action="${animedbUrl}/signup/confirm">
            <div class="grid-x grid-padding-y">
                <div class="small-10 cell">
                    <div class="grid-x input-group">
                        <label for="uid" class="small-4 text-right">ID</label>
                        <div class="small-5">
                            <input type="text" id="uid" name="userId" class="input-group-field" maxlength="16">
                            <p id="idMsg" aria-live="assertive"><spring:message code="signup.idRule" /></p>
                        </div>
                        <label for="nickname" class="small-4 text-right"><spring:message code="member.nickname" /></label>
                        <div class="small-5">
                            <input type="text" id="nickname" name="nickname" class="input-group-field" maxlength="9">
                            <p id="nicknameMsg" aria-live="assertive"><spring:message code="member.nicknameRule" /></p>
                        </div>
                        <label for="pwd1" class="small-4 text-right"><spring:message code="member.pwd" /></label>
                        <div class="small-5">
                            <input type="password" id="pwd1" name="passwd" class="input-group-field" placeholder="">
                        </div>
                        <label for="pwd2" class="small-4 text-right"><spring:message code="member.checkPwd" /></label>
                        <div class="small-5">
                            <input type="password" id="pwd2" class="input-group-field">
                            <p id="pwdMsg" aria-live="assertive"><spring:message code="member.pwdRule" /></p>
                            <p id="pwdMsg2" aria-live="assertive"></p>
                        </div>
                        <label for="firstName" class="small-4 text-right"><spring:message code="member.name" /></label>
                        <div class="small-5">
                            <div class="grid-x">
                                <div class="small-6">
                                    <input type="text" id="firstName" name="firstName" class="input-group-field" maxlength="10" placeholder="<spring:message code="member.firstName" />">
                                    <p id="firstNameMsg" aria-live="assertive"></p>
                                </div>
                                <div class="small-6">
                                    <input type="text" id="lastName" name="lastName" style="margin-left: 9%" class="input-group-field" maxlength="10" placeholder="<spring:message code="member.lastName" />">
                                    <p id="lastNameMsg" style="margin-left: 9%" aria-live="assertive"></p>
                                </div>
                            </div>
                        </div>
                        <label for="gender" class="small-4 text-right"><spring:message code="member.gender" /></label>
                        <div class="small-5">
                            <select id="gender" name="gender" class="input-group-field">
                                <option selected disabled hidden><spring:message code="animedb.select" /></option>
                                <option value="male"><spring:message code="member.male" /></option>
                                <option value="female"><spring:message code="member.female" /></option>
                            </select>
                            <p id="genderMsg" aria-live="assertive"></p>
                        </div>
                        <label for="birthYear" class="small-4 text-right"><spring:message code="member.birthday" /></label>
                        <div class="small-5">
                            <div class="grid-x">
                                <div class="small-3">
                                    <select id="birthYear" name="birthYear" class="input-group-field">
                                        <option selected disabled hidden><spring:message code="signup.year" /></option>
                                        <c:forEach var="i" begin="1900" end="${sysYear}" step="1">
                                            <option value="${sysYear - i + 1900}">${sysYear - i + 1900}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="small-3">
                                    <select id="birthMonth" name="birthMonth" class="input-group-field">
                                        <option selected disabled hidden><spring:message code="signup.month" /></option>
                                    </select>
                                </div>
                                <div class="small-3">
                                    <select id="birthDay" name="birthDay" class="input-group-field">
                                        <option selected disabled hidden><spring:message code="signup.day" /></option>
                                    </select>
                                </div>
                            </div>
                            <div class="small-5">
                                <p id="birthMsg" aria-live="assertive"></p>
                            </div>
                        </div>
                        <label for="email" class="small-4 text-right"><spring:message code="member.email" /></label>
                        <div class="small-5">
                            <input type="text" id="email" name="email" class="input-group-field" placeholder="animeDB@animedb.com">
                            <p id="emailMsg" aria-live="assertive"></p>
                        </div>
                        <label for="phone" class="small-4 text-right"><spring:message code="member.phone" /></label>
                        <div class="small-5">
                            <input type="text" id="phone" name="phone" class="input-group-field" maxlength="12" onkeypress="inNumber()">
                            <p id="phoneMsg" aria-live="assertive"><spring:message code="member.phoneRule" /></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <button type="button" class="button alert" id="backBtn" onclick="history.go(-2)"><i class="fi-x"></i> <spring:message code="animedb.back" /></button>
                <button type="button" class="button primary" id="newJoinBtn"><i class="fi-check"></i> <spring:message code="signup.join" /></button>
            </div>
        </form>
    </div>
</div>
<script>
    var joinFrm = document.joinFrm;

    $(document).ready(function (){
        $('#uid').blur(function (){
            checkId();
        });
        $('#nickname').blur(function () {
            checkNickname();
        });
        $('#pwd1').off("focus").on("focus", function () {
            if ($(this).val() !== '') {
                validetePwd($('#pwd1').val(), $('#pwdMsg'));
            }
        }).off("click").on("click", function () {
            if ($(this).val() !== '') {
                validetePwd($('#pwd1').val(), $('#pwdMsg'));
            }
        }).off('keyup').on('keyup', function () {
            $(this).blur();
            $(this).focus();
        }).keypress(function (event) {
            checkCapslock(event);
        }).keyup(function (event) {
            checkShiftUp(event);
        }).keydown(function (event) {
            checkShiftDown(event);
        }).blur(function (){
            checkUserPwd();
        });

        $('#pwd2').off("focus").on("focus", function () {
            if ($(this).val() !== '') {
                checkPwdMatched();
            }
        }).off("click").on("click", function () {
            if ($(this).val() !== '') {
                checkPwdMatched();
            }
        }).off('keyup').on('keyup', function () {
            $(this).blur();
            $(this).focus();
        }).keypress(function (event) {
            checkCapslock(event);
        }).keyup(function (event) {
            checkShiftUp(event);
        }).keydown(function (event) {
            checkShiftDown(event);
        }).blur(function () {
            checkPwdMatched();
        });
        $('#firstName').blur(function () {
            checkFirstName();
        });
        $('#lastName').blur(function () {
            checkLastName();
        });
        $('#gender').blur(function () {
            checkGender();
        })
        $('#birthYear').blur(function () {
            selectedBirthYear();
        })
        $('#birthMonth').blur(function () {
            selectedBirthMonth();
        })
        $('#birthDay').blur(function () {
            checkBirthday();
        })
        $('#email').blur(function () {
            checkEmail();
        });
        $('#phone').blur(function () {
            checkPhone();
        });
    })

    function checkId() {
        var uid = $('#uid').val();
        var obj = $('#idMsg');

        if (formInput(uid, obj, "<spring:message code="alert.noInput" />")) return false;
        if (formId(uid, obj, "<spring:message code="alert.noId" />。")) return false;
        hideMsg(obj);

        $.ajax({
            type : "GET",
            url : "${animedbUrl}/signup/check_id",
            data : {"userId" : uid},
            success : function (data) {
                if (data.result === 'pass') {
                    showSuccessMsg(obj, data.msg);
                } else {
                    showErrorMsg(obj, data.msg);
                    return false;
                }
            },
            error : function () {
                showErrorMsg(obj, "<spring:message code="alert.serverError" />")
                return false;
            }
        })
        return true;
    }

    function checkNickname(){
        var nickname = $('#nickname').val();
        var obj = $('#nicknameMsg');

        if (formInput(nickname, obj, "<spring:message code="alert.noInput" />")) return false;
        if (formNickname(nickname, obj, "<spring:message code="alert.noNickname" />")) return false;

        hideMsg(obj);

        return true;
    }

    function checkUserPwd() {
        var pwd = $('#pwd1').val();
        var obj = $('#pwdMsg');

        if (formInput(pwd, obj, "<spring:message code="alert.notInsertPwd" />")) return false;
        if (checkPwdMatched()) {
            checkPwdMatched();
        } else if (validetePwd(pwd, obj)) {
            hideMsg(obj);
        }
        return true;
    }

    function checkPwdMatched() {
        var curPwd = $('#pwd1').val();
        var checkPwd = $('#pwd2').val();
        var obj = $('#pwdMsg');

        if (formInput(curPwd, obj, "<spring:message code="alert.notInsertPwd" />")) return false;
        if (validetePwd(curPwd, obj) && formInput(checkPwd, obj, "<spring:message code="alert.emptyPwd" />")) return false;
        if (validetePwd(curPwd, obj) && formPwdMatched(curPwd, checkPwd, obj)) return false;

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

    function checkGender() {
        var gender = $('#gender').val();
        var obj = $('#genderMsg');

        if (formSelect(gender, obj, "<spring:message code="alert.unselectedGender" />")) return false;

        hideMsg(obj);
        return true;
    }

    function selectedBirthYear() {
        var birthYear = $('#birthYear');
        var birthMonth = $('#birthMonth');
        var birthDay = $('#birthDay');

        if (birthYear.val() !== null) {
            birthMonth.html('<option selected disabled hidden><spring:message code="signup.month" /></option>' +
                            '<c:forEach var="i" begin="1" end="12" step="1">' +
                            '<fmt:formatNumber value="${i}" var="month" pattern="00" />' +
                            '<option value="${month}">${month}</option>' +
                            '</c:forEach>')
        }

        if (birthDay.val() !== null) {
            birthDay.html('<option selected disabled hidden><spring:message code="signup.day" /></option>');
        }
    }

    function selectedBirthMonth() {
        var birthYear = $('#birthYear');
        var birthMonth = $('#birthMonth');
        var birthDay = $('#birthDay');

        if (birthMonth.val() !== null) {
            if (birthMonth.val() === '02' && ((birthYear.val() % 4 === 0 && birthYear.val() % 100 !== 0) || birthYear.val() % 400 === 0)) {
                birthDay.html('<option selected disabled hidden><spring:message code="signup.day" /></option>' +
                    '<c:forEach var="i" begin="1" end="29" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
            else if (birthMonth.val() === '02' && !((birthYear.val() % 4 === 0 && birthYear.val() % 100 !== 0) || birthYear.val() % 400 === 0)) {
                birthDay.html('<option selected disabled hidden><spring:message code="signup.day" /></option>' +
                    '<c:forEach var="i" begin="1" end="28" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
            else if (birthMonth.val() < 8 && birthMonth.val() % 2 === 1 || birthMonth.val() >= 8 && birthMonth.val() % 2 === 0) {
                birthDay.html('<option selected disabled hidden><spring:message code="signup.day" /></option>' +
                    '<c:forEach var="i" begin="1" end="31" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
            else {
                birthDay.html('<option selected disabled hidden><spring:message code="signup.day" /></option>' +
                    '<c:forEach var="i" begin="1" end="30" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
        }
    }

    function checkBirthday() {
        var birthYear = $('#birthYear').val();
        var birthMonth = $('#birthMonth').val();
        var birthDay = $('#birthDay').val();
        var obj = $('#birthMsg');

        if (formBirthday(birthYear, birthMonth, birthDay, obj, "<spring:message code="alert.unselectedBirthday" />")) return false;

        hideMsg(obj);

        return true;
    }

    function checkEmail() {
        var email = $('#email').val();
        var obj = $('#emailMsg');

        if (formInput(email, obj, "<spring:message code="alert.noInput" />")) return false;
        if (formEmail(email, obj, "<spring:message code="alert.noEmail" />")) return false;

        $.ajax({
            type : "GET",
            data : {"email" : email},
            url : "${animedbUrl}/signup/check_email",
            success : function (data) {
                if (data.result !== 'pass') {
                    showErrorMsg(obj, data.msg);
                    return false;
                }
            },
            error : function () {
                showErrorMsg(obj, "<spring:message code="alert.serverError" />")
                return false;
            }
        })

        hideMsg(obj);

        return true;
    }

    function checkPhone() {
        var phone = $('#phone').val();
        var obj = $('#phoneMsg');

        if (formInput(phone, obj, "<spring:message code="alert.noInput" />")) return false;
        if (formPhoneNumber(phone, obj, "<spring:message code="alert.noPhone" />")) return false;

        hideMsg(obj);

        return true;
    }

    function inNumber(){
        if (event.keyCode < 48 || event.keyCode > 57) {
            event.returnValue = false;
        }
    }

    var isShift = false;
    function checkShiftUp(e) {
        if (e.which && e.which === 16) {
            isShift = false;
        }
    }

    function checkShiftDown(e) {
        if (e.which && e.which === 16) {
            isShift = true;
        }
    }

    function checkCapslock(e) {
        var myKeyCode = 0;
        var myShiftKey = false;
        if (window.event) { // IE
            myKeyCode = e.keyCode;
            myShiftKey = e.shiftKey;
        } else if (e.which) { // netscape ff opera
            myKeyCode = e.which;
            myShiftKey = isShift;
        }

        var Msg = $("#pwdMsg2");
        if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
            showErrorMsg(Msg,"<spring:message code="alert.capsLockOn" />");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(Msg,"<spring:message code="alert.capsLockOn" />");
        } else {
            hideMsg(Msg);
        }
    }

    function checkAll() {
        return !!(checkId() &
            checkNickname() &
            validetePwd($('#pwd1').val(), $('#pwdMsg')) &
            checkUserPwd() &
            checkPwdMatched() &
            checkFirstName() &
            checkLastName() &
            checkGender() &
            checkBirthday() &
            checkEmail() &
            checkPhone());
    }

    $('#newJoinBtn').click(function () {

        if (checkAll()) {
            $('#newJoinBtn').prop("disabled", true).html('<img src="${animedbImg}ajax_loader.gif">');
            $('#backBtn').prop("disabled", true);
            joinFrm.submit();
        }
    })
</script>
<script>
    var strings = new Array();

    strings['pwd.matched'] = "<spring:message code="alert.pwdMatched" />"
    strings['pwd.unmatched'] = "<spring:message code="alert.pwdUnmatched"/>"
    strings['pwd.notAllowed'] = "<spring:message code="alert.noPwd" />"
    strings['pwd.short'] = "<spring:message code="alert.shortPwd" />"
    strings['pwd.long'] = "<spring:message code="alert.longPwd" />"
    strings['pwd.safety'] = "<spring:message code="pwd.safety" />"
    strings['pwd.low'] = "<spring:message code="pwd.safetyLow" />"
    strings['pwd.medium'] = "<spring:message code="pwd.safetyMedium" />"
    strings['pwd.high'] = "<spring:message code="pwd.safetyHigh" />"
    strings['pwd.weak'] = "<spring:message code="alert.weakPwd" />"
    strings['pwd.strong'] = "<spring:message code="alert.strongPwd" />"
    strings['pwd.perfect'] = "<spring:message code="alert.perfectPwd" />"

</script>
<script src="${js}common.js" defer crossorigin="anonymous"></script>
<script src="${js}validatePwd.js" defer crossorigin="anonymous"></script>
<%@include file="../inc/footer.jsp"%>
</body>