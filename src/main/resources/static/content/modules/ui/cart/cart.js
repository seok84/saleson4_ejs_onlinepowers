let ANALYTICS_ITEM_LIST = [];

$(function () {
    const message = $('#message').val();

    if (message) {
        $saleson.core.alert(message);
    }

    const $container = $('.item-list-container');

    $container.on('click', '.user-attention', function () {
        const $selector = $(this);
        const itemId = parseInt( $selector.data('item'));

        $saleson.handler.addToWishlist(itemId, $selector);
    });

    try {
        $saleson.analytics.cartView((items)=>{
            ANALYTICS_ITEM_LIST = JSON.parse(JSON.stringify(items));
        });
    }catch (e){}

    $container.on('click', '.circle-checkbox', function() {
        const $selector = $(this);

        if ($selector.find('.check-sold-out').length > 0) {
            $saleson.core.alert('해당 상품은 품절되었습니다. ');
            return false;
        }
    });


    // 첫 진입시 전체선택 활성화
    $("input[name=allCheck]").prop('checked',true);
    checkAll();

    calculateEventHandler();
});

/**
 * 메인 이동
 */
function goToMain() {
    $saleson.core.redirect($saleson.const.pages.INDEX);
}

/**
 * 전체 선택
 */
function checkAll() {
    let allCheck = $("input[name=allCheck]").prop('checked');

    const $mainCheckbox = $('.checkbox.main');
    const $subCheckboxes = $('.checkbox.sub');

    if (allCheck) {
        $mainCheckbox.prop("checked", true);

        Object.values($subCheckboxes).forEach(function(ele) {
            if(!$(ele).prop('disabled')) {
                ele.checked = true;
            }
        });
    } else {
        $mainCheckbox.prop("checked", false);
        $subCheckboxes.prop("checked", false);
    }

    calculateEventHandler();
}

/**
 * 메인 그룹 전체 선택
 */
function mainGroupCheck(sellerId) {
    const $mainCheckbox = $('.checkbox.main[data-group="' + sellerId + '"]');
    const $subCheckboxes = $('.checkbox.sub[data-group="' + sellerId + '"]');

    let isChecked = $mainCheckbox.prop("checked");

    if (isChecked) {
        Object.values($subCheckboxes).forEach(function(ele) {
            if(!$(ele).prop('disabled')) {
                ele.checked = true;
            }
        });
    } else {
        $subCheckboxes.prop("checked", false);
    }

    calculateEventHandler();
}

/**
 * 서브 그룹 체크박스 선택
 * ( 서브 그룹 체크박스중 하나라도 선택 ? 메인 체크박스 활성화 )
 */
function subGroupCheck(sellerId) {
    const $mainCheckbox = $('.checkbox.main[data-group="' + sellerId + '"]');
    const $subCheckboxes = $('.checkbox.sub[data-group="' + sellerId + '"]');

    let subCheckBoxIsChecked = false;

    $subCheckboxes.each((index, element) => {
        if ($(element).prop("checked")) {
            subCheckBoxIsChecked = true;
        }
    });

    if (subCheckBoxIsChecked) {
        $mainCheckbox.prop("checked", true);
    } else {
        $mainCheckbox.prop("checked", false);
    }

    calculateEventHandler();
}

/**
 * 상품 수량 값 변경
 */
function updateQuantityValue(target, type) {
    const $quantity = $(`#${target}_quantity`);
    const $quantityBox = $quantity.closest('.quantity-box');

    let currentQuantity = Number($quantity.val());
    currentQuantity = type ? (currentQuantity + 1) : (currentQuantity - 1);

    const maxQuantity = $quantityBox.data("maxQuantity");
    const minQuantity = $quantityBox.data("minQuantity");

    if (minQuantity > 0) {
        if (currentQuantity < minQuantity) {
            $saleson.core.alert("해당 상품의 최소 구매가능 수량은 " + minQuantity + "개 입니다.");
            return false;
        }
    }

    if (maxQuantity > 0) {
        if (currentQuantity > maxQuantity) {
            $saleson.core.alert("해당 상품의 최대 구매가능 수량은 " + maxQuantity + "개 입니다.");
            return false;
        }
    }

    $quantity.val(currentQuantity);
    calculateEventHandler();
}

/**
 * 상품 수량 변경
 */
