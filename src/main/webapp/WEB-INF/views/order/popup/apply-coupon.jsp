<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<!-- 팝업 -->
<!-- show 클래스로 노출여부 제어 -->
<!-- 상품쿠폰적용 -->

<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">
        상품쿠폰적용
    </div>
    <div class="p-2 modal-body">
        <p class="modal-desc">상품쿠폰 적용 <span>사용 가능한 쿠폰만 보여집니다.</span></p>
        <div class="toggle-content brand-container">

            <c:forEach items="${buy.receivers[0].sellerShipping}" var="sellerShipping" >
                <c:set var="sellerId" value="${sellerShipping.sellerId}" scope="request"/>
                <c:set var="shippingIndex" value="${buy.receivers[0].shippingIndex}" scope="request"/>

                <div class="brand-wrap">
                    <div class="product-list-container"> <!-- 반복요소 product-list-container -->
                        <ul class="product-list-wrap">
                            <c:set var="totalPriceList" value="${sellerShipping.totalPrice}" />

                            <c:forEach items="${sellerShipping.shippings}" var="shipping" varStatus="shippingIndex">
                                <c:set var="shipping" value="${shipping}" scope="request"/>
                                <c:set var="singleShipping" value="${shipping.singleShipping}"/>
                                <c:set var="scope" value="coupon-list" scope="request"/>
                                <c:set var="totalItemPrice" value="${totalPriceList[shippingIndex.index]}" scope="request"/>

                                <c:choose>
                                    <c:when test="${singleShipping eq true}">
                                        <c:set var="buyItem" value="${shipping.buyItem}" scope="request"/>
                                        <c:set var="lastItem" value="${true}" scope="request" />
                                        <c:set var="itemPrice" value="${buyItem.itemPrice}" scope="request" />

                                        <jsp:include page="../../include/buyItem/buy-item-list.jsp"/>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${shipping.buyItems}" var="buyItem" varStatus="itemIndex">
                                            <c:set var="buyItem" value="${buyItem}" scope="request" />
                                            <c:set var="lastItem" value="${itemIndex.last}" scope="request" />

                                            <jsp:include page="../../include/buyItem/buy-item-list.jsp"/>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="btn-wrap gap">
            <button class="btn btn-primary" onclick="setCoupon()">적용</button>
            <button class="btn btn-default close">취소</button>
        </div>
    </div>
</div>

