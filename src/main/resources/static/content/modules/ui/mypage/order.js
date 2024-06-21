/**
 * 클레임 팝업
 */
function getClaimPopup(orderCode, orderSequence, itemSequence, claimType, escrowStatus) {
    try {
        const param = {
            'orderCode': orderCode,
            'orderSequence': orderSequence,
            'itemSequence': itemSequence,
            'claimType': claimType
        };
        let claimName = "";
        if (claimType == '1' || claimType == '4') {
            claimName = "cancel";
        } else if (claimType == '2') {
            claimName = "return";
        } else if (claimType == '3') {
            claimName = "exchange";
        }

        $saleson.handler.getPopup(param, `/mypage/info/popup/${claimName}-apply`, `.open-modal-${claimName}`);

    } catch (e) {
        $saleson.core.alert('클레임 팝업정보 요청 중 오류가 발생하였습니다.');
    }
}

/**
 * 리뷰작성 팝업
 */
function getReviewPopup(orderCode, orderSequence, itemSequence, itemUserCode) {

    try {
        const param = {
            'orderCode': orderCode,
            'orderSequence': orderSequence,
            'itemSequence': itemSequence,
            'itemUserCode': itemUserCode
        };

        $saleson.handler.getPopup(param, "/mypage/info/popup/review", ".open-modal-review");

    } catch (e) {
        $saleson.core.alert('리뷰 팝업정보 요청 중 오류가 발생하였습니다.');
    }
}

/**
 * 구매확정
 */
async function confirm(orderCode, orderSequence, itemSequence) {

    $saleson.core.confirm("구매확정하시겠습니까?", function () {

        let param = {
            "orderCode": orderCode,
            "orderSequence": orderSequence,
            "itemSequence": itemSequence
        };

        $saleson.api.post("/api/order/confirm-purchase", param)
            .then(function (response) {
                if (response.status === 200) {
                    $saleson.core.alert("구매확정되었습니다.", function () {
                        $saleson.core.reload();
                    });
                }
            }).catch(function (error) {
            $saleson.core.api.handleApiExeption(error);
        });
    });
}

/**
 * 배송조회
 */
function deliverySearch(url, number) {
    const link = url + number;
    $saleson.core.redirect(link);
}

/**
 * 클레임 파일첨부
 */
function fileChange(event, type) {
    const photoList = $("#" + type + "ApplyForm .photo-list")[0];

    let fileList = event.target.files;

    // 파일 valid check
    $saleson.handler.validFiles(fileList, ['gif', 'png', 'jpg', 'jpeg', 'pdf'], 4);

    for (let i = 0; i < fileList.length; i++) {
        let file = fileList[i];
        let fileExt = fileList[i].name;

        // 미리보기 생성
        try {
            let reader = new FileReader();
            let self = this;

            reader.onload = function (e) {
                photoList.appendChild(createPreviewImage(e.target.result, type));
            };

            reader.readAsDataURL(file);
        } catch (e) {
            $saleson.core.alert('이미지 파일 미리보기 생성 중 오류가 발생하였습니다.');
        }
    }
}

function createPreviewImage(src, type) {

    const li = document.createElement("li");
    li.className = "photo-item";

    const previewImage = document.createElement("img");
    previewImage.src = src;

    previewImage.className = "thumbnail";

    const deleteBtn = document.createElement("button");
    deleteBtn.className = "btn-delete";
    deleteBtn.addEventListener('click', () => fileDelete(li));

    li.appendChild(previewImage);
    li.appendChild(deleteBtn);

    return li;
}

function fileDelete(li) {
    const form = li.closest('form');
    const previewContainer = li.parentElement;
    previewContainer.removeChild(li);
}

// 주문바로취소
function orderCancel(orderCode, orderSequence, itemSequence) {

    $saleson.core.confirm("주문취소하시겠습니까?", () => {

        let param = {
            'orderCode': orderCode,
            'orderSequence': orderSequence,
            'itemSequence': itemSequence
        };

        $saleson.api.post("/api/order/cancel", param)
            .then(function (response) {
                if (response.status === 200) {
                    $saleson.core.alert("주문취소되었습니다.", function () {

                        try {
                            $saleson.analytics.allRefund(orderCode, orderSequence);
                        } catch (e) {
                        }

                        location.reload();
                    });
                }
            }).catch(function (error) {
            $saleson.core.api.handleApiExeption(error);
        });
    });

}

function openDaumPostAddress(mode) {
    let tagNames = {
        'newZipcode': `${mode}ReceiveZipcode`,
        'sido': `${mode}ReceiveSido`,
        'sigungu': `${mode}ReceiveSigungu`,
        'eupmyeondong': `${mode}ReceiveEupmyeondong`,
        'roadAddress': `${mode}ReceiveAddress`,
        'jibunAddressDetail': `${mode}ReceiveAddress2`
    }
    if (mode == 'return') {
        tagNames = {
            'newZipcode': `${mode}ReserveZipcode`,
            'sido': `${mode}ReserveSido`,
            'sigungu': `${mode}ReserveSigungu`,
            'eupmyeondong': `${mode}ReserveEupmyeondong`,
            'roadAddress': `${mode}ReserveAddress`,
            'jibunAddressDetail': `${mode}ReserveAddress2`
        }
    }
    openDaumAddress(tagNames, () => {
    });
}

function reasonChange() {
    let checked = $("select[name=claimReason] option:selected").html();
    let claimReasonText = $("input[name=claimReasonText]");
    claimReasonText.val("");
    if (checked == '기타') {
        claimReasonText.show();
    } else {
        claimReasonText.hide();
        claimReasonText.val(checked);
    }
}

/*
* PG결제 영수증 출력 - PC만
* */
function receiptIssuance(receipt) {
    const option = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
    window.open(receipt, '영수증', option);
}

/*
* 화면출력 - PC만
* */
function printScreen() {
    window.print();
}