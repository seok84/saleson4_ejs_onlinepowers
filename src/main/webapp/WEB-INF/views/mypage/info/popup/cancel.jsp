<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">취소신청</div>
    <div class="modal-body p-2 type-cancel">
        <form id="cancelForm">
            <c:set var="claimApply" value="${content.claimApply}" />

            <input type="hidden" name="orderCode" value="${claimApply.orderCode}">
            <input type="hidden" name="orderSequence" value="${claimApply.orderSequence}">
            <input type="hidden" name="refundType">
            <input type="hidden" name="claimType" value="${claimApply.claimType}">
            <input type="hidden" name="claimRefundType" value="2">

            <div class="check-wrap all-check">
                <label class="input-checkbox"><input type="checkbox" onchange="cancelCheckAll(this);" /><i></i> 전체선택</label>
            </div>
            <!-- 아이템 영역 -->
            <c:forEach items="${claimApply.orderItems}" var="orderItem">
                <c:if test="${orderItem.claimApplyFlag eq 'Y'}">
                    <c:set var="i" value="${orderItem}" scope="request" />
                    <c:set var="claimType" value="${claimApply.claimType}" scope="request" />
                    <jsp:include page="/WEB-INF/views/include/order/order-item.jsp"/>
                </c:if>
            </c:forEach>
            <div class="article-divider"></div>
            <!-- 취소사유 -->
            <h3 class="form-title">취소사유</h3>
            <div class="select-wrap">
                <select class="input-select" name="claimReason" onchange="cancelReturnChange()">
                    <c:forEach items="${content.claimReasons}" var="claim">
                        <option value="${claim.id}">${claim.label}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic" name="claimReasonDetail" placeholder="취소 사유를 입력하세요" style="display: none;"/>
            </div>
            <ul class="dot-list large-dot">
                <li>주문 시 사용한 쿠폰과 적립금은 취소 시 복구됩니다. (단, 쿠폰의 경우 유효기간이 남은 쿠폰에 한함)</li>
                <li>이미 상품이 발송된 것으로 확인되면 취소 요청이 자동으로 철회되며, 이 경우 상품을 받으신 후 반품신청을 하실 수 있습니다.</li>
            </ul>
            <!-- 환불정보 -->
            <div class="return-content">
                <h3 class="form-title">환불정보</h3>
                <div class="form-line">
                    <input type="text" class="form-basic required" placeholder="예금주명" name="returnBankInName" title="예금주명"/>
                    <span class="feedback invalid" style="display: none">유효성 메시지</span>
                </div>
                <div class="form-line bank">
                    <div class="flex">
                        <div class="select-wrap">
                            <select class="input-select" name="returnBankName">
                                <c:forEach items="${banks.list}" var="bank">
                                    <option value="${bank.key}">${bank.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="text" class="form-basic required" name="returnVirtualNo" placeholder="계좌번호" title="계좌번호"/>
                        <span class="feedback invalid" style="display: none">유효성 메시지</span>
                    </div>
                </div>
                <ul class="dot-list large-dot">
                    <li>부분취소가 불가능한 결제방식(카드)의 경우 위에 입력하신 계좌로 취소금액을 입금해드립니다.</li>
                    <li>통장입금의 경우 택배가 판매자에게 도착한 후, 2~3일 이내에 반품 신청하신 계좌로 입금됩니다.</li>
                </ul>
            </div>
            <div class="cancel-product">
                <table>
                    <tbody>
                    <tr class="list">
                        <th>취소상품금액</th>
                        <td id="totalItemReturnAmount">0원</td>
                    </tr>
                    <tr class="list">
                        <th>추가배송비</th>
                        <td id="totalAddShippingAmount">0원</td>
                    </tr>
                    <tr class="total">
                        <th>총 환불금액</th>
                        <td id="totalReturnAmount">0원</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <ul class="dot-list large-dot">
                <li>
                    환불 금액에 대한 내용이 노출되고 있습니다. 환불 금액에 대한 내용이 노출되고 있습니다. 환불 금액에 대한 내용이 노출되고 있습니다.
                </li>
            </ul>
            <div class="link-wrap">
                <button type="submit" class="btn btn-primary link-item w-half">신청</button>
                <button type="button" class="btn btn-default link-item w-half" data-dismiss="">취소</button>
            </div>
        </form>
    </div>
</div>
<script>
    function refundDataView(checked, response){
        let totalItemReturnAmount = 0;
        let totalAddShippingAmount = 0;
        let totalReturnAmount = 0;
        if (checked){
            totalItemReturnAmount = response.totalItemReturnAmount;
            totalAddShippingAmount = response.totalAddShippingAmount;
            totalReturnAmount = response.totalReturnAmount;
        }
        // 취소상품금액
        $("#totalItemReturnAmount").html(totalItemReturnAmount+"원");
        // 추가배송비
        $("#totalAddShippingAmount").html(totalAddShippingAmount+"원");
        // 총 환불금액
        $("#totalReturnAmount").html(totalReturnAmount+"원");
    }

    function cancelCheckAll(e){
        $("input[name=id]").prop('checked', e.checked);
        getRefundPrice();
    }

    function getRefundPrice(){
        const dataArray = Array.from($("input[name=id]:checked")).map(input => input.value);

        if (dataArray.length > 0){
            let formData = $saleson.core.formToJson('cancelForm');

            formData.id = dataArray;

            $saleson.api.post("/api/order/refund-amount", JSON.stringify(formData))
            .then(function (response) {
                if (response.status === 200){
                    refundDataView(true, response.data);
                }
            }).catch(function(error) {
                $saleson.core.api.handleApiExeption(error);
            });
        } else {
            refundDataView(false);
        }
    }

    function cancelReturnChange(){
        let checked = $("select[name=claimReason] option:selected").html();
        let claimReasonDetail = $("input[name=claimReasonDetail]");
        claimReasonDetail.val("");
        if (checked == '기타'){
            claimReasonDetail.show();
        } else {
            claimReasonDetail.hide();
            claimReasonDetail.val(checked);
        }
    }

    $(function(){
        $("#cancelForm").validator({
            'requiredClass' : 'required',
            'submitHandler' : function() {

                if ($("input[name=id]:checked").length == 0){
                    $saleson.core.alert("취소상품을 선택해주세요.");
                    return false;
                }

                let formData = $saleson.core.formToJson('cancelForm');
                formData.id = Array.from($("input[name=id]:checked")).map(input => input.value);

                $saleson.api.post("/api/order/cancel-apply", JSON.stringify(formData))
                .then(function (response) {
                    if (response.status === 200){
                        $saleson.core.alert("취소신청 되었습니다.", function(){
                            refundAnalytics();
                            salesOnUI.modal().dismiss('.open-modal-cancel');
                            $saleson.core.reload();
                        });
                    }
                }).catch(function(error) {
                    $saleson.core.api.handleApiExeption(error);
                });
                return false;
            }
        });

        function refundAnalytics() {
            try {
                const $selector = $("input[name=id]:checked");
                const orderCode = $('#cancelForm').find('input[name=orderCode]').val();


                if ($selector.length > 0) {

                    let value = 0;
                    const items = [];

                    $selector.each(function(idx) {
                        const $element = $selector.eq(idx).closest('.order-item-element');
                        if ($element.length > 0) {
                            const itemUserCode = $element.data('item-user-code');
                            const salePrice = Number($element.data('sale-price'));
                            const quantity = Number($element.find('select.input-select').val());
                            value += (salePrice * quantity);
                            items.push({id:itemUserCode, quantity: quantity});
                        }
                    });

                    $saleson.analytics.refund({
                        transactionId: orderCode,
                        value : value,
                        items: items
                    });
                }
            } catch (e) {}
        }
    })


</script>