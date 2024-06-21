
$(function () {
    const $container = $('.item-list-container');

    const $spotTimer = $container.find('.spot-timer');

    if ($spotTimer.length > 0) {
        $saleson.handler.startSpotItemCountdown($spotTimer);
    }

    $saleson.handler.itemEventHandler('.item-list-container');

    const $listForm = $('#itemListForm');

    $listForm.on('change', '#itemListSorting', function () {

        let sort = '';
        let orderBy = '';

        try {
            const value = $(this).val();
            const array = value.split('__');

            orderBy = array[0];
            sort = array[1];


        } catch (e) {}

        $listForm.find('input[name=sort]').val(sort);
        $listForm.find('input[name=orderBy]').val(orderBy);

        $listForm.submit();
    });

    try {

        $container.each(function(idx, c) {

            const data = $(c).data();

            if (data.analyticsFlag) {
                $saleson.analytics.frontImpression($(c), data.listName, data.listId);
            }
        });

    } catch (e) {console.log(e)}

    $container.on('click', '.redirect-item-view', function (e) {
        e.preventDefault();
        const containerData = $(this).closest('.item-list-container').data();
        const $itemElement = $(this).closest('.item-element');
        const itemUserCode = $itemElement.data('item-user-code');
        if (containerData.analyticsFlag && itemUserCode != '') {
            try {
                $saleson.analytics.frontSelect($itemElement.find('.item-analytics-data'), containerData.listName, containerData.listId);
            } catch (e) {}
        }

        $saleson.core.redirect('/item/'+itemUserCode);

    });

});

