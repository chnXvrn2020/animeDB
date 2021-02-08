// Check blank
function formInput(tag, obj, msg) {
    if (trim.val !== '') return false;
    showErrorMsg(obj, msg);
    return true;
}

// Check select
function formSelect(tag, obj, msg) {
    if (tag != null) return false;
    showErrorMsg(obj, msg);
    return true;
}

// Check ID
function formId(tag, obj, msg) {
    var pattern = /^[a-z0-9][a-z0-9_]{6,16}$/g;
    if (pattern.test(tag)) return false;
    else showErrorMsg(obj, msg);
    return true;
}

// Check nickname
function formNickname(tag, obj, msg) {
    if (!(tag.length <= 1 || tag.length > 9 || $.trim(tag) !== tag)) return false;
    else showErrorMsg(obj, msg);
    return true;
}

// Check password is matched
function formPwdMatched(p, c, obj) {
    if (p === c) {showSuccessMsg(obj, strings['pwd.matched']); return false;}
    else {showErrorMsg(obj, strings['pwd.unmatched']); return true;}
}

// Check birthday
function formBirthday(year, month, day, obj, msg) {
    if (!(year === null || month === null || day === null)) return false;
    showErrorMsg(obj, msg);
    return true;
}

// Check Email
function formEmail(tag, obj, msg) {
    var pattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (pattern.test(tag)) return false;
    else showErrorMsg(obj, msg);
    return true;
}

// Check phone number
function formPhoneNumber(tag, obj, msg) {
    var pattern = /^[0-9]{9,12}$/g
    if (pattern.test(tag)) return false;
    else showErrorMsg(obj, msg);
    return true;
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

