<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <div class="contents-area-page cart-page">
        <h1 class="title-h1 pc">장바구니</h1>
        <input id="isLogin" type="hidden" value="${isLogin}">
        <input id="message" type="hidden" value="${message}">
        <c:choose>
            <c:when test="${!empty response.receivers.sellerShipping}">
                <div class="contents-area">
                    <div class="contents-left">
                        <!-- 전체선택 -->
                        <div class="select-all-wrap">
                            <div class="select-all">
                                <label class="circle-checkbox">
                                    <input type="checkbox" class="checkbox" onchange="checkAll()" name="allCheck"><i></i>
                                </label>
                                전체선택
                            </div>
                            <button class="btn btn-default btn-round btn-delete" type="button" onclick="deleteCartIds()" >선택삭제</button>
                        </div>
                        <!-- 장바구니/주문서 리스트 -->
                        <c:forEach items="${response.receivers.sellerShipping}" var="sellerShipping" >
                            <c:set var="shippingIndex" value="${response.receivers.shippingIndex}" scope="request"/>
                            <c:set var="sellerId" value="${sellerShipping.sellerId}" scope="request"/>

                            <div class="brand-container">
                                <div class="brand-name">
                                    <label class="circle-checkbox">
                                    <input type="checkbox" class="checkbox main" onchange="mainGroupCheck(${sellerId})" data-group="${sellerId}"><i></i>
                                    </label>
                                    ${sellerShipping.sellerName}(${sellerShipping.itemQuantity})
                                </div>
                                <div class="brand-wrap">
                                    <div class="product-list-container">
                                        <ul class="product-list-wrap">
                                        <c:set var="totalPriceList" value="${sellerShipping.totalPrice}" />

                                        <c:forEach items="${sellerShipping.shippings}" var="shipping" varStatus="index">
                                            <c:set var="shipping" value="${shipping}" scope="request"/>
                                            <c:set var="singleShipping" value="${shipping.singleShipping}"/>
                                            <c:set var="scope" value="cart-list" scope="request"/>
                                            <c:set var="totalItemPrice" value="${totalPriceList[index.index]}" scope="request"/>

                                            <c:choose>
                                                <c:when test="${singleShipping eq true}">
                                                    <c:set var="buyItem" value="${shipping.buyItem}" scope="request"/>
                                                    <c:set var="lastItem" value="${true}" scope="request" />
                                                    <c:set var="itemPrice" value="${buyItem.itemPrice}" scope="request" />

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
                        <!-- 총금액 -->
                        <c:set var="orderPrice" value="${response.orderPrice}" />
                        <c:set var="totalShippingCount" value="${response.receivers.totalShippingCount}" />
                        <div class="total-product pc">
                            <h3 class="content-title"><i class="ico"><img src="/static/content/image/ico/ico_money.svg"
                                                                          alt="전체 상품 합계"></i>전체 상품 합계</h3>
                            <div class="price-info-wrap">

                                <div class="price-info">
                                    <p>총 상품금액</p>
                                    <p class="total-item-amount"><fmt:formatNumber value="${orderPrice.totalItemAmountBeforeDiscounts}" pattern="#,###"/><b>원</b></p>
                                </div>
                                <div class="operator">+</div>
                                <div class="price-info">
                                    <p>배송비</p>
                                    <p class="total-shipping-amount"><fmt:formatNumber value="${orderPrice.totalShippingAmount}" pattern="#,###"/><b>원</b></p>
                                </div>
                                <div class="operator">-</div>
                                <div class="price-info">
                                    <p>할인혜택</p>
                                    <p class="total-discount-amount"><fmt:formatNumber value="${orderPrice.totalDiscountAmount}" pattern="#,###"/><b>원</b></p>
                                </div>
                                <div class="operator">=</div>
                                <div class="price-info final">
                                    <p>최종 결제금액</p>
                                    <p class="order-pay-amount"><fmt:formatNumber value="${orderPrice.orderPayAmount}" pattern="#,###"/><b>원</b></p>
                                </div>
                            </div>
                        </div>
                        <div class="total-product mobile">
                            <h3 class="content-title"><i class="ico">
                                <img src="/static/content/image/ico/ico_money.svg" alt="전체 상품 합계"></i>전체 상품 합계</h3>
                            <div class="price-info-wrap">
                                <div class="price-info">
                                    <p>총 상품금액</p>
                                    <p class="total-item-amount"><fmt:formatNumber value="${orderPrice.totalItemAmountBeforeDiscounts}" pattern="#,###"/><b>원</b></p>
                                </div>
                                <div class="price-info">
                                    <p>배송비</p>
                                    <p class="total-shipping-amount"><fmt:formatNumber value="${orderPrice.totalShippingAmount}" pattern="#,###"/><b>원</b></p>
                                </div>
                                <div class="price-info">
                                    <p>할인혜택</p>
                                    <p class="total-discount-amount"><fmt:formatNumber value="${orderPrice.totalDiscountAmount}" pattern="#,###"/><b>원</b></p>
                                </div>
                            </div>
                        </div>
                        <div class="floating-bottom mobile">
                            <div class="price-info final">
                                <p>최종 결제금액</p>
                                <p class="order-pay-amount"><fmt:formatNumber value="${orderPrice.orderPayAmount}" pattern="#,###"/><b>원</b></p>
                            </div>
                            <button class="btn btn-primary btn-buy" onclick="executePaymentStep()" >주문하기(${totalShippingCount})</button>
                        </div>
                    </div>
                    <div class="contents-right">
                        <!-- 플로팅 어사이드 -->
                        <div class="floating-aside">
                            <div class="floating-contents">
                                <div class="title">최종 결제금액</div>
                                <ul class="content">
                                    <li>
                                        <p>총 상품금액</p>
                                        <p class="total-item-amount"><fmt:formatNumber value="${orderPrice.totalItemPrice}" pattern="#,###"/><b>원</b></p>
                                    </li>
                                    <li>
                                        <p>배송비</p>
                                        <p class="total-shipping-amount"><fmt:formatNumber value="${orderPrice.totalShippingAmount}" pattern="#,###"/><b>원</b></p>
                                    </li>
                                    <li class="benefit">
                                        <p>총 할인혜택</p>
                                        <p class="total-discount-amount">- <fmt:formatNumber value="${orderPrice.totalDiscountAmount}" pattern="#,###"/><b>원</b></p>
                                    </li>
                                    <li class="point">
                                        <p>적립예정 포인트</p>
                                        <p class="total-earn-point">${orderPrice.totalEarnPoint} P</p>
                                    </li>
                                </ul>
                                <div class="total">
                                    <p></p>
                                    <p class="order-pay-amount"><fmt:formatNumber value="${orderPrice.orderPayAmount}" pattern="#,###"/><b>원</b></p>
                                </div>
                                <button class="btn btn-primary btn-round btn-floating" type="button" onclick="executePaymentStep()">주문하기</button>
                            </div>
                        </div>

                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 노컨텐츠 -->
                <div class="no-contents">
                    <img src="/static/content/image/item/no-contents.svg" alt="상품없음">
                    <p>엇? 장바구니에 아무것도 없어요<br>
                        상품을 둘러볼까요? :D</p>
                    <button class="btn btn-primary-line btn-round btn-home" type="button" onclick="goToMain()">메인으로</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/cart/cart.js"></script>
        <script>
            $(() =>{
                salesOnUI.tooltip('.tooltip-handler');
            })
        </script>
    </page:javascript>

    <page:model>
        <div class="modal modal-product-detail"></div> <!-- 구성상품 보기 -->
    </page:model>

</layout:default>