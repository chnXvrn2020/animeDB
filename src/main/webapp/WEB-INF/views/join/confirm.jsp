<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <%@include file="../inc/header.jsp"%>
    <c:set var="now" value="<%=new java.util.Date()%>" />
    <fmt:formatDate value="${now}" var="sysYear" pattern="yyyy" />
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<div class="main-section">
    <div class="grid-container">
        <nav aria-label="breadCrumb" role="navigation">
            <ul class="breadcrumbs">
                <li class="breadcrumb-item active">
                    <span>利用規約に同意</span>
                </li>
                <li class="breadcrumb-item">
                    <span class="active">新規情報入力</span>
                </li>
                <li class="breadcrumb-item">
                    <span>新規登録完了</span>
                </li>
            </ul>
        </nav>
        <hr style="margin-top: 3%">
        <form class="newMember" name="joinFrm" method="post" action="${contextPath}confirm">
            <div class="grid-x grid-padding-y">
                <div class="small-10 cell">
                    <div class="grid-x input-group">
                        <label for="uid" class="small-4 text-right">ID</label>
                        <div class="small-5">
                            <input type="text" id="uid" name="userId" class="input-group-field" maxlength="16" placeholder="6～16長さの半角の英字小文字、数字　記号は_のみ">
                            <p id="idMsg" aria-live="assertive"></p>
                        </div>
                        <label for="nickname" class="small-4 text-right">ニックネーム</label>
                        <div class="small-5">
                            <input type="text" id="nickname" name="nickname" class="input-group-field" maxlength="9" placeholder="2～9長さのニックネーム入力">
                            <p id="nicknameMsg" aria-live="assertive"></p>
                        </div>
                        <label for="pwd1" class="small-4 text-right">パスワード</label>
                        <div class="small-5">
                            <input type="password" id="pwd1" name="passwd" class="input-group-field" placeholder="8～16長さの英字の大小文字、数字及び記号">
                        </div>
                        <label for="pwd2" class="small-4 text-right">パスワード確認</label>
                        <div class="small-5">
                            <input type="password" id="pwd2" class="input-group-field">
                            <p id="pwdMsg" aria-live="assertive"></p>
                            <p id="pwdMsg2" aria-live="assertive"></p>
                        </div>
                        <label for="firstName" class="small-4 text-right">お名前</label>
                        <div>
                            <input type="text" id="firstName" name="firstName" class="input-group-field" maxlength="10" placeholder="姓（漢字）">
                            <p id="firstNameMsg" aria-live="assertive"></p>
                        </div>
                        <div>
                            <input type="text" id="lastName" name="lastName" style="margin-left: 9%" class="input-group-field" maxlength="10" placeholder="名（漢字）">
                            <p id="lastNameMsg" style="margin-left: 9%" aria-live="assertive"></p>
                        </div>
                        <label for="furiFirstName" class="small-4 text-right">フリガナ</label>
                        <div>
                            <input type="text" id="furiFirstName" name="furiFirst" class="input-group-field" maxlength="10" placeholder="セイ（カナ）">
                            <p id="furiFirstNameMsg" aria-live="assertive"></p>
                        </div>
                        <div>
                            <input type="text" id="furiLastName" name="furiLast" style="margin-left: 9%" class="input-group-field" maxlength="10" placeholder="メイ（カナ）">
                            <p id="furiLastNameMsg" style="margin-left: 9%" aria-live="assertive"></p>
                        </div>
                        <label for="gender" class="small-4 text-right">性別</label>
                        <div class="small-5">
                            <select id="gender" name="gender" class="input-group-field">
                                <option selected disabled hidden>お選びください。</option>
                                <option value="男性">男性</option>
                                <option value="女性">女性</option>
                            </select>
                            <p id="genderMsg" aria-live="assertive"></p>
                        </div>
                        <label for="birthYear" class="small-4 text-right">生年月日</label>
                        <div class="small-5">
                            <div class="grid-x">
                                <div class="small-3">
                                    <select id="birthYear" name="birthYear" class="input-group-field">
                                        <option selected disabled hidden>年</option>
                                        <c:forEach var="i" begin="1900" end="${sysYear}" step="1">
                                            <option value="${sysYear - i + 1900}">${sysYear - i + 1900}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="small-3">
                                    <select id="birthMonth" name="birthMonth" class="input-group-field">
                                        <option selected disabled hidden>月</option>
                                    </select>
                                </div>
                                <div class="small-3">
                                    <select id="birthday" name="birthday" class="input-group-field">
                                        <option selected disabled hidden>日</option>
                                    </select>
                                </div>
                            </div>
                            <div class="small-5">
                                <p id="birthMsg" aria-live="assertive"></p>
                            </div>
                        </div>
                        <label for="email" class="small-4 text-right">メールアドレス</label>
                        <div class="small-5">
                            <input type="text" id="email" name="email" class="input-group-field" placeholder="animeDB@animedb.com">
                            <p id="emailMsg" aria-live="assertive"></p>
                        </div>
                        <label for="addr1" class="small-4 text-right">郵便番号</label>
                        <div class="small-5">
                            <input type="text" id="addr1" name="addr1" class="input-group-field" maxlength="7" placeholder="７桁をハイフン（-）なしで入力" onkeypress="inNumber()" onkeyup="AjaxZip3.zip2addr(this, '', 'addr2', 'addr3')">
                        </div>
                        <label for="addr2" class="small-4 text-right">都道府県</label>
                        <div class="small-5">
                            <input type="text" id="addr2" name="addr2" class="input-group-field" readonly>
                        </div>
                        <label for="addr3" class="small-4 text-right">以降の住所</label>
                        <div class="small-5">
                            <input type="text" id="addr3" name="addr3" class="input-group-field">
                            <p id="addrMsg" aria-live="assertive"></p>
                        </div>
                        <label for="phone" class="small-4 text-right">携帯番号</label>
                        <div class="small-5">
                            <input type="text" id="phone" name="phone" class="input-group-field" placeholder="ハイフン（-）なしで入力" maxlength="12" onkeypress="inNumber()">
                            <p id="phoneMsg" aria-live="assertive"></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <button type="button" class="button alert" id="backBtn" onclick="history.go(-2)"><i class="fi-x"></i> 戻る</button>
                <button type="button" class="button primary" id="newJoinBtn"><i class="fi-check"></i> 会員登録</button>
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
                validetePwd();
            }
        }).off("click").on("click", function () {
            if ($(this).val() !== '') {
                validetePwd();
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
            isPwdNull();
        });

        $('#pwd2').off("focus").on("focus", function () {
            if ($(this).val() !== '') {
                checkPwdCorrect();
            }
        }).off("click").on("click", function () {
            if ($(this).val() !== '') {
                checkPwdCorrect();
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
            checkPwdCorrect();
        });
        $('#firstName').blur(function () {
            checkFirstName();
        });
        $('#lastName').blur(function () {
            checkLastName();
        });
        $('#furiFirstName').blur(function () {
            checkFuriFirst();
        });
        $('#furiLastName').blur(function () {
            checkFuriLast();
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
        $('#birthday').blur(function () {
            checkBirthday();
        })
        $('#email').blur(function () {
            checkEmail();
        });
        $('#addr1').off("focus").on("focus", function () {
            setAddrClear();
        }).off('keyup').on('keyup', function () {
            $(this).focus();
        }).blur(function () {
            checkAddr();
        })
        $('#addr3').blur(function () {
            checkAddr();
        })
        $('#phone').blur(function () {
            checkPhone();
        });
    })

    function checkId() {
        var uid = $('#uid')
        var msg = $('#idMsg');
        var regId = /^[a-z0-9][a-z0-9_]{6,16}$/g;

        if(uid.val() === "") {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regId.test(uid.val())) {
            showErrorMsg(msg, "正しくない形式のIDです。");
            return false;
        }

        $.ajax({
            type : "GET",
            url : "${contextPath}check_id",
            data : {"userId" : uid.val()},
            success : function (data) {
                if (data.result === 'pass') {
                    showSuccessMsg(msg, data.msg);
                } else {
                    showErrorMsg(msg, data.msg);
                    return false;
                }
            },
            error : function () {
                showErrorMsg(msg, "サーバーエラーが発生しました。")
                return false;
            }
        })
        return true;
    }

    function checkNickname(){
        var nickname = $('#nickname');
        var msg = $('#nicknameMsg');

        if (nickname.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }
        if (nickname.val().length <= 1 || nickname.val().length > 9) {
            showErrorMsg(msg, "正しくない形式のニックネームです。");
            return false;
        }

        hideMsg(msg);
        return true;
    }

    function isPwdNull() {
        var pwd = $('#pwd1');
        var msg = $('#pwdMsg');

        if (pwd.val() === '') {
            showErrorMsg(msg, "パスワードが入力されておりません。");
            return false;
        }

        if (checkPwdCorrect()) {
            checkPwdCorrect();
        } else if (validetePwd()) {
            hideMsg(msg);
        }
        return true;
    }

    function checkPwdCorrect() {
        var curPwd = $('#pwd1');
        var checkPwd = $('#pwd2');
        var msg = $('#pwdMsg');

        if (curPwd.val() === '') {
            showErrorMsg(msg, "パスワードが入力されておりません。");
            return false;
        }

        if (validetePwd() && checkPwd.val() === '') {
            showErrorMsg(msg, "パスワード確認欄が空欄です。");
            return false;
        }

        if (validetePwd() && curPwd.val() === checkPwd.val()) {
            showSuccessMsg(msg, "ご入力のパスワードが一致します。");
        } else if (validetePwd() && curPwd.val() !== checkPwd.val()){
            showErrorMsg(msg, "ご入力のパスワードを再度ご確認ください。");
            return false;
        }
        return true;
    }

    function checkFirstName() {
        var firstName = $('#firstName');
        var msg = $('#firstNameMsg');
        var regFirstName = /[\u3040-\u309f]$|[\u30a0-\u30ff]$|[\u4e00-\u9fff]$/g;

        if (firstName.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regFirstName.test(firstName.val())) {
            showErrorMsg(msg, "正しくない形式です。")
            return false;
        }

        hideMsg(msg);

        return true;
    }

    function checkLastName() {
        var lastName = $('#lastName');
        var msg = $('#lastNameMsg');
        var regLastName = /[\u3040-\u309f]$|[\u30a0-\u30ff]$|[\u4e00-\u9fff]$/g;

        if (lastName.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regLastName.test(lastName.val())) {
            showErrorMsg(msg, "正しくない形式です。")
            return false;
        }

        hideMsg(msg);

        return true;
    }

    function checkFuriFirst() {
        var furiFirst = $('#furiFirstName');
        var msg = $('#furiFirstNameMsg');
        var regFuriFirst = /[\u30a0-\u30ff]$/g;

        if (furiFirst.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regFuriFirst.test(furiFirst.val())) {
            showErrorMsg(msg, "正しくない形式です。")
            return false;
        }

        hideMsg(msg);

        return true;
    }

    function checkFuriLast() {
        var furiLast = $('#furiLastName');
        var msg = $('#furiLastNameMsg');
        var regFuriLast = /[\u30a0-\u30ff]$/g;

        if (furiLast.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regFuriLast.test(furiLast.val())) {
            showErrorMsg(msg, "正しくない形式です。")
            return false;
        }

        hideMsg(msg);

        return true;
    }

    function checkGender() {
        var gender = $('#gender');
        var msg = $('#genderMsg');

        if (gender.val() == null) {
            showErrorMsg(msg, "性別をお選びください。")
            return false;
        }

        hideMsg(msg);
        return true;
    }

    function selectedBirthYear() {
        var birthYear = $('#birthYear');
        var birthMonth = $('#birthMonth');
        var birthday = $('#birthday');

        if (birthYear.val() !== null) {
            birthMonth.html('<option selected disabled hidden>月</option>' +
                            '<c:forEach var="i" begin="1" end="12" step="1">' +
                            '<fmt:formatNumber value="${i}" var="month" pattern="00" />' +
                            '<option value="${month}">${month}</option>' +
                            '</c:forEach>')
        }

        if (birthday.val() !== null) {
            birthday.html('<option selected disabled hidden>日</option>');
        }
    }

    function selectedBirthMonth() {
        var birthYear = $('#birthYear');
        var birthMonth = $('#birthMonth');
        var birthday = $('#birthday');

        if (birthMonth.val() !== null) {
            if (birthMonth.val() === '02' && ((birthYear.val() % 4 === 0 && birthYear.val() % 100 !== 0) || birthYear.val() % 400 === 0)) {
                birthday.html('<option selected disabled hidden>日</option>' +
                    '<c:forEach var="i" begin="1" end="29" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
            else if (birthMonth.val() === '02' && !((birthYear.val() % 4 === 0 && birthYear.val() % 100 !== 0) || birthYear.val() % 400 === 0)) {
                birthday.html('<option selected disabled hidden>日</option>' +
                    '<c:forEach var="i" begin="1" end="28" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
            else if (birthMonth.val() < 8 && birthMonth.val() % 2 === 1 || birthMonth.val() >= 8 && birthMonth.val() % 2 === 0) {
                birthday.html('<option selected disabled hidden>日</option>' +
                    '<c:forEach var="i" begin="1" end="31" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
            else {
                birthday.html('<option selected disabled hidden>日</option>' +
                    '<c:forEach var="i" begin="1" end="30" step="1">' +
                    '<fmt:formatNumber value="${i}" var="day" pattern="00" />' +
                    '<option value="${day}">${day}</option>' +
                    '</c:forEach>' +
                    '</option>')
            }
        }

    }

    function checkBirthday() {
        var birthYear = $('#birthYear');
        var birthMonth = $('#birthMonth');
        var birthday = $('#birthday');
        var msg = $('#birthMsg');

        if (birthYear.val() === null || birthMonth.val() === null || birthday.val() === null) {
            showErrorMsg(msg, "生年月日が入力されておりません。")
            return false;
        }

        hideMsg(msg);
        return true;
    }

    function checkEmail() {
        var email = $('#email');
        var msg = $('#emailMsg');
        var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

        if (email.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regEmail.test(email.val())) {
            showErrorMsg(msg, "正しくないメールアドレス形式です。");
            return false;
        }

        $.ajax({
            type : "GET",
            data : {"email" : email.val()},
            url : "${contextPath}check_email",
            success : function (data) {
                if (data.result !== 'pass') {
                    showErrorMsg(msg, data.msg);
                    return false;
                }
            },
            error : function () {
                showErrorMsg(msg, "サーバーエラーが発生しました。")
                return false;
            }
        })

        hideMsg(msg);
        return true;
    }

    function checkAddr() {
        var addr1 = $('#addr1');
        var addr2 = $('#addr2');
        var addr3 = $('#addr3');
        var msg = $('#addrMsg');

        if (addr1.val() === '' && addr2.val() === '' && addr3.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (addr2.val() === '' || addr1.val().length < 7) {
            showErrorMsg(msg, "正しくない郵便番号です。");
            return false;
        }

        if (addr3.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        hideMsg(msg);
        return true;
    }

    function setAddrClear() {
        var addr1 = $('#addr1');
        var addr2 = $('#addr2');
        var addr3 = $('#addr3');

        if (addr1.val() === '' && (addr2.val() !== '' || addr3.val() !== '')) {
            addr2.val('');
            addr3.val('');
        }
    }

    function checkPhone() {
        var phone = $('#phone');
        var msg = $('#phoneMsg');
        var regPhone = /^[0-9]{9,12}$/g

        if (phone.val() === '') {
            showErrorMsg(msg, "入力されておりません。");
            return false;
        }

        if (!regPhone.test(phone.val())) {
            showErrorMsg(msg, "正しくない携帯番号形式です。");
            return false;
        }

        hideMsg(msg);
        return true;
    }

    function validetePwd() {
        var o = {
            length : [8,16],
            lower : 1,
            upper : 1,
            alpha : 1,
            numeric : 1,
            special : 1,
            custom : [],
            badWords : [],
            badSequenceLength : 5,
            noQwertySequences : true,
            spaceChk : true,
            noSequential : false
        };
        var pwd = $('#pwd1');
        var msg = $('#pwdMsg');

        if (o.spaceChk && /\s/g.test(pwd.val())) {
            showErrorMsg(msg, "8～16長さの英字の大小文字、数字及び記号をご入力ください。");
            return false;
        }

        if (pwd.val().length < o.length[0]) {
            showErrorMsg(msg, "パスワードを " + o.length[0] + "長さ以上ご入力ください。");
            return false;
        }

        if (pwd.val().length > o.length[1]) {
            showErrorMsg(msg, "パスワードは " + o.length[1] + "長さ以内に入力すべきです。");
            return false;
        }

        if (o.badSequenceLength && pwd.val().length >= o.length[0]) {
            var lower = "abcdefghijklmnopqrstuvwxyz";
            var upper = lower.toUpperCase();
            var numbers = "0123456789";
            var qwerty = "qwertyuiopasdfghjklzxcvbnm";
            var start = o.badSequenceLength - 1;
            var seq = "_" + pwd.val().slice(0, start);

            for (var i = start; i < pwd.val().length; i++) {
                seq = seq.slice(1) + pwd.val().charAt(i);
                if (
                    lower.indexOf(seq) > -1 ||
                    upper.indexOf(seq) > -1 ||
                    numbers.indexOf(seq) > -1 ||
                    (o.noQwertySequences && qwerty.indexOf(seq) > 1)
                ) {
                    pwdSafetyLow(msg);
                    return false;
                }
            }
        }

        var re = {
            lower : /[a-z]/g,
            upper : /[A-Z]/g,
            alpha : /[A-Z]/gi,
            numeric : /[0-9]/g,
            special : /[\W_]/g
        };

        var lower = (pwd.val().match(re['lower']) || []).length > 0 ? 1 : 0;
        var upper = (pwd.val().match(re['upper']) || []).length > 0 ? 1 : 0;
        var numeric = (pwd.val().match(re['numeric']) || []).length > 0 ? 1 : 0;
        var special = (pwd.val().match(re['special']) || []).length > 0 ? 1 : 0;

        if ((pwd.val().match(re['numeric']) || []).length === pwd.val().length) {
            showErrorMsg(msg, "8～16長さの英字の大小文字、数字及び記号をご入力ください。");
            return false;
        }

        if (lower + upper + numeric + special <= 2) {
            pwdSafetyLow(msg);
            return false;
        }

        if (lower + upper + numeric + special <= 3) {
            pwdSafetyMedium(msg);
            return true;
        }else if (lower + upper + numeric + special <= 4) {
            pwdSafetyHigh(msg);
            return true;
        }

    }

    function pwdSafetyLow(obj) {
        var html = "<span style='color: black'>パスワード強度 </span><span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>弱い</span> "
            + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
            + "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
            + "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
            + "<br>"
            + "<span style='color: red'>より強固なパスワードをご入力ください。</span>"
        obj.html(html);
    }

    function pwdSafetyMedium(obj) {
        var html = "<span style='color: black'>パスワード強度 </span><span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>強固</span>"
            + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
            + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
            + "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
            + "<br>"
            + "<span style='color: green'>強固なパスワードです。</span>"
        obj.html(html);
    }

    function pwdSafetyHigh(obj) {
        var html = "<span style='color: black'>パスワード強度 </span><span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>完璧</span>"
            + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
            + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
            + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
            + "<br>"
            + "<span style='color: green'>予測できないパスワードでもっと強固です。</span>"
        obj.html(html);
    }

    $(function () {
        $.fn.autoKana('#firstName', '#furiFirstName', {katakana: true})
        $.fn.autoKana('#lastName', '#furiLastName', {katakana: true})
    })

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
            showErrorMsg(Msg,"Caps Lockがオンになっております。");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(Msg,"CCaps Lockがオンになっております。");
        } else {
            hideMsg(Msg);
        }
    }

    function showErrorMsg(obj, msg) {
        obj.css('color', 'red');
        obj.html(msg);
        obj.show();
    }

    function showSuccessMsg(obj, msg) {
        obj.css('color', 'green');
        obj.html(msg);
        obj.show();
    }

    function hideMsg(obj) {
        obj.html('');
    }

    function checkAll() {
        if (
            checkId() &
            checkNickname() &
            validetePwd() &
            isPwdNull() &
            checkPwdCorrect() &
            checkFirstName() &
            checkLastName() &
            checkFuriFirst() &
            checkFuriLast() &
            checkGender() &
            checkBirthday() &
            checkEmail() &
            checkAddr() &
            checkPhone()
        ) {
            return true;
        } else {
            return false;
        }
    }

    $('#newJoinBtn').click(function () {

        if (checkAll()) {
            $('#newJoinBtn').prop("disabled", true).html('<img src="${contextPath}/assets/images/img/ajax_loader.gif">');
            $('#backBtn').prop("disabled", true);
            joinFrm.submit();
        }
    })
</script>

<%@include file="../inc/footer.jsp"%>
</body>