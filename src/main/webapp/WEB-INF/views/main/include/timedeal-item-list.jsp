<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:if test="${not empty timedealItems and not empty timedealItems.content}">
    <c:forEach var="item" items="${timedealItems.content}">
        <c:set var="item" value="${item}" scope="request"/>

        <div class="swiper-slide item-element" data-item-user-code="${item.itemUserCode}">
            <div class="thum redirect-item-view">
                <img src="${item.itemImage}" alt="${item.itemName}" onerror="errorImage(this)" loading="lazy" decoding="async">
            </div>
            <div class="info-container">
                <div class="time-area redirect-item-view" data-spot-countdown-date="${item.spotCountdownDate}">
                    <span class="timer-day"></span>
                    <span class="timer-time"></span>
                </div>

                <div class="title-main paragraph-ellipsis redirect-item-view">
                    <c:if test="${not empty item.brand}"><b>[${item.brand}]</b></c:if>${item.itemName}
                </div>
                <c:if test="${item.discountRate > 0}">
                    <div class="discounted redirect-item-view">
                        <span><fmt:formatNumber value="${item.salePrice}" pattern="#,###"/></span>원
                    </div>
                </c:if>
                <div class="flex justify-between">
                    <div class="price-wrap redirect-item-view">
                        <p class="price">
                            <span><fmt:formatNumber value="${item.presentPrice}" pattern="#,###"/></span>
                            <span>원</span>
                        </p>
                        <c:if test="${item.discountRate > 0}">
                            <p class="sale">${item.discountRate}%</p>
                        </c:if>
                    </div>

                    <jsp:include page="/WEB-INF/views/include/item/user-action.jsp"/>

                </div>

                <c:if test="${not empty item.labels}">
                    <div class="tag-wrap type-underline">
                        <c:forEach var="label" items="${item.labels}">
                            <div class="tag" style="background-color: ${label.color}">${label.label}</div>
                        </c:forEach>
                    </div>
                </c:if>

            </div>
            <jsp:include page="/WEB-INF/views/include/item/analytics-data.jsp"/>
        </div>

    </c:forEach>
</c:if>
