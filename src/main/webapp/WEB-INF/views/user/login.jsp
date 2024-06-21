<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<!-- Kakao SDK -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.min.js"></script>
<!-- Apple SDK -->
<script src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>
<layout:default>

    <div class="user-page">
        <!-- // 로그인 -->
        <h1 class="title-h1">로그인</h1>
        <form id="login-form">
            <div class="form-line mb-10 m-mb-6">
                <input type="text" id="loginId" class="form-basic required" placeholder="아이디"
                       title="아이디"/>
                <span class="feedback invalid" style="display: none;">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="password" id="password" class="form-basic required" placeholder="비밀번호"
                       title="비밀번호"/>
                <span class="feedback invalid" style="display: none;">유효성 메시지</span>
            </div>
            <div class="user-check-area">
                <div class="check-wrap no-margin">
                    <label class="input-checkbox"><input id="saveId" type="checkbox"><i></i>아이디
                        저장</label>
                </div>
                <div class="find-idpw-area">
                    <a href="/user/find-id">아이디 찾기</a>
                    <span class="divider"></span>
                    <a href="/user/find-pw">비밀번호 찾기</a>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-login">로그인</button>
        </form>
            <div class="sns-join-container">
                <h2>SNS 계정으로 간편 로그인</h2>
                <div class="sns-wrap">
                    <a href="javascript:void(0);" onclick="loginWithSns('kakao', 'login', '${target}');"><span class="circle"><img src="/static/content/image/common/sns_kakao.svg"
                                                         alt="카카오톡"></span><span
                            class="sns-type">카카오톡</span></a>
                    <a href="javascript:void(0);" onclick="loginWithSns('naver', 'login', '${target}');"><span class="circle"><img src="/static/content/image/common/sns_naver.svg"
                                                         alt="네이버"></span><span
                            class="sns-type">네이버</span></a>
                    <a href="javascript:void(0);" onclick="loginWithSns('apple', 'login', '${target}');"><span class="circle"><img src="/static/content/image/common/sns_apple.svg"
                                                         alt="애플"></span><span
                            class="sns-type">애플</span></a>
                </div>
                <p class="get-joined">회원이 아니신가요?<a href="/user/certify-join">회원가입</a></p>
            </div>


        <!-- // 비회원 주문조회 -->

        <div class="non-member">
            <button type="button" id="non-member" class="btn btn-default non-member-inquiry">
                비회원 주문조회<span class="toggle-arr"></span>
            </button>
            <div class="non-member-content">
                <p class="user-page-info">주문시 인증한 휴대폰번호로 인증을 통해<br/>확인하실 수 있습니다.</p>
                <form id="guest-form">
                    <input type="hidden" id="requestToken"/>
                    <div class="form-line mb-10">
                        <input type="text" id="name" class="form-basic required"
                               placeholder="이름을 입력하세요" title="이름"/>
                        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                    </div>
                    <div class="form-line mb-10">
                        <div class="flex">
                            <input type="text" id="phoneNumber" class="form-basic required"
                                   placeholder="휴대폰 번호를 입력하세요" title="휴대폰 번호"/>
                            <button type="button" id="send_auth_number" class="btn btn-black">인증요청</button><!-- 인증요청 -> 재전송 -->
                        </div>
                        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                    </div>
                    <div class="form-line mb-10">
                        <div class="flex">
                            <span class="time-limit"></span>
                            <input id="authNumber" type="text" class="form-basic required" placeholder="인증번호를 입력하세요" title="인증 번호"/>
                            <button id="check_auth_number" class="btn btn-black">인증 확인</button>
                        </div>
                    </div>

                    <button type="submit" id="confirmGuestLogin"
                            class="btn btn-black2 user-number-inquiry">조회하기
                    </button>
                </form>
            </div>
        </div>

        <!-- // 모달 -->
    </div>

    <div id="temp">

    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/user/sns.js"></script>
        <script src="/static/content/modules/ui/auth/auth.js"></script>
        <script type="application/javascript">

            const deviceType = "${salesonContext.deviceType}";
            let redirectTarget = '${target}';

            $(() => {
                salesOnUI.toggleActive('.non-member-inquiry');
                salesOnUI.inputPasswordUI();
                if($saleson.store.cookie.get('userId')) {
                    $('#loginId').val(decodeURIComponent($saleson.store.cookie.get('userId')))
                    $("#saveId").prop("checked", true);
                }
                $('#send_auth_number').click(function() {
                    SmsAuthHandler.sendAuthNumber($('#name').val(), $('#phoneNumber').val(),$('#check_auth_number'),$('.time-limit'), (token) => {
                        $('#requestToken').val(token);
                    })
                    console.log($('#requestToken').val());
                    return false;
                });

                $('#check_auth_number').click(function() {
                    SmsAuthHandler.checkAuthNumber($('#authNumber').val(),$('#requestToken').val(),$('.time-limit'), (successFlag) => {
                        if(successFlag) {
                            $('#check_auth_number').text('인증완료');
                        }
                        else {
                            $saleson.core.alert("인증에 실패하였습니다");
                        }
                    });
                    return false;
                });

                $('#login-form').validator(function() {
                    // if (!$.validator.validatePassword($('#loginId').val(),$('#password').val())) {
                    //     return false;
                    // }
                    loginAction();
                    return false;
                });

                $('#guest-form').validator(function() {
                    confirmGuestLogin();
                    return false;
                });

            });

            function loginAction() {
                if (redirectTarget == '') {
                    redirectTarget = '/'
                }

                $('#temp').empty();

                const param = {
                    loginType: 'ROLE_USER',
                    loginId: $('#loginId').val(),
                    password: $('#password').val()
                };
                $saleson.auth.login(param, (token) => {
                    const formData = {
                        target: redirectTarget,
                        token: token,
                        salesonId: $saleson.auth.salesonId()
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/auth/fetch',
                        data: formData,
                        success: function(response) {
                            const expires = new Date();
                            if($("#saveId").prop("checked")) {
                                expires.setDate(expires.getDate() + 10);
                                $saleson.store.cookie.set("userId", $('#loginId').val(), {'expires': expires});
                            } else {
                                expires.setDate(expires.getDate());
                                $saleson.store.cookie.set("userId", "", {'expires': expires})
                            }

                            try {
                                if (response.successFlag) {
                                    $saleson.analytics.setUserId(response.data);
                                }
                            } catch (e) {}


                            $saleson.core.redirect(redirectTarget);
                        },
                        error : function (response) {
                            $saleson.core.alert(response.error, function () {
                                location.reload();
                            });
                        }

                    });

                })
            }


            function confirmGuestLogin() {
                if(!authChecked) {
                    $saleson.core.alert("인증해주시기바랍니다.");
                    return false;
                }
                const request = {
                    authNumber :  $("#authNumber").val(),
                    phoneNumber : $("#phoneNumber").val(),
                    requestToken : $("#requestToken").val(),
                    userName : $("#name").val()
                }
                $saleson.auth.guestLogin(request, (token) => {

                    const formData = {
                        target: '/',
                        token: token,
                        salesonId: $saleson.auth.salesonId()
                    };
                    $.ajax({
                        type: 'POST',
                        url: '/auth/fetch',
                        data: formData,
                        success: function(response) {
                            if(response.successFlag) {
                               $saleson.core.redirect("/mypage/info/order");
                            } else {
                                $saleson.core.alert("로그인 오류가 발생하였습니다.")
                            }
                        },
                        error : function (response) {
                            $saleson.core.alert(response.error);

                        }

                    });

                })


            }


        </script>


    </page:javascript>


</layout:default>
