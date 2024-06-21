<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">교환신청</div>
    <div class="modal-body p-2 type-exchange">
        <form id="exchangeApplyForm">
            <c:set var="exchangeApply" value="${content.exchangeApply}" />
            <c:set var="claimType" value="3" scope="request" />
            <input type="hidden" name="shipmentReturnId" value="${exchangeApply.shipmentReturnId}">
            <input type="hidden" name="orderCode" value="${orderRequest.orderCode}">
            <input type="hidden" name="orderSequence" value="${orderRequest.orderSequence}">
            <input type="hidden" name="itemSequence" value="${orderRequest.itemSequence}">

            <!-- 아이템 영역 -->
            <c:set var="i" value="${content.exchangeApply.orderItem}" scope="request"/>
            <jsp:include page="/WEB-INF/views/include/order/order-item.jsp"/>

            <div class="article-divider"></div>
            <!-- 취소사유 -->
            <h3 class="form-title">교환사유</h3>
            <div class="select-wrap">
                <select class="input-select" name="claimReason" onchange="exchangeReturnChange()">
                    <c:forEach items="${content.claimReasons}" var="claim">
                        <option value="${claim.id}">${claim.label}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic" name="claimReasonDetail" placeholder="반품 사유를 입력하세요" style="display: none;"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <label for="exchange-claimImage" class="btn btn-default btn-add-photo">
                <input type="file" name="claimImage" id="exchange-claimImage" class="hidden" multiple onchange="fileChange(event, 'exchange')"/>
                <img src="/static/content/image/ico/ico_camera.svg" alt="사진 첨부하기" class="ico" /><span>사진 첨부하기</span>
            </label>
            <ul class="photo-list"></ul>
            <ul class="dot-list large-dot">
                <li>5MB 이하의 사진 4장까지 첨부 가능</li>
            </ul>
            <!-- 반송방법 -->
            <h3 class="form-title">반송방법</h3>
            <div class="radio-wrap">
                <label class="input-radio"><input type="radio" name="exchangeShippingAskType" value="1" onchange="checkExchange();" checked /><i></i>회수요청 </label>
                <label class="input-radio"><input type="radio" name="exchangeShippingAskType" value="2" onchange="checkExchange();" /><i></i>직접발송</label>
            </div>
            <div class="form-line package" style="display: none">
                <div class="flex">
                    <div class="select-wrap">
                        <select name="exchangeShippingCompanyName" id="exchangeShippingCompanyName" class="input-select">
                            <c:forEach items="${content.deliveryCompanyList}" var="deliveryCompany">
                                <option value="${deliveryCompany.deliveryCompanyName}">${deliveryCompany.deliveryCompanyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="text" name="exchangeShippingNumber" class="form-basic" placeholder="송장번호">
                </div>
            </div>

            <div class="form-line">
                <input type="text" class="form-basic required" name="exchangeReceiveName" placeholder="이름" value="${exchangeApply.exchangeReceiveName}" title="이름"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="exchangeReceiveMobile" placeholder="'-'없이 번호만 입력" value="${exchangeApply.exchangeReceiveMobile}" title="연락처"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="hidden" value="${exchangeApply.exchangeReceiveSido}" name="exchangeReceiveSido">
                <input type="hidden" value="${exchangeApply.exchangeReceiveSigungu}" name="exchangeReceiveSigungu">
                <input type="hidden" value="${exchangeApply.exchangeReceiveEupmyeondong}" name="exchangeReceiveEupmyeondong">
                <div class="flex">
                    <input type="text" class="form-basic required" name="exchangeReceiveZipcode" placeholder="" readonly value="${exchangeApply.exchangeReceiveZipcode}" title="우편번호"/>
                    <button type="button" class="btn btn-black" onclick="openDaumPostAddress('exchange')">우편번호</button>
                </div>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="exchangeReceiveAddress" placeholder="기본주소" readonly value="${exchangeApply.exchangeReceiveAddress}" title="주소"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="exchangeReceiveAddress2" placeholder="상세주소" value="${exchangeApply.exchangeReceiveAddress2}" title="상세주소"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="link-wrap">
                <button type="submit" class="btn btn-primary link-item w-half">신청</button>
                <button type="button" class="btn btn-default link-item w-half" data-dismiss="">취소</button>
            </div>
        </form>
    </div>
</div>

<script>
    $(function(){
        $("#exchangeApplyForm").validator({
            'requiredClass' : 'required',
            'submitHandler' : function() {
                let exchangeApplyForm = $('#exchangeApplyForm');
                let formData = new FormData();

                formData.append('orderCode', $("input[name=orderCode]").val()); // 주문번호
                formData.append('orderSequence', $("input[name=orderSequence]").val()); // 주문순번
                formData.append('itemSequence', $("input[name=itemSequence]").val()); // 상품순번
                formData.append('shipmentReturnId', $("input[name=shipmentReturnId]").val()); // SHIPMENT RETURN ID

                formData.append('applyQuantity', $("select[name=applyQuantity] option:selected").val());

                // 교환사유
                let claimReasons = $("select[name=claimReason] option:selected").html();
                formData.append('claimReasonDetail',claimReasons);
                if (claimReasons == '기타'){
                    let claimReasonDetail = $("#claimReasonDetail").val();
                    formData.append('claimReasonDetail',claimReasonDetail);
                }

                let shippingAskType = $("input[name=exchangeShippingAskType]").val();

                let files = $("input[name=claimImage]")[0].files;
                if (files.length > 0){  // 첨부 이미지가 존재한다면
                    for (let i=0; i < files.length; i++) {
                        formData.append('orderClaimImageFiles[' + i + ']', files[i]);
                    }
                }
                formData.append('exchangeShippingAskType',shippingAskType); // 반송방법 (회수, 직접)
                if (shippingAskType == '2'){    // 직접회수
                    formData.append('exchangeShippingCompanyName', $("input[name=exchangeShippingCompanyName]").val()); // 택배사
                    formData.append('exchangeShippingNumber', $("input[name=exchangeShippingNumber]").val());       // 송장번호
                }

                formData.append('exchangeReceiveName', $("input[name=exchangeReceiveName]").val()); // 주소 - 이름

                // 연락처
                let mobile = $("input[name=exchangeReceiveMobile]").val().replace(/-/g, '');
                formData.append('exchangeReceiveMobile', mobile);
                formData.append('exchangeReceivePhone', mobile);

                formData.append('exchangeReceiveZipcode', $("input[name=exchangeReceiveZipcode]").val()); // 주소 - 우편번호
                formData.append('exchangeReceiveAddress', $("input[name=exchangeReceiveAddress]").val()); // 주소 - 기본
                formData.append('exchangeReceiveAddress2', $("input[name=exchangeReceiveAddress2]").val()); // 주소 - 상세주소

                formData.append('exchangeReceiveSido', $("input[name=exchangeReceiveSido]").val()); //  시도
                formData.append('exchangeReceiveSigungu', $("input[name=exchangeReceiveSigungu]").val());   //  시군구
                formData.append('exchangeReceiveEupmyeondong', $("input[name=exchangeReceiveEupmyeondong]").val()); //  읍면동

                $saleson.api.post("/api/order/exchange-apply", formData)
                .then(function (response) {
                    if (response.status === 200){
                        $saleson.core.alert("교환신청 되었습니다.", function(){
                            salesOnUI.modal().dismiss('.open-modal-exchange');
                            $saleson.core.reload();
                        });
                    }
                }).catch(function(error) {
                    $saleson.core.api.handleApiExeption(error);
                });

                return false;
            }
        });
    })

    function checkExchange() {
        let displayValue = $('input[name="exchangeShippingAskType"][value="2"]').is(":checked") ? "block" : "none";
        $(".form-line.package").css("display", displayValue);
    }

    function exchangeReturnChange(){
        let checked = $("select[name=claimReason] option:selected").html();
        let claimReasonDetail = $("input[name=claimReasonDetail]");
        claimReasonDetail.val("");
        if (checked == '기타'){
            claimReasonDetail.show();
        } else {
            claimReasonDetail.hide();
            claimReasonDetail.val(checked);
        }
    }
</script>