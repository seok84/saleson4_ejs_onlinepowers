<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="item-list-container horizon order-item-element"
     data-item-user-code="${i.itemUserCode}"
     data-sale-price="${i.salePrice}"
>
    <c:if test="${not empty claimType && claimType == '1'}">
        <label class="checkbox">
            <input type="checkbox" name="id" value="${i.claimApplyItemKey}" onchange="getRefundPrice();"/><i></i>
        </label>
        <input type="hidden" name="claimApplyItemMap[${i.claimApplyItemKey}].itemSequence" value="${i.itemSequence}">
    </c:if>
    <div class="item-list">
        <!-- 아이템 썸네일 영역 -->
        <div class="thumbnail-container sold-out">
            <div onclick="$saleson.core.redirect('/item/${i.itemUserCode}')" class="thumbnail-wrap">
                <img class="thumbnail" src="${i.imageSrc}" alt="${i.itemName}" onerror="errorImage(this)">
            </div>
        </div>
        <!-- 아이템 정보 영역 -->
        <div class="info-container">
            <div class="title-main paragraph-ellipsis">
                <c:if test="${not empty i.brand}">
                    <b>[${i.brand}]</b>
                </c:if>
                ${i.itemName}
            </div>
            <c:if test="${not empty i.options}">
                <div class="title-sub paragraph-ellipsis">
                        ${i.options}
                </div>
            </c:if>
            <%--<div class="underline red" onclick="salesOnUI.modal('.modal-product')">
                구성 상품 보기
            </div>--%>
            <div class="purchase-amount">
                <p class="price"><fmt:formatNumber value="${i.itemAmount}" pattern="#,###"/>원</p>
                <p class="amount">수량 ${i.quantity}개</p>
            </div>
            <!-- 취소/교환/반품 -->
            <c:if test="${not empty claimType}">
                <c:choose>
                    <c:when test="${claimType == '1'}">
                        <div class="select-wrap select-amount">
                            <span>수량</span>
                            <select name="claimApplyItemMap[${i.claimApplyItemKey}].applyQuantity" class="input-select small-arr" onchange="getRefundPrice();">
                                <c:forEach begin="1" end="${i.quantity - i.claimApplyQuantity}" step="1" var="quantity">
                                    <option value="${quantity}" ${quantity == (i.quantity - i.claimApplyQuantity) ? 'selected' : ''}>${quantity}개</option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:when>
                    <c:when test="${claimType == '2' || claimType == '3'}">
                        <div class="select-wrap select-amount">
                            <span>수량</span>
                            <select name="applyQuantity" class="input-select small-arr">
                            <c:forEach begin="1" end="${i.quantity - i.claimApplyQuantity}" step="1" var="quantity">
                                <option value="${quantity}" ${quantity == (i.quantity - i.claimApplyQuantity) ? 'selected' : ''}>${quantity}개</option>
                            </c:forEach>
                            </select>
                        </div>
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
</div>