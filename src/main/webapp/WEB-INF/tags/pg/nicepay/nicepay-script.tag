<%@ tag pageEncoding="utf-8" %>

<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-3.0.js" type="text/javascript"></script>
<script type="text/javascript">
    // 결제창 최초 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
    function nicepayStart(){

        // PC 결제
        if (!$saleson.core.isMobile()) {

        //    document.getElementById('vExp').value = getTomorrow();

            goPay(document.buy);

        } else {
            // MOBILE 결제
            let NICEPAY_FORM_NAME = 'NICEPAY_FORM';
            $('#' + NICEPAY_FORM_NAME).remove();

            $_submitForm = $('<form id="'+ NICEPAY_FORM_NAME +'"/>');
            $_submitForm.css('display', 'none');

            $.each($('div.nicepay-input-area', $('form#buy')).find('input'), function(){
                $_submitForm.append($('<input />').attr({
                    'type'		: 'hidden',
                    'name'		: $(this).attr('name'),
                    'value'		: $(this).val()
                }));
            });

            $_submitForm.attr({
                'method'			: 'post',
                'accept-charset' 	: 'euc-kr',
                'action'			: 'https://web.nicepay.co.kr/v3/v3Payment.jsp'
            });

            $('body').append($_submitForm);
            $_submitForm.submit();
        }

    }

    // 결제 최종 요청시 실행됩니다. <<'nicepaySubmit()' 이름 수정 불가능>>
    function nicepaySubmit(){
        document.buy.submit();
    }

    // 결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
    function nicepayClose(){
        alert("결제가 취소 되었습니다");
    }

    // 가상계좌입금만료일 설정 (today +1)
    function getTomorrow(){
	    var today = new Date();

	    today.setDate(today.getDate()+1);

	    var yyyy = today.getFullYear().toString();
	    var mm = (today.getMonth()+1).toString();
	    var dd = (today.getDate()+1).toString();

        if (mm.length < 2) {mm = '0' + mm;}
        if (dd.length < 2) {dd = '0' + dd;}

        return (yyyy + mm + dd);
    }
</script>