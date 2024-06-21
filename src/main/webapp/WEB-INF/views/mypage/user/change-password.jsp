<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>


<layout:mypage>

    <section class="mypage-password">
        <div class="title-container">
            <h2 class="title-h2">비밀번호 변경</h2>
        </div>
        <form id="change-password-form">
            <div class="user-page find-idpw">
                <h3 class="form-title">현재 비밀번호</h3>
                <div class="form-line">
                    <input type="password" id="originalPassword" class="form-basic required" title="사용중인 비밀번호" placeholder="사용중인 비밀번호" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <h3 class="form-title">변경할 비밀번호</h3>
                <div class="form-line">
                    <input type="password" id="password" class="form-basic required" title="변경할 비밀번호" placeholder="변경할 비밀번호" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <h3 class="form-title">변경할 비밀번호 재입력</h3>
                <div class="form-line">
                    <input type="password" id="confirmPassword" class="form-basic required" title="변경할 비밀번호 재입력" placeholder="변경할 비밀번호 재입력" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
            </div>
            <div class="link-wrap">
                <button type="submit" class="btn btn-primary confirm-btn">확인</button>
            </div>
        </form>
    </section>

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
</layout:mypage>
