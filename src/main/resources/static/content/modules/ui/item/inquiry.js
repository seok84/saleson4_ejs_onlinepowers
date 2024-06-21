const $ITEM_INQUIRY_LIST = $('#item-inquiry-list');
$(function () {
    const $DETAIL_INQUIRE_CONTENTS = $('.detail-inquire-contents');
    const $ITEM_INQUIRY_FORM = $('#item-inquiry-form');
    const ITEM_ID = ITEM.itemId;

    $DETAIL_INQUIRE_CONTENTS.on('click','.btn-edit-qna', function() {

        if ($ITEM_INQUIRY_FORM.hasClass('hidden')) {
            if (!$saleson.auth.loggedIn()) {
                $saleson.core.confirm($saleson.const.message.LOGIN_MESSAGE, () => {
                    const target = $saleson.core.requestContext.requestUri;
                    $saleson.core.redirect($saleson.const.pages.LOGIN + '?target=' + target);
                })
                return false;
            }
        }

        initInquiry();
        $ITEM_INQUIRY_FORM.toggleClass('hidden');
    });

    $ITEM_INQUIRY_FORM.on('click','.close-inquiry', function() {
        initInquiry();
        $ITEM_INQUIRY_FORM.addClass('hidden');
    });

    $ITEM_INQUIRY_FORM.validator(function () {
        $saleson.core.confirm('상품 문의를 등록하시겠습니까?', () => {
            submitAction();
        });

        return false;
    });

    function initInquiry() {
        $ITEM_INQUIRY_FORM.find('input[name=qnaGroup]').val('');
        $ITEM_INQUIRY_FORM.find('input[name=secretFlag]').prop('checked',false);
        $ITEM_INQUIRY_FORM.find('input[name=subject]').val('');
        $ITEM_INQUIRY_FORM.find('textarea[name=question]').val('');
    }

    async function submitAction() {
        const formData = new FormData($ITEM_INQUIRY_FORM[0]);
        formData.append("itemId", ITEM_ID);

        await $saleson.api.post('/api/qna/item-inquiry', formData);

        $saleson.core.alert('등록되었습니다.', () => {
            paginationInquiry(1);
            $ITEM_INQUIRY_FORM.find('.close-inquiry').trigger('click');
        });
    }

    // 화면 로딩시 호출
    paginationInquiry(1);

    $DETAIL_INQUIRE_CONTENTS.on('click', '.inquiry-report-btn', function () {
        const data = $(this).data();
        ReportHandler.inquiry(data.id, data.blockFlag);
    });

});

function paginationInquiry(page) {

    const ITEM_USER_CODE = ITEM.itemUserCode;

    const param = {
        page: page,
        size: 10
    }

    $ITEM_INQUIRY_LIST.empty();

    $.get('/item/'+ITEM_USER_CODE+'/inquiry', param, function (response) {
        $ITEM_INQUIRY_LIST.append(response);

        const totalElements = $ITEM_INQUIRY_LIST.find('.content-sub-list').data('total-elements')
        $('#item-inquiry-list-count').text($saleson.core.formatNumber(totalElements));
    }, 'html');
}