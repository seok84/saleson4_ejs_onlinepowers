$(function () {
    let $container = $(".period-container").closest("form");

    $container.on('change', '.input-select',function () {
        const selectedValue = $('.input-select').val();
        let startDate = new Date();
        let endDate = new Date();
        endDate.setDate(endDate.getDate());
        switch(selectedValue) {
            case 'week-1':
                startDate.setDate(startDate.getDate() - 7);
                break;
            case 'month-1':
                startDate.setMonth(startDate.getMonth() - 1)
                break;
            case 'month-3':
                startDate.setMonth(startDate.getMonth() - 3)
                break;
            case 'month-6':
                startDate.setMonth(startDate.getMonth() - 6)
                break;
            default :
                startDate = null; // 초기화
                endDate = null;   // 초기화
                break;

        }
        if(selectedValue === ''){
            $('input[name=searchStartDate]').val('');
            $('input[name=searchEndDate]').val('');
        } else {
            $('input[name=searchStartDate]').val(formatDate(startDate));
            $('input[name=searchEndDate]').val(formatDate(endDate));
        }

    })

    $container.submit(function () {
        validateStartAndEnd();
    })
})


function formatDate(date) {
    const year = date.getFullYear().toString();
    const month = (date.getMonth() + 1).toString();
    const day = date.getDate().toString();

    return year +'-'+ (month.length === 1 ? '0' + month : month) +'-'+
        (day.length === 1 ? '0' + day : day) ;
}

function validateStartAndEnd() {

    let $startDate = ($('input[name=searchStartDate]').val()).replace(/-/g, "");
    let $endDate = ($('input[name=searchEndDate]').val()).replace(/-/g, "");


    if (!$.validator.isEmpty($startDate) && !$.validator.isEmpty($endDate)) {
        let d1 = new Date($startDate.substring(0, 4), $startDate.substring(4, 6) - 1, $startDate.substring(6, 8));
        let d2 = new Date($endDate.substring(0, 4), $endDate.substring(4, 6) - 1, $endDate.substring(6, 8));

        let $dayNumber = (d2 - d1) /(1000*60*60*24);

        if ($dayNumber < 0){
            if ($(this).attr('name').indexOf('ndDate') > -1) {
                alert('종료일을 시작일 이후 날짜로 지정해 주세요.');
                $endDate.val('').focus();
            } else {
                alert('시작일을 종료일 이전 날짜로 지정해 주세요.');
                $startDate.val('').focus();
            }
            return false;
        }

    }
}




