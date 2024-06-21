<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
<div class="user-page find-idpw">
    <h1 class="title-h1">90일 경과 비밀번호 변경하기</h1>
    <p class="user-page-info">
        개인정보 보호를 위해, 비밀번호 변경 후<br />
        90일이 지난 후에는 비밀번호 재설정을 권장합니다.<br />
        <em>[연장하기]</em> 버튼을 누르시면 기존 비밀번호로 유지됩니다
    </p>
    <form id="expired-password">
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
    <div class="link-wrap btn-wrap gap">
        <button type="button" id="delayPassword" class="btn btn-default link-item">연장</button>
        <button type="submit" id="changePassword" class="btn btn-primary link-item">변경</button>
    </div>
    </form>

</div>


    <page:javascript>
        <script>
            $(() => {
                salesOnUI.inputPasswordUI();
                $('#expired-password').validator(function() {
                    $saleson.core.confirm("변경하시겠습니까?", function () {
                        changePassword();
                    })
                    return false;
                });
                $('#delayPassword').click(function() {
                    $saleson.core.confirm("연장하시겠습니까?", function () {
                        delayPassword();
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

                $saleson.api.post('api/auth/change-password', request)
                .then(function (response) {
                    $saleson.core.alert("변경 되었습니다", function () {
                        $saleson.core.redirect('/user/login');
                    })

                })
                .catch(function(error) {
                    $saleson.core.api.handleApiExeption(error);
                });

            }
            function delayPassword() {
                $saleson.api.post('api/auth/delay-change-password')
                .then(function () {
                    let url = '/auth/refresh';
                    $.ajax({
                        type: 'POST',
                        url: url,
                        success: function(response) {
                            console.log(response);
                            $saleson.core.alert("연장 되었습니다", function () {
                                $saleson.core.redirect('/');
                            })

                        },
                        error : function (response) {
                            $saleson.core.alert(response.error);
                            location.reload();

                        }
                    });
                })
                .catch(function(error) {
                    $saleson.core.api.handleApiExeption(error);
                });

            }
        </script>

    </page:javascript>

</layout:default>