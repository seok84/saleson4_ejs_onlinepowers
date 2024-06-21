<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
<div class="user-page find-idpw">
    <h1 class="title-h1">비밀번호 변경하기</h1>
    <form id="change-password-form">
    <h3 class="form-title">기존 비밀번호</h3>
    <div class="form-line">
        <input type="password" id="originalPassword" class="form-basic required" title="기존 비밀번호" placeholder="기존 비밀번호" />
        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
    </div>
    <h3 class="form-title">새 비밀번호</h3>
    <div class="form-line">
        <input type="password" id="password" class="form-basic required" title="새 비밀번호" placeholder="8~16자 이내 영문, 숫자, 특수문자" />
        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
    </div>
    <h3 class="form-title">새 비밀번호 재입력</h3>
    <div class="form-line">
        <input type="password" id="confirmPassword" class="form-basic required" title="비밀번호 재입력" placeholder="비밀번호를 다시 한번 입력하세요" />
        <span class="feedback invalid" style="display: none;">유효성 메시지</span>
    </div>
    <div class="link-wrap">
        <button type="submit" class="btn btn-primary confirm-btn">저장</button>
    </div>
    </form>
</div>

<page:javascript>
    <script>
        $(() => {
            salesOnUI.inputPasswordUI();
            $('#change-password-form').validator(function() {
                $saleson.core.confirm("변경 하시겠습니까?", function () {
                    changePassword();
                })

                return false;
            });

        });

        function changePassword() {

            let request = {
                originalPassword : $("#originalPassword").val(),
                password : $("#password").val(),
                confirmPassword : $("#confirmPassword").val(),
            }

            $saleson.api.post('/api/auth/change-password', request)
            .then(function (response) {
                $saleson.core.alert("변경 되었습니다", function () {
                    $saleson.core.redirect('/user/login');
                })

            })
            .catch(function(error) {
                $saleson.core.api.handleApiExeption(error);
            });

        }
    </script>

</page:javascript>

</layout:default>