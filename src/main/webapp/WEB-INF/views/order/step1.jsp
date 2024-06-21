<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" 	uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="daum"	tagdir="/WEB-INF/tags/daum" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<!-- 결제시 필요한 정보들 -->
<%@ taglib prefix="inicis"	tagdir="/WEB-INF/tags/pg/inicis" %>
<%@ taglib prefix="lgdacom"	tagdir="/WEB-INF/tags/pg/lgdacom" %>
<%@ taglib prefix="kspay"	tagdir="/WEB-INF/tags/pg/kspay" %>
<%@ taglib prefix="kakaopay"	tagdir="/WEB-INF/tags/pg/kakaopay" %>
<%@ taglib prefix="kcp"	tagdir="/WEB-INF/tags/pg/kcp" %>
<%@ taglib prefix="easypay"	tagdir="/WEB-INF/tags/pg/easypay" %>
<%@ taglib prefix="nicepay"	tagdir="/WEB-INF/tags/pg/nicepay" %>


<layout:default>
<div class="contents-area-page order-page">
    <c:set var="buy" value="${response.buy}" scope="request"/>

    <form:form modelAttribute="buy" name="buy" method="post" >
        <form:hidden path="orderCode" />

        <c:set var="orderPrice" value="${buy.orderPrice}"/>
        <form:hidden path="orderPrice.totalItemCouponDiscountAmount" />
        <form:hidden path="orderPrice.totalItemCouponDiscountAmount" />
        <form:hidden path="orderPrice.totalCartCouponDiscountAmount" />
        <form:hidden path="orderPrice.totalPointDiscountAmount" />
        <form:hidden path="orderPrice.totalShippingCouponUseCount" />
        <form:hidden path="orderPrice.totalShippingCouponDiscountAmount" />
        <form:hidden path="orderPrice.totalItemSaleAmount" />
        <form:hidden path="orderPrice.totalShippingAmount" />
        <form:hidden path="orderPrice.orderPayAmount" />
        <form:hidden path="orderPrice.orderPayAmountTotal" />
        <form:hidden path="orderPrice.payAmount" />
        <form:hidden path="orderPrice.totalUserLevelDiscountAmount" />

        <form:hidden path="deviceType" />

        <!-- 회원 정보 -->
        <c:if test="${isLogin == true}">
            <c:if test="${not empty buy.defaultUserDelivery}">
                <div id="defaultDeliveryInputArea">
                    <c:set var="defaultUserDelivery" value="${buy.defaultUserDelivery}" />
                    <form:hidden path="defaultUserDelivery.userName" />
                    <form:hidden path="defaultUserDelivery.phone" />
                    <form:hidden path="defaultUserDelivery.mobile" />
                    <form:hidden path="defaultUserDelivery.newZipcode" />
                    <form:hidden path="defaultUserDelivery.zipcode" />
                    <form:hidden path="defaultUserDelivery.sido" />
                    <form:hidden path="defaultUserDelivery.sigungu" />
                    <form:hidden path="defaultUserDelivery.eupmyeondong" />
                    <form:hidden path="defaultUserDelivery.address" />
                    <form:hidden path="defaultUserDelivery.addressDetail" />
                </div>
            </c:if>
        </c:if>

        <h1 class="title-h1 pc">주문/결제</h1>
        <div class="contents-area" ref="targetElement">
            <div class="contents-left">

                <c:if test="${!isLogin}">
                    <div class="toggle-title active">
                        <h2>주문자정보</h2>
                        <button type="button" class="toggle-arr"></button>
                    </div>

                    <div class="toggle-content info-delivery buyer-info">
                        <!-- 이름 -->
                        <div class="form-line">
                            <input name="userName" type="text" class="form-basic required" placeholder="홍길동" title="구매자 성함"/>
                            <span class="feedback invalid">유효성 메시지</span>
                        </div>
                        <!-- 전화번호 -->
                        <div class="form-line">
                            <input name="userPhone" type="text" class="form-basic required" placeholder="01011112222" title="구매자 휴대폰 번호" />
                            <span class="feedback invalid">유효성 메시지</span>
                        </div>
                        <!-- 이메일 -->
                        <div class="form-line">
                            <input name="userEmail" type="email" class="form-basic required" placeholder="abc@abc.com" title="구매자 이메일"/>
                            <span class="feedback invalid">유효성 메시지</span>
                        </div>
                    </div>
                </c:if>

                <!-- 배송정보 -->
                <div class="toggle-title active">
                    <h2 @click="showModal">배송정보</h2>
                    <button type="button" class="toggle-arr"></button>
                </div>
                <div class="toggle-content info-delivery">
                    <c:set var="disabled" value="${isLogin eq false ? '' : 'disabled' }" />
                    <c:set var="receivers" value="${buy.receivers[0]}" scope="request"/>

                    <!-- 주문 정보 -->
                    <c:forEach items="${receivers.buyQuantitys}" var="buyQuantity" varStatus="buyQuantityIndex">
                        <form:hidden path="receivers[0].buyQuantitys[${buyQuantityIndex.index}].itemSequence" value="${buyQuantity.itemSequence}" />
                        <form:hidden path="receivers[0].buyQuantitys[${buyQuantityIndex.index}].quantity" value="${buyQuantity.quantity}" />
                    </c:forEach>
                    <form:hidden path="receivers[0].receiveNewZipcode"/>
                    <form:hidden path="receivers[0].receivePhone" value="${receivers.receivePhone}"/>
                    <form:hidden path="receivers[0].receiveSido" />
                    <form:hidden path="receivers[0].receiveSigungu" />
                    <form:hidden path="receivers[0].receiveEupmyeondong" />

                    <div class="form-line">
                        <form:input path="receivers[0].receiveName" type="text" class="form-basic ${disabled} required" value="${receivers.receiveName}" placeholder="홍길동" title="수령인 성함"/>
                        <span class="feedback invalid">받는사람을 입력해주세요</span>
                    </div>
                    <div class="form-line">
                        <form:input type="text" path="receivers[0].receiveMobile" class="form-basic ${disabled} required" value="${receivers.receiveMobile}" placeholder="01011112222" title="수령인 전화번호"/>
                        <span class="feedback invalid">받는사람 휴대폰 정보를 입력해주세요</span>
                    </div>
                    <!-- 주소 (회원)-->
                    <div class="form-line">

                        <!-- 구매자 정보 -->
                        <form:hidden path="buyer.newZipcode" />
                        <form:hidden path="buyer.zipcode" />
                        <form:hidden path="buyer.address" />
                        <form:hidden path="buyer.addressDetail" />
                        <form:hidden path="buyer.sido" />
                        <form:hidden path="buyer.sigungu" />
                        <form:hidden path="buyer.eupmyeondong" />

                        <form:hidden path="buyer.userName" />
                        <form:hidden path="buyer.mobile" />
                        <form:hidden path="buyer.email" />
                        <form:hidden path="buyer.phone" />

                        <div class="flex">
                            <form:input type="text" path="receivers[0].receiveZipcode" class="form-basic disabled required" value="${receivers.receiveZipcode}" placeholder="08318" title="수령지 우편번호"/>

                            <c:choose>
                                <c:when test="${isLogin}">
                                    <button class="btn btn-black" type="button" onclick="getReceiveChangePopup()">주소변경</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-black" type="button" onclick="openDaumpostCode()">우편번호</button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <span class="feedback invalid">주소를 입력해주세요</span>
                    </div>
                    <div class="form-line">
                        <form:input type="text" path="receivers[0].receiveAddress" class="form-basic disabled required" value="${receivers.receiveAddress}" placeholder="서울 구로구 디지털로27길 24(벽산디지털밸리)" title="수령지 주소"/>
                        <span class="feedback invalid">주소를 입력해주세요</span>
                    </div>
                    <div class="form-line">
                        <form:input type="text" path="receivers[0].receiveAddressDetail" class="form-basic required" value="${receivers.receiveAddressDetail}" placeholder="711호 온라인파워스" title="수령지 상세 주소" />
                        <span class="feedback invalid">주소를 입력해주세요</span>
                    </div>

                    <!-- 배송문구 -->
                    <c:set var="selected" value="${receivers.content eq '' ? 'selected' : ''}" />
                    <div class="select-wrap">
                        <select class="input-select shipping-content">
                            <option value="집앞" selected="${selected}">집앞</option>
                            <option value="경비실">경비실</option>
                            <option value="">직접입력</option>
                        </select>
                    </div>
                    <!-- 배송문구 - 직접입력 선택일 때만 노출 -->
                    <div class="form-line shipping-content-input" style="display: none">
                        <input type="text" class="form-basic content-input" id="receivers[0].content" name="receivers[0].content" placeholder="직접입력" />
                        <span class="feedback invalid">배송메시지를 입력해주세요</span>
                    </div>
                </div>

                <!-- 주문 상품리스트 -->
                <div class="toggle-title active toggle-order-list">
                    <h2>주문상품 정보 (${response.buy.receivers[0].totalShippingCount}개)</h2>
                    <button type="button" class="toggle-arr"></button>
                </div>
                <c:forEach items="${response.buy.receivers[0].sellerShipping}" var="sellerShipping" >
                    <c:set var="shippingIndex" value="${response.buy.receivers[0].shippingIndex}" scope="request"/>
                    <c:set var="sellerId" value="${sellerShipping.sellerId}" scope="request"/>

                    <div class="toggle-content brand-container"> <!-- 반복요소 brand-container -->
                        <div class="brand-name"> ${sellerShipping.sellerName}(${sellerShipping.itemQuantity})</div>
                        <div class="brand-wrap">
                            <div class="product-list-container"> <!-- 반복요소 product-list-container -->
                                <ul class="product-list-wrap">
