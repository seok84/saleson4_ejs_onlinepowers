<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<!-- 모달 -->
<!-- 구성상품 -->
<c:set var="buyItems" value="${response.buyItems}"/>

<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">
        구성상품

    </div>
    <div class="p-2 modal-body">
        <!-- 아이템 리스트 horizon -->

        <div class="item-list-container horizon">
            <!-- 반복 요소 item-list -->
            <c:forEach items="${buyItems}" var="item" varStatus="index">
                <c:set var="itemPrice" value="${item.itemPrice}" />
                <c:set var="itemDetail" value="${item.itemDetailResponse}" />

                <div class="item-list">
                    <!-- 아이템 썸네일 영역 -->
                    <div class="thumbnail-container sold-out">
                        <c:if test="${itemDetail.itemSoldOutFlag eq 'Y' ? 'sold-out': ''}">
                            <div class="sold-out-wrap">
                                <span>
                                    <img src="/static/content/image/sample/sold-out.png" alt="품절">
                                </span>
                            </div>
                        </c:if>
                        <div class="thumbnail-wrap">
                            <img class="thumbnail" src="${itemDetail.itemImage}" onerror="errorImage(this)" alt="${itemDetail.itemName}">
                        </div>
                    </div>
                    <!-- 아이템 정보 영역 -->
                    <div class="info-container">
                        <div class="title-main paragraph-ellipsis">
                            <c:if test="${not empty itemDetail.brand}">
                                <b>[${itemDetail.brand}]</b>
                            </c:if>
                                ${itemDetail.itemName}
                        </div>
                        <div class="title-sub paragraph-ellipsis">
                            <c:if test="${itemDetail.itemOptionFlag eq 'Y'}">
                                ${item.options}
                            </c:if>
                        </div>
                        <div class="purchase-amount">
                            <p class="price"><fmt:formatNumber value="${itemDetail.salePrice}" pattern="#,###"/>원</p>
                            <p class="amount">수량 ${itemPrice.quantity}개</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<div class="dimmed-bg" data-dismiss></div>
