<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<layout:mypage>

    <section class="mypage-myInfo">
        <div class="title-container">
            <h2 class="title-h2">내 정보 관리</h2>
        </div>
        <input type="hidden" id="isSnsJoined" value="${isSnsJoined}">
        <div class="intro user-page">
            <img src="/static/content/image/common/img_find_pw.png" alt="내 정보 관리" class="content-img">
            <p class="content-info">개인정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 입력해 주세요.</p>
            <form id="check_password">
                <div class="form-line">
                    <input type="password" id="checkPassword" class="form-basic required" placeholder="비밀번호" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <button type="submit"  class="btn btn-primary confirm-btn">확인</button>
            </form>
        </div>
    </section>
    <page:javascript>
        <script>
            let isSnsJoined = ${isSnsJoined};

            $(() => {
                salesOnUI.inputPasswordUI();
                if(isSnsJoined) {
                    $saleson.store.session.set("passwordChecked", true);
                    $saleson.core.redirect("/mypage/user/modify");
                }
                $('#check_password').validator(function () {
                   checkPassword();
                    return false;
                });

            })

            function checkPassword() {
                let param = {
                    password : $('#checkPassword').val()
                }

                $saleson.api.post('api/auth/check-password', param)
                .then(function (response) {
                    if(response.status == 200) {
                        $saleson.store.session.set("passwordChecked", true);
                       $saleson.core.redirect("/mypage/user/modify");
                    }

                })
                .catch(function(error) {
                    console.log(error);
                    $saleson.core.alert(error.response.data.message);
                });



            }




        </script>
    </page:javascript>

</layout:mypage>
