<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 아이템 썸네일 영역 -->
<div class="item-element ${not empty itemListContainerClass ? itemListContainerClass : 'item-list'} ${not empty itemListClass ? itemListClass : 'item-list-4'}"
     data-item-user-code="${item.itemUserCode}"
>
    <c:if test="${wishCheckBoxFlag}">
    <label class="checkbox"><input type="checkbox" value="${wishlistId}"><i></i></label>
    </c:if>
    <div class="thumbnail-container ${item.itemSoldOutFlag eq 'Y' ? 'sold-out': ''}">
        <div class="sold-out-wrap">
            <span>
                <img src="/static/content/image/sample/sold-out.png" alt="품절">
            </span>
        </div>
        <c:if test="${not empty item.rank}">
            <div class="rank best">${item.rank}</div>
        </c:if>

        <div class="thumbnail-wrap redirect-item-view">
            <img class="thumbnail" src="${not empty itemImage ? itemImage : item.itemImage}" alt="${item.itemName}" onerror="errorImage(this)" loading="lazy" decoding="async">
        </div>

        <c:if test="${displaySpotFlag}">
            <c:if test="${item.spotFlag && (empty relationItemFlag || relationItemFlag eq 'N') }">
                <c:choose>
                    <c:when test="${'1' eq item.spotDateType}">
                        <div class="timedeal">
                            <p>
                                <span>TIME</span>
                                <span>SALE</span>
                            </p>
                            <p>
                                <span>${item.displaySpotStartTime} ~ ${item.displaySpotEndTime}</span>
                                <span>${item.weekDays}</span>
                            </p>
                        </div>
                    </c:when>
                    <c:when test="${'2' eq item.spotDateType}">
                        <div class="timedeal spot-timer" data-spot-countdown-date="${item.spotCountdownDate}">
                            <p>
                                <span>TIME</span>
                                <span>SALE</span>
                            </p>
                            <p class="d-day">
                                <span class="timer-day">D-00</span>
                                <span class="timer-time">00 : 00 : 00</span>
                            </p>
                        </div>
                    </c:when>
                </c:choose>

            </c:if>
        </c:if>


        <jsp:include page="user-action.jsp"/>
    </div>
    <!-- 아이템 정보 영역 -->
    <div class="info-container redirect-item-view ${item.itemSoldOutFlag eq 'Y' ? 'sold-out': ''}">
        <div class="title-main paragraph-ellipsis">
            ${item.displayItemName}
        </div>
        <div class="title-sub paragraph-ellipsis">
            ${item.itemSummary}
        </div>
        <c:if test="${item.discountRate > 0}">
            <div class="discounted"><fmt:formatNumber value="${item.salePrice}" pattern="#,###"/>원</div>
        </c:if>

        <div class="price-wrap">
            <p class="price">
                <span><fmt:formatNumber value="${item.presentPrice}" pattern="#,###"/></span>
                <span>원</span>
            </p>
            <c:if test="${item.discountRate > 0}">
                <p class="sale">${item.discountRate}%</p>
            </c:if>

        </div>
        <c:if test="${not empty item.labels}">
            <div class="tag-wrap">
                <c:forEach var="label" items="${item.labels}">
                    <div class="tag" style="background-color: ${label.color}">${label.label}</div>
                </c:forEach>
            </div>
        </c:if>

    </div>
    <jsp:include page="analytics-data.jsp"/>
</div>