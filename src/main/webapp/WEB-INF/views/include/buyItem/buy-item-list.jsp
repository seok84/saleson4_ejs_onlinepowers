<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="itemDetail" value="${buyItem.itemDetailResponse}" />
<c:set var="itemPrice" value="${buyItem.itemPrice}" />
<c:set var="itemDetailShipping" value="${buyItem.itemDetailResponse.shipping}" />

<!--
* scope = {"cart-list", "order-list", "coupon-list"}
순서대로 장바구니, 주문서, 주문서 쿠폰리스트
-->

    <li class="product-list ${scope} ${buyItem.orderQuantity.soldOutFlag eq true ? 'sold-out' : ''}"> <!-- 반복요소 product-list -->
        <c:if test="${scope eq 'cart-list'}">
            <button class="btn-close" type="button" onclick="deleteCartId(`${buyItem.cartId}`)"></button>
        </c:if>
        <div class="product-info-group">
            <div class="calculate-event" style="display: none"
                 data-sale-price="${itemPrice.itemSalePrice  + itemPrice.optionPrice}"
                 data-quantity="${itemPrice.quantity}"
                 data-discount-price="${itemPrice.discountPrice}"
                 data-earn-point="${itemPrice.earnPoint}"
                 data-shipping="${shipping.shipping}"
                 data-shipping-type="${shipping.shippingType}"
                 data-shipping-group-type="${shipping.shippingGroupCode}"
                 data-shipping-free-amount="${shipping.shippingFreeAmount}"
                 data-shipping-item-count="${shipping.shippingItemCount}"
            ></div>
            <div class="product-info info1">
                <!-- 아이템 -->
                <div class="product-item">
                    <div class="item-list-container horizon">
                        <div class="item-list">
                            <!-- 체크박스 -->
                            <c:if test="${scope eq 'cart-list'}">
                                <label class="circle-checkbox">
                                    <c:set var="disabled" value="${buyItem.orderQuantity.soldOutFlag eq true ? 'disabled' : ''}" />
                                    <input type="checkbox" class="checkbox sub ${not empty disabled ? 'check-sold-out' : ''}" id="${buyItem.cartId}" data-group="${buyItem.sellerId}" onchange="subGroupCheck(${buyItem.sellerId})" ${disabled} ><i></i>
                                </label>
                            </c:if>
                            <!-- 아이템 썸네일 영역 -->
                            <div class="thumbnail-container sold-out">
                                <c:if test="${buyItem.orderQuantity.soldOutFlag eq true }" >
                                    <div class="sold-out-wrap" onclick="$saleson.core.redirect('/item/${buyItem.itemUserCode}')">
                                        <span>
                                            <img src="/static/content/image/sample/sold-out.png" alt="품절">
                                        </span>
                                    </div>
                                </c:if>
                                <div class="thumbnail-wrap">
                                    <img class="thumbnail" src="${itemDetail.itemImage}" onerror="errorImage(this)" alt="${buyItem.itemName}" onclick="$saleson.core.redirect('/item/${buyItem.itemUserCode}')">
                                </div>
                                <c:if test="${scope eq 'cart-list'}">
                                    <div class="user-action">
                                        <div class="user-ico user-attention" data-item="${buyItem.itemId}">관심상품</div>
                                    </div>
                                </c:if>
                            </div>
                            <!-- 아이템 정보 영역 -->
                            <div class="info-container">
                                <div class="title-main paragraph-ellipsis">
                                    <c:if test="${not empty buyItem.brand}">
                                        <b>[${buyItem.brand}]</b>
                                    </c:if>
                                    ${buyItem.itemName}
                                </div>
                                <div class="title-sub paragraph-ellipsis">
                                    ${buyItem.options}
                                </div>
                                <c:if test="${buyItem.setItemFlag eq 'Y'}">
                                    <c:choose>
                                        <c:when test="${scope eq 'cart-list'}">
                                            <div class="underline red" onclick="getFreegiftItemPopupByCartId('${buyItem.cartId}')">
                                                구성 상품 보기
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="underline red" onclick="getFreegiftItemPopupByOrder('${buyItem.itemId}')">
                                                구성 상품 보기
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty buyItem.freeGiftItemList}">
                        <div class="item-gift">
                            <span><i>선물</i>구매 사은품</span>
                            <span>${buyItem.freeGiftItemText}</span>
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="product-info info2 item-price-info-${buyItem.itemSequence}-${shippingIndex}"
                 data-item-sale-price="${itemPrice.itemSalePrice}"
                 data-item-quantity="${itemPrice.quantity}"
                 data-item-discount-amount="${itemPrice.discountAmount}"
                 data-item-sale-amount="${itemPrice.saleAmount}">

                <c:choose>
                    <c:when test="${scope eq 'cart-list'}">
                        <div class="product-info2-price">
                            <p>상품가 <fmt:formatNumber value="${(itemPrice.itemSalePrice + itemPrice.optionPrice) * itemPrice.quantity}" pattern="#,###"/>원</p>
                            <p>할인 <fmt:formatNumber value="${itemPrice.discountAmount}" pattern="#,###"/>원</p>
                        </div>
                        <p class="discounted">할인적용가 <fmt:formatNumber value="${itemPrice.saleAmount}" pattern="#,###"/>원</p>
                    </c:when>
                    <c:otherwise>
                        <div class="info2-list">
                            <p>상품가 <fmt:formatNumber value="${(itemPrice.itemSalePrice  + itemPrice.optionPrice) * itemPrice.quantity}" pattern="#,###"/>원</p>
                            <p>할인 <span class="op-expected-discount-amount ${scope eq 'order-list' ? 'order' : 'coupon'}-${buyItem.itemSequence}-${shippingIndex}"><fmt:formatNumber value="${itemPrice.discountAmount}" pattern="#,###"/></span>원</p>
                            <p class="discounted">할인적용가 <span class="op-expected-item-sale-amount ${scope eq 'order-list' ? 'order' : 'coupon'}-${buyItem.itemSequence}-${shippingIndex}"><fmt:formatNumber value="${itemPrice.saleAmount}" pattern="#,###"/></span>원</p>
                        </div>
                        <p class="quantity">수량:${itemPrice.quantity}개</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${scope eq 'cart-list' or scope eq 'order-list'}">
                <div class="product-info info3">
                    <c:choose>
                        <c:when test="${scope eq 'cart-list'}">
                            <div class="quantity-wrap">
                                <div class="quantity-box"
                                     data-max-Quantity="${buyItem.orderQuantity.maxQuantity}"
                                     data-min-Quantity="${buyItem.orderQuantity.minQuantity}">

                                    <button type="button" class="btn-quantity btn-minus" onclick="updateQuantityValue(${buyItem.cartId}, false)"></button>
                                    <input type="number" id="${buyItem.cartId}_quantity" title="수량" readonly
                                           value="${itemPrice.quantity}"
                                           data-quantity="${itemPrice.quantity}"
                                           maxlength="999" class="quantity number">
                                    <button type="button" class="btn-quantity btn-plus" onclick="updateQuantityValue(${buyItem.cartId}, true)"></button>
                                </div>

                                <button class="btn btn-change" type="button" onclick="updateQuantity(${buyItem.cartId})">변경</button>
                            </div>
                            <c:if test="${!buyItem.orderQuantity.soldOutFlag eq true}">
                                <button class="btn btn-primary-line btn-buynow" type="button" onclick="executeDirectPurchase(${buyItem.cartId})">바로구매</button>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${fn:length(buyItem.itemCoupons) > 1}">
                                    <p class="op-used-coupon itemCouponUsedArea-${buyItem.itemSequence} coupon-apply"></p>
                                    <button class="btn btn-round btn-coupon" type="button" onclick="availableCouponsCheck()">상품 쿠폰 적용</button>
                                </c:when>
                                <c:otherwise>
                                    <p class="coupon-none">적용 쿠폰 없음</p>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>

        <c:if test="${scope eq 'coupon-list'}" >
            <div class="select-coupon">
                <div class="select-wrap">
                    <c:set var="itemCoupons" value="${buyItem.itemCoupons}" />
                    <c:choose>
                        <c:when test="${ !empty itemCoupons }">
                            <c:set var="itemCouponAreaKey" value="coupon-${ buyItem.itemSequence }-${shippingIndex}" />
                            <c:forEach items="${ itemCoupons }" var="coupon">
                                <c:set var="couponKey" value="item-coupon-${coupon.couponUserId}-${ buyItem.itemSequence }-${shippingIndex}" />
                                <div class="hide hidden" data-item-coupon-area-key="${ itemCouponAreaKey }">
                                    <c:set var="couponKey" value="item-coupon-${coupon.couponUserId}-${ buyItem.itemSequence }-${shippingIndex}" />
                                    <span
                                            data-coupon-key="${couponKey}"
                                            data-coupon-name="${coupon.couponName}"
                                            data-coupon-user-id="${coupon.couponUserId}"
                                            data-discount-amount="${coupon.discountAmount}"
                                            data-discount-price="${coupon.discountPrice}"
                                            data-coupon-concurrently="${coupon.couponConcurrently}"
                                            data-coupon-type="default"
                                            data-item-sequence="${ buyItem.itemSequence }"
                                            data-shipping-index="${shippingIndex}"></span>
                                </div>

                            </c:forEach>

                            <select class="input-select op-item-coupon" name="op-item-coupon-select" data-coupon-area-key="${ itemCouponAreaKey }">
                                <option value="clear">쿠폰을 선택해주세요.</option>
                                <c:forEach items="${ itemCoupons }" var="coupon">
                                    <c:set var="couponKey" value="item-coupon-${coupon.couponUserId}-${ buyItem.itemSequence }-${shippingIndex}" />
                                    <option value="${ couponKey }" data-coupon-user-id="${coupon.couponUserId}" data-item-sequence="${ buyItem.itemSequence }" data-shipping-index="${shippingIndex}">
                                            ${coupon.couponUserId}. ${coupon.couponName}
                                        - ${(coupon.discountAmount)}원 할인

                                        <c:choose>
                                            <c:when test="${coupon.couponConcurrently == '1'}">[1개 수량만 적용]</c:when>
                                            <c:otherwise>[구매 수량 할인]</c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <!--  쿠폰이 없을 경우 -->
                            <p>사용가능한 쿠폰이 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>
        <c:if test="${lastItem eq true}">
            <div class="product-price">
                <div class="price-info info1 op-shipping-text-${shipping.shippingSequence}">
                    <p>
                        <span class="total-item-price-${shipping.shippingSequence}" data-price="${totalItemPrice.groupTotalItemSalePrice}">
                            상품금액 <fmt:formatNumber value="${totalItemPrice.groupTotalItemSalePrice}" pattern="#,###"/>원 +
                        </span>
                        <span class="shipping-price-text">배송비 <span class="shipping-amount-text-${shipping.shippingSequence}"><fmt:formatNumber value="${totalItemPrice.groupTotalShippingPrice}" pattern="#,###"/></span>원</span>
                        <b class="order-price-text">= <span class="group-order-price-text-${shipping.shippingSequence}"><fmt:formatNumber value="${totalItemPrice.groupTotalPrice}" pattern="#,###"/></span>원</b>
                    </p>
                    <c:if test="${shipping.shippingType ne 1 and shipping.realShipping ne 0 and shipping.shippingFreeAmount > 0}">
                        <p>(<b><fmt:formatNumber value="${shipping.shippingFreeAmount}" pattern="#,###"/>원 이상</b> 무료배송)</p>
                    </c:if>
                </div>
                <div class="price-info info2">
                    <p>
                        <span class="">
                                ${shipping.shippingTypeLabel}
                        </span>
                        <c:choose>
                            <c:when test="${itemDetail.deliveryType eq '1'}">
                                <c:set var="deliveryCompanyName" value="본사" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="deliveryCompanyName" value="${itemDetail.deliveryCompanyName}" />
                            </c:otherwise>
                        </c:choose>

                        <b>
                            <c:if test="${not empty deliveryCompanyName}">
                                (${deliveryCompanyName})
                            </c:if>
                        </b>
                    </p>
                    <c:if test="${not empty shipping.shippingTypeMessage}">
                        <i class="tooltip-handler">!</i>
                        <div class="tooltip-wrap">
                            <div class="dimmed-bg" data-dismiss-tooltip></div>
                            <div class="text-center tooltip-content tooltip-delivery">
                                <button type="button" class="btn-tooltip-close" data-dismiss-tooltip>닫기</button>
                                <p class="tooltip-tit">${shipping.shippingTypeLabel}</p>
                                <p class="txt1">${shipping.shippingTypeMessage}</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
    </li>
