let optionState = {
    selectedOptions : [],
    completedOptions : [],
    setSelectedOptions : []
};

/**
 * 상품 Tab
 */
function item_tab() {

    const $itemTab = $(".tab-item");
    const tabHeight = $(".tabs").height();
    $itemTab.on('click', function(e) {
        e.preventDefault();
        var idx = $(this).index();

        $(this).parent().children(".tab-item").removeClass('active');
        $(this).addClass('active');
        $('.item-tab-content').hide();
        $('.item-tab-content').eq(idx).show();

        var target = $( $(this).attr('href') );
        if( target.length ) {
            $('html, body').animate({
                scrollTop: target.offset().top - tabHeight +1
            }, 'fast');
        }
    });
}

/**
 * 쿠폰 다운로드
 * @returns {boolean}
 */
function downloadCouponAll(){
    const loggedIn = $saleson.auth.loggedIn();

    if (!loggedIn) {
        $saleson.core.confirm('로그인 페이지로 이동하시겠습니까?', () => {
            const target = $saleson.core.requestContext.requestUri;
            $saleson.core.redirect(
                $saleson.const.pages.LOGIN + '?target=' + target);
        })

        return false;
    }
    $saleson.handler.getPopup('', '/item/'+ITEM.itemUserCode+'/coupon-down', '.modal-coupon');
}
function islandInfoModal(page) {
    const where = $("select[name=where]").val();
    const query = $("#query").val();

    const param = {
        where, query, page
    };

    $saleson.handler.getPopup(param, '/common/island-info', '.modal-delivery');
}
function relationItems() {
    const target = $(".recommend-container");
    $.ajax({
        type :"GET",
        async : true,
        url : '/item/'+ITEM.itemUserCode+"/relation",
        dataType : "html",
        success: function(response, status, request) {
            target.html(response);
            salesOnUI.relationSwiper();
            itemEventHandler(".item-list-container");
            redirectItemHandler($(".relation-swiper"));
        },
        error:function(response,status,request){
            error(response);
        }
    });
}

function redirectItemHandler($selector) {
    $saleson.handler.redirectItemHandler($selector);
}
function itemEventHandler(parentSelector) {
    $saleson.handler.itemEventHandler(parentSelector, ($s)=> {

    });
}



/**
 * 필수 옵션을 선택해주세요. 창 토글
 */
$(document).on("click", ".dropdown-title", function(e){
    itemCalculator.dropdownTitle(this, ".dropdown-title");
});
/**
 * 필수 옵션을 선택해주세요. 창 토글
 */
$(document).on("click", ".option-contents .select-wrap", function(){
    itemCalculator.selectWrap(this, ".option-dropdown");
});

//옵션 제목 클릭 ex) 색상, 사이즈
$(document).on('click', '.option-title', function(e){
    itemCalculator.optionTitle(this, '.option-title');
});

//옵션 값 클릭 ex) 노랑, 초록
$(document).on('click', '.option-inner .option-btn', function(e){
    itemCalculator.optionBtn(this);
});
// 옵션 닫기 버튼 클릭
$(document).on('click', '.option-list .btn-close', function(e){
    itemCalculator.optionClose(this);
});

//상품 수량 +
$(document).on('click', '.btn-plus', function(e) {
    itemCalculator.plusAction(this);
});
//상품 수량 -
$(document).on('click', '.btn-minus', function(e) {
    itemCalculator.minusAction(this);
});

//장바구니 담기
$(document).on('click', '.cart', function(e) {
    itemCalculator.addToCart(this);
});
//바로구매
$(document).on('click', '.buyNow', function(e) {
    itemCalculator.buyNow(this);
});
//텍스트 옵션 추가
$(document).on('click', '.text-option-add', function(e){
    itemCalculator.textOption(this);
});



