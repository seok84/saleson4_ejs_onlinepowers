let ANALYTICS_ITEM_LIST = [];
const ANALYTICS_STEP= {
    beginCheckout: false,
    addShippingInfo: false
}

$(function () {
    // tooltip event ui sample

    salesOnUI.scrollEvent('.contents-area');

    // tooltip event ui sample
    salesOnUI.tooltip('.tooltip-handler');

    salesOnUI.toggleHidden('.input-select', '.select-option')

    // toggle ui
    salesOnUI.toggleActive('.toggle-title');
    salesOnUI.toggleActive('.toggle-arr', '.toggle-wrap');

    // terms toggle ui
    salesOnUI.toggleTerms();

    salesOnUI.paymentTab('.payment', '.payment-form-wrap');

    const MOBILE_FLAG = $saleson.core.isMobile() || $saleson.core.isApp();

    // pay type 초기값 set
    const $payment = $(".payment");
    $payment.on('click', (e) => {
        e.preventDefault();

        let $target = $(e.currentTarget);
        let payType = $target.data('payment');

        let notMixPayTypeSelectCount = 0;
        $.each(OrderHandler.notMixPayType, function(i, payType) {
            $.each($(".payment.active"), function(j, t) {
                if (payType == $(this).val()) {
                    notMixPayTypeSelectCount++;
                }
            });
        });

        // 복합결제가 불가능한 결제타입을 1개이상 선택하였으면
        if (notMixPayTypeSelectCount > 1) {
            $(".payment.active").not(this).removeClass('active');
        }

        $('input.op-order-payAmounts').removeClass('op-default-payment');
        $target.children('input').addClass('op-default-payment');

        // 결제금액 초기화
        OrderHandler.setOrderPayAmountClear();
    })

    // 비회원 체크박스 핸들링
    const $checkboxWrap = $('.check-wrap');
    $checkboxWrap.on('click', '.circle-input-checkbox',() => {
    });

    // 상품 좋아요
    const $container = $('.item-list-container');
    $container.on('click', '.user-attention', function () {
        const $selector = $(this);
        const itemId = parseInt( $selector.data('item'));

        $saleson.handler.addToWishlist(itemId, $selector);
    });

    // 배송문구 핸들링
    const $shippingContent = $('.shipping-content');
    $shippingContent.on('change', (event) => {
        let value = event.target.value ;

        if (value == '') {
            $('.shipping-content-input').css('display', 'block');
        } else {
            $('.shipping-content-input').css('display', 'none');
        }
    });

    // 포인트 사용 직접사용
    $('.use-all-point').on('click', (event) => {
        OrderHandler.pointUsedAll($(event.currentTarget));
    })


    // 포인트 사용 직접입력
    $expectedPoint = $('.expected-deducation-point');
    $expectedPoint.on('focusout', (event) => {
        $('.use-all-point').prop('checked', false);

        // 사용할 포인트
        let usePoint = $(event.target).val().replace(",", '');

        // 사용 예정 포인트 계산
        OrderHandler.pointUsed(Number(usePoint));
    });

    // 폼 제출
    $('#buy').validator({
        'requiredClass' : 'required',
        'submitHandler' : function ()  {
            const api = $saleson.api;
            let url = '/order/convert-form';

            if (MOBILE_FLAG) {
                $('input[name="deviceType"]').val("MOBILE");
            }

            // 비회원일경우에 주문자 정보 구성해줌
            setBuyerInfo();

            //가격정보를 구성하는 단계
            let orderPayAmount = $('input[name="orderPrice.orderPayAmount"]').val();
            if (orderPayAmount < 0) {
                alert('결제 금액을 확인하십시오. 결제 요청액 : ' + orderPayAmount);
                return false;
            }

            // 전체 상품 금액
            let totalItemSaleAmount = Number($('input[name="orderPrice.totalItemSaleAmount"]').val());

            // 전체 배송 금액
            let totalShipingAmount = Number($('input[name="orderPrice.totalShippingAmount"]').val());

            // 전체 포인트 금액
            let totalPointAmount = Number($('input[name="orderPrice.totalPointDiscountAmount"]').val());

            // 전체 상품금액이 전체 포인트 금액보다 크다면 true
            let pointCheck = (totalItemSaleAmount + totalShipingAmount) > totalPointAmount;

            let payType = $(".payment.active").data('payment');
            if (pointCheck) {
                // 무통장 validation check
                if (payType == 'bank') {
                    let isBankInfoEmpty = false;
                    let targetElement = {};

                    $('.select-account').each((index, element) => {

                        if ($(element).val() == '') {
                            targetElement = $(element);
                            isBankInfoEmpty = true;
                            return false;
                        }
                    });

                    if (isBankInfoEmpty) {
                        $saleson.core.alert('무통장에 대한 정보를 입력하지 않았습니다.');
                        targetElement.focus();
                        return false;
                    }
                }
            }
            $('input[name="retentionPoint"]').val(OrderHandler.buy.retentionPoint);
            // 개인정보 안내 동의
            let checkPrivacyTerms = false;

            if (MOBILE_FLAG) {
                checkPrivacyTerms = $('.agree-privacy.mobile').prop('checked');

                if (!checkPrivacyTerms) $('.agree-privacy.mobile').focus();
            } else {
                checkPrivacyTerms = $('.agree-privacy.pc').prop('checked')
            }

            if(!checkPrivacyTerms) {
                $saleson.core.alert("개인정보 제 3자 제공 및 수집·이용 안내를 확인 후 동의해주세요.");

                return false;
            }

            // 최조 구매동의 안내 동의
            let checkItemTerms = false;

            if (MOBILE_FLAG) {
                checkItemTerms = $('.agree-item-terms.mobile').prop('checked');

                if (!checkItemTerms) $('.agree-item-terms.mobile').focus();
            } else {
                checkItemTerms = $('.agree-item-terms.pc').prop('checked');
            }

            if(!checkItemTerms) {
                $saleson.core.alert("구매동의 안내를 확인 후 동의해주세요.");
                return false;
            }else {
                //setCheckoutStep(Ga.const.CHECKOUT_CONFIRM_ORDER_STEP);
            }


            let isSuccess = false;
            let savePaymentType = [];

            // 배송문구
            let $shippingContent = $('.shipping-content');
            if ($shippingContent.val() != '') {
                $('input[name="receivers[0].content"]').val($shippingContent.val());
            }

            historyBackDataSet();

            // 결제 버튼 비활성화
            $('.payment-btn').prop('disabled', true);

            $.ajax({
                type :"POST",
                async : true,
                url : url,
                data : $('#buy').serialize(),
                dataType : "json",
                success: async function(json, status, request) {
                    try {
                        const response = await api.post('/api/order/save', json.data);
                        if (response.status == 200) {
                            isSuccess = true;
                            const {data} =  response.data;
                            savePaymentType = data.savePaymentType;


                            // 주문 코드
                            $('input[name="orderCode"]').val(data.orderCode);

                            if (OrderHandler.getApprovalType(savePaymentType, 'naverpay')) {
                                //orderPrice.orderPayAmount

                                if (OrderHandler.buy.orderPayAmount < 100) {
                                    $saleson.core.alert("총 결제금액이 100원 미만일 경우 네이버페이를 이용 할 수 없습니다.");
                                    return false;
                                }

                                // ga
                                //setCheckoutStep($s.ga.const.CHECKOUT_PURCHASE_STEP);
                                let oPay = Naver.Pay.create({
                                    "mode" : "production",
                                    "clientId" : OrderHandler.buy.buyPayments['naverpay'].mid,
                                    "openType" : "page"
                                });


                                let returnParam = '?orderCode=' + data.orderCode + '&amount=' + response.data.naverpay.totalPayAmount + '&encryptedString=' + response.encryptedString;
                                let defaultUrl = $saleson.const.cookie.API;

                                oPay.open({
                                    "returnUrl" : $saleson.store.cookie.get(defaultUrl) + '/api/order/naverpay/payment' + returnParam,
                                    "merchantPayKey": response.data.orderCode,
                                    "productName": response.data.naverpay.productName,
                                    "totalPayAmount": response.data.naverpay.totalPayAmount,
                                    "taxScopeAmount": response.data.naverpay.taxScopeAmount,
                                    "taxExScopeAmount": response.data.naverpay.taxExScopeAmount,
                                    "productItems": response.data.naverpay.productItems,
                                    "deliveryFee": OrderHandler.buy.totalShippingAmount,
                                    "productCount": response.data.naverpay.productCount
                                });


                            } else if (OrderHandler.getApprovalType(savePaymentType, 'bank') || OrderHandler.buy.orderPayAmount === 0) {
                                orderSubmit();
                            } else {
                                $.each(data.pgData, function (key, value) {
                                    $('.nicepay-input-area > input[name="' + key + '"]').val(value);
                                    if (key === 'ReturnURL'){
                                        $('#buy').attr('action', value);
                                    }
                                });

                                nicepayStart();
                            }

                            try {
                                $saleson.analytics.addPaymentInfo(ANALYTICS_ITEM_LIST, savePaymentType);
                            } catch (e) {}
                        }

                    } catch (e) {
                        $('.payment-btn').prop('disabled', false);
                        console.log(e, "error");
                        $saleson.core.alert(e.response.data.message);
                    }
                },
                error : function(response){
                    $('.payment-btn').prop('disabled', false);
                    console.error(response);
                }
            });

            return false;
        }
    })
    // historyBackDataSet();

    try {
        $saleson.analytics.beginCheckout((items)=>{
            ANALYTICS_ITEM_LIST = JSON.parse(JSON.stringify(items));
            ANALYTICS_STEP.beginCheckout = true;
            if (LOGIN_FLAG) {
                try {
                    $saleson.analytics.addShippingInfo(ANALYTICS_ITEM_LIST);
                    ANALYTICS_STEP.addShippingInfo = true;
                } catch (e) {}
            }
        });

    } catch (e) {}
});