`                                    <c:set var="totalPriceList" value="${sellerShipping.totalPrice}" />

                                    <c:forEach items="${sellerShipping.shippings}" var="shipping" varStatus="index">
                                        <c:set var="shipping" value="${shipping}" scope="request"/>
                                        <c:set var="singleShipping" value="${shipping.singleShipping}"/>
                                        <c:set var="scope" value="order-list" scope="request"/>
                                        <c:set var="totalItemPrice" value="${totalPriceList[index.index]}" scope="request"/>

                                        <c:choose>
                                            <c:when test="${singleShipping eq true}">

                                                <c:set var="buyItem" value="${shipping.buyItem}" scope="request"/>
                                                <c:set var="lastItem" value="${true}" scope="request" />

                                                <jsp:include page="../include/buyItem/buy-item-list.jsp"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${shipping.buyItems}" var="buyItem" varStatus="itemIndex">
                                                    <c:set var="buyItem" value="${buyItem}" scope="request" />
                                                    <c:set var="lastItem" value="${itemIndex.last}" scope="request" />

                                                    <jsp:include page="../include/buyItem/buy-item-list.jsp"/>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- 포인트 -->
                <c:if test="${ not empty response.buy.buyPayments['point'] }">
                    <div class="toggle-title active">
                        <h2>포인트</h2>
                        <button type="button" class="toggle-arr"></button>
                    </div>
                    <div class="toggle-content">
                        <div class="info-point">
                            <form:hidden path="retentionPoint"/>
                            <c:set var="disabled" value="${response.buy.retentionPoint == 0 ? 'disabled':''}" />
                            <div class="point-status">
                                <p>보유 포인트</p>
                                <p class="point-possession" data-point="${response.buy.userTotalPoint}"><fmt:formatNumber value="${response.buy.userTotalPoint}" pattern="#,###"/> P</p>
                            </div>
                            <div class="use-point-wrap">
                                <div class="check-wrap">
                                    <label class="circle-input-checkbox">
                                        <input type="checkbox" class="use-all-point" ${disabled}><i></i>모두 사용
                                    </label>
                                </div>
                                <div class="use-point">
                                    <label class="input-point">
                                        <input id="usedPoint" class="expected-deducation-point" type="number" value="0" ${disabled} data-point="0">
                                        <form:hidden path="buyPayments['point'].amount" class="op-order-payAmounts ${buy.defaultPaymentType == 'point' ? 'op-default-payment' : '' }" />
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- 쿠폰 -->
                <c:if test="${response.useCoupon == true}">
                    <div class="op-coupon-hide-field-area hide hidden">
                        <c:if test="${ !empty response.buy.makeUseCouponKeys }">
                            <c:forEach items="${ buy.makeUseCouponKeys }" var="value">
                                <input type="hidden" name="useCouponKeys" value="${ value }" class="useCoupon" />
                            </c:forEach>
                        </c:if>
                    </div>
                </c:if>

                <!-- pg정보 -->
                <div class="pgInputArea">
                    <c:choose>
                        <c:when test="${response.configPg.pgType == 'inicis' }">
                            <inicis:inipay-input/>
                        </c:when>
                        <c:when test="${response.configPg.pgType == 'lgdacom' }">
                            <lgdacom:xpay-input />
                        </c:when>
                        <c:when test="${response.configPg.pgType == 'kspay' }">
                            <kspay:kspay-input />
                        </c:when>
                        <c:when test="${response.configPg.pgType == 'kcp' }">
                            <kcp:kcp-input />
                        </c:when>
                        <c:when test="${response.configPg.pgType == 'easypay' }">
                            <easypay:easypay-input />
                        </c:when>
                        <c:when test="${fn:toLowerCase(response.configPg.pgType) == 'nicepay' }">
                            <nicepay:nicepay-input />
                        </c:when>
                    </c:choose>
                </div>
                <!-- 결제수단 -->
                <div class="toggle-title active">
                    <h2>결제수단</h2>
                    <button type="button" class="toggle-arr"></button>
                </div>
                <div class="toggle-content info-payment-method">
                    <form:hidden path="${defaultPaymentType}"/>
                    <c:set var="approvalType" value="${buy.defaultPaymentType}"/>
                    <c:set var="approvalTypeLabel" value=""/>

                    <c:if test="${isLogin}" >
                        <p>
                            최근 결제수단으로 결제 : ${response.recentOrderPayment.approvalTypeLabel}
                        </p>
                    </c:if>
                    <ul class="payment-wrap" data-pay-type="${buy.defaultPaymentType}">
                        <c:if test="${ not empty response.buy.buyPayments['bank'] }">
                            <li class="payment default ${buy.defaultPaymentType eq 'bank' ? 'active' : ''}" data-payment="bank">
                                <img src="/static/content/image/cart/payment_bank_free.svg" alt="default">
                                <span>무통장입금</span>

                                <form:hidden path="buyPayments['bank'].amount" class="op-order-payAmounts ${buy.defaultPaymentType == 'bank' ? 'op-default-payment' : '' }"
                                             value="${buy.defaultPaymentType == 'bank' ? orderPrice.orderPayAmount : 0 }"
                                             data-payment-type="bank"/>
                            </li>
                        </c:if>
                        <c:if test="${ not empty response.buy.buyPayments['card'] }" >
                            <li class="payment default ${buy.defaultPaymentType eq 'card' ? 'active' : ''}" data-payment="card">
                                <img src="/static/content/image/cart/payment_card.svg" alt="default">
                                <span>신용카드</span>

                                <form:hidden path="buyPayments['card'].amount" class="op-order-payAmounts ${buy.defaultPaymentType == 'card' ? 'op-default-payment' : '' }"
                                             value="${buy.defaultPaymentType == 'card' ? orderPrice.orderPayAmount : 0 }"
                                             data-payment-type="card"/>
                            </li>
                        </c:if>
                        <c:if test="${ not empty response.buy.buyPayments['vbank'] }">

                            <li class="payment default ${buy.defaultPaymentType eq 'vbank' ? 'active' : ''}" data-payment="vbank">
                                <img src="/static/content/image/cart/payment_virtual.svg" alt="default">
                                <span>가상계좌</span>

                                <form:hidden path="buyPayments['vbank'].amount" class="op-order-payAmounts ${buy.defaultPaymentType == 'vbank' ? 'op-default-payment' : '' }"
                                             value="${approvalType == 'vbank' ? orderPrice.orderPayAmount : 0 }"
                                             data-payment-type="vbank"/>

                                <!-- 에스크로 설정값 -->
                                <form:hidden path="buyPayments['vbank'].escrowStatus" value="N"/>
                            </li>
                        </c:if>
                        <c:if test="${ not empty response.buy.buyPayments['hp'] }">
                            <li class="payment default ${buy.defaultPaymentType eq 'hp' ? 'active' : ''}" data-payment="hp">
                                <img src="/static/content/image/cart/payment_phone.svg" alt="default">
                                <span>휴대전화</span>

                                <form:hidden path="buyPayments['hp'].amount" class="op-order-payAmounts ${buy.defaultPaymentType == 'hp' ? 'op-default-payment' : '' }"
                                             value="${buy.defaultPaymentType == 'hp' ? orderPrice.orderPayAmount : 0 }"
                                             data-payment-type="hp"/>
                            </li>
                        </c:if>
                        <c:if test="${ not empty response.buy.buyPayments['realtimebank'] }">
                            <li class="payment default ${buy.defaultPaymentType eq 'realtimebank' ? 'active' : ''}" data-payment="realtimebank">
                                <img src="/static/content/image/cart/payment_realtime.svg" alt="default">
                                <span>실시간 계좌이체</span>

                                <form:hidden path="buyPayments['realtimebank'].amount" class="op-order-payAmounts ${buy.defaultPaymentType == 'realtimebank' ? 'op-default-payment' : '' }"
                                             value="${buy.defaultPaymentType == 'realtimebank' ? orderPrice.orderPayAmount : 0 }"
                                             data-payment-type="realtimebank"/>

                                <!-- 에스크로 설정값 -->
                                <form:hidden path="buyPayments['realtimebank'].escrowStatus" value="N"/>
                            </li>
                        </c:if>
                            <%--
                            <c:if test="${ not empty response.buy.buyPayments['naverpay'] }">
                                <li class="payment easy naver">
                                    <img src="/static/content/image/cart/payment_naver.svg" alt="easy">
                                </li>
                            </c:if>
                            <li class="payment easy kakao">
                                <img src="/static/content/image/cart/payment_kakao.svg" alt="easy">
                            </li>
                            <li class="payment easy toss">
                                <img src="/static/content/image/cart/payment_toss.svg" alt="easy">
                            </li>
                            <li class="payment easy kb">
                                <img src="/static/content/image/cart/payment_kb.svg" alt="easy">
                            </li>
                            <li class="payment easy hana">
                                <img src="/static/content/image/cart/payment_hana.svg" alt="easy">
                            </li>--%>
                    </ul>

                    <!-- 무통장입금 -->
                    <div class="payment-form-wrap bank">
                        <ul class="dot-list">
                            <li>무통장 입금시 발생하는 수수료는 손님 부담입니다.</li>
                            <li>인터넷 뱅킹 또는 은행창구 입금시 의뢰인(송금인)명은 ‘입금인 입력’ 란에 입금하신 성함과 동일하게 기재해 주시기 바랍니다. <br>
                                ( 만약 다를 경우 고객센터 1234-5678로 꼭 연락주시기 바랍니다.)</li>
                            <li>무통장 입금시 입금자와 입금 예정일을 입력해주세요.</li>
                            <li>현금영수증 미신청시 현금영수증 발급이 되지 않습니다.</li>
                        </ul>
                        <div class="payment-form" >
                            <h3 class="form-title">입금은행</h3>
                            <div class="select-wrap">
                                <div>
                                    <form:select path="buyPayments['bank'].bankVirtualNo" title="입금은행" class="input-select bank-info select-account">
                                        <option value="">은행을 선택하세요</option>

                                        <c:forEach items="${ response.buy.buyPayments['bank'].accountNumbers }" var="list">
                                            <c:set var="accountValue" value="${ list.bankName } 계좌번호： ${ list.accountNumber } (${ list.accountHolder })" />
                                            <form:option value="${ accountValue }" label="${accountValue}" />
                                        </c:forEach>
                                    </form:select>
                                </div>
                            </div>
                            <h3 class="form-title">입금자명</h3>
                            <div class="form-line">
                                <form:input path="buyPayments['bank'].bankInName" title="입금자명" class="form-basic bank-info select-account" />
                                <span class="feedback invalid">유효성 메시지</span>
                            </div>
                            <h3 class="form-title">입금예정일</h3>
                            <div class="select-wrap">
                                <form:select path="buyPayments['bank'].bankExpirationDate" title="입금예정일" class="bank-info select-account">
                                    <c:forEach items="${ buy.buyPayments['bank'].expirationDates }" var="item">

                                        <form:option value="${ item }" />
                                    </c:forEach>
                                </form:select>
                            </div>
                            <%--                            <h3 class="form-title">현금영수증 신청</h3>
                            <div class="radio-wrap">

                                    <c:forEach items="${response.cashbillTypes}" var="cashbillType" varStatus="i">
                                        ${cashbillType.label}
                                        &lt;%&ndash;<form:radiobutton path="cashbill.cashbillType" value="${cashbillType.code}" id="cashbill_${i.count}" label="${cashbillType.label}"
                                                          checked="${cashbillType.id == 'NONE' ? 'checked' : ''}"
                                                          />&ndash;%&gt;
                                    </c:forEach>
                            </div>
                            <div class="form-line">
                                <input type="text" class="form-basic" placeholder="휴대전화 또는 사업자등록번호 숫자만 입력" />
                                <!-- <span class="feedback invalid">유효성 메시지</span> -->
                            </div>--%>
                        </div>
                    </div>

                    <!-- 신용카드 -->
                    <jsp:include page="./payment/card.jsp"/>

                    <!-- 가상계좌 -->
                    <jsp:include page="./payment/vbank.jsp"/>

                    <!-- 휴대폰 결제 -->
                    <jsp:include page="./payment/mobile.jsp"/>

                    <!-- 실시간 계좌이체 -->
                    <jsp:include page="./payment/realtimebank.jsp"/>
                </div>

                <!-- 결제 예정 금액 -->
                <c:set var="orderPrice" value="${response.buy.orderPrice}" />
                <div class="total-expected">
                    <h3 class="content-title">
                        <i class="ico"><img src="/static/content/image/ico/ico_money.svg"
                                                                  alt="결제 예정 금액"></i>결제 예정 금액</h3>
                    <ul class="expected-info-wrap">
                        <li class="expected-info primary first">
                            <p>총 상품금액</p>
                            <p class="op-total-item-sale-amount-text"><fmt:formatNumber value="${orderPrice.totalItemPrice}" pattern="#,###"/><b>원</b></p>
                        </li>
                        <li class="expected-info">
                            <p>상품할인</p>
                            <p class="op-total-item-discount-amount-text">-<fmt:formatNumber value="${orderPrice.totalItemDiscountAmount}" pattern="#,###"/><b>원</b></p>
                        </li>
                        <c:if test="${orderPrice.totalSetDiscountAmount > 0}">
                            <li class="expected-info">
                                <p>세트할인</p>
                                <p class="op-total-user-discount-amount-text">-<fmt:formatNumber value="${orderPrice.totalSetDiscountAmount}" pattern="#,###"/><b>원</b></p>
                            </li>
                        </c:if>
                        <c:if test="${orderPrice.totalUserLevelDiscountAmount > 0}">
                            <li class="expected-info">
                                <p>회원할인</p>
                                <p class="op-total-user-discount-amount-text">-<fmt:formatNumber value="${orderPrice.totalUserLevelDiscountAmount}" pattern="#,###"/><b>원</b></p>
                            </li>
                        </c:if>
                        <li class="expected-info primary">
                            <p>배송비</p>
                            <p class="op-total-delivery-charge-text"><fmt:formatNumber value="${orderPrice.totalShippingAmount + orderPrice.totalShippingCouponDiscountAmount}" pattern="#,###"/><b>원</b></p>
                        </li>
                        <li class="expected-info primary">
                            <p>상품 쿠폰</p>
                            <p class="totalItemCouponDiscountAmountText">0<b>원</b></p>
                        </li>
                        <li class="expected-info primary">
                            <p>포인트 사용</p>
                            <p class="op-total-point-discount-amount-text">0<b>P</b></p>
                        </li>
                        <li class="expected-info primary last">
                            <p>최종 결제금액</p>
                            <p class="op-order-pay-amount-text"><fmt:formatNumber value="${orderPrice.orderPayAmount}" pattern="#,###"/><b>원</b></p>
                        </li>


                    </ul>
                </div>

                <!-- 약관동의 -->
                <div class="agree-terms mobile">
                    <div class="agree toggle-wrap active">
                        <label class="circle-input-checkbox"><input type="checkbox" class="agree-privacy mobile"><i></i></label>
                        개인정보 제 3자 제공동의
                        <i class="toggle-arr"></i>
                        <div class="toggle-content">
                            개인정보 제 3자 제공동의 내용 자리입니다 개인정보 제 3자 제공동의 내용 자리입니다 개인정보 제 3자 제공동의 내용 자리입니다
                        </div>
                    </div>
                    <div class="agree">
                        <label class="circle-input-checkbox"><input type="checkbox" class="agree-item-terms mobile"><i></i></label>
                        주문할 상품의 상품명, 상품가격, 배송정보를 확인하였으며, 구매에 동의 하시겠습니까?
                    </div>
                </div>

                <div class="floating-bottom mobile">
                    <div class="price-info final">
                        <p>총 결제금액(${response.buy.receivers[0].totalShippingCount})</p>
                        <p class="op-order-pay-amount-text"><fmt:formatNumber value="${orderPrice.orderPayAmount}" pattern="#,###"/><b>원</b></p>
                    </div>
                    <button type="submit" class="btn btn-primary btn-buy payment-btn">결제하기</button>
                </div>
            </form:form>
        </div>

        <div class="contents-right">
            <!-- 플로팅 어사이드 -->
            <div class="floating-aside">
                <div class="floating-contents">
                    <div class="title">최종 결제금액 </div>
                    <ul class="content expected-info-wrap">

                        <li class="expected-info primary first active"> <!-- 토글 시 active -->
                            <p class="toggle-wrap">총 상품금액<i class="toggle-arr"></i></p>
                            <p class="op-total-item-sale-amount-text"><fmt:formatNumber value="${orderPrice.totalItemPrice}" pattern="#,###"/><b>원</b></p>
                        </li>
                        <li class="expected-info sub">
                            <p>상품할인</p>
                            <p class="op-total-item-discount-amount-text">-<fmt:formatNumber value="${orderPrice.totalItemDiscountAmount}" pattern="#,###"/><b>원</b></p>
                        </li>
                        <c:if test="${orderPrice.totalSetDiscountAmount > 0}">
                            <li class="expected-info sub">
                                <p>세트할인</p>
                                <p class="op-total-user-discount-amount-text">-<fmt:formatNumber value="${orderPrice.totalSetDiscountAmount}" pattern="#,###"/><b>원</b></p>
                            </li>
                        </c:if>
                        <c:if test="${orderPrice.totalUserLevelDiscountAmount > 0}">
                            <li class="expected-info sub">
                                <p>회원할인</p>
                                <p class="op-total-user-discount-amount-text">-<fmt:formatNumber value="${orderPrice.totalUserLevelDiscountAmount}" pattern="#,###"/><b>원</b></p>
                            </li>
                        </c:if>
                        <li class="expected-info primary dashed-none">
                            <p>배송비</p>
                            <p class="op-total-delivery-charge-text">+ <fmt:formatNumber value="${orderPrice.totalShippingAmount + orderPrice.totalShippingCouponDiscountAmount}" pattern="#,###"/><b>원</b></p>
                        </li>
                        <li class="expected-info primary">
                            <p>상품 쿠폰</p>
                            <p class="totalItemCouponDiscountAmountText">0<b>원</b></p>
                        </li>
                        <li class="expected-info primary">
                            <p>포인트 사용</p>
                            <p class="op-total-point-discount-amount-text">0<b>P</b></p>
                        </li>
                        <li class="expected-info primary last">
                            <p>적립 예정 포인트</p>
                            <p class="op-earn-point-text"><fmt:formatNumber value="${orderPrice.totalEarnPoint}" pattern="#,###"/><b>P</b></p>
                        </li>
                    </ul>
                    <div>
                    </div>
                    <div class="agree-terms">
                        <div class="agree toggle-wrap active"> <label class="circle-input-checkbox">
                            <input class="agree-privacy pc" type="checkbox"><i></i></label>
                            개인정보 제 3자 제공동의
                            <i class="toggle-arr"></i>
                            <div class="toggle-content">
                                개인정보 제 3자 제공동의 내용 자리입니다 개인정보 제 3자 제공동의 내용 자리입니다 개인정보 제 3자 제공동의 내용 자리입니다
                            </div>
                        </div>
                        <div class="agree">
                            <label class="circle-input-checkbox"><input class="agree-item-terms pc" type="checkbox"><i></i></label>
                            주문할 상품의 상품명, 상품가격, 배송정보를 확인하였으며, 구매에 동의 하시겠습니까?
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary btn-round btn-floating payment-btn"><span class="op-order-pay-amount-text"></span> 결제하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
<daum:address />



<page:javascript>
        <%--
        <c:choose>
            <c:when test="${rebsponse.pgType == 'inicis'}">
                <inicis:inipay-script />
            </c:when>
            <c:when test="${response.pgType == 'lgdacom' }">
                <lgdacom:xpay-script />
            </c:when>
            <c:when test="${response.pgType == 'kspay' }">
                <kspay:kspay-script />
            </c:when>
            <c:when test="${response.pgType == 'kcp' }">
                <kcp:kcp-script />
            </c:when>
            <c:when test="${response.pgType == 'easypay' }">
                <easypay:easypay-script />
            </c:when>
            <c:when test="${response.pgType == 'nicepay' }">
                <nicepay:nicepay-script />
            </c:when>
        </c:choose>
        --%>

        <nicepay:nicepay-script />
        <script src="/static/content/modules/ui/order/handler.js"></script>
        <script src="/static/content/modules/ui/order/step1.js"></script>

        <script>

            const LOGIN_FLAG = '${isLogin}' == 'true';

            $(()=> {

                // 주문시 스크립트에서 사용할 데이터 초기화
                OrderHandler.init(${response.userData}, "${response.configPg.pgType}", '${response.config.minimumPaymentAmount}', '${response.config.pointUseMin}', '${response.config.pointUseMax}', '${response.config.pointUseRatio}', '${response.config.pointUseRatio}','${response.buy.retentionPoint}');

                // sns 연동정보 확인
                OrderHandler.setSnsInfo();

                // 배송비 재 설정
                OrderHandler.getIslandType();

                // 쿠폰 사용체크
                OrderHandler.setShippingAmount();

                // 할인 적용내용 초기화!!
                historyBackDataSet();

            })
        </script>
    </page:javascript>

    <page:model>
        <c:if test="${salesonContext.login}">
            <div class="modal modal-address-list"></div> <!-- 회원 주소 리스트 팝업 -->
            <div class="modal address-modal"></div> <!-- 주소 추가 팝업 -->
            <div class="modal modal-apply-coupon"> <!-- 쿠폰 적용 팝업-->
                <jsp:include page="./popup/apply-coupon.jsp"/>
            </div>
        </c:if>
        <div class="modal modal-product-detail"></div> <!-- 구성상품 보기 -->
    </page:model>

</layout:default>