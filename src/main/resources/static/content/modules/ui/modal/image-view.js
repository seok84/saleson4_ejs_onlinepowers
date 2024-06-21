const ImageViewHandler = {
    modal: '.image-pop',

    init:()=> {

        const $modal = $(ImageViewHandler.modal);

        $modal.on('click', '.image-item', function(e) {
            e.preventDefault();
            const file = $(this).find('img').attr('src');
            $modal.find('.expansion-img').html(`<img src="${file}" onerror="errorImage(this)"/>`);
        });
    },
    open:(files = [], index = 0)=>{

        const $modal = $(ImageViewHandler.modal);

        if (files.length > 0 && $modal.length > 0) {
            const $imageList = $modal.find('.image-list');
            $imageList.empty();

            for (const file of files) {
                $imageList.append(`<li class="image-item"><img src="${file}" onerror="errorImage(this)"/></li>`);
            }

            $imageList.find('.image-item').eq(index).trigger('click');

            salesOnUI.modal().show('.image-pop');
        }
    }
}

$(() => {
    ImageViewHandler.init();
});