<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="daum"	tagdir="/WEB-INF/tags/daum" %>

<layout:mypage>

    <section class="mypage-address">
        <!-- //본문 -->
        <div class="title-container m-line-divider">
            <h2 class="title-h2">배송주소록 관리</h2>
            <div class="btn-wrap ">
                <button type="button" class="btn btn-default btn-action" onclick="insertDelivery();">
                    <img src="/static/content/image/ico/ico_plus.svg" class="ico-plus">새 배송지 추가
                </button>
                <button type="button" class="btn btn-black btn-action btn-set-default" onclick="defaultDelivery();">기본 배송지로 설정</button>
            </div>
        </div>
        <!-- //주소록 리스트 -->
        <ul class="address-container">
            <c:forEach items="${pageContent.content}" var="delivery" varStatus="deliveryIndex">
                <c:set var="checked" value="${deliveryIndex.first ? 'checked' : '' }" />

                <li class="address-list">
                    <input type="hidden" name="defaultFlag" value="${delivery.defaultFlag}">
                    <input type="hidden" name="userDeliveryId" value="${delivery.userDeliveryId}">
                    <input type="hidden" name="title" value="${delivery.title}">
                    <input type="hidden" name="userName" value="${delivery.userName}">
                    <input type="hidden" name="newZipcode" value="${delivery.newZipcode}">
                    <input type="hidden" name="zipcode" value="${delivery.newZipcode}">
                    <input type="hidden" name="address" value="${delivery.address}">
                    <input type="hidden" name="addressDetail" value="${delivery.addressDetail}">
                    <input type="hidden" name="mobile" value="${delivery.mobile}">

                    <div class="radio-wrap"><label class="input-radio"><input type="radio" name="userDeliveryId" value="${delivery.userDeliveryId}" ${checked}><i></i></label>
                    </div>
                    <div class="address-content">
                        <div class="title"><strong>${delivery.title}</strong>
                            <c:if test="${delivery.defaultFlag == 'Y'}">
                                <span class="default">기본배송지</span>
                            </c:if>
                        </div>
                        <p>[${delivery.newZipcode}] ${delivery.address} ${delivery.addressDetail}</p>
                        <p>${delivery.mobile}</p>
                    </div>
                    <div class="btn-wrap">
                        <button type="button" class="btn btn-default btn-middle" onclick="deliveryDetail('${delivery.userDeliveryId}')">수정</button>
                        <button type="button" class="btn btn-default btn-middle" onclick="deleteDelivery('${delivery.userDeliveryId}')">삭제</button>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <div class="mobile">
            <div class="btn-wrap">
                <button type="button" class="btn btn-default btn-black2 btn-set-default">기본 배송지로 설정</button>
            </div>
        </div>
        <c:if test="${empty pageContent.content}">
            <div class="no-contents">
                <p>등록된 배송지 정보가 없습니다.</p>
            </div>
        </c:if>
        <page:pagination/>
    </section>
    <daum:address />
    <page:javascript>
        <script>

            // 기본배송지 설정
            function defaultDelivery(){
                $saleson.core.confirm("기본배송지로 설정하시겠습니까?", function (){
                    const param = {
                        "userDeliveryId" : $("input[type=radio][name=userDeliveryId]:checked").val()
                    };
                    $saleson.api.post("/api/shipping/base-shipping", param)
                    .then(function (response) {
                        if (response.status === 200){
                            $saleson.core.alert("기본배송지가 설정되었습니다.", function(){
                                location.reload();
                            });
                        }
                    }).catch(function(error) {
                        $saleson.core.alert(error);
                    });
                });
            }

            // 배송주소록 삭제
            function deleteDelivery(userDeliveryId){
                $saleson.core.confirm("배송주소를 삭제하시겠습니까?", function (){
                    const param = {
                        "userDeliveryId" : userDeliveryId
                    };
                    $saleson.api.post("/api/shipping/delete", param)
                    .then(function (response) {
                        if (response.status === 200){
                            $saleson.core.alert("배송주소가 삭제되었습니다.", function(){
                                location.reload();
                            });
                        }
                    }).catch(function(error) {
                        $saleson.core.alert(error);
                    });
                });
            }
            
            function deliveryModal(mode){
                if (mode == 'insert'){
                    $(".modal-header").html("배송지 추가");
                }
                if (mode == 'edit'){
                    $(".modal-header").html("배송지 수정");
                }
                salesOnUI.modal().show('.address-modal');
            }

            function insertDelivery(){
                const deliveryForm = $("#deliveryForm");
                deliveryForm.find("input[type=text]").val("");
                deliveryModal('insert');
            }

            // 배송지 상세
            function deliveryDetail(userDeliveryId){

                const delivery = $('input[name=userDeliveryId][value='+userDeliveryId+']').closest('li');
                const hiddenInputs = delivery.find("input[type=hidden]");

                let deliveryForm = $("#deliveryForm");
                hiddenInputs.each(function () {
                    const inputName = $(this).attr('name');
                    deliveryForm.find("input[name="+inputName+"]").val($(this).val());
                });
                deliveryModal('edit');
            }

            function openDaumPostAddress(){
                const tagNames = {
                    'newZipcode'			: 'newZipcode',
                    'sido'					: 'sido',
                    'sigungu'				: 'sigungu',
                    'eupmyeondong'			: 'eupmyeondong',
                    'roadAddress'			: 'address',
                    'jibunAddressDetail' 	: 'addressDetail'
                }

                openDaumAddress(tagNames, () => {});

            }

            async function getDefaultAddress(event) {
                try {
                    let isChecked = event.target.checked;
                    const $addressForm = $('#deliveryForm');

                    if (isChecked) {
                        const api = $saleson.api;
                        let url = '/api/shipping/default-address';

                        await api.get(url)
                        .then((response) => {
                            const data = response.data;

                            if (data.userDeliveryId <= 0) {
                                $saleson.core.alert('기본 배송지로 설정된 정보가 없습니다.');
                                console.log(event);
                                event.target.checked ? event.target.checked = false : null;
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
                    $saleson.core.alert('주소 변경 팝업정보 요청 중 오류가 발생하였습니다.');
                }
            }


            // 배송지 등록 & 수정
            $(function(){
                $("#deliveryForm").validator({
                    'requiredClass' : 'required',
                    'submitHandler' : function() {
                        let msg = "배송지를 등록하시겠습니까?";
                        let userDeliveryId =  $("#deliveryForm input[name=userDeliveryId]").val();
                        if (userDeliveryId != null && userDeliveryId != ''){
                            msg = "배송지를 수정하시겠습니까?";
                        }

                        $saleson.core.confirm(msg, function (){
                            const deliveryForm = $("#deliveryForm");
                            const param = {
                                'userDeliveryId' : deliveryForm.find("input[name=userDeliveryId]").val(),
                                'defaultFlag' : deliveryForm.find("input[name=defaultFlag]:checked").val() ?? 'N',
                                'title' : deliveryForm.find("input[name=title]").val(),
                                'userName' : deliveryForm.find("input[name=userName]").val(),
                                'newZipcode' : deliveryForm.find("input[name=newZipcode]").val(),
                                'zipcode' : deliveryForm.find("input[name=newZipcode]").val(),
                                'address' : deliveryForm.find("input[name=address]").val(),
                                'addressDetail' : deliveryForm.find("input[name=addressDetail]").val(),
                                'mobile' : deliveryForm.find("input[name=mobile]").val(),
                                'sido' : deliveryForm.find("input[name=sido]").val(),
                                'sigungu' : deliveryForm.find("input[name=sigungu]").val(),
                                'eupmyeondong' : deliveryForm.find("input[name=eupmyeondong]").val()
                            };
                            $saleson.api.post("/api/shipping", param)
                            .then(function (response) {
                                if (response.status == 200){
                                    $saleson.core.alert("배송지가 등록되었습니다.", function(){
                                        location.reload();
                                    });
                                }
                            }).catch(function(error) {
                                $saleson.core.alert(error);
                            });
                        });
                        return false;
                    }
                });

                $('.modal-close').click( function () {
                    $('input[onchange="getDefaultAddress(event)"]').prop('checked', false);
                })

            })

        </script>
    </page:javascript>
    <page:model>
        <jsp:include page="./popup/delivery.jsp"/>
    </page:model>
</layout:mypage>
