
let countdownTimer;
let authChecked = false;
let check = false;
let SmsAuthHandler = {};

SmsAuthHandler.sendAuthNumber = function (name, phoneNumber, selector, timeLimit,
    callback) {

    if (!$saleson.core.isFunction(callback)) {
        $saleson.core.alert('empty callback');
        return false;
    }
    if ($.validator.isEmpty(name)) {
        $saleson.core.alert("이름을 입력해주세요");
        return false;
    }
    if (!$.validator.patterns._phone_number.test(phoneNumber)) {
        $saleson.core.alert("휴대폰 번호를 입력해주세요");
        return false;
    }
    let request = {
        phoneNumber: phoneNumber,
        userName: name
    }
    clearInterval(countdownTimer);
    $saleson.api.post("/api/auth/send-auth-number", request)
    .then(function (response) {
        $saleson.core.alert("인증번호를 요청하였습니다");
        startCountdownTimer(selector, timeLimit);
        check = true;
        callback(response.data);
    })
    .catch(function (error) {
        $saleson.core.api.handleApiExeption(error);
    })

}

SmsAuthHandler.checkAuthNumber = function (authNumber, requestToken, timeLimit, callback) {

    if (!$saleson.core.isFunction(callback)) {
        $saleson.core.alert('empty callback');
        return false;
    }
    if(!check) {
        $saleson.core.alert("인증번호를 다시 요청해주세요");
        return  false;
    }
    if ($.validator.isEmpty(authNumber)) {
        $saleson.core.alert("인증번호를 입력해주세요");
        return false;
    }
    let request = {
        requestToken: requestToken,
        authNumber: authNumber
    }

    $saleson.api.post("/api/auth/check-auth-number", request)
    .then(function (response) {
        console.log(response, "response")
        if(response.status === 200) {
            $saleson.core.alert("인증되었습니다.");
            callback(true);
            authChecked = true;
            clearInterval(countdownTimer);
            timeLimit.text("");
        }

    })
    .catch(function (error) {
        $saleson.core.alert(error.response.data.message);
    })
}

function startCountdownTimer(selector, timeLimit) {
    let timer = 60;
    if(selector.text("인증만료")) {
        selector.text("인증 확인");
    }
    countdownTimer = setInterval(function () {
        timer--;
        timeLimit.text(timer + "초");
        if (timer <= 0) {
            clearInterval(countdownTimer);
            check = false;
            selector.text("인증만료");
        }
    }, 1000);
}



