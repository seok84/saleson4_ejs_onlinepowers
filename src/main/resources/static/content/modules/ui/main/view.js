const openWindowPopup = (popup = {}) => {

    const url = '/popup/' + popup.popupId;
    const popupName = 'main-popup-' + popup.popupId;
    const width = popup.width;
    const height = popup.height;
    const scrollbars = 'n';
    const xPosition = popup.leftPosition;
    const yPosition = popup.topPosition;

    let xP = 0, yP = 0, xC = 0, yC = 0, scr = 0, zero = 0, one = 1;
    let target = url == null || url == '' ? '' : url;
    let w = width == null || width == '' ? 400 : width;
    let h = height == null || height == '' ? 400 : height;

    if (parseInt(navigator.appVersion) >= 4) {
        xC = (screen.width - w) / 2;
        yC = (screen.height - h) / 2;
    }

    xP = xPosition == null || xPosition == 'c' ? xC : xPosition;
    yP = yPosition == null || yPosition == 'c' ? yC : yPosition;
    scr = scrollbars == null || scrollbars == 'n' ? 0 : scrollbars;

    const parameters = 'location=' + zero +
        ',menubar=' + zero +
        ',height=' + h +
        ',width=' + w +
        ',toolbar=' + zero +
        ',scrollbars=' + scr +
        ',status=' + zero +
        ',resizable=' + one +
        ',left=' + xP +
        ',screenX=' + xP +
        ',top=' + yP +
        ',screenY=' + yP;

    const newWin = window.open(target, popupName, parameters);

    if (newWin) {
        newWin.focus();
    }
};

const getLayerPopupTemplate = () => {
    return `<div class="modal show" id="popup-modal-{{popupId}}" style="{{popupStyle}}" data-cache-key="{{cacheKey}}">
        <div class="modal-wrap">
            <button class="modal-close">닫기</button>
            <div class="modal-header">
                알림
            </div>

            <div class="modal-body">
                <div class="content-wrap">
                    {{popupContent}}
                </div>
                <div class="content-footer">
                    <div class="check-area" style="cursor: pointer;">
                        <label class="checkbox"><input type="checkbox"><i></i></label>
                        <span>오늘 하루 이창을 열지 않음</span>
                    </div>
                    <button type="button" class="popup-close">닫기</button>
                </div>
            </div>
        </div>
    </div>`;
}

const openLayerPopup = ($popupArea, popup = {}) => {

    let template = getLayerPopupTemplate();

    const popupStyle = `position:absolute; left:${popup.leftPosition}px; top:${popup.topPosition}px; width:${popup.width}px; height:${popup.height};`;


    const imageLink = popup.imageLink;
    const popupImage = popup.popupImage;
    const content = popup.content;

    let popupContent = '';

    if (typeof imageLink !== 'undefined' && imageLink != null && imageLink != '') {
        popupContent += '<a href="' + imageLink + '">';
    }

    if (popupImage != null && typeof popupImage !== 'undefined' && popupImage != '') {

        popupContent += '<img src="' + popupImage + '" border="0" />';
    } else {
        popupContent += content;
    }

    if (typeof imageLink !== 'undefined' && imageLink != null && imageLink != '') {
        popupContent += '</a>';
    }

    template = template.replace(/{{popupId}}/g, popup.popupId)
        .replace(/{{popupStyle}}/g, popupStyle)
        .replace(/{{width}}/g, popup.width)
        .replace(/{{height}}/g, popup.height)
        .replace(/{{cacheKey}}/g, popup.cacheKey)
        .replace(/{{popupContent}}/g, popupContent);

    $popupArea.append(template);

};