function historyBackDataSet (){
    OrderHandler.setAmountText();
}

/*
  * 주소 변경 팝업
  * */
function getReceiveChangePopup() {
    try {
        $saleson.handler.getPopup({}, "/shipping/popup/address-list", ".modal-address-list");
    } catch (error) {
        $saleson.core.alert(error.response.data.message);
    }
}

/*
  * 주소 추가 팝업
  * */
function addressAddPopup() {
    $saleson.handler.getPopup({}, "/shipping/popup/address-add", ".address-modal");
}

function orderSubmit() {
    let orderCode =  $('input[name="orderCode"]').val();

    let formData = new FormData();
    formData.append('orderCode', orderCode);

    const api = $saleson.api;
    let url = 'api/order/pay';

    try {

        api.post(url, formData)
        .then((response) => {
            if (response.status == 200) {
                $saleson.core.alert('상품이 주문되었습니다.', ()=> {
                    let data = response.data;
                    $saleson.core.redirect('/order/step2?orderSequence=' + data.orderSequence + '&orderCode=' + data.orderCode);
                })
            }
        })
        .catch(function (error) {
            $saleson.core.api.handleApiExeption(error);
        });
    } catch (error) {
        $saleson.core.redirect('/order/step2');
    }
}



/*
* 기본 배송지 설정
* */
function changeDefaultAddress() {
    $saleson.core.confirm('기본배송지로 설정하시겠습니까?', async () => {
        const $checkRadio = $('.default-address:checked');
        const userDeliveryId = $checkRadio.data('deliveryId');

        let param = {
            'userDeliveryId' : userDeliveryId,
        }

        try {
            const api = $saleson.api;
            let url = '/api/shipping/base-shipping';

            const {data} = await api.post(url, param);

            if (data.status == 200) {
                $saleson.core.alert('기본 배송지로 설정되었습니다.', () => {
                    $saleson.core.reload();
                });
            } else {
                throw new Error();
            }


        } catch (error) {
            $saleson.core.alert(error.response.data.message);
        }
    })
}


