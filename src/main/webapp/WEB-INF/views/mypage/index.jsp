<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:mypage>

    <section class="mypage-main">
        <div class="title-container">
            <h2 class="title-h2">최근 주문 내역</h2>
            <a href="/mypage/info/order" class="link">전체보기<i class="arrow"></i></a>
        </div>
        <!-- // 최근 주문 내역 -->
        <div class="order-item-wrapper">
            <c:choose>
             <c:when test="${!empty content.orderList[0]}">
            <c:set var="o" value="${content.orderList[0]}"></c:set>
            <c:set var="i" value="${content.orderList[0].items[0]}"></c:set>

            <div class="order-item">
                <div class="info">
                    <span class="date">
                            <fmt:parseDate value="${o.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </span>
                    <a href="/mypage/info/order-detail/${o.orderCode}" class="detail">
                        <span>${o.orderCode}</span>
                        주문상세
                        <i class="arrow"></i>
                    </a>
                </div>
                <div class="order-status">
                    <div class="wrapper">
                        <p class="delivery-status-wrap"><span class="status deposit-waiting">${i.orderStatusLabel}</span></p>
                        <div class="item-wrap">
                            <c:set var="i" value="${i}" scope="request"/>
                            <jsp:include page="/WEB-INF/views/include/order/order-item.jsp"/>
                        </div>
                    </div>
                </div>
            </div>
             </c:when>
                <c:otherwise>
                    <div class="no-contents">
                        <p>최근 주문내역이 없습니다.</p>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>

        <div class="title-container">
            <h2 class="title-h2">관심상품</h2>
            <a href="/mypage/info/wishlist" class="link">전체보기<i class="arrow"></i></a>
        </div>

        <!-- // 관심상품 -->
        <div class="liked-item-list">
            <div class="item-list-container vertical">

                <c:forEach items="${content.wishlists}" var="wish">
                    <c:set var="itemListClass" value="item-list-3" scope="request"/>
                    <c:set var="showWishFlag" value="true" scope="request"/>
                    <c:set var="item" value="${wish.item}" scope="request"/>
                    <jsp:include page="/WEB-INF/views/include/item/item.jsp"/>
                </c:forEach>

            </div>
            <c:if test="${empty content.wishlists}">
            <div class="no-contents">
                <p>관심상품이 없습니다.</p>
            </div>
            </c:if>

    </section>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>
    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
