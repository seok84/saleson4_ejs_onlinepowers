<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty newItems and not empty newItems.content}">
    <ul>
        <c:forEach var="item" items="${newItems.content}">
            <c:set var="item" value="${item}" scope="request"/>
            <li class="item-element" data-item-user-code="${item.itemUserCode}">
                <div class="thumb redirect-item-view"><img src="${item.itemImage}" alt="${item.itemName}" onerror="errorImage(this)" loading="lazy" decoding="async"></div>
                <div class="hover">
                    <div class="info">

                        <jsp:include page="/WEB-INF/views/include/item/user-action.jsp"/>

                        <a href="#" class="redirect-item-view">
                            <div class="goods-title">${item.displayItemName}</div>
                            <c:if test="${item.discountRate > 0}">
                                <div class="discounted">
                                    <fmt:formatNumber value="${item.salePrice}" pattern="#,###"/>원
                                </div>
                            </c:if>
                            <div class="price-wrap">
                                <p class="price">
                                    <span><fmt:formatNumber value="${item.presentPrice}" pattern="#,###"/></span>원
                                </p>
                                <c:if test="${item.discountRate > 0}">
                                    <p class="sale">${item.discountRate}%</p>
                                </c:if>

                            </div>
                        </a>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/views/include/item/analytics-data.jsp"/>
            </li>
        </c:forEach>

    </ul>
</c:if>

