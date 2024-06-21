const naverLoginAppId = SOCIAL_CONFIG.naver.appId;
const naverClientSecret = SOCIAL_CONFIG.naver.clientSecret;
const naverLoginCallBack = SOCIAL_CONFIG.naver.callBack;
const kakaoLoginAppId = SOCIAL_CONFIG.kakao.appId;
const kakaoCallBackUrl = SOCIAL_CONFIG.kakao.callBack;
const kakaoRestApiKey = SOCIAL_CONFIG.kakao.restApiKey;
const frontendDomain = window.location.origin;
const appleClientId = "";
const appleRedirectUrl = "";

/**
 * sns 로그인 분기
 */
function loginWithSns(snsType, state, target) {
    if (snsType === "naver") {
        loginWithNaver(state, target);
    } else if (snsType === "kakao") {
        loginWithKakao(state, target);
    } else if (snsType === "apple") {
        $saleson.core.alert("애플 로그인 준비중");
        // loginWithApple(state, target);
    }
}

/**
 * 네이버 로그인 요청
 */
function loginWithNaver(state, target) {
    let uri = 'https://nid.naver.com/oauth2.0/authorize?' +
        'response_type=code' +
        '&client_id=' + naverLoginAppId +
        '&redirect_uri=' + frontendDomain + naverLoginCallBack +
        '&state=' + state + "_" + target;
    console.log(uri, "네이버 로그인 uri");
    // 사용자가 사용하기 편하게끔 팝업창으로 띄어준다.
    if (deviceType === 'MOBILE') {
        $saleson.core.redirect(uri);

    } else {
        console.log(uri, 'uri');
        window.open(uri, "Naver Login PopupScreen", "width=450, height=600");
    }

}
/**
 * 카카오 로그인 요청
 */
function loginWithKakao(state, target) {
    //모바일 분기 작성해야함 모바일은 콜백으로
    if (!Kakao.isInitialized()) {
        Kakao.init(kakaoLoginAppId);
    }
    if (!(deviceType === 'MOBILE')) {
        // 로그인 창을 띄웁니다.
        Kakao.Auth.login({
            success: function (authObj) {
                Kakao.API.request({
                    url: '/v2/user/me',
                    success: function (response) {
                        // 카톡 닉네임 이모티콘 제거 정규식
                        var patterns = "[\\uD83C-\\uDBFF\\uDC00-\\uDFFF]+";
                        var nickName = response?.properties?.nickname;
                        if (nickName) {
                            nickName = nickName.replace(new RegExp(patterns),
                                '');
                            response.properties.nickname = nickName;
                        }
                        // 카카오에서 던지는 response.id값은 정수형
                        // 스크립트에서 id가 문자형으로 파싱되면서 hash값이 변경되므로 뒤에 ''를 붙여 hash값 변조를 막는다.
                        let snsUser = {
                            "email": response?.kakao_account?.email ?? '',
                            "snsId": response.id + '',
                            "snsName": response?.properties?.nickname ?? '',
                            "snsType": "kakao",
                            "state": state + "_" + target,
                            "token": ''
                        };

                        if (state == 'login' || state == 'join') {
                            snsLogin(snsUser);
                        } else if (state == 'connect') {
                            snsConnect(snsUser);
                        }
                    },
                    fail: function (error) {
                        console.log(error, "로그인 요청 실패");
                        console.log(JSON.stringify(error));
                    }
                });
            },
            fail: function (err) {
                console.log(err, "로그인 요청 실패");
                $saleson.core.alert(JSON.stringify(err));
            }
        });
    } else {
        console.log("mobile: " + frontendDomain + kakaoCallBackUrl);
        Kakao.Auth.authorize({
            redirectUri: frontendDomain + kakaoCallBackUrl,
            state: state + "_" + target
        });

    }
}
/**
 * apple 로그인 요청
 */
function loginWithApple(state, target) {
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    AppleID.auth.init({
        clientId: appleClientId,
        scope: 'name email',
        redirectURI: appleRedirectUrl, // return urls 등록 필요(Resister Website URLs) : localhost는 허용되지 않음
        usePopup: true, //or false defaults to false
        state: state + "_" + target
    });
    //Listen for authorization success
    document.addEventListener('AppleIDSignInOnSuccess', (data) => {
        var snsUser = {
            "snsType": "apple",
            "token": data.detail.authorization.id_token
        };

        snsLogin(snsUser);
    });
    //Listen for authorization failures
    document.addEventListener('AppleIDSignInOnFailure', (error) => {
        //handle error.
        $saleson.core.alert(JSON.stringify(error));
    });
}
/**
 * sns 로그인 요청 콜백 후 로그인
 */
