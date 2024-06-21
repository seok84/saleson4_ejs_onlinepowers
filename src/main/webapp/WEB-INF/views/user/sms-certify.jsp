<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<layout:default>

<div class="user-page">
    <!-- // 회원가입 -->
    <h1 class="title-h1">회원가입</h1>
        <form class="sns-auth-form">
            <p class="form-title">SMS인증</p>
            <div class="form-line mb-10">
                <input type="text" class="form-basic required" id="name" placeholder="이름을 입력하세요" />
                <span class="feedback invalid" style="display: none;">유효성 메시지</span>
            </div>
            <div class="form-line mb-10">
                <div class="flex">
                    <input type="text" class="form-basic required" id="phoneNumber" placeholder="휴대폰 번호를 입력하세요" />
                    <button type="button" id="send_auth_number" class="btn btn-black m-w-98">인증요청</button><!-- 인증요청 -> 재전송 -->
                    <!--<button type="button" class="btn btn-black m-w-98">재전송</button> 인증요청 -> 재전송 -->
                </div>
                <span class="feedback invalid" style="display: none;">유효성 메시지</span>
            </div>
            <input type="hidden" id="requestToken">
            <div class="form-line mb-10">
                <div class="flex">
                    <span class="time-limit"></span>
                    <input type="text" id="authNumber" class="form-basic required" placeholder="인증번호를 입력하세요" />
                    <button type="button" id="check_auth_number" class="btn btn-black m-w-98">인증 확인</button>
                </div>
                <span class="feedback invalid" style="display: none;">유효성 메시지</span>
            </div>
            <div class="link-wrap">
                <button class="btn btn-default w-half link-item" ><a href="/user/certify-join">취소</a></button>
                <button type="submit" id="next" class="btn btn-primary w-half link-item" >다음</button>
            </div>
        </form>
</div>

    <page:javascript>
        <script src="/static/content/modules/ui/auth/auth.js"></script>
        <script>
            $(() => {
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

                $('.sns-auth-form').validator(function() {
                        checkAccountJoin();
                       return false;
                });
            });
            function checkAccountJoin() {
                if(!authChecked) {
                    $saleson.core.alert("인증을 완료해주십시오");
                    return false;
                }
                let request = {
                    phoneNumber : $("#phoneNumber").val(),
                    userName : $("#name").val()
                }
                $saleson.api.post("/api/auth/check-account-join", request)
                .then(function (response) {
                    $saleson.store.session.set("userName", $('#name').val());
                    $saleson.store.session.set("phoneNumber", $('#phoneNumber').val());
                    $saleson.core.redirect("/user/join");
                })

                .catch(function(error) {
                    $saleson.core.alert(error.response.data.message);
                })






            }


        </script>

    </page:javascript>
</layout:default>