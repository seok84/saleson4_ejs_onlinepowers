
const clearTooltips = () => {
    const tooltips = $('form').find('.invalid');

    if (typeof tooltips != 'undefined' && tooltips != null && tooltips.length > 0) {
        for (let i = 0; i < tooltips.length; i++) {
            let maintainFlag = false;
            const tooltip = tooltips.eq(i);

            try {
                const fromGroup = tooltip.closest('.form-line');

                if (fromGroup.length > 0
                    && !fromGroup.hasClass('is-invalid')) {

                    maintainFlag = true;
                }
            } catch (e) {
                maintainFlag = false;
            }

            if (!maintainFlag) {
                $saleson.core.tooltip(tooltip).hide();
            }
        }
    }
};

export default {
    formEventHandler() {
        $('form').on('keydown', 'input, textarea', function () {
            clearTooltips();
        });

        $('form').on('change', 'textarea, input, input:checkbox, input:radio', function () {
            clearTooltips();
        });

        $('form').find('.feedback.invalid').hide();
    },
    validFiles(files = [], extensions = [], fileSize = 0) {

        const emptys = [null, undefined, ''];

        for (const file of files) {

            if (emptys.includes(file)) {
                $saleson.core.alert('파일정보가 없습니다.');
                return false;
            }

            const fileName = file.name;

            if (emptys.includes(fileName)) {
                $saleson.core.alert('파일명이 없습니다.');
                return false;
            }

            const initSize = 1 * 1024 * 1024;
            if (file.size > fileSize * initSize) {
                $saleson.core.alert('파일크기는 ' + fileSize + 'MB 이내로 등록 가능합니다.');
                return false;
            }

            const fileExt = fileName.split('.').pop().toLowerCase();
            if (!extensions.includes(fileExt)) {
                $saleson.core.alert( '['+extensions.join(', ')+']'+ '만 등록 가능합니다.');
                return false;
            }
        }

        return true;
    },

    async addToWishlist(itemId, $selector) {
        try {
            const loggedIn = $saleson.auth.loggedIn();

            if (!loggedIn) {
                $saleson.core.confirm('로그인 페이지로 이동하시겠습니까?', () => {
                    const target = $saleson.core.requestContext.requestUri;
                    $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
                })

                return false;
            }

            const api = $saleson.api;

            const response = await api.post('/api/wishlist', {itemId: itemId});
            try {
                const statusType = response.data.addEventType;

                let count = Number($('#aside-wishlist-count').data('count'));

                let message = $saleson.const.message.REMOVE_TO_WISHLIST_MESSAGE;
                $selector.removeClass('active');

                if ('ADD' == statusType) {
                    // wishlistFlag Fales 처리
                    // $selector.addClass('active');
                    message = $saleson.const.message.ADD_TO_WISHLIST_MESSAGE;
                    count++;

                    try {
                        $saleson.analytics.addToWishlist(response.data.itemUserCode);
                    } catch (e) {}

                } else {
                    count--;
                }

                $('#aside-wishlist-count').data('count', count);
                $('#aside-wishlist-count').text($saleson.core.formatNumber(count));

                $saleson.core.toast(message);
            } catch (e) {}

        } catch (e) {
            $saleson.core.alert('관심상품 추가/삭제시 오류가 발생했습니다.');
        }
    },
    async addToCart(itemId, orderMinQuantity, nonmemberOrderType) {
        try {

            const target = $saleson.core.requestContext.requestUri;
            const quantity = Number(orderMinQuantity) > 1 ? Number(orderMinQuantity) : 1;
            const loggedIn = $saleson.auth.loggedIn();

            if (!loggedIn && nonmemberOrderType == '2') {
                $saleson.core.confirm('회원만 구매가 가능합니다. 로그인 페이지로 이동하시겠습니까?', () => {
                    $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
                })

                return false;
            }

            const param = {
                'arrayRequiredItems': [itemId + '||' + quantity + '||']
            };

            const api = $saleson.api;

            await api.post('/api/cart/add', param);

            try {
                api.get('/api/common/cart-info')
                    .then((response) => {
                        const data = response.data;
                        $('#header-cart-quantity').text($saleson.core.formatNumber(data.cartQuantity));
                    });
            } catch (e) {
                console.log(e)
            }

            try {
                $saleson.analytics.addToCart(param);
            } catch (e) {}


            $saleson.core.toast('장바구니에 추가 되었습니다.');
        } catch (e) {
            $saleson.core.alert('장바구니 추가시 오류가 발생했습니다.');
        }
    },
    async getPopup(param, url, target, error, callback){
        const callbackToCheck = [null, undefined, ''];
        $.ajax({
            type :"GET",
            async : true,
            url : url,
            data : param,
            dataType : "html",
            success: function(response, status, request) {
                if (callbackToCheck.includes(callback)){
                    $(target).html(response);
                    salesOnUI.modal().show(target);
                } else {
                    callback(response);
                }
            },
            error:function(response,status,request){
                if (callbackToCheck.includes(error)){
                    console.log(response);
                } else {
                    error(response);
                }
            }
        });
    },
    async copyText(value) {
        const temp = document.createElement('input');
        temp.value = value;
        document.body.appendChild(temp);

        temp.select();
        document.execCommand('copy');
        document.body.removeChild(temp);

        $saleson.core.toast('클립보드에 복사 되었습니다.')
    },
    addLatelyValue: function (key, value, option = {limit:10, expiresDays:1}, callback) {
        const cookieValue = $saleson.store.cookie.get(key);
        const limit = option.limit;
        const expiresDays = option.expiresDays;

        let lately = [];

        if (typeof cookieValue !== undefined && cookieValue != null && cookieValue.length > 0) {
            lately = decodeURIComponent(cookieValue);
            lately = lately.split(",");
        } else {
            lately = [];
        }

        const pos = lately.indexOf(value);

        if (pos < 0) {
            lately.unshift(value);
            if (lately.length > limit) {
                const subLength = lately.length - limit;
                lately.splice(limit, subLength);
            }
        } else {
            lately.splice(pos, 1);
            lately.unshift(value);
        }

        const expires = new Date();
        expires.setDate(expires.getDate() + expiresDays);
        $saleson.store.cookie.set(key, lately.join(","), {'expires': expires});

        if ($saleson.core.isFunction(callback)) {
            callback(lately);
        }

    },
    startSpotItemCountdown($list) {
        try {

            if ($list.length > 0) {
                $list.each(function (idx) {
                    const $time = $list.eq(idx);
                    const time = $time.data('spot-countdown-date');

                    if (typeof time !== undefined && time != null && time != '') {
                        const countDownTime = new Date(time).getTime();

                        let interval = setInterval(function () {

                            const now = new Date().getTime();
                            const distance = countDownTime - now;

                            const day = Math.floor(distance / (1000 * 60 * 60 * 24));

                            $time.find('.timer-day').text(day + 'Day');
                            $time.find('.timer-time').text(countdownTime(distance));

                            if (distance < 0) {
                                clearInterval(interval);
                            }
                        }, 1000);

                    }
                });

                const countdownTime = (distance = 0) => {
                    const hour = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    const minute = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    const second = Math.floor((distance % (1000 * 60)) / 1000);

                    return padZero(hour) + ' : ' + padZero(minute) + ' : ' + padZero(second);
                }

                const padZero = (value = 0) => {

                    if (value < 10) {
                        return '0' + value;
                    }

                    return value + '';
                }
            }

        } catch (e) {

        }
    },
    itemEventHandler(parentSelector, callback) {
        const $parent = $(parentSelector);

        if ($parent.length > 0) {

            $parent.off('click', '.user-basket')
                .on('click', '.user-basket', function (e) {
                    e.preventDefault();
                    const params = $(this).closest('.user-action').data();
                    $saleson.handler.addToCart(params.itemId, params.orderMinQuantity, params.nonmemberOrderType);
                });

            $parent.off('click', '.user-attention')
                .on('click', '.user-attention', function (e) {
                    e.preventDefault();
                    const $selector = $(this);
                    const params = $selector.closest('.user-action').data();
                    $saleson.handler.addToWishlist(params.itemId, $selector);
                });

            if ($saleson.core.isFunction(callback)) {
                callback($parent);
            }
        }
    },
    redirectItemHandler($selector) {
        $selector
            .off('click', '.redirect-item-view')
            .on('click', '.redirect-item-view', function (e) {
                e.preventDefault();
                const data = $selector.data();
                const $itemElement = $(this).closest('.item-element');
                const itemUserCode = $itemElement.data('item-user-code');

                if (data.analyticsFlag && itemUserCode != '') {

                    try {
                        $saleson.analytics.frontSelect($itemElement.find('.item-analytics-data'), data.listName, data.listId);
                    } catch (e) {}
                }

                $saleson.core.redirect('/item/'+itemUserCode);
            });
    },
    async visitEventHandler() {
        try {

            const key = 'IS_VISIT';

            let visit = $saleson.store.cookie.get(key);

            if (visit == null || visit === '') {

                const agent = navigator.userAgent;
                const referrer = document.referrer;
                const domain = $saleson.core.findDomain(referrer);
                let remoteAddr = '';

                try {
                    const ipResponse = await $saleson.api.$axios("https://checkip.amazonaws.com", {}, {});
                    remoteAddr = ipResponse.data;
                } catch (e) {}


                const param = {
                    'agent': agent,
                    'referer': referrer,
                    'browser': $saleson.core.getBrowser(agent),
                    'os': $saleson.core.getOs(agent),
                    'domain': domain,
                    'domainName': $saleson.core.getDomainName(domain),
                    'remoteAddr': remoteAddr,
                    'language': navigator.language
                }

                const visitResponse = await $saleson.api.post('/api/common/visit', param);

                if (visitResponse.data.status === 200) {

                    const expires = new Date();
                    expires.setDate(expires.getDate() + 1);
                    $saleson.store.cookie.set(key, '1', {'expires': expires})
                }

            }
        } catch (e) {
            console.log(e)
        }
    }
}