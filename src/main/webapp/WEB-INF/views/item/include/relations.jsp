<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<c:if test="${not empty itemList.list}">
    <h4 class="recommend-title">
        다른 고객들이 많이 본 상품
    </h4>

    <c:set var="itemListClass" value="${itemListClass}" scope="request"/>
    <c:set var="itemListContainerClass" value="swiper-slide" scope="request"/>
    <c:set var="relationItemFlag" value="Y" scope="request"/>
    <div class="item-list-container swiper relation-swiper swiper-visible">
        <div class="swiper-wrapper">
            <c:forEach var="item" items="${itemList.list}" varStatus="i">
                <c:set var="item" value="${item}" scope="request"/>
                <jsp:include page="/WEB-INF/views/include/item/item.jsp"/>
            </c:forEach>
        </div>
        <div class="swiper-controls">
            <button class="swiper-prev show">이전</button>
            <button class="swiper-next show">다음</button>
        </div>
    </div>
</c:if>