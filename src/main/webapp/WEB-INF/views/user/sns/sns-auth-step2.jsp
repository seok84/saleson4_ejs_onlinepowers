<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
<div class="user-page sns-auth-page step2">
    <h1 class="title-h1">회원가입</h1>
    <p class="title-auth">SNS 인증</p>
    <form class="sns-auth-form">
        <div class="sns-auth-input">
            <div class="form-line">
                <input type="text" id="name" class="form-basic" placeholder="이름을 입력하세요" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <input type="hidden" id="requestToken"/>
            <div class="form-line">
                <div class="flex">
                    <input type="text" id="phoneNumber" class="form-basic" placeholder="휴대폰 번호를 입력하세요" />
                    <button  id="send_auth_number" class="btn btn-black">인증요청</button>
                    <!-- 인증요청 클릭 후 카운트 될 때-> 재전송으로 변경 -->
                    <!-- <button class="btn btn-black">재전송</button> -->
                </div>
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <div class="form-line">
                <div class="flex">
                    <span class="time-limit"></span>
                    <input type="text" id="authNumber" class="form-basic" placeholder="인증번호를 입력하세요" />
                    <button id="check_auth_number" class="btn btn-black">인증 확인</button>
                </div>
                <!-- <span class="feedback invalid">유효성 메시지</span> -->
            </div>
        </div>
        <div class="btn-wrap gap">
            <button type="button" class="btn btn-default btn-cancel"  onclick="window.history.back()">취소</button>
            <button type="submit" id="next" class="btn btn-primary btn-next">다음</button>
        </div>
    </form>
</div>
    <page:javascript>
        <script src="/static/content/modules/ui/auth/auth.js"></script>
        <script>

            $(() => {

                $saleson.store.session.set("snsUser", decodeURIComponent($saleson.store.cookie.get("snsUser")));
                $saleson.store.cookie.set("snsUser", "",{'expires': -1});

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
                    if(!authChecked) {
                        $saleson.core.alert("인증을 완료하여 주십시오");
                        return false;
                    }
                    $saleson.store.session.set("phoneNumber", $('#phoneNumber').val());
                    $saleson.core.redirect("/user/sns/sns-join");
                    return false;
                });
            });

        </script>


    </page:javascript>



</layout:default>