<script>
    $(function () {

        let shippingAmount = OrderHandler.buy.totalShippingAmount;
        $('#op-total-shipping-amount-text').html($saleson.core.formatNumber(shippingAmount));

        // disabled 처리
        $('.op-item-coupon').on('change', function(e){
            let couponAreaKey = $(this).data('couponAreaKey');
            let selectedCouponUserId = $(this).find('option:selected').data('couponUserId');

            $.each($('.op-item-coupon'), function(){
                let checkCouponAreaKey = $(this).data('couponAreaKey');
                $.each($('div[data-item-coupon-area-key="'+ checkCouponAreaKey +'"] > span'), function() {
                    let coupon = $(this).data();

                    $(this).data('disabled', false);
                    if (couponAreaKey == checkCouponAreaKey) {
                        $(this).data('selected', coupon.couponUserId == selectedCouponUserId ? true : false);
                    } else {
                        $(this).data('selected', coupon.couponUserId == selectedCouponUserId ? false : coupon.selected);
                    }
                });
            });

            $.each($('.op-item-coupon'), function() {
                $this = $(this);
                $.each($('div[data-item-coupon-area-key="'+ $(this).data('couponAreaKey') +'"] > span'), function() {
                    let coupon = $(this).data();
                    if (coupon.selected) {
                        let couponUserId = coupon.couponUserId;
                        $.each($('.op-item-coupon').not($this), function() {
                            $.each($('div[data-item-coupon-area-key="'+ $(this).data('couponAreaKey') +'"] > span'), function() {
                                if (couponUserId == $(this).data('couponUserId')) {
                                    $(this).data('disabled', true);
                                }
                            });
                        })
                    }
                });
            });

            setCouponDiscountData();
        });


        // 취소일때만 clear값으로 세팅
        $('.modal-apply-coupon').on('click','.close',function() {
            $saleson.core.confirm('쿠폰과 관련된 할인 금액들이 전부 초기화 상태로 변경됩니다.', () => {
                $.each($('.op-item-coupon'), function(){
                    let checkCouponAreaKey = $(this).data('couponAreaKey');
                    $.each($('div[data-item-coupon-area-key="'+ checkCouponAreaKey +'"] > span'), function() {
                        let coupon = $(this).data();

                        if (coupon.selected) {
                            coupon.selected = false;
                        }

                        if (coupon.disabled) {
                            coupon.disabled = false;
                        }
                    });
                });

                setCouponDiscountData('clear')

                // 초기화
                OrderHandler.setCouponDiscountAmount({}, {}, {});
                salesOnUI.modal().dismiss('.modal-apply-coupon')
            })
        });
    })


    function setCouponDiscountData(type) {
        $.each($('.op-item-coupon'), function() {

            let differentPlaceSelectedCoupons = [];
            let differentPlaceSelectNotCoupons = [];
            let selectId = 0;

            $.each($('div[data-item-coupon-area-key="'+ $(this).data('couponAreaKey') +'"] > span'), function() {
                let coupon = $(this).data();

                if (coupon.selected) {
                    selectId = coupon.couponUserId;
                }

                if (coupon.disabled == true) {
                    differentPlaceSelectedCoupons.push(coupon);
                } else {
                    differentPlaceSelectNotCoupons.push(coupon);
                }
            });

            $(this).find('optgroup, option').remove();
            if (differentPlaceSelectedCoupons.length > 0) {
                $_optionGroup = $('<optgroup label="다른 상품에 적용된 쿠폰" />');
                $.each(differentPlaceSelectedCoupons, function(i, coupon) {
                    $_optionGroup.append(makeOption(coupon));
                });

                $(this).append($_optionGroup);

                $_optionGroup = $('<optgroup label="사용 가능 쿠폰" />');

                $_option = $('<option />').val('clear').text('쿠폰을 선택하세요.');
                if (selectId == 0) {
                    $_option.prop('selected', true);
                }

                $_optionGroup.append($_option);
                if (differentPlaceSelectNotCoupons.length > 0) {
                    $.each(differentPlaceSelectNotCoupons, function(i, coupon) {
                        $_optionGroup.append(makeOption(coupon));
                    });
                }

                $(this).append($_optionGroup);
            } else {

                $_option = $('<option />').val('clear').text('쿠폰을 선택하세요.');
                if (selectId == 0) {
                    $_option.prop('selected', true);
                }

                $(this).append($_option);

                $_this = $(this);
                $.each(differentPlaceSelectNotCoupons, function(i, coupon){
                    $_this.append(makeOption(coupon));
                });
            }
        });

        if (type == 'clear') {
            setItemPrice('all');
        } else {
            // 쿠폰 할인 계산식
            setItemPrice('coupon');
        }
    }


    function makeOption(coupon) {
        let optionText = coupon.couponUserId + '. ' + coupon.couponName;
        optionText += ' - ' + $saleson.core.formatNumber(coupon.discountAmount) + '원 할인';
        if (coupon.couponConcurrently == '1') {
            optionText += ' [1개 수량만 적용]';
        } else {
            optionText += ' [구매 수량 할인]';
        }

        $_option = $('<option />').val(coupon.couponKey).text(optionText);
        if (coupon.selected) {
            $_option.prop('selected', true);
        }

        $_option.data({
            'couponKey'				: coupon.couponKey,
            'couponUserId'			: coupon.couponUserId,
            'discountAmount'		: coupon.discountAmount,
            'discountPrice'			: coupon.discountPrice,
            'couponConcurrently'	: coupon.couponConcurrently,

            'key'					: coupon.couponKey,
            'itemSequence'			: coupon.itemSequence,
            'shippingIndex'			: coupon.shippingIndex,
            'couponType'			: coupon.couponType
        });

        return $_option;
    }


    function setCoupon() {
        let itemCoupons = [];
        let addItemCoupons = [];
        let cartCoupons = [];
        $.each($('.op-item-coupon'), function() {
            if ($(this).val() != 'clear') {
                let coupon = $(this).find('option:selected').data();
                itemCoupons.push(coupon);
            }
        });

        setItemPrice('order');

        debugger
        OrderHandler.setCouponDiscountAmount(itemCoupons, addItemCoupons, cartCoupons);
        salesOnUI.modal().dismiss('.modal-apply-coupon');
    }


    // 쿠폰 계산
    function setItemPrice(scope) {
        $.each($('.op-item-coupon'), function() {
            if (scope != 'all') {
                if ($(this).val() != 'clear') {
                    let coupon = $(this).find('option:selected').data();
                    let couponDiscountAmount = Number(coupon.discountAmount);

                    let selectedOption = $(this).find('option:selected').val().split('-');

                    let itemSequence = selectedOption[3];
                    let shippingIndex = selectedOption[4];

                    const $itemPriceInfo = $('.item-price-info-' + itemSequence + '-' +shippingIndex);

                    let itemSalePrice = $itemPriceInfo.data('itemSalePrice');
                    let itemDiscountAmount = $itemPriceInfo.data('itemDiscountAmount');
                    let itemSaleAmount = $itemPriceInfo.data('itemSaleAmount');

                    $('.op-expected-discount-amount.'+ scope +'-' + itemSequence+'-' + shippingIndex).html($saleson.core.formatNumber(itemDiscountAmount + couponDiscountAmount));
                    $('.op-expected-item-sale-amount.' + scope + '-' + itemSequence + '-' + shippingIndex).html($saleson.core.formatNumber(itemSaleAmount - couponDiscountAmount));
                }

            } else {
                let key = $(this).data('couponAreaKey').split('-');

                let itemSequence = key[1];
                let shippingIndex = key[2];

                // 할인가 및 판매가 초기화
                $.each($('.op-expected-discount-amount, .op-expected-item-sale-amount'), function () {
                    updatePrice(this, itemSequence, shippingIndex, $(this).hasClass('op-expected-discount-amount') ? 'itemDiscountAmount' : 'itemSaleAmount');
                });

            }
        });
    }

    function updatePrice(element, itemSequence, shippingIndex, dataKey) {
        const $itemPriceInfo = $('.item-price-info-' + itemSequence + '-' + shippingIndex);

        let className = $(element).attr('class').split(' ')[1];
        let classNames = className.split('-');

        if (itemSequence === classNames[1] && shippingIndex === classNames[2]) {
            let itemAmount = $itemPriceInfo.data(dataKey);
            $(element).html($saleson.core.formatNumber(itemAmount));
        }
    }

</script>