<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">반품신청</div>
    <div class="modal-body p-2 type-return">
        <form id="returnApplyForm">
            <c:set var="returnApply" value="${content.returnApply}" />
            <c:set var="claimType" value="2" scope="request" />
            <input type="hidden" name="shipmentReturnId" value="${returnApply.shipmentReturnId}">
            <input type="hidden" name="orderCode" value="${orderRequest.orderCode}">
            <input type="hidden" name="orderSequence" value="${orderRequest.orderSequence}">
            <input type="hidden" name="itemSequence" value="${orderRequest.itemSequence}">

            <!-- 아이템 영역 -->
            <c:set var="i" value="${content.returnApply.orderItem}" scope="request"/>
            <jsp:include page="/WEB-INF/views/include/order/order-item.jsp"/>

            <div class="article-divider"></div>
            <!-- 취소사유 -->
            <h3 class="form-title">반품사유</h3>
            <div class="select-wrap">
                <select class="input-select" name="claimReason" onchange="reasonReturnChange()">
                    <c:forEach items="${content.claimReasons}" var="claim">
                        <option value="${claim.id}">${claim.label}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic" name="claimReasonDetail" placeholder="반품 사유를 입력하세요" style="display: none;"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <label for="return-claimImage" class="btn btn-default btn-add-photo">
                <input type="file" name="claimImage" id="return-claimImage" class="hidden" multiple onchange="fileChange(event, 'return')"/>
                <img src="/static/content/image/ico/ico_camera.svg" alt="사진 첨부하기" class="ico" /><span>사진 첨부하기</span>
            </label>
            <ul class="photo-list"></ul>
            <ul class="dot-list large-dot">
                <li>5MB 이하의 사진 4장까지 첨부 가능</li>
            </ul>
            <!-- 반송방법 -->
            <h3 class="form-title">반송방법</h3>
            <div class="radio-wrap">
                <label class="input-radio"><input type="radio" name="returnShippingAskType" value="1" onchange="checkExchange();"  checked /><i></i>지정택배사 이용 </label>
                <label class="input-radio"><input type="radio" name="returnShippingAskType" value="2" onchange="checkExchange();" /><i></i>직접발송</label>
            </div>
            <div class="form-line package" style="display: none">
                <div class="flex">
                    <div class="select-wrap">
                        <select name="returnShippingCompanyName" id="returnShippingCompanyName" class="input-select">
                            <c:forEach items="${content.deliveryCompanyList}" var="deliveryCompany">
                                <option value="${deliveryCompany.deliveryCompanyName}">${deliveryCompany.deliveryCompanyName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <input type="text" name="returnShippingNumber" class="form-basic" placeholder="송장번호">
                </div>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="returnReserveName" placeholder="홍길동" value="${returnApply.returnReserveName}" readonly title="이름"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="returnReserveMobile" placeholder="'-'없이 번호만 입력" value="${returnApply.returnReserveMobile}" title="연락처"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="hidden" value="${returnApply.returnReserveSido}" name="returnReserveSido">
                <input type="hidden" value="${returnApply.returnReserveSigungu}" name="returnReserveSigungu">
                <input type="hidden" value="${returnApply.returnReserveEupmyeondong}" name="returnReserveEupmyeondong">
                <div class="flex">
                    <input type="text" class="form-basic required" name="returnReserveZipcode" placeholder="우편번호" value="${returnApply.returnReserveZipcode}" readonly title="우편번호"/>
                    <button type="button" class="btn btn-black" onclick="openDaumPostAddress('return')">우편번호</button>
                </div>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="returnReserveAddress" placeholder="기본주소" value="${returnApply.returnReserveAddress}" readonly title="주소"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" class="form-basic required" name="returnReserveAddress2" placeholder="상세주소" ${returnApply.returnReserveAddress2} title="상세주소"/>
                <span class="feedback invalid" style="display: none">유효성 메시지</span>
            </div>
            <!-- 환불정보 -->
            <div class="return-content">
                <h3 class="form-title">환불정보</h3>
                <div class="form-line">
                    <input type="text" class="form-basic required" placeholder="예금주명" name="returnBankInName" title="예금주명"/>
                    <span class="feedback invalid" style="display: none">유효성 메시지</span>
                </div>
                <div class="form-line bank">
                    <div class="flex">
                        <div class="select-wrap">
                            <select class="input-select" name="returnBankName">
                                <c:forEach items="${banks.list}" var="bank">
                                    <option value="${bank.key}">${bank.label}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <input type="text" class="form-basic required" name="returnVirtualNo" placeholder="계좌번호" title="계좌번호"/>
                        <span class="feedback invalid" style="display: none">유효성 메시지</span>
                    </div>
                </div>
                <ul class="dot-list large-dot">
                    <li>부분취소가 불가능한 결제방식(카드)의 경우 위에 입력하신 계좌로 취소금액을 입금해드립니다.</li>
                    <li>통장입금의 경우 택배가 판매자에게 도착한 후, 2~3일 이내에 반품 신청하신 계좌로 입금됩니다.</li>
                </ul>
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
        $("#returnApplyForm").validator({
            'requiredClass' : 'required',
            'submitHandler' : function() {
debugger
                let formData = new FormData();

                formData.append('orderCode', $("input[name=orderCode]").val()); // 주문번호
                formData.append('orderSequence', $("input[name=orderSequence]").val()); // 주문순번
                formData.append('itemSequence', $("input[name=itemSequence]").val()); // 상품순번
                formData.append('shipmentReturnId', $("input[name=shipmentReturnId]").val()); // SHIPMENT RETURN ID

                formData.append('applyQuantity', $("select[name=applyQuantity] option:selected").val());

                // 반품사유
                let claimReasons = $("select[name=claimReason] option:selected").html();
                formData.append('claimReasonDetail',claimReasons);
                if (claimReasons == '기타'){
                    let claimReasonDetail = $("#claimReasonDetail").val();
                    formData.append('claimReasonDetail',claimReasonDetail);
                }

                let shippingAskType = $("input[name=returnShippingAskType]:checked").val();

                let files = $("input[name=claimImage]")[0].files;
                if (files.length > 0){  // 첨부 이미지가 존재한다면
                    for (let i=0; i < files.length; i++) {
                        formData.append('orderClaimImageFiles[' + i + ']', files[i]);
                    }
                }
                formData.append('returnShippingAskType',shippingAskType); // 반송방법 (회수, 직접)
                if (shippingAskType == '2'){    // 직접회수
                    formData.append('returnShippingCompanyName', $("input[name=returnShippingCompanyName]").val()); // 택배사
                    formData.append('returnShippingNumber', $("input[name=returnShippingNumber]").val());       // 송장번호
                }

                formData.append('returnReserveName', $("input[name=returnReserveName]").val()); // 주소 - 이름

                let mobile = $("input[name=returnReserveMobile]").val().replace(/-/g, '');
                formData.append('returnReserveMobile', mobile);
                formData.append('returnReservePhone', mobile);

                formData.append('returnReserveZipcode', $("input[name=returnReserveZipcode]").val()); // 주소 - 우편번호
                formData.append('returnReserveAddress', $("input[name=returnReserveAddress]").val()); // 주소 - 기본
                formData.append('returnReserveAddress2', $("input[name=returnReserveAddress2]").val()); // 주소 - 상세주소

                formData.append('returnReserveSido', $("input[name=returnReserveSido]").val()); //  시도
                formData.append('returnReserveSigungu', $("input[name=returnReserveSigungu]").val());   //  시군구
                formData.append('returnReserveEupmyeondong', $("input[name=returnReserveEupmyeondong]").val()); //  읍면동

                // 환불정보
                formData.append('returnBankInName', $("input[name=returnBankInName]").val()); // 예금주
                formData.append('returnBankName', $("input[name=returnBankName]").val()); // 은행
                formData.append('returnVirtualNo', $("input[name=returnVirtualNo]").val()); // 계좌

                $saleson.api.post("/api/order/return-apply", formData)
                .then(function (response) {
                    if (response.status === 200){
                        $saleson.core.alert("반품신청 되었습니다.", function(){
                            salesOnUI.modal().dismiss('.open-modal-return');
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
        let displayValue = $('input[name="returnShippingAskType"][value="2"]').is(":checked") ? "block" : "none";
        $(".form-line.package").css("display", displayValue);
    }

    function reasonReturnChange(){
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