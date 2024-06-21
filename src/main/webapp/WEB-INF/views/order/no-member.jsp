<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<layout:default>


<div class="order-non-member-page">
    <h1 class="title-h1 pc">비회원 약관 동의</h1>
    <div class="w-582">
        <div class="induce-login">
            <p>
                비회원으로 구매하시면 세일즈온에서 드리는 쿠폰할인 및 포인트 적립 혜택을 받으실수 없습니다.<br />
                또한 비회원 주문시에는 포인트가 지급되지 않습니다.
            </p>
            <div class="btn-wrap gap">
                <button class="btn btn-primary" type="button" onclick="$saleson.core.redirect('/user/login');">로그인</button>
                <button class="btn btn-default" type="button" onclick="$saleson.core.redirect('/user/certify-join');">회원가입</button>
            </div>
        </div>
        <ul class="terms-content">
            <li class="check-wrap whole-check">
                <label class="circle-input-checkbox"><input type="checkbox" class="checkbox all-check"><i></i>
                <p class="terms-title">모든 약관 동의</p>
                </label>
            </li>
            <li class="check-wrap">
                <label class="circle-input-checkbox">
                    <input type="checkbox" class="checkbox sub-checkbox"><i></i>
                    <p class="terms-title">이용약관에 동의  <em>(필수)</em></p>
                </label>
                <div class="terms-list">
                    <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_AGREEMENT')">약관보기</a>
                </div>
            </li>
            <li class="check-wrap">
                <label class="circle-input-checkbox">
                    <input type="checkbox" class="checkbox sub-checkbox"><i></i>
                    <p class="terms-title">개인정보의 수집·이용목적 및 항목 동의 <em>(필수)</em></p>
                </label>
                <div class="terms-list">
                    <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_PROTECT_POLICY')">약관보기</a>
                </div>
            </li>
        </ul>
        <button class="btn btn-round btn-large btn-primary btn-order" type="button">주문하기</button>
    </div>
</div>
    <page:javascript>
        <script src="/static/content/modules/ui/order/order.js"></script>
        <script>
            $(() => {
                $('.sub-checkbox').change(function () {
                    $(".all-check").prop('checked',
                        $(".sub-checkbox:checked").length === $(".sub-checkbox").length);
                });

                $('.all-check').change(function () {
                    $(".sub-checkbox").prop('checked', this.checked);
                });

                /**
                 * 상품 정보 저장
                 */
                $('.btn-order').click( function () {
                    if (!($('.sub-checkbox:checked').length === 2)) {
                        $saleson.core.alert("약관에 동의해주세요");
                        return false;
                    }
                    location.href = '/order/step1';
                })
            })


            function policyModal(policyType) {
                const $modal = $(".policy")
                $saleson.api.get(`/api/policy/` + policyType)
                .then(function (response) {
                    $modal.find('.modal-header').text(response.data.title);
                    $modal.find('.modal-content').html(response.data.content);
                    // salesOnUI.modal('.policy').show();
                    salesOnUI.modal().show('.policy');
                })
            }

        </script>
    </page:javascript>
    <page:model>
        <div class="modal policy">
            <div class="modal-wrap">
                <button class="modal-close" data-dismiss>닫기</button>
                <div class="modal-header">
                </div>
                <div class="p-2 modal-body">
                    <div class="modal-content">

                    </div>
                </div>
            </div>
            <div class="dimmed-bg"></div>
        </div>
    </page:model>
</layout:default>