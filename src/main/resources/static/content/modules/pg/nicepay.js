let NICEPAY_VM, NICEPAY_SALESON;

function nicepayStart() {
	document.getElementById('vExp').value = getTomorrow();

	if (NICEPAY_VM.isMobile === false) {
		goPay(document.buy);
	} else {
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
function nicepaySubmit() {

	let formData = new FormData();
	formData.append('orderCode', document.getElementsByName('orderCode')[0].value);
	if (NICEPAY_VM.payType !== 'bank' &&  NICEPAY_VM.order.buy.orderPayAmount !== 0) {
		formData.append('PayMethod', document.getElementsByName('PayMethod')[0].value);
		formData.append('SelectQuota', document.getElementsByName('SelectQuota')[0].value);
		formData.append('SelectCardCode', document.getElementsByName('SelectCardCode')[0].value);
		formData.append('GoodsName', document.getElementsByName('GoodsName')[0].value);
		formData.append('GoodsCnt', document.getElementsByName('GoodsCnt')[0].value);
		formData.append('Amt', document.getElementsByName('Amt')[0].value);
		formData.append('BuyerName', document.getElementsByName('BuyerName')[0].value);
		formData.append('BuyerTel', document.getElementsByName('BuyerTel')[0].value);
		formData.append('Moid', document.getElementsByName('Moid')[0].value);
		formData.append('MID', document.getElementsByName('MID')[0].value);
		formData.append('UserIP', document.getElementsByName('UserIP')[0].value);
		formData.append('MallIP', document.getElementsByName('MallIP')[0].value);
		formData.append('VbankExpDate', document.getElementsByName('VbankExpDate')[0].value);
		formData.append('CharSet', document.getElementsByName('CharSet')[0].value);
		formData.append('BuyerEmail', document.getElementsByName('BuyerEmail')[0].value);
		formData.append('SocketYN', document.getElementsByName('SocketYN')[0].value);
		formData.append('GoodsCl', document.getElementsByName('GoodsCl')[0].value);
		formData.append('TransType', document.getElementsByName('TransType')[0].value);
		formData.append('EncodeParameters', document.getElementsByName('EncodeParameters')[0].value);
		formData.append('EdiDate', document.getElementsByName('EdiDate')[0].value);
		formData.append('SignData', document.getElementsByName('SignData')[0].value);
		formData.append('TrKey', document.getElementsByName('TrKey')[0].value);

		formData.append('AuthResultCode', document.getElementsByName('AuthResultCode')[0].value);
		formData.append('AuthResultMsg', document.getElementsByName('AuthResultMsg')[0].value);
		formData.append('AuthToken', document.getElementsByName('AuthToken')[0].value);
		formData.append('TxTid', document.getElementsByName('TxTid')[0].value);
		formData.append('NextAppURL', document.getElementsByName('NextAppURL')[0].value);
		formData.append('NetCancelURL', document.getElementsByName('NetCancelURL')[0].value);
		formData.append('Signature', document.getElementsByName('Signature')[0].value);
		formData.append('devicetype', NICEPAY_VM.buy.deviceType);

		formData.append('salesonTokenType', NICEPAY_SALESON.core.getTokenType());
		formData.append('salesonId', NICEPAY_SALESON.core.getState(NICEPAY_SALESON.const.SALESON_ID));
		formData.append('salesonToken', NICEPAY_SALESON.core.getToken());
		formData.append('failUrl', NICEPAY_VM.buy.failUrl);
		formData.append('successUrl', NICEPAY_VM.buy.successUrl);
	}

	NICEPAY_SALESON.api.pay(formData, function (response) {
		NICEPAY_SALESON.redirect('/order/step2?orderSequence=' + response.orderInfo.orderSequence + '&orderCode=' + response.orderInfo.orderCode);

	}, function (error) {
		if (document.getElementById('nice_layer') != null) {
			document.getElementById('nice_layer').remove();
		}

		if (document.getElementById('bg_layer') != null) {
			document.getElementById('bg_layer').remove();
		}

		NICEPAY_SALESON.alert(error.response.data.message);
		NICEPAY_VM.submitCheck = false;
	});
}

// 결제창 종료 함수 <<'nicepayClose()' 이름 수정 불가능>>
function nicepayClose() {
	NICEPAY_VM.submitCheck = false;
	NICEPAY_SALESON.alert("결제가 취소되었습니다.");
}

// 가상계좌입금만료일 설정 (today +1)
function getTomorrow() {
	let today = new Date();

	today.setDate(today.getDate()+1);

	let yyyy = today.getFullYear().toString();
	let mm = (today.getMonth()+1).toString();
	let dd = (today.getDate()+1).toString();

	if (mm.length < 2) {mm = '0' + mm;}
	if (dd.length < 2) {dd = '0' + dd;}

	return (yyyy + mm + dd);
}

function initNicepay(vm, $s) {
	NICEPAY_VM = vm;
	NICEPAY_SALESON = $s;
}