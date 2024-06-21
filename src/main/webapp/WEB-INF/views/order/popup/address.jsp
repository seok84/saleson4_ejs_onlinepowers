<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="daum"	tagdir="/WEB-INF/tags/daum" %>

<!-- 배송지 추가 -->
    <div class="dimmed-bg" data-dismiss></div>
    <div class="modal-wrap">
        <button class="modal-close" data-dismiss>닫기</button>
        <div class="modal-header">
            배송지 추가
        </div>
        <div class="modal-body">
            <form id="addressForm" method="post">
                <div class="btn-wrap gap ">
                    <div class="btn btn-default btn-middle check-wrap">
                        <label class="circle-input-checkbox purple">
                            <input type="checkbox" id="defaultFlag" name="defaultFlag" checked><i></i>기본 배송지로 설정</label>
                    </div>
                    <div class="btn btn-default btn-middle check-wrap">
                        <label class="circle-input-checkbox purple">
                            <input type="checkbox" class="" onchange="getDefaultAddress(event)"><i></i>기본 배송지 가져오기
                        </label>
                    </div>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic required" id="title" name="title" placeholder="배송지" />
                    <span class="feedback invalid" style="display: none;">배송지를 입력해주세요</span>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic required" id="userName" name="userName" placeholder="받는사람" />
                    <span class="feedback invalid" style="display: none;">받는사람을 입력해주세요</span>
                </div>
                <div class="form-line">
                    <div class="flex">
                        <input type="text" class="form-basic required" id="zipcode" name="zipcode" placeholder="우편번호 찾기" />
                        <button type="button" class="btn btn-black" onclick="openDaumpostCode()">우편번호</button>
                    </div>
                    <span class="feedback invalid" style="display: none;">우편번호를 입력해주세요</span>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic required" id="address" name="address" placeholder="기본주소" />
                    <span class="feedback invalid" style="display: none;">기본주소를 입력해주세요</span>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic required" id="addressDetail" name="addressDetail" placeholder="상세주소" />
                    <span class="feedback invalid" style="display: none;">상세주소를 입력해주세요</span>
                </div>
                <div class="form-line">
                    <input type="number" class="form-basic required" id="mobile" name="mobile" placeholder="휴대폰 또는 전화번호 숫자만 입력" />
                    <span class="feedback invalid" style="display: none;">휴대폰번호를 입력해주세요</span>
                </div>
                <div class="btn-wrap">
                    <button type="submit" class="btn btn-primary w-160">저장</button>
                </div>
                <div class="hide hidden">
                    <input type="hidden" id="newZipcode" name="newZipcode" />
                    <input type="hidden" id="sido" name="sido" />
                    <input type="hidden" id="sigungu" name="sigungu" />
                    <input type="hidden" id="eupmyeondong" name="eupmyeondong" />
                </div>
            </form>
        </div>
    </div>
<daum:address />

<script>
    $(function () {

        const $form = $('#addressForm');

        $form.validator(()=> {
            const api = $saleson.api;
            let url = '/api/shipping';

            $saleson.core.confirm('배송지를 등록하시겠습니까?', () => {
                try {

                    let json = $saleson.core.formToJson('addressForm');

                    if (json.defaultFlag == undefined) {
                        json.defaultFlag = 'N';
                    } else {
                        json.defaultFlag = 'Y';
                    }

                    api.post(url, json)
                    .then((response) => {
                        if (response.data.status == 200) {
                            $saleson.core.alert('등록되었습니다.', () => {
                                $saleson.core.reload();
                            });
                        }
                    })
                    .catch(function(error) {
                        $saleson.core.api.handleApiExeption(error);
                    });

                } catch (error) {
                    console.error('등록 테스트');
                }
            });


            return false;
        })

    })

    /*
    * 주소 변경 팝업
    * */
    function getReceiveChangePopup() {
        try {
            $saleson.handler.getPopup({}, "/shipping/popup/address-list", ".modal-address-list");
        } catch (e) {
            $saleson.core.alert('주소 변경 팝업정보 요청 중 오류가 발생하였습니다.');
        }
    }

    /*
    * 기본 배송지 설정
    * */
    function changeDefaultAddress() {
        $saleson.core.confirm('기본배송지로 설정하시겠습니까?', async () => {
            const $checkRadio = $('.default-address:checked');
            const userDeliveryId = $checkRadio.data('deliveryId');

            let param = {
                'userDeliveryId' : userDeliveryId,
            }

            try {
                const api = $saleson.api;
                let url = '/api/shipping/base-shipping';

                const {data} = await api.post(url, param);

                if (data.status == 200) {
                    $saleson.core.alert('기본 배송지로 설정되었습니다.', () => {
                        $saleson.core.reload();
                    });
                } else {
                    throw new Error();
                }


            } catch (e) {
                $saleson.core.alert('주소 변경 팝업정보 요청 중 오류가 발생하였습니다.');
            }
        })
    }



    /*
    *
    * 기본 배송지 가져오기
    * */
    async function getDefaultAddress(event) {
        try {
            let isChecked = event.target.checked;
            const $addressForm = $('#addressForm');

            if (isChecked) {
                const api = $saleson.api;
                let url = '/api/shipping/default-address';

                await api.get(url)
                .then((response) => {
                    const data = response.data;

                    if (data.userDeliveryId <= 0) {
                        $saleson.core.alert('기본 배송지로 설정된 정보가 없습니다.');
                        return false;
                    }


                    let title = data.title;
                    let userName = data.userName;
                    let zipcode = data.zipcode;
                    let address = data.address;
                    let addressDetail = data.addressDetail;
                    let mobile = data.mobile.replaceAll('-','');
                    let sido = data.sido;
                    let sigungu = data.sigungu;
                    let eupmyeondong = data.eupmyeondong;
                    let newZipcode = data.newZipcode;

                    $addressForm.find('#title').val(title)
                    $addressForm.find('#userName').val(userName);
                    $addressForm.find('#zipcode').val(zipcode);
                    $addressForm.find('#address').val(address);
                    $addressForm.find('#addressDetail').val(addressDetail);
                    $addressForm.find('#mobile').val(mobile);
                    $addressForm.find('#sido').val(sido);
                    $addressForm.find('#sigungu').val(sigungu);
                    $addressForm.find('#eupmyeondong').val(eupmyeondong);
                    $addressForm.find('#newZipcode').val(newZipcode);

                });
            } else {
                // reset
                $addressForm.find('input[type="text"]').val('');
                $addressForm.find('input[type="number"]').val('');
            }
        } catch (e) {
            debugger
            $saleson.core.alert('주소 변경 팝업정보 요청 중 오류가 발생하였습니다.');
        }
    }


    function openDaumpostCode () {
        const tagNames = {
            'newZipcode'			: 'newZipcode',
            'zipcode': 'zipcode',
            'roadAddress'			: 'address',
            'sido' : 'sido',
            'sigungu' : 'sigungu',
            'eupmyeondong' : 'eupmyeondong'
        }

        openDaumAddress(tagNames);
    }
</script>
