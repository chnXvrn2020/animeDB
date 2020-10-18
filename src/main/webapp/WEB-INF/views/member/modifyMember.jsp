<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <%@include file="../inc/header.jsp"%>
</head>
<body>
<%@include file="../inc/gnb.jsp"%>
<c:set value="${sessionScope.member}" var="member" />
<c:if test="${empty member}">
<script>
    location.href = '${contextPath}/';
</script>
</c:if>
<div class="main-section">
    <div class="grid-container">
        <div class="modifyMember">
            <div class="grid-x grid-padding-y">
                <form class="small-8 cell">
                    <div class="memberImage">
                        <c:choose>
                            <c:when test="${member.attachment eq null}">
                                <img id="memberImg" src="${contextPath}/assets/images/img/profile_image.png">
                            </c:when>
                            <c:otherwise>
                                <img id="memberImg" src="${contextPath}/assets/images/img/profile_image.png">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="imageBtn">
                        <input type="file" id="inputImage">
                        <label for="inputImage" class="button alert">
                            <span>イメージ変更</span>
                        </label>
                        <input type="hidden" id="deleteImage" value="N">
                        <label for="deleteImage" id="delImgBtn" class="button secondary">
                            <span>イメージ削除</span>
                        </label>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">ID</span>
                        <span class="small-6">${member.userId}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">性別</span>
                        <span class="small-6">${member.gender}</span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">生年月日</span>
                        <span class="small-6"><fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd" /></span>
                    </div>
                    <div class="grid-x info">
                        <span class="small-3">メールアドレス</span>
                        <span class="small-6">${member.email}</span>
                    </div>
                    <div class="grid-x info">
                        <label for="nickname" class="small-3">ニックネーム</label>
                        <div class="small-6">
                            <input type="text" class="input-group-field" id="nickname" name="nickname" value="${member.nickname}" maxlength="9" placeholder="2～9長さのニックネーム入力">
                            <p id="nicknameMsg" aria-live="assertive"></p>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <label class="small-3" for="firstName">お名前</label>
                        <div class="small-6">
                            <div class="grid-x">
                                <div class="small-6">
                                    <input type="text" class="input-group-field" id="firstName" name="firstName" value="${member.firstName}" maxlength="10" placeholder="姓（漢字）">
                                    <p id="firstNameMsg" aria-live="assertive"></p>
                                </div>
                                <div class="small-6">
                                    <input type="text" class="input-group-field" id="lastName" name="lastName" value="${member.lastName}" maxlength="10" placeholder="名（漢字）">
                                    <p id="lastNameMsg" style="margin-left: 9%" aria-live="assertive"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <label for="furiFirstName" class="small-3">フリガナ</label>
                        <div class="small-6">
                            <div class="grid-x">
                                <div class="small-6">
                                    <input type="text" class="input-group-field" id="furiFirstName" name="furiFirst" value="${member.furiFirst}" maxlength="10" placeholder="セイ（カナ）">
                                    <p id="furiFirstNameMsg" aria-live="assertive"></p>
                                </div>
                                <div class="small-6">
                                    <input type="text" class="input-group-field" id="furiLastName" name="furiLast" value="${member.furiLast}" maxlength="10" placeholder="メイ（カナ）">
                                    <p id="furiLastNameMsg" style="margin-left: 9%" aria-live="assertive"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <label for="addr1" class="small-3">郵便番号</label>
                        <c:set value="${member.addr1}" var="addr1" />
                        <input type="text" id="addr1" name="addr1" value="${fn:replace(addr1, "-", "")}" class="small-6 input-group-field" maxlength="7" placeholder="７桁をハイフン（-）なしで入力" onkeypress="inNumber()" onkeyup="AjaxZip3.zip2addr(this, '', 'addr2', 'addr3')">
                    </div>
                    <div class="grid-x">
                        <label for="addr2" class="small-3">都道府県</label>
                        <input type="text" id="addr2" name="addr2" value="${member.addr2}" class="input-group-field small-6" readonly>
                    </div>
                    <div class="grid-x">
                        <label for="addr3" class="small-3">都道府県</label>
                        <div class="small-6">
                            <input type="text" id="addr3" name="addr3" value="${member.addr3}" class="input-group-field">
                            <p id="addrMsg" aria-live="assertive"></p>
                        </div>
                    </div>
                    <div class="grid-x info">
                        <label for="phone" class="small-3">携帯番号</label>
                        <div class="small-6">
                            <c:set value="${member.phone}" var="phone" />
                            <input type="text" id="phone" name="phone" value="${fn:replace(phone, "-", "")}" class="input-group-field" maxlength="12" placeholder="ハイフン（-）なしで入力" onkeypress="inNumber()">
                            <p id="phoneMsg" aria-live="assertive"></p>
                        </div>
                    </div>
                    <input type="hidden" name="_csrf" value="${sessionScope.CSRF_TOKEN}">
                </form>
            </div>
        </div>
        <div class="modifyBtn">
            <button type="button" class="button primary">変更</button>
            <button type="button" class="button alert">戻る</button>
        </div>
    </div>
</div>

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
        $('#furiFirstName').blur(function () {
            checkFuriFirst();
        });
        $('#furiLastName').blur(function () {
            checkFuriLast();
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
        $('#delImgBtn').click(function () {
            $('#memberImg').attr("src", "${contextPath}/assets/images/img/profile_image.png");
            $('#deleteImage').val('Y');
        })
    });


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

    function showErrorMsg(obj, msg) {
        obj.css('color', 'red');
        obj.html(msg);
        obj.show();
    }

    function hideMsg(obj) {
        obj.html('');
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

    function handleImgFileSelect(e) {
        var files = e.target.files;
        var fileArr = Array.prototype.slice.call(files);

        fileArr.forEach(function (f) {
            if (!f.type.match("image.*")) {
                alert("イメージ拡張子のファイルのみ選択できます。");
                return;
            }

            var reader = new FileReader();
            reader.onload = function (e) {
                $('#memberImg').attr("src", e.target.result);
                $('#deleteImage').val('N');
            }
            reader.readAsDataURL(f);
        })
    }

</script>

<%@include file="../inc/footer.jsp"%>
</body>