function updateQuantity(target) {
    $saleson.core.confirm('상품의 수량을 변경하시겠습니까?',async () => {
        try {
            // 로딩바 심어주기
            let quantity = $(`#${target}_quantity`).val();

            let param = {
                cartId : target,
                quantity : quantity
            }

            const api = $saleson.api;

            const {data} = await api.post('/api/cart/update-quantity', param);

            if (data.status == 200) {

                try {
                    $saleson.analytics.changeQuantity(
                        ANALYTICS_ITEM_LIST,
                        target,
                        Number(quantity)
                    );
                } catch (e) {}


                location.reload();
            } else
                throw new Error();

        } catch (error) {
            $saleson.core.alert(error.response.data.message);
        }
    });
}

/**
 * 구성상품 팝업
 */
function getFreegiftItemPopupByCartId(cartId) {

    try {

        $saleson.handler.getPopup({}, `/cart/popup/${cartId}`, '.modal-product-detail');

    } catch (e) {
        $saleson.core.alert('클레임 팝업정보 요청 중 오류가 발생하였습니다.');
    }

}

/**
 * 주문서로 이동
 * 상품의 수량이 변경되었지만, 변경 버튼을 행하지 않을시 해당 액션은 막아놓기
 */
function executePaymentStep() {

    let changeFlag = false;

    $('.quantity-box').each((index, element) => {
        let quantity = $(element).find('input');

        let currentQuantity = quantity.val();
        let initQuantity = quantity.data('quantity');

        if (currentQuantity != initQuantity) {
            changeFlag = true;
        }
    })

    if (changeFlag) {
        $saleson.core.alert('수량 변경한 상품이 존재합니다.\n해당 상품의 수량 변경 버튼을 눌러주세요!');
        return false;
    }

    // 상품 수량
    let $availableItem = $('.checkbox:checked').map(function () {
        if (this.id != '') {
            return this.id;
        }
    }).get();

    if ($availableItem.length == 0) {
        $saleson.core.alert("구매할 상품을 선택해주세요");
        return false;
    }

    saveOrderItemTemp($availableItem, "상품의 수량을 확인해주세요.");
}

/**
 * 바로구매로 이동
 * 상품의 수량이 변경되었지만, 변경 버튼을 행하지 않을시 해당 액션은 막아놓기
 */
function executeDirectPurchase(target) {
    const $quantity = $(`#${target}_quantity`);

    let initQuantity = parseInt($quantity.data("quantity"));
    let currentQuantity = parseInt($quantity.val());

    // 같으면 이동
    if (initQuantity == currentQuantity) {
        let $availableItem = [target];
        saveOrderItemTemp($availableItem, "상품의 수량을 확인해주세요.");
    } else {
        $saleson.core.alert('수량 변경한 상품이 존재합니다.\n해당 상품의 수량 변경 버튼을 눌러주세요!');
        return false;
    }
}


/**
 * 상품 정보 저장
 */
async function saveOrderItemTemp($availableItem, message) {
    let isLogin = $('#isLogin').val();

    let cartIds = [];
    let isSuccess = true;
    let quantity = -1;

    for (let i = 0; i < $availableItem.length; i++) {
        quantity = parseInt(
            document.getElementById($availableItem[i] + '_quantity').value);
        if (quantity <= 0) {
            isSuccess = false;
        }
        cartIds[i] = $availableItem[i];
    }

    if (isSuccess == false) {
        $saleson.core.alert(message);	// 상품의 수량을 확인해주세요.
        return;
    }

    let params = {
        'cartIds': cartIds
    };

    try {

        const api = $saleson.api;
        let url = '/api/order/buy';

        const data = await api.post(url, params);

        if (data.status == 200) {
            //성공시
            url = isLogin == 'true' ? '/order/step1' : '/order/no-member';
            $saleson.core.redirect(url);
        } else
            throw new Error();

    } catch (error) {
        $saleson.core.alert(error.response.data.message);
    }

}

/**
 * 장바구니 상품 삭제 (단건)
 */
function deleteCartId(cartId) {
    $saleson.core.confirm('상품을 장바구니에서 삭제하시겠습니까?', () => {
        let cartIds = new Array();
        cartIds.push(cartId);

        let param = {
            'id' : cartIds
        }

        deleteAction(param);
    });
}


/**
 * 장바구니 선택 삭제
 */
