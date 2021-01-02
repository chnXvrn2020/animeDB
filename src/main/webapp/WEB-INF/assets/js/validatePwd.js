function validetePwd(pwd, obj) {
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

    if (o.spaceChk && /\s/g.test(pwd)) {
        showErrorMsg(obj, strings['pwd.notAllowed']);
        return false;
    }

    if (pwd.length < o.length[0]) {
        showErrorMsg(obj, strings['pwd.short']);
        return false;
    }

    if (pwd.length > o.length[1]) {
        showErrorMsg(obj, strings['pwd.long']);
        return false;
    }

    if (o.badSequenceLength && pwd.length >= o.length[0]) {
        var lower = "abcdefghijklmnopqrstuvwxyz";
        var upper = lower.toUpperCase();
        var numbers = "0123456789";
        var qwerty = "qwertyuiopasdfghjklzxcvbnm";
        var start = o.badSequenceLength - 1;
        var seq = "_" + pwd.slice(0, start);

        for (var i = start; i < pwd.length; i++) {
            seq = seq.slice(1) + pwd.charAt(i);
            if (
                lower.indexOf(seq) > -1 ||
                upper.indexOf(seq) > -1 ||
                numbers.indexOf(seq) > -1 ||
                (o.noQwertySequences && qwerty.indexOf(seq) > 1)
            ) {
                pwdSafetyLow(obj);
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

    var lower = (pwd.match(re['lower']) || []).length > 0 ? 1 : 0;
    var upper = (pwd.match(re['upper']) || []).length > 0 ? 1 : 0;
    var numeric = (pwd.match(re['numeric']) || []).length > 0 ? 1 : 0;
    var special = (pwd.match(re['special']) || []).length > 0 ? 1 : 0;

    if ((pwd.match(re['numeric']) || []).length === pwd.length) {
        showErrorMsg(obj, strings['pwd.notAllowed']);
        return false;
    }

    if (lower + upper + numeric + special <= 2) {
        pwdSafetyLow(obj);
        return false;
    }

    if (lower + upper + numeric + special <= 3) {
        pwdSafetyMedium(obj);
        return true;
    }else if (lower + upper + numeric + special <= 4) {
        pwdSafetyHigh(obj);
        return true;
    }

}

function pwdSafetyLow(obj) {
    var html = "<span style='color: black'>" + strings['pwd.safety'] + " </span><span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>" + strings['pwd.low'] + "</span>"
        + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
        + "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
        + "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
        + "<br>"
        + "<span style='color: red'>" + strings['pwd.weak'] + "</span>"
    obj.html(html);
}

function pwdSafetyMedium(obj) {
    var html = "<span style='color: black'>" + strings['pwd.safety'] + " </span><span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>" + strings['pwd.medium'] + "</span>"
        + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
        + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
        + "<span style='color:#E5E5E5; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
        + "<br>"
        + "<span style='color: green'>" + strings['pwd.strong'] + "</span>"
    obj.html(html);
}

function pwdSafetyHigh(obj) {
    var html = "<span style='color: black'>" + strings['pwd.safety'] + "  </span><span style='color:#E5E5E5'>|</span> <span style='color:#E3691E; font-weight:bold;'>" + strings['pwd.high'] + "</span>"
        + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;'>―</span>"
        + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
        + "<span style='color:#E3691E; font-weight:bold; font-size:20px; position: relative; top: 1.5px;''>―</span>"
        + "<br>"
        + "<span style='color: green'>" + strings['pwd.perfect'] + "</span>"
    obj.html(html);
}