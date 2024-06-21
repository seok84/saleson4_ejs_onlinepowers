<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<layout:default>

    <div class="user-page secede-page">
        <h1 class="title-h1">회원탈퇴</h1>
        <p class="user-page-info">
            회원탈퇴시<br class="mobile"/> 상품 구매내역, 쿠폰 및 포인트 등 모든 정보가 삭제되며<br/>
            회원 서비스를 모두 이용할 수 없습니다.
        </p>
            <%--    <p class="extinct-point"><span>소멸예정 포인트</span><strong><fmt:formatNumber value="${secedeInfo.point}" pattern="#,###"/></strong></p>--%>
        <c:if test="${!isSnsJoined}">
            <div class="form-line">
                <input type="password" id="password" class="form-basic required" name="password"
                       placeholder="비밀번호"/>
                <span class="feedback invalid" style="display: none;">유효성 메시지</span>
            </div>
        </c:if>
        <h2 class="survey-title">탈퇴이유</h2>
        <p class="survey-content">
            그동안 Saleson store를 이용해 주셔서 감사합니다.<br>
            더 나은 운영을 위한 설문조사 이므로 솔직한 답변 부탁 드립니다.
        </p>
        <input type="hidden" id="loginId" value="${secedeInfo.loginId}">
        <p class="survey-divider"></p>
        <div class="radio-wrap survey-radio-wrap">
            <label class="input-radio"><input type="radio" name="secede-survey" value="test"><i></i>상품설명이
                알기 어렵기 때문에</label>
            <label class="input-radio"><input type="radio" name="secede-survey"><i></i>주문 및 문의 시 직원의
                대응이 만족스럽지 않아서</label>
            <label class="input-radio"><input type="radio" name="secede-survey"><i></i>상품의 상태가 좋지
                않아서</label>
            <label class="input-radio"><input type="radio" name="secede-survey"><i></i>상품의 가격이
                높아서</label>
            <label class="input-radio"><input type="radio" name="secede-survey"><i></i>원하는 상품이
                없어서</label>
            <label class="input-radio"><input type="radio" name="secede-survey"><i></i>기타</label>
        </div>
        <div class="form-line">
            <textarea name="ect-survey" cols="30" rows="10" class="form-basic text-area" readonly
                      placeholder="기타사유가 있다면 입력하세요"></textarea>
        </div>

        <button type="button" id="openSecedeModal" class="btn btn-primary confirm-btn">탈퇴</button>
    </div>

    <page:javascript>
        <script>
            let isSnsJoined = ${isSnsJoined};
            $(() => {
                salesOnUI.inputPasswordUI();
                $('.radio-wrap input[name="secede-survey"]').change(function() {
                    if ($('input[name="secede-survey"]:checked').parent().text() === '기타') {
                        $('textarea[name="ect-survey"]').prop('readonly', false);
                    } else {
                        $('textarea[name="ect-survey"]').prop('readonly', true);
                    }
                })

                $('#openSecedeModal').click(function () {
                    if(!isSnsJoined) {
                        if ($.validator.isEmpty($('#password').val())) {
                            $saleson.core.alert("비밀번호를 입력하세요");
                            return false;
                        }
                    }
                    if($.validator.isEmpty($('input[name="secede-survey"]:checked').parent().text())) {
                        $saleson.core.alert("탈퇴 사유를 입력해주세요!");
                        return false;
                    }
                    if ($('input[name="secede-survey"]:checked').parent().text() === '기타') {
                        if ($.validator.isEmpty($('textarea[name="ect-survey"]').val())) {
                            $saleson.core.alert("탈퇴 사유를 입력해주세요");
                            return false;
                        }

                    }
                    salesOnUI.modal().show('.modal-secede');
                })

                $('#confirmSecede').click(function () {
                    salesOnUI.modal().dismiss('.modal-secede');
                    let leaveReason;
                    if ($('input[name="secede-survey"]:checked').parent().text() === '기타') {
                        leaveReason = $('textarea[name="ect-survey"]').val();
                    } else {
                        leaveReason = $('input[name="secede-survey"]:checked').parent().text()
                    }
                    let param = {
                        loginId : $('#loginId').val(),
                        password : $('#password').val(),
                        leaveReason : leaveReason,
                        snsFlag : isSnsJoined
                    }
                    $saleson.api.post("/api/auth/secede", param)
                    .then(function (response) {

                        console.log(response);
                        if (response.status == 200){
                            $saleson.core.alert("탈퇴 완료되었습니다.", function(){
                                $saleson.auth.logout('/');
                            });
                        }
                    })
                    .catch(function(error) {
                        $saleson.core.alert(error.response.data.message);
                    });


                })
            });


        </script>


    </page:javascript>
    <page:model>
        <div class="modal modal-secede">
            <div class="dimmed-bg" data-dismiss></div>
            <div class="modal-wrap">
                <button class="modal-close" data-dismiss>닫기</button>
                <div class="modal-header">
                    회원탈퇴
                </div>
                <div class="modal-body p-2">
                    <div class="modal-content">
                        <div class="text-center">
                            정말 탈퇴 하시겠습니까?
                        </div>
                    </div>
                    <div class="btn-wrap gap">
                        <button type="button" id="confirmSecede" class="btn btn-default">탈퇴</button>
                        <button type="button" onclick="salesOnUI.modal().dismiss('.modal-secede')" class="btn btn-primary" data-dismiss>취소</button>
                    </div>
                </div>
            </div>
        </div>
    </page:model>

</layout:default>
