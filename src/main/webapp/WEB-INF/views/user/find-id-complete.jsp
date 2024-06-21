<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<layout:default>

<div class="user-page find-idpw">
    <h1 class="title-h1">아이디 찾기</h1>
    <img src="/static/content/image/common/img_find_id.png" alt="아이디 찾기" class="find-img find-img-id ">
    <p class="sub-title">입력하신 회원 정보로 검색된 아이디입니다.</p>
    <div class="box">
        <p>
            <strong id="userName"></strong> 회원님의 아이디는<br>
            <strong id="userId"> </strong>입니다.
        </p>
    </div>
    <ui class="dot-list">
        <li>전체 아이디 받기시, <em>등록된 회원정보의 휴대전화번호로 메시지</em>가 발송됩니다.</li>
    </ui>
    <div class="btn-wrap gap link-wrap">
        <a href="/user/find-pw" class="btn btn-primary link-item">비밀번호 찾기</a>
        <button type="button" id="send_login_id" class="btn btn-default link-item"> 전체 아이디 받기</button>
    </div>
</div>



    <page:javascript>
        <script>
            $(() => {
               const loginId = $saleson.store.session.get("loginId");
               const loginIdNoMask = $saleson.store.session.get("loginIdNoMask");
               const name = $saleson.store.session.get("userName");
               const phoneNumber = $saleson.store.session.get("phoneNumber");
                $('#userName').text(name);
                $('#userId').text(loginId);
                $('#send_login_id').click(function() {
                    sendLoginId();
                    return false;
                });


                function sendLoginId() {
                    const param = {
                        loginId : loginIdNoMask,
                        userName : name,
                        phoneNumber : phoneNumber
                    }

                    $saleson.api.post("/api/auth/send-login-id", param)
                    .then(function (response) {
                            $saleson.core.alert("메시지를 발송하였습니다.", function () {
                                $saleson.core.redirect('/user/login');
                            })
                    })
                    .catch(function(error) {
                        $saleson.core.api.handleApiExeption(error);
                    });

                }

            });

        </script>

    </page:javascript>

</layout:default>