function deleteCartIds() {
    $saleson.core.confirm('상품들을 장바구니에서 삭제하시겠습니까?',async () => {
        let cartIds = new Array();

        cartIds = $('.checkbox:checked').map(function () {
            if (this.id != '') {
                return this.id;
            }
        }).get();

        let param = {
            'id': cartIds
        }

        deleteAction(param);
    })
}


function deleteAction (param) {
    const api = $saleson.api;
    api.post('/api/cart/delete', param)
    .then((response) => {
        if (response.data.status == 200) {

            try {
                $saleson.analytics.removeFromCart(ANALYTICS_ITEM_LIST, cartIds)
            } catch (e) {}

            $saleson.core.reload();
        }
    })
    .catch(function(error) {
        $saleson.core.api.handleApiExeption(error);
    });
}

function calculateEventHandler() {

    try {
        const getCalculateObject = () => {
            return {
                item: 0,
                shipping: 0,
                discount:0,
                earnPoint:0,
                shippingType:''
            }
        };

        const appendMap = (map = {}, key='', data = {}, quantity = 0) => {
            const keys = Object.keys(map);
            const co = keys.includes(key) ? map[key] : getCalculateObject();
            const shippingType = data.shippingType.toString();

            co.item += Number(data.salePrice) * quantity;
            co.discount += Number(data.discountPrice) * quantity;
            co.earnPoint += Number(data.earnPoint) * quantity;
            co.shippingType = shippingType;


            let shipping = 0;
            const originShipping = Number(data.shipping);

            const shippingFreeAmount = Number(data.shippingFreeAmount);
            const shippingItemCount = Number(data.shippingItemCount);

            switch (shippingType) {
                case '2': // 판매자 조건부
                case '3': // 출고지 조건부
                case '4': // 상품 조건부
                    shipping = co.item >= shippingFreeAmount ? 0 : originShipping;
                    break;
                case '5': // 개당 배송비
                    let count = Math.floor(quantity / shippingItemCount);
                    count += quantity % shippingItemCount > 0 ? 1 : 0;

                    shipping = originShipping * count;
                    break;
                case '6': // 고정 배송비
                    shipping = co.shipping + originShipping;
                    break;
                default:
            }

            co.shipping = shipping;

            map[key] = co;
        }

        const $selected = $('.checkbox.sub:checked');
        const map = {};

        if ($selected.length > 0) {


            $selected.each(function (idx) {
                const $parent = $selected.eq(idx)
                    .closest('.product-info-group');
                const $info = $parent.find('.calculate-event');
                const quantity = Number($parent.find('input.quantity').val());
                const data = $info.data();

                // 데이터를 map 형식으로 merge
                let key = '';

                switch (data.shippingType.toString()) {
                    case '1': // 무료배송
                        key = 'freeShipping';
                        break;
                    case '2': // 판매자 조건부
                    case '3': // 출고지 조건부
                    case '4': // 상품 조건부
                    case '5': // 개당 배송비
                        key = data.shippingGroupType;
                        break;
                    case '6': // 고정 배송비
                        key = 'fixShipping';
                        break;
                    default:
                }

                appendMap(map, key, data, quantity);
            });
        }

        let itemAmount = 0;
        let shippingAmount = 0;
        let discountAmount = 0;
        let orderPayAmount = 0;
        let earnPoint = 0;

        const values = Object.values(map);

        if (typeof values != 'undefined' && values != null && values.length > 0) {
            values.forEach(co=>{
                itemAmount += co.item;
                shippingAmount += co.shipping;
                discountAmount += co.discount;
                earnPoint += co.earnPoint;
            });
        }

        orderPayAmount = itemAmount + shippingAmount - discountAmount;

        $('.total-item-amount').html(`${$saleson.core.formatNumber(itemAmount)}<b>원</b>`);
        $('.total-shipping-amount').html(`${$saleson.core.formatNumber(shippingAmount)}<b>원</b>`);
        $('.total-discount-amount').html(`- ${$saleson.core.formatNumber(discountAmount)}<b>원</b>`);
        $('.order-pay-amount').html(`${$saleson.core.formatNumber(orderPayAmount)}<b>원</b>`);
        $('.total-earn-point').html(`${$saleson.core.formatNumber(earnPoint)} P`);

    } catch (e) {
    }
}