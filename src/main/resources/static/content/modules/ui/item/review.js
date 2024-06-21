
const $ITEM_REVIEW_LIST = $('#item-review-list');
const $DETAIL_REVIEW_CONTENTS = $('.detail-review-contents');

$(function () {

    $DETAIL_REVIEW_CONTENTS.on('change','select[name=score]', function (){
        paginationReview(1);
    });

    $DETAIL_REVIEW_CONTENTS.on('change','input[name=photoFlag]', function (){
        paginationReview(1);
    });

    $('#item-review-sort').on('click','li', function (){

        $(this).closest('ul').find('li').removeClass('active');
        $(this).addClass('active');

        $DETAIL_REVIEW_CONTENTS.find('input[name=orderBy]').val($(this).data('sort'));
        paginationReview(1);
    });

    // 화면 로딩시 호출
    paginationReview(1);

    $DETAIL_REVIEW_CONTENTS.find('.photo-list')
        .on('click', '.photo-item', function (e) {
        e.preventDefault();
        const $list = $(this).closest('.photo-list');
        const $imgs = $list.find('img');
        const files = [];

        $imgs.each(function (idx) {
            files.push($imgs.eq(idx).attr('src'));
        });

        ImageViewHandler.open(files, $(this).index())
    });

    $DETAIL_REVIEW_CONTENTS.on('click', '.review-report-btn', function () {
        const data = $(this).data();
        ReportHandler.review(data.id, data.blockFlag);
    });

});

function paginationReview(page) {

    const ITEM_USER_CODE = ITEM.itemUserCode;

    const orderBy = $DETAIL_REVIEW_CONTENTS.find('input[name=orderBy]').val();
    const score = $DETAIL_REVIEW_CONTENTS.find('select[name=score]').val();
    const photoFlag = $DETAIL_REVIEW_CONTENTS.find('input[name=photoFlag]:checked').val();

    const param = {
        page, orderBy, score, photoFlag
    }

    $ITEM_REVIEW_LIST.empty();

    $.get('/item/'+ITEM_USER_CODE+'/review', param, function (response) {
        $ITEM_REVIEW_LIST.append(response);

        const totalElements = $ITEM_REVIEW_LIST.find('.review-content').data('total-elements')
        $('#item-review-list-count').text($saleson.core.formatNumber(totalElements));
    }, 'html');
}