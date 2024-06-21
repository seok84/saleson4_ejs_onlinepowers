
/**
 * 초기화
 */

let OrderHandler = {
    'buy' 						: null,
    'pgType' 					: '',
    'totalItemPriceByCoupon'	: 0,
    'minimumPaymentAmount'		: 0,
    'pointUseMin'				: 0,
    'pointUseMax'				: 0,
    'pointUseRatio'				: 0,
    'orgReceivers'				: null,
    'useItemCoupons'			: [],
    'useAddItemCoupons'			: [],
    'useCartCoupons'			: [],
    'notMixPayType'				: [],
    'saveReceiverHtml'			: '',
    'orgZipcode'				: '',
    'isSns'                     : false,
    'itemPrice'                  : null
}

/**
 * 초기화
 */
OrderHandler.init = (buy, pgType, minimumPaymentAmount, pointUseMin, pointUseMax, pointUseRatio) => {
    OrderHandler.buy = buy;
    OrderHandler.pgType = pgType.toLowerCase();
    OrderHandler.totalItemPriceByCoupon = buy.totalItemAmountBeforeDiscounts;
    if ($.isNumeric(minimumPaymentAmount) == false) {
        minimumPaymentAmount = 0;
    }

    OrderHandler.minimumPaymentAmount = Number(minimumPaymentAmount);

    if ($.isNumeric(pointUseMin) == false) {
        pointUseMin = Number(pointUseMin);
    }

    if ($.isNumeric(pointUseMax) == false) {
        pointUseMax = Number(pointUseMax);
    }

    if ($.isNumeric(pointUseRatio) == false) {
        pointUseRatio = Number(pointUseRatio);
    }

    OrderHandler.notMixPayType = OrderHandler.buy.notMixPayType;
    OrderHandler.orgReceivers = OrderHandler.buy.receivers;
    OrderHandler.pointUseMin = pointUseMin;
    OrderHandler.pointUseMax = pointUseMax;
    OrderHandler.pointUseRatio = pointUseRatio;
}