function snsLogin(snsUser) {
    let target = snsUser.state.split("_")[1];
    if (target == '') {
        target = '/'
    }
    let hmacMessage = JSON.stringify(snsUser);
    let hashInBase64 = $saleson.auth.getHashInBase64(hmacMessage);
    let url = "/api/auth/sns-login";
    $saleson.axios.post(url, snsUser, {
        headers: {
            Hmac: hashInBase64
        }
    })
    .then(function (response) {
        if (response.data.value == "loginSuccess") {
            const formData = {
                target: target,
                token: response.data.token,
                salesonId: $saleson.auth.salesonId()
            };
            $.ajax({
                type: 'POST',
                url: '/auth/fetch',
                data: formData,
                success: function (response) {
                    if (response.successFlag) {

                        try {
                            $saleson.analytics.setUserId(response.data);
                        } catch (e) {}

                        if (snsUser.snsType == 'naver') {
                            if (deviceType === "MOBILE") {
                                $saleson.core.redirect(target);
                            } else {
                                opener.parent.location = target;
                                window.close();
                            }
                        } else {
                            $saleson.core.redirect(target);
                        }
                    } else {
                        $saleson.core.alert("로그인 오류가 발생하였습니다.")
                    }
                },
                error: function (response) {
                    $saleson.core.alert(response.error);
                }
            });
        } else if (response.data.value == "redirectToJoin") {
            $saleson.core.alert(response.data.message, function () {
                $saleson.store.cookie.set("snsUser", hmacMessage);
                if (snsUser.snsType == 'naver') {
                    if (deviceType === "MOBILE") {
                        $saleson.core.redirect('/user/sns/sns-auth-step2');
                    } else {
                        opener.parent.location = '/user/sns/sns-auth-step2';
                        window.close();
                    }
                }
                $saleson.core.redirect('/user/sns/sns-auth-step2');
            });

        } else if (response.data.value == "notJoinedUser") {
            $saleson.core.alert(response.data.message, function () {
                if (snsUser.snsType == 'naver') {
                    if (deviceType === "MOBILE") {
                        $saleson.core.redirect('/user/certify-join');
                    } else {
                        opener.parent.location = '/user/certify-join';
                        window.close();
                    }
                }
                $saleson.core.redirect('/user/certify-join');

            });

        } else if (response.data.value == "alreadyJoin") {
            $saleson.core.alert(response.data.message, function () {
                if (snsUser.snsType == 'naver') {
                    if (deviceType === "MOBILE") {
                        $saleson.core.redirect('/user/login');
                    } else {
                        opener.parent.location = '/user/login';
                        window.close();
                    }
                }
                $saleson.core.redirect('/user/login');
            });

        } else {
            $saleson.core.alert(response, function () {
            });
        }
    }, function (error) {
        let data = error.response.data;
        console.log(error);
        $saleson.core.alert(error, function () {
            $saleson.core.redirect('/');
        });
    });

}
/**
 * SNS 연동 분기, 연동 해제
 */
function connectSns(snsType, state, snsUserId) {
    if (snsUserId != undefined && snsUserId > 0) {
        $saleson.core.confirm("선택하신 SNS의 연결해제를 진행하시겠습니까?", function () {
            var snsUser = {
                "snsUserId": snsUserId,
                "snsType": snsType,
                "token": ''
            };
            $saleson.api.post("/api/auth/disconnect-sns", snsUser)
            .then(function (response) {
                    console.log(response);
                    if (response.data.value === "disconnectSuccess") {
                        $saleson.core.alert(response.data.message, function () {
                            location.replace('/auth/logout?redirect='+'/');
                        });
                    } else {
                        console.log("error occurred - " + response.data.message);
                    }
                }, function (error) {
                    console.dir(error, 'error');
                    $saleson.core.alert(error);
                }
            )
            .catch(function (error) {
                $saleson.core.api.handleApiExeption(error);
            })
        });
    } else {
        const target = '/mypage/user/connect-sns';
        if (snsType === "naver") {
            loginWithNaver(state, target);
        } else if (snsType === "kakao") {
            loginWithKakao(state, target);
        } else if (snsType === "apple") {
            $saleson.core.alert("애플 로그인 준비중", function () {
                location.reload()
            });

            // loginWithApple(state, target);
        }
    }
}
/**
 * SNS 연동
 */
function snsConnect(snsUser) {
    $saleson.api.post("/api/auth/sns-connect", snsUser)
    .then(function (response) {
        let info = response.data;
        if (info.value == "connectSuccess" || info.value == "connectAlready") {
            $saleson.core.alert(info.message, function () {
                if (snsUser.snsType == 'naver') {
                    if (deviceType !== "MOBILE") {
                        opener.location.reload();
                        window.close();
                    } else {
                        $saleson.core.redirect("/mypage/user/connect-sns");
                    }
                } else if (snsUser.snsType == 'kakao') {
                    if (deviceType !== "MOBILE") {
                        location.reload();
                    } else {
                        $saleson.core.redirect("/mypage/user/connect-sns");
                    }
                } else if (snsUser.snsType == 'apple') {
                    if (deviceType !== "MOBILE") {
                        location.reload();
                    } else {
                        $saleson.core.redirect("/mypage/user/connect-sns");
                    }
                }
            });
        }
    })
}