/*
* * 상품 쿠폰 조회
* */
function availableCouponsCheck(){
    try {
        salesOnUI.modal().show('.modal-apply-coupon');
    } catch (error) {
        $saleson.core.alert(error.response.data.message);
    }
}

function openDaumpostCode () {
    const tagNames = {
        'newZipcode'			: 'receivers[0].receiveNewZipcode',
        'zipcode': 'receivers[0].receiveZipcode',
        'roadAddress': 'receivers[0].receiveAddress',
        'sido'					: 'receivers[0].receiveSido',
        'sigungu'				: 'receivers[0].receiveSigungu',
        'eupmyeondong'			: 'receivers[0].receiveEupmyeondong',
    }

    openDaumAddress(tagNames, () =>{
        OrderHandler.buy.receivers[0].zipcode = $('input[name="receivers[0].receiveZipcode"]').val();

        OrderHandler.getIslandType();

        OrderHandler.setAmountText();

        try {
            if (!ANALYTICS_STEP.addShippingInfo) {
                $saleson.analytics.addShippingInfo(ANALYTICS_ITEM_LIST);
                ANALYTICS_STEP.addShippingInfo = true;
            }
        } catch (e) {}

    });
}

/*
*
* 비회원일때 구매자 정보 setting
*
* */
function setBuyerInfo() {
    // 해당 영역이 화면에 노출이 되면?
    let isLogin = $('.buyer-info').is(':visible');

    if (isLogin) {

        // 주문자 정보 set
        $('input[name="buyer.userName"]').val($('.buyer-info input[name="userName"]').val());
        $('input[name="buyer.mobile"]').val($('.buyer-info input[name="userPhone"]').val());
        $('input[name="buyer.phone"]').val($('.buyer-info input[name="userPhone"]').val());
        $('input[name="buyer.email"]').val($('.buyer-info input[name="userEmail"]').val());
    }
}


/**
 * 주문서 기준 구성상품 팝업
 */
function getFreegiftItemPopupByOrder(itemId) {
    try {
        $saleson.handler.getPopup({}, `/order/popup/set-item-info/${itemId}`, '.modal-product-detail');
    } catch (error) {
        $saleson.core.alert(error.response.data.message);
    }

}