// 쿠폰 사용 체크 2017-04-25 yulsun.yoo
OrderHandler.setShippingAmount = () => {
    // 배송비 계산전 초기화
    OrderHandler.buy.totalShippingAmount = 0;

    $.each(OrderHandler.buy.receivers, function(index, receiver) {
        let receiverTotalDeliveryChange = 0;
        let receiverTotalDeliveryChange2 = 0;
        let islandType = '';
        let realShipping = 0;

        for (let j = 0; j < receiver.shippingList.length; j++) {
            let shipping = receiver.shippingList[j];
            let addDeliveryCharge = 0;
            islandType = shipping.islandType;

            if (shipping.shippingExtraCharge1 > 0 || shipping.shippingExtraCharge2 > 0) {
                if (islandType == 'JEJU') {
                    addDeliveryCharge = shipping.shippingExtraCharge1;
                } else if (islandType == 'ISLAND') {
                    addDeliveryCharge = shipping.shippingExtraCharge2;
                }
            }


            if (shipping.shippingType == '1') {
                realShipping = addDeliveryCharge;
            } else if (shipping.shippingType == '2' || shipping.shippingType == '3') {
                let totalItemAmount = 0;

                if (shipping.shippingType == '3') {
                    if (!shipping.shipmentGroupCode) {
                        for (let i=0;i<shipping.buyItems.length;i++) {
                            let item = shipping.buyItems[i];

                            totalItemAmount += item.baseAmountForShipping;
                        }
                    } else {
                        for (let i=0;i<OrderHandler.buy.receivers.length;i++) {
                            let receiver1 = OrderHandler.buy.receivers[i];

                            if (receiver.shippingIndex == receiver1.shippingIndex) {
                                for (let j=0;j<receiver1.shippingList.length;j++) {
                                    let shipping1 = receiver1.shippingList[j];

                                    if (shipping1.shippingType == '3') {
                                        for (let k=0;k<shipping1.buyItems.length;k++) {
                                            let item1 = shipping1.buyItems[k];

                                            if (item1.shipmentGroupCode) {
                                                if (shipping1.shipmentGroupCode == item1.shipmentGroupCode) {
                                                    totalItemAmount += item1.baseAmountForShipping;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    for (let i=0;i<shipping.buyItems.length;i++) {
                        let item = shipping.buyItems[i];

                        totalItemAmount += item.baseAmountForShipping;
                    }

                }

                if (shipping.shippingFreeAmount <= totalItemAmount) {
                    realShipping = addDeliveryCharge;
                } else {
                    realShipping = shipping.shipping + addDeliveryCharge;
                }
            } else if (shipping.shippingType == '4') {
                let baseAmountForShipping = 0;
                if (shipping.singleShipping) {
                    baseAmountForShipping = shipping.buyItem.baseAmountForShipping;
                } else {
                    let items = shipping.buyItems;

                    if (typeof items != undefined && items.length > 0) {
                        for (let i=0;i<items.length;i++) {
                            baseAmountForShipping += items[i].baseAmountForShipping;
                        }
                    }
                }

                if (shipping.shippingFreeAmount <= baseAmountForShipping) {
                    realShipping = addDeliveryCharge;
                } else {
                    realShipping = shipping.shipping + addDeliveryCharge;
                }
            } else if (shipping.shippingType == '5') {
                let boxCount = 0;
                if (shipping.singleShipping) {
                    boxCount = Math.ceil(Number(shipping.buyItem.quantity) / shipping.shippingItemCount);
                } else {
                    let items = shipping.buyItems;

                    if (typeof items != undefined && items.length > 0) {
                        for (let i=0;i<items.length;i++) {
                            boxCount += Math.ceil(Number(items[i].quantity) / shipping.shippingItemCount);
                        }
                    }
                }

                realShipping = (shipping.shipping + addDeliveryCharge) * boxCount;
            } else {
                realShipping = shipping.shipping + addDeliveryCharge;
            }

            shipping.realShipping = realShipping;
            shipping.addDeliveryCharge = addDeliveryCharge;
        }
    });

    // 착불
    for (let i=0;i<OrderHandler.buy.receivers.length;i++) {
        let receiver = OrderHandler.buy.receivers[i];
        let receiverTotalDeliveryChange = 0;
        let receiverTotalDeliveryChange2 = 0;

        for (let j=0;j<receiver.shippingList.length;j++) {
            let shipping = receiver.shippingList[j];

            if (shipping.shippingPaymentType != '2') {
                receiverTotalDeliveryChange += shipping.realShipping;
                OrderHandler.buy.totalShippingAmount += shipping.realShipping;
            } else {
                // 착불 금액
                receiverTotalDeliveryChange2 += shipping.realShipping;
            }
        }
    }

    OrderHandler.setAmountText();
}

/**
 * 사용가능 배송 쿠폰
 */
OrderHandler.setShippingCoupon = function(addDeliveryCharge) {

    OrderHandler.buy.totalShippingCouponDiscountAmount = 0;
    OrderHandler.buy.totalShippingCouponUseCount = 0;
    if (OrderHandler.buy.shippingCoupon > 0) {

        OrderHandler.useShippingCoupon = 0;
        $.each(OrderHandler.buy.receivers, function(i, receiver) {
            $.each(receiver.shippingList, function(j, shipping) {
                if (OrderHandler.buy.shippingCoupon > OrderHandler.useShippingCoupon) {
                    let key = "useShippingCoupon['SHIPPING-COUPON-" + shipping.shippingSequence + "'].useFlag";
                    $_input = $('input[name="'+ key +'"]');

                    shipping.discountShipping = 0;
                    if ($_input.size() > 0) {
                        if ($_input.prop('checked') == true) {
                            if ($_input.prop('disabled') == false) {

                                if (shipping.realShipping > 0) {

                                    shipping.discountShipping = shipping.realShipping - shipping.addDeliveryCharge;

                                    shipping.realShipping = shipping.realShipping - shipping.discountShipping;
                                    OrderHandler.buy.totalShippingCouponDiscountAmount += shipping.discountShipping;
                                    OrderHandler.buy.totalShippingCouponUseCount++;
                                    OrderHandler.useShippingCoupon++;

                                } else {
                                    $_input.prop('checked', false);
                                }
                            }
                        }
                    }
                }
            })
        });

    }
}


// 제주도서산간 여부 조회
OrderHandler.getIslandType = () => {
    let islandType = 0;

    $.each(OrderHandler.buy.receivers, async function (index, receiver) {
        let zipCode = receiver.zipcode;
        if (zipCode != '') {

            const api = $saleson.api;
            let url = '/api/common/island-info';
            try {

                let param = {
                    'zipCode': zipCode,
                    'where':'ZIPCODE'
                };

                const {data} = await api.get(url, param);

                if (data.content.length > 0) {
                    islandType = data.content[0].islandType;
                }

                let shippingList = receiver.shippingList;

                for (let subIndex = 0; subIndex < shippingList.length;
                    subIndex++) {
                    let shipping = shippingList[subIndex];

                    OrderHandler.buy.receivers[index].shippingList[subIndex].islandType = islandType;
                }

                // 배송비 재설정
                OrderHandler.setShippingAmount();

                // 배송지 그룹 재설정
                OrderHandler.setGroupShippingAmount();
            } catch (error) {
                console.error(error)
            }
        }
    })

}


/**
 * 마일리지 전체 사용
 */
OrderHandler.pointUsedAll = function ($checkbox) {
    let usePoint = 0;
    try {
        if ($checkbox.prop('checked') == true) {
            if (OrderHandler.pointUseMax == -1) {

                usePoint = Math.floor(((OrderHandler.buy.orderPayAmount
                        + OrderHandler.buy.totalPointDiscountAmount) / 100)
                    * OrderHandler.pointUseRatio);

                if(usePoint > OrderHandler.buy.userTotalPoint ) {
                    usePoint = OrderHandler.buy.userTotalPoint;
                }
            } else {
                usePoint = OrderHandler.buy.retentionPoint;
            }

        }

    } catch (e) {
        //alert(e.message);
    }
    OrderHandler.pointUsed(usePoint);
}

/**
 * 포인트 사용
 */
OrderHandler.pointUsed = (usePoint) => {
    OrderHandler.setPointDiscountAmount(usePoint);
    OrderHandler.setAmountText();
}

OrderHandler.setPointDiscountAmount = (usePoint) => {
    let totalPoint = OrderHandler.buy.userTotalPoint;
    let retentionPoint = OrderHandler.buy.retentionPoint;
    if (retentionPoint == 0) {
        OrderHandler.buy.totalPointDiscountAmount = 0;
    }

    if(totalPoint < usePoint) {
        usePoint = totalPoint;
    }
    // if (retentionPoint < usePoint) {
    //     usePoint = retentionPoint;
    // }
    // 이미 적용된 포인트 금액은 더해서 계산함
    let orderPayAmount = OrderHandler.buy.orderPayAmount
        + OrderHandler.buy.totalPointDiscountAmount;
    // 결제 예정 금액의 포인트 할인 반영율 적용
    let ratioPointAmount = Math.floor(
        (orderPayAmount / 100) * OrderHandler.pointUseRatio);

    // max값
    if (orderPayAmount - OrderHandler.minimumPaymentAmount < usePoint) {
        $saleson.core.alert("포인트 최대 사용범위를 초과하였습니다.");
        usePoint = orderPayAmount - OrderHandler.minimumPaymentAmount;
    }

    if (usePoint > ratioPointAmount) {
        $saleson.core.alert("포인트 최대 사용범위를 초과하였습니다.");
        usePoint = ratioPointAmount;
    }

    if (usePoint < 0) {
        usePoint = 0;
    }

    if (OrderHandler.pointUseMin > usePoint) {
        if (usePoint > 0) {
            $saleson.core.alert("포인트 최소 사용 범위 미만입니다.");
        }
        usePoint = 0;
    }

    if (OrderHandler.pointUseMax > 0) {
        if (OrderHandler.pointUseMax < usePoint) {
            $saleson.core.alert("포인트 최대 사용범위를 초과하였습니다.");
            usePoint = OrderHandler.pointUseMax;

        }
    }

    if (usePoint > 0) {
        // 100원단위 사용 가능
        usePoint = Math.floor(usePoint * 0.01) * 100;
    }

    OrderHandler.buy.totalPointDiscountAmount = usePoint;
}



/**
 * 가격정보를 세팅
 */
OrderHandler.setAmountText = (isClear) => {

    let unit = " 원";

    if (isClear == undefined) {
        isClear = true;
    }

    let totalItemQuantities = 0;

    // 적립 예정 포인트에 쿠폰 사용금액을 차감후 계산하는 경우
    if (OrderHandler.buy.isPointApplyCouponDiscount == true) {
        OrderHandler.buy.totalEarnPoint = 0;
    }

    $.each(OrderHandler.getTotalItems(), function(i, item) {
        totalItemQuantities += item.quantity;
        OrderHandler.setItemAmountText(item);
    });

    // 배송비를 정책별로 합산한다. <상품 목록에 데이터 갱신용!!>
    let groupShippings = [];
    $.each(OrderHandler.buy.receivers, function(i, receiver) {
        $.each(receiver.shippingList, function(j, shipping) {

            let realShipping = Number(shipping.realShipping);
            let buyItems = {};

            if (shipping.singleShipping) {
                buyItems = shipping.buyItem;
            } else {
                buyItems = shipping.buyItems[0];
            }

            let isSet = false;
            if (groupShippings.length > 0) {
                $.each(groupShippings, function(j, tempShipping) {
                    if (tempShipping.shippingSequence == shipping.shippingSequence) {
                        groupShippings[j].realShipping += realShipping;
                        isSet = true;
                    }
                });
            }

            if (isSet == false) {
                let temp = {
                    'shippingSequence'		: shipping.shippingSequence,
                    'realShipping'			: realShipping,
                    'shippingPaymentType'	: shipping.shippingPaymentType,
                    'buyItems'              : buyItems
                };

                groupShippings.push(temp);
            }
        });
    });

    for (let i=0;i<groupShippings.length;i++) {
        let shipping = groupShippings[i];

        let buyItem = shipping.buyItems;
        let itemPrcie = (buyItem.saleAmount * buyItem.quantity) - buyItem.discountAmount;
    }

    let totalItemDiscountAmount = OrderHandler.buy.totalItemDiscountAmount;
    let totalUserLevelDiscountAmount = OrderHandler.buy.totalUserLevelDiscountAmount;
    let totalItemCouponDiscountAmount = OrderHandler.buy.totalItemCouponDiscountAmount;
    let totalCartCouponDiscountAmount = OrderHandler.buy.totalCartCouponDiscountAmount;

    let totalPointDiscountAmount = OrderHandler.buy.totalPointDiscountAmount;

    let totalShippingCouponDiscountAmount = OrderHandler.buy.totalShippingCouponDiscountAmount;
    let totalSetDiscountAmount = OrderHandler.buy.totalSetDiscountAmount;

    let totalCouponDiscountAmount = totalItemCouponDiscountAmount + totalCartCouponDiscountAmount;
    let totalDiscountAmount = totalItemDiscountAmount + totalUserLevelDiscountAmount + totalItemCouponDiscountAmount + totalCartCouponDiscountAmount + totalPointDiscountAmount + totalShippingCouponDiscountAmount + totalSetDiscountAmount;

    // 전체 상품 금액
    $('.op-total-item-sale-amount-text').html($saleson.core.formatNumber(OrderHandler.buy.totalItemPrice) + unit);

    // 전체 쿠폰 할인 금액
    //$('.totalCouponDiscountAmountText').val($saleson.core.formatNumber(totalCouponDiscountAmount) + unit);

    // 상품 쿠폰 할인 금액
    $('.totalItemCouponDiscountAmountText').html($saleson.core.formatNumber(totalItemCouponDiscountAmount) + unit);

    // 총 적립 금액
    $('.op-earn-point-text').html($saleson.core.formatNumber(OrderHandler.buy.totalEarnPoint) + " P");

    // 총 배송비
    $('.op-total-delivery-charge-text').html( $saleson.core.formatNumber(OrderHandler.buy.totalShippingAmount) + unit);

    // 결제금액 계산
    OrderHandler.setOrderPayAmount(isClear);
}



/**
 * 상품 금액 View처리
 */
OrderHandler.setItemAmountText = (item) => {

    let itemCouponDiscountAmountText = "0";
    let $itemCouponUsedArea = $('.itemCouponUsedArea-' + item.itemSequence);

    $itemCouponUsedArea.html("");
    if (item.couponDiscountAmount > 0) {
        itemCouponDiscountAmountText = "-" + $saleson.core.formatNumber(item.couponDiscountAmount);

        // SKC 쿠폰 사용 아이콘
        $itemCouponUsedArea.html("쿠폰적용완료");
    } else {
        $itemCouponUsedArea.html("");
    }

    // 상품 토탈 할인 금액 (스팟, 즉시, 쿠폰)
    let itemDiscountAmount = item.discountAmount;
    if (item.couponDiscountAmount > 0) {
        itemDiscountAmount += item.couponDiscountAmount
    }
    let itemDiscountAmountText = $saleson.core.formatNumber(itemDiscountAmount) + "원";

    // 쿠폰 할인 금액
    $('.itemCouponDiscountAmountText-' + item.itemSequence).html(itemCouponDiscountAmountText);
    $('.itemDiscountAmountText-' + item.itemSequence).html(itemDiscountAmountText);
    $('.itemPayAmountText-' + item.itemSequence).html($saleson.core.formatNumber(item.saleAmount));


    // 포인트 금액을 반영하는 경우
    if (item.isPointApplyCouponDiscount == true) {
        let itemEarnPoint = 0;

        // 기본 포인트
        if (Number(item.point) > 0) {
            if (item.pointType == '1') {

                itemEarnPoint += Math.floor(Number(item.sumPrice - item.couponDiscountPrice) * (Number(item.point) / 100));
            } else {
                // CJH 2016.11.12 금액으로 지정되어있으면?
            }
        }

        // 회원 포인트
        if (Number(item.userLevelPointRate > 0)) {
            itemEarnPoint += Math.floor(Number(item.sumPrice - item.couponDiscountPrice) * (Number(item.userLevelPointRate) / 100));
        }

        OrderHandler.buy.totalEarnPoint += Number(itemEarnPoint * item.quantity);
    }
}



OrderHandler.setSnsInfo = async () => {
    const api = $saleson.api;
    let url = '/api/auth/sns-info';

    try {
        let {data} = await api.get(url);

        if (data.snsFlag) {
            OrderHandler.isSns = data.snsFlag;
        }
    } catch(error) {
        console.error(error)
    }
}

OrderHandler.getTotalItems = () => {
    let tempItems = [];
    $.each(OrderHandler.buy.receivers, function(i, receiver) {
        $.each(receiver.shippingList, function(j, shipping) {
            if (shipping.singleShipping) {

                let quantity = shipping.buyItem.quantity;

                let isSet = false;
                if (tempItems.length > 0) {
                    $.each(tempItems, function(z, tempItem){
                        if (tempItem.itemSequence == shipping.buyItem.itemSequence) {

                            quantity = Number(quantity) + Number(tempItem.quantity);

                            tempItems[z] = {
                                'itemSequence'					: tempItem.itemSequence,
                                'couponDiscountPrice'			: tempItem.couponDiscountPrice,
                                'couponDiscountAmount'			: Number(tempItem.couponDiscountAmount),
                                'quantity'						: quantity,
                                'beforeDiscountAmount'			: Number(tempItem.sumPrice) * quantity,
                                'saleAmount'					: (Number(tempItem.sumPrice) * quantity) - (Number(tempItem.couponDiscountAmount)),
                                'sumPrice'						: tempItem.sumPrice,
                                'itemName'						: tempItem.itemName,
                                'itemUserCode'					: tempItem.itemUserCode,
                                'optionText'					: tempItem.optionText,
                                'itemImageSrc'					: tempItem.itemImageSrc,
                                'shipmentGroupType'				: tempItem.shipmentGroupType,
                                'isPointApplyCouponDiscount'	: tempItem.isPointApplyCouponDiscount,
                                'pointType'						: tempItem.pointType,
                                'point'							: tempItem.point,
                                'userLevelPointRate'			: tempItem.userLevelPointRate,

                                'itemSaleAmount'				: tempItem.itemSaleAmount,
                                'baseAmountForShipping'			: tempItem.baseAmountForShipping,
                                'discountAmount'				: tempItem.discountAmount,
                                'itemDiscountAmount'			: tempItem.itemDiscountAmount,
                                'userLevelDiscountAmount'		: tempItem.userLevelDiscountAmount
                            };

                            isSet = true;
                        }
                    });
                }

                if (isSet == false) {
                    let tempItem = {
                        'itemSequence'					: shipping.buyItem.itemSequence,
                        'couponDiscountPrice'			: shipping.buyItem.couponDiscountPrice,
                        'couponDiscountAmount'			: Number(shipping.buyItem.couponDiscountAmount),
                        'quantity'						: quantity,
                        'beforeDiscountAmount'			: Number(shipping.buyItem.sumPrice) * quantity,
                        'saleAmount'					: (Number(shipping.buyItem.sumPrice) * quantity) - (Number(shipping.buyItem.couponDiscountAmount)),
                        'sumPrice'						: shipping.buyItem.sumPrice,
                        'itemName'						: shipping.buyItem.itemName,
                        'itemUserCode'					: shipping.buyItem.itemUserCode,
                        'optionText'					: shipping.buyItem.optionText,
                        'itemImageSrc'					: shipping.buyItem.itemImageSrc,
                        'shipmentGroupType'				: shipping.buyItem.shipmentGroupType,
                        'isPointApplyCouponDiscount'	: shipping.buyItem.isPointApplyCouponDiscount,
                        'pointType'						: shipping.buyItem.pointType,
                        'point'							: shipping.buyItem.point,
                        'userLevelPointRate'			: shipping.buyItem.userLevelPointRate,

                        'itemSaleAmount'				: shipping.buyItem.itemSaleAmount,
                        'baseAmountForShipping'			: shipping.buyItem.baseAmountForShipping,
                        'discountAmount'				: shipping.buyItem.discountAmount,
                        'itemDiscountAmount'			: shipping.itemDiscountAmount,
                        'userLevelDiscountAmount'		: shipping.userLevelDiscountAmount,


                    };

                    tempItems.push(tempItem);
                }



            } else {
                $.each(shipping.buyItems, function(z, item){
                    let quantity = item.quantity;

                    let isSet = false;
                    if (tempItems.length > 0) {
                        $.each(tempItems, function(d, tempItem){
                            if (tempItem.itemSequence == item.itemSequence) {

                                quantity = Number(quantity) + Number(tempItem.quantity);
                                tempItems[d] = {
                                    'itemSequence'					: tempItem.itemSequence,
                                    'couponDiscountPrice'			: tempItem.couponDiscountPrice,
                                    'couponDiscountAmount'			: Number(tempItem.couponDiscountAmount),
                                    'quantity'						: quantity,
                                    'beforeDiscountAmount'			: Number(tempItem.sumPrice) * quantity,
                                    'saleAmount'					: (Number(tempItem.sumPrice) * quantity) - (Number(tempItem.couponDiscountAmount)),
                                    'sumPrice'						: tempItem.sumPrice,
                                    'itemName'						: tempItem.itemName,
                                    'itemUserCode'					: tempItem.itemUserCode,
                                    'optionText'					: tempItem.optionText,
                                    'itemImageSrc'					: tempItem.itemImageSrc,
                                    'shipmentGroupType'				: tempItem.shipmentGroupType,
                                    'isPointApplyCouponDiscount'	: tempItem.isPointApplyCouponDiscount,
                                    'pointType'						: tempItem.pointType,
                                    'point'							: tempItem.point,
                                    'userLevelPointRate'			: tempItem.userLevelPointRate,

                                    'itemSaleAmount'				: tempItem.itemSaleAmount,
                                    'baseAmountForShipping'			: tempItem.baseAmountForShipping,
                                    'discountAmount'				: tempItem.discountAmount,
                                    'itemDiscountAmount'			: tempItem.itemDiscountAmount,
                                    'userLevelDiscountAmount'		: tempItem.userLevelDiscountAmount
                                }

                                isSet = true;
                            }
                        });
                    }

                    if (isSet == false) {
                        let tempItem = {
                            'itemSequence'					: item.itemSequence,
                            'couponDiscountPrice'			: item.couponDiscountPrice,
                            'couponDiscountAmount'			: Number(item.couponDiscountAmount),
                            'quantity'						: quantity,
                            'beforeDiscountAmount'			: Number(item.sumPrice) * quantity,
                            'saleAmount'					: (Number(item.sumPrice) * quantity) - (Number(item.couponDiscountAmount)),
                            'sumPrice'						: item.sumPrice,
                            'itemName'						: item.itemName,
                            'itemUserCode'					: item.itemUserCode,
                            'optionText'					: item.optionText,
                            'itemImageSrc'					: item.itemImageSrc,
                            'shipmentGroupType'				: item.shipmentGroupType,
                            'isPointApplyCouponDiscount'	: item.isPointApplyCouponDiscount,
                            'pointType'						: item.pointType,
                            'point'							: item.point,
                            'userLevelPointRate'			: item.userLevelPointRate,

                            'itemSaleAmount'				: item.itemSaleAmount,
                            'baseAmountForShipping'			: item.baseAmountForShipping,
                            'discountAmount'				: item.discountAmount,
                            'itemDiscountAmount'			: item.itemDiscountAmount,
                            'userLevelDiscountAmount'		: item.userLevelDiscountAmount
                        }

                        tempItems.push(tempItem);
                    }
                });
            }
        });
    });

    return tempItems;
}

OrderHandler.setPaymentType = () => {

}

OrderHandler.getApprovalType = (array, type) => {
    let approvalType = "";
    $.each(array, function(i, key){
        if (key == type) {
            approvalType = key;
            return true;
        }
    });

    return (approvalType == "" ? false : true);
}

OrderHandler.setOrderPayAmountClear = () => {
    $('input.op-order-payAmounts').val(0);
    $('input.op-default-payment').val(OrderHandler.buy.orderPayAmount);
}

OrderHandler.setOrderPayAmount = (isClear) => {

    let unit = '원';
    let point = OrderHandler.buy.totalPointDiscountAmount;

    let orderPayAmount = OrderHandler.buy.totalItemSaleAmount + OrderHandler.buy.totalShippingAmount - OrderHandler.buy.totalCartCouponDiscountAmount - point;
    OrderHandler.buy.orderPayAmount = orderPayAmount;

    // 전체 결제 금애
    $('.op-order-pay-amount-text').not('input').html($saleson.core.formatNumber(orderPayAmount) + unit);

    if (isClear == true) {
        OrderHandler.setOrderPayAmountClear();
    }

    $('input[name="orderPrice.totalItemSaleAmount"]').val(OrderHandler.buy.totalItemSaleAmount);
    $('input[name="orderPrice.totalItemCouponDiscountAmount"]').val(OrderHandler.buy.totalItemCouponDiscountAmount);
    $('input[name="orderPrice.totalCartCouponDiscountAmount"]').val(OrderHandler.buy.totalCartCouponDiscountAmount);
    $('input[name="orderPrice.totalPointDiscountAmount"]').val(point);

    $('input[name="orderPrice.totalUserLevelDiscountAmount"]').val(OrderHandler.buy.totalUserLevelDiscountAmount);

    // 실제 마일리지 사용액
    $('input[name="buyPayments[\'point\'].amount"]').val(point);

    $('input[name="orderPrice.totalShippingAmount"]').val(OrderHandler.buy.totalShippingAmount);
    $('input[name="orderPrice.orderPayAmount"]').val(orderPayAmount);

    // 계산된 포인트
    $('.op-total-point-discount-amount-text').html( $saleson.core.formatNumber(point) + ' P');
    $('.expected-deducation-point').val(point);
    $('.point-possession').html($saleson.core.formatNumber(OrderHandler.buy.userTotalPoint - point) + ' P')
}

OrderHandler.setCouponDiscountAmount = (itemCoupons, addItemCoupons, cartCoupons) => {
    try {

        // [SKC] 2017-09-07. 쿠폰 적용 시 포인트 할인금액을 초기화
        // 포인트 적용 후 쿠폰적용시 결제 금액이 마이너스가 나오는 경우가 있음..
        $('input#retentionPointUseAll').prop('checked', false);
        $('.op-total-point-discount-amount-text').val(0);

        // 선택해제
        $('.use-all-point').prop('checked', false);
        OrderHandler.pointUsed(0);


        // 복합 배송 설정때 쿠폰 사용 할인금액을 각각 설정하기 위함..
        OrderHandler.useItemCoupons = itemCoupons;
        OrderHandler.useAddItemCoupons = itemCoupons;
        OrderHandler.useCartCoupons = cartCoupons;

        let couponInputs = "";

        //상품 쿠폰 할인액
        let totalItemCouponDiscountAmount = 0;

        let totalItemSaleAmount = 0;
        let totalItemDiscountAmount = 0;

        // 전체 상품쿠폰 할인금액 초기화
        OrderHandler.buy.totalItemCouponDiscountAmount = 0;

        let couponKeys = [];
        $.each(OrderHandler.buy.receivers, function(i, receiver){
            $.each(receiver.shippingList, function(j, shipping) {
                if (shipping.singleShipping) {

                    shipping.buyItem.saleAmount = shipping.buyItem.beforeDiscountAmount;
                    shipping.buyItem.couponDiscountAmount = 0;
                    shipping.buyItem.couponDiscountPrice = 0;

                    let key = OrderHandler.setItemCouponDiscountAmount(itemCoupons, shipping.buyItem, receiver.shippingIndex);

                    if (key != '') {
                        var isInsert = true;
                        for(var z = 0; z < couponKeys.length; z++) {
                            if (couponKeys[z] == key) {
                                isInsert = false;
                            }
                        }

                        if (isInsert) {
                            couponKeys.push(key);
                        }
                    }

                    key = OrderHandler.setItemCouponDiscountAmount(addItemCoupons, shipping.buyItem, receiver.shippingIndex);
                    if (key != '') {
                        var isInsert = true;
                        for(var z = 0; z < couponKeys.length; z++) {
                            if (couponKeys[z] == key) {
                                isInsert = false;
                            }
                        }

                        if (isInsert) {
                            couponKeys.push(key);
                        }
                    }

                    totalItemSaleAmount += shipping.buyItem.saleAmount;
                    totalItemCouponDiscountAmount += shipping.buyItem.couponDiscountAmount;
                } else {
                    $.each(shipping.buyItems, function(z, item) {

                        item.saleAmount = item.beforeDiscountAmount;
                        item.couponDiscountAmount = 0;
                        item.couponDiscountPrice = 0;

                        let key = OrderHandler.setItemCouponDiscountAmount(itemCoupons, item, receiver.shippingIndex);

                        if (key != '') {
                            let isInsert = true;
                            for(let h = 0; h < couponKeys.length; h++) {
                                if (couponKeys[h] == key) {
                                    isInsert = false;
                                }
                            }

                            if (isInsert) {
                                couponKeys.push(key);
                            }
                        }

                        key = OrderHandler.setItemCouponDiscountAmount(addItemCoupons, item, receiver.shippingIndex);
                        if (key != '') {
                            let isInsert = true;
                            for(let h = 0; h < couponKeys.length; h++) {
                                if (couponKeys[h] == key) {
                                    isInsert = false;
                                }
                            }

                            if (isInsert) {
                                couponKeys.push(key);
                            }
                        }

                        totalItemSaleAmount += item.saleAmount;
                        totalItemCouponDiscountAmount += item.couponDiscountAmount;
                    });
                }
            });
        });

        if (couponKeys.length > 0) {
            $.each(couponKeys, function(key, value){
                couponInputs += '<input type="hidden" name="useCouponKeys" value="'+ value +'" class="useCoupon" />';
            });
        }

        OrderHandler.buy.totalItemCouponDiscountAmount = totalItemCouponDiscountAmount;
        OrderHandler.buy.totalItemSaleAmount = totalItemSaleAmount;

        // 사용자가 상품 쿠폰을 사용하면 배송료가 변경될수 있음.
        OrderHandler.setShippingAmount();

        let totalCartCouponDiscountAmount = 0;
        if (cartCoupons.length > 0) {
            for (let i = 0; i < cartCoupons.length; i++) {
                let coupon = cartCoupons[i];
                totalCartCouponDiscountAmount = totalCartCouponDiscountAmount + coupon.discountAmount;
                couponInputs += '<input type="hidden" name="useCouponKeys" value="'+ coupon.key +'" class="useCoupon" />';
            }
        }

        $('.op-coupon-hide-field-area').html(couponInputs);


        OrderHandler.setAmountText();

    } catch(e) {
        alert('쿠폰 사용처리도중 에러가 발생하였습니다.');
        location.reload();
    }
}



/**
 * 상품쿠폰 금액 Set
 */
OrderHandler.setItemCouponDiscountAmount = (itemCoupons, item, shippingIndex) => {
     let beforeDiscountAmount = item.beforeDiscountAmount;
     let itemSequence = item.itemSequence;

     //상품쿠폰 사용 처리
     let coupon = OrderHandler.getItemCoupon(itemCoupons, itemSequence, shippingIndex);

     let couponKey = '';
    if (coupon != null) {

        item.couponDiscountPrice += coupon.discountPrice;
        item.couponDiscountAmount += coupon.discountAmount;

        item.saleAmount = item.beforeDiscountAmount - item.couponDiscountAmount;
        OrderHandler.buy.totalItemCouponDiscountAmount = item.couponDiscountAmount;
        couponKey = coupon.key;
    }

    return couponKey;
}


/**
 * 상품별 사용 쿠폰 리턴
 */
OrderHandler.getItemCoupon = (itemCoupons, itemSequence, shippingIndex) => {
    if (itemCoupons.length > 0) {
        for(i = 0; i < itemCoupons.length; i++) {
            let coupon = itemCoupons[i];

            if (coupon.itemSequence == itemSequence && coupon.shippingIndex == shippingIndex) {
                return coupon;
            }
        }
    }

    return null;
}


OrderHandler.setGroupShippingAmount = () => {
    $.each(OrderHandler.buy.receivers, function(i, receiver) {
        let shippingList = receiver.shippingList;

        $.each(shippingList, (shippingIndex, shipping) => {
            let shippingSequence = shipping.shippingSequence;
            let realShipping = shipping.realShipping;
            let totalItemPrice = $('.total-item-price-'+shippingSequence).data('price')

            $('.shipping-amount-text-'+shippingSequence).each(function () {
                $(this).html($saleson.core.formatNumber(realShipping));
            });

            $('.group-order-price-text-'+shippingSequence).each(function (index) {
                $(this).html($saleson.core.formatNumber(totalItemPrice + realShipping));
            });

        })
    })
}