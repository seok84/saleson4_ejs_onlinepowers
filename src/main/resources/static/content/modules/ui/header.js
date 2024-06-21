$(() => {
    const SEARCH_EXPIRES_DAYS = 1;

    const $searchingArea = $('.searching-area');
    const $headerSearchForm = $('#header-search-form');
    const $searchingList = $('.searching-list');

    async function setSearchInfo(data = {}) {
        try {

            const keywords = data.keywords;
            const recommend = data.recommend;

            if (typeof keywords !== undefined && keywords != null && keywords.length > 0) {
                const $keyword = $searchingList.find('.list-popular ol');
                $keyword.empty();

                let index = 1;
                for (const word of keywords) {
                    $keyword.append(`<li><em class="number">${index}</em><a href="/item/result?query=${word.keyword}" class="text">${word.keyword}</a></li>`);
                    index++;
                }
            }

            if (typeof recommend !== undefined && recommend != null) {
                $headerSearchForm.find('input[name=query]').attr('placeholder', recommend.content);
                $searchingArea.data('recommend-link', recommend.link).data('recommend-blank-flag', recommend.blankFlag);
            }
        } catch (e) {
        }
    }

    async function setQickinfo(data = {cartQuantity: 0, wishlistCount: 0}) {
        try {

            const cartQuantity = Number(data.cartQuantity);
            const wishlistCount = Number(data.wishlistCount);

            $('#aside-wishlist-count').data('count', wishlistCount);
            $('#aside-wishlist-count').text($saleson.core.formatNumber(wishlistCount));
            $('#header-cart-quantity').text($saleson.core.formatNumber(cartQuantity));
        } catch (e) {
        }
    }

    async function setGnb(list = []) {
        try {

            if (typeof list !== undefined && list != null && list.length > 0) {
                for (const gnb of list) {
                    $('.quick-link .link-area .swiper-wrapper')
                        .append(`<a href="${gnb.target}" class="swiper-slide">${gnb.title}</a>`)
                }

                salesOnUI.mGnbSwiper().init(); // mobile gnb swiper init
            }
        } catch (e) {
        }
    }

    async function setTopBanner(storeList = []) {


        const cookieKey = 'TOP_BANNER_COOKIE';
        const $topBanner = $('#top-banner');
        const valid = $saleson.store.cookie.get(cookieKey);

        if ((typeof valid === undefined || valid == null || valid == '')
            && $topBanner.length > 0) {

            try {
                const list = storeList;
                let banner = '';

                if (typeof list !== undefined && list != null) {
                    if (list.length == 2) {
                        banner = `<div class="flex type1">
    <div class="bg-left" style="background: ${list[0].color};"></div>
    <div class="bg-right" style="background: ${list[1].color};"></div>
    <a href="${list[0].url}"><img src="${list[0].image}" alt="${list[0].content}" onerror="errorImage(this)"></a>
    <a href="${list[1].url}"><img src="${list[1].image}" alt="${list[1].content}" onerror="errorImage(this)"></a>
    <button type="button" class="top-banner-close">닫기</button>
</div>`;
                    } else if (list.length == 1) {
                        banner = `<div class="flex type2">
    <div class="bg-left" style="background: ${list[0].color};"></div>
    <div class="bg-right" style="background: ${list[0].color};"></div>
    <button type="button" class="top-banner-close white">닫기</button>
    <a href="${list[0].url}"><img src="${list[0].image}" alt="${list[0].content}" onerror="errorImage(this)"></a>
</div>`;
                    }

                }

                $topBanner.find('section').append(banner);

                $topBanner.on('click', '.top-banner-close', function (e) {
                    e.preventDefault();

                    $topBanner.closest('.fixed-header').toggleClass('hide-banner');
                    const expires = new Date();
                    expires.setDate(expires.getDate() + 1);
                    $saleson.store.cookie.set(cookieKey, 'close', {'expires': expires});
                });
            } catch (e) {
            }
        }
    }

    async function setHeader() {
        try {
            const [gnb, searchInfo, quickInfo, topBanner] = await Promise.all([
                $saleson.api.get('/api/common/gnb-list'),
                $saleson.api.get('/api/search/info'),
                $saleson.api.get('/api/common/quick-info'),
                $saleson.api.get('/api/display/top-banner')
            ]);

            setGnb(gnb.data.list);
            setSearchInfo(searchInfo.data);
            setQickinfo(quickInfo.data);
            setTopBanner(topBanner.data.list);

        } catch (e) {
            console.log('header error', e);
        }
    }

    setHeader();

    $headerSearchForm.validator(function () {

        const query = $headerSearchForm.find('input[name=query]').val();

        if (query != '') {
            $saleson.handler.addLatelyValue($saleson.const.const.LATELY_SEARCH, query, {
                limit: 10,
                expiresDays: SEARCH_EXPIRES_DAYS
            });
            $saleson.core.redirect('/item/result?query=' + query);
        } else {
            const data = $searchingArea.data();
            try {
                const link = data.recommendLink;
                if (typeof link !== undefined && link != null && link != '') {
                    if (data.recommendBlankFlag) {
                        window.open(link);
                    } else {
                        $saleson.core.redirect(link);
                    }
                }
            } catch (e) {
            }
        }

        return false;
    });


    $searchingList.on('click', '.delete-all', function (e) {
        e.preventDefault();
        $saleson.store.cookie.set($saleson.const.const.LATELY_SEARCH, '');

        $searchingList.find('.list-recent ul li').remove();
    });

    $searchingList.on('click', '.delete', function (e) {
        e.preventDefault();

        const key = $saleson.const.const.LATELY_SEARCH;

        let lately = $saleson.store.cookie.get(key);
        const value = $(this).data('word') + '';

        if (typeof lately !== undefined && lately != null && lately != '') {
            lately = decodeURIComponent(lately);
            const array = lately.split(',');
            let index = array.indexOf(value);

            array.splice(index, 1);

            const expires = new Date();
            expires.setDate(expires.getDate() + SEARCH_EXPIRES_DAYS);
            $saleson.store.cookie.set(key, array.join(","), {'expires': expires})
        }

        $(this).closest('li').remove();
    });

    // 방문통계
    $saleson.handler.visitEventHandler();

});