$(function () {

    function displayAjax(url = '', callback, dataType='html') {
        $.ajax({
            type :"GET",
            async : true,
            url : url,
            dataType : dataType,
            success: function(response, status, request) {
                if ($saleson.core.isFunction(callback)) {
                    callback(response);
                }
            }
        });
    }

    function processFrontImpression($selector) {
        try {

            const data = $selector.data();

            if (data.analyticsFlag) {
                $saleson.analytics.frontImpression($selector, data.listName, data.listId);
            }
        } catch (e) {}
    }

    function redirectItemHandler($selector) {
        $saleson.handler.redirectItemHandler($selector);
    }

    function itemEventHandler(parentSelector, analyticsFlag = false) {
        $saleson.handler.itemEventHandler(parentSelector, ($s)=> {
            if (analyticsFlag) {
                processFrontImpression($s);
            }
        });
    }

    // 스와이프
    // visual swiper
    salesOnUI.mainVisualSwiper();

    // best area swiper
    salesOnUI.mainbestItemSwiper();

    // tab area swiper
    salesOnUI.mainTabSwiper();


    async function popupEventHandler(response) {

        const isCached = (cacheKey = '') => {

            const cookie = $saleson.store.cookie.get(cacheKey);
            return typeof cookie != 'undefined' && cookie != null && cookie != ''
        }

        const $popupArea = $('#popup-area');
        $popupArea.empty();

        if (response.successFlag) {
            const data = response.data;
            const windows = data.windows;
            const layers = data.layers;
            if (typeof windows !== undefined && windows != null && windows.length > 0) {
                windows.forEach(popup => {
                    if (!isCached(popup.cacheKey)) {
                        openWindowPopup(popup);
                    }

                });
            }

            if (typeof layers !== undefined && layers != null && layers.length > 0) {
                layers.forEach(popup => {
                    if (!isCached(popup.cacheKey)) {
                        openLayerPopup($popupArea, popup);
                    }

                });
            }
        }


        $popupArea.on('click', '.modal-close', function (e) {
            e.preventDefault();
            $(this).closest('.modal').removeClass('show');
        });

        $popupArea.on('click', '.popup-close', function (e) {
            e.preventDefault();
            $(this).closest('.modal').removeClass('show');
        });

        $popupArea.on('click', '.check-area', function (e) {

            e.preventDefault();

            const $modal = $(this).closest('.modal');

            const cacheKey = $modal.data('cache-key');

            if (typeof cacheKey !== undefined && cacheKey != null && cacheKey != '') {
                const expires = new Date();
                expires.setDate(expires.getDate() + 1);
                $saleson.store.cookie.set(cacheKey, 'Y', {'expires': expires});
            }

            $modal.removeClass('show');
        });

    }

    async function brandEventHandler(response) {

        // 브랜드
        const $brandArea = $('.focus-brand-area');

        $brandArea.find('.brand-list')
            .empty()
            .append(response);

        // time area swiper
        salesOnUI.mainBrandSwiper();

        $brandArea.on('click', '.swiper-slide', function (e) {
            e.preventDefault();
            $(this).addClass('on').siblings().removeClass('on');
            $saleson.core.redirect('/brand/' + $(this).data('brand-id'));
        });
    }

    async function reviewEventHandler(response) {
        // 리뷰
        const $reviewArea = $('.main-review-area');
        $reviewArea.find('.swiper-wrapper')
            .empty()
            .append(response);

        // review area swiper
        salesOnUI.mainReviewSwiper();
    }

    function timedealItemEventHandler(response) {
        // 타임세일 카운트 다운
        const $timesaleArea = $('.main-timesale-area');
        const $wrapper = $timesaleArea.find('.swiper-wrapper');

        $wrapper.empty().append(response);

        if ($wrapper.find('.swiper-slide').length == 0) {
            $timesaleArea.hide();
            $('.main-timesale-bg').hide();
        }

        salesOnUI.mainTimeSwiper();
        itemEventHandler('.main-timesale-area', true);
        redirectItemHandler($timesaleArea);

        $saleson.handler.startSpotItemCountdown($('.main-timesale-area').find('.time-area'));
    }

    async function newItemEventHandler(response) {

        $('.main-new-item-list')
            .empty()
            .append(response);

        itemEventHandler('.main-new-item-list', true);
        redirectItemHandler($('.main-new-item-list'));
    }

    async function featuredEventHandler(response) {
        $('#main-featured')
            .empty()
            .append(response);
    }

    async function mdEventHandler() {

        try {

            const {data} = await $saleson.api.get('/api/display/md-tags');

            $('#md-tag').find('.swiper-wrapper').empty();

            data.tags.forEach(tag=>{
                $('#md-tag').find('.swiper-wrapper').append(`<div class="swiper-slide">
                        <a class="main-tabitem" data-tag="${tag}" >#${tag}</a>
                    </div>`);
            });


            $('#md-tag').on('click', 'a', function (e) {
                e.preventDefault();

                const tag = $(this).data('tag');
                const container = '#md-item-list-container';

                $(container).empty();

                displayAjax('/main/md-list?tag=' + tag, function (response) {
                    $(container).append(response);
                    processFrontImpression($(container));
                });

                itemEventHandler(container);
                redirectItemHandler($(container));
            });

            $('#md-tag a').eq(0).trigger('click');

        } catch (e) {}
    }
    async function setBanner() {
        try {
            const {data} = await $saleson.api.get('/api/display/banner');

            $('.ad-area').empty();
            if (data.advertisement != null && data.advertisement.length > 0) {
                for (const ad of data.advertisement) {
                    $('.ad-area').append(`<a href="${ad.url}"><img src="${ad.image}" alt="${ad.content}" onerror="errorImage(this)" loading="lazy" decoding="async"></a>`);
                }
            }

            $('#main-featured-banner').find('ul').empty();

            if (data.featured != null && data.featured.length > 0) {
                for (const featured of data.featured) {
                    $('#main-featured-banner').find('ul').append(`<li class="event-item">
                    <a href="${featured.url}">
                        <div class="event-thumbnail">
                            <img src="${featured.image}" alt="${featured.content}" onerror="errorImage(this)" loading="lazy" decoding="async">
                        </div>
                    </a>
                </li>`);
                }
            }

            $('.main-ad-banner-area').find('.flex').empty();

            if (data.middleBanner != null && data.middleBanner.length > 0) {
                for (const middleBanner of data.middleBanner) {
                    $('.main-ad-banner-area').find('.flex').append(`<a href="${middleBanner.url}" class="img-banner pc">
                    <img src="${middleBanner.image}" alt="${middleBanner.content}" alt="" onerror="errorImage(this)" loading="lazy" decoding="async">
                </a>`);
                }
            }

            if (data.mobileMiddleBanner != null && data.mobileMiddleBanner.length > 0) {
                for (const middleBanner of data.mobileMiddleBanner) {
                    $('.main-ad-banner-area').find('.flex').append(`<a href="${middleBanner.url}" class="img-banner mobile">
                    <img src="${middleBanner.image}" alt="${middleBanner.content}" alt="" onerror="errorImage(this)" loading="lazy" decoding="async">
                </a>`);
                }
            }
        } catch (e) {}

    }

    displayAjax('/main/new-item-list', newItemEventHandler);
    displayAjax('/main/timedeal-item-list', timedealItemEventHandler);
    displayAjax('/main/brand-list', brandEventHandler);
    displayAjax('/main/review-list', reviewEventHandler);
    displayAjax('/main/featured-list', featuredEventHandler);
    displayAjax('/main/popup', popupEventHandler, 'json');

    // 베스트
    const $bestItemArea = $('.main-bestitem-area');

    $bestItemArea.find('.swiper-slide').on('click', function (e) {
        e.preventDefault();

        $(this).closest('.swiper-wrapper').find('.swiper-slide').removeClass('on');
        $(this).addClass('on');

        const tag = $(this).data('key');
        const container = '#best-item-list-container';

        $(container).empty();

        displayAjax('/main/group-best/item-list?tag=' + tag, function (response) {
            $(container).append(response);
            processFrontImpression($(container));
        });

        itemEventHandler(container);
        redirectItemHandler($(container));

        $('#redirect-best').attr('href', `display/best?tag=${tag}`);
    });

    $bestItemArea.find('.swiper-slide').eq(0).trigger('click');

    try {
        $saleson.analytics.view('메인');
    } catch (e) {}

    mdEventHandler();
    setBanner();
});



