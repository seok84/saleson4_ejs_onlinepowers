<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="swiper main-visual pc">
    <div class="swiper-wrapper">
        <c:forEach var="promotion" items="${promotion.promotion}">
            <c:if test="${not empty promotion.image}">
                <div class="swiper-slide" style="background: ${promotion.color}">
                    <a href="${promotion.url}">
                        <img src="${promotion.image}" alt="${promotion.content}" onerror="errorImage(this)" loading="lazy" decoding="async">
                    </a>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <div class="swiper-controls">
        <button class="swiper-prev">이전</button>
        <button class="swiper-next">다음</button>
    </div>

    <div class="main-swiper-pagination-wrap">
        <button class="btn-pause">swiper auto control</button>

        <div class="main-swiper-pagination"></div>
    </div>

</div>

<div class="swiper main-visual mobile">
    <div class="swiper-wrapper">
        <c:forEach var="promotion" items="${promotion.mobilePromotion}">
            <c:if test="${not empty promotion.image}">
                <div class="swiper-slide" style="background: ${promotion.color}">
                    <a href="${promotion.url}">
                        <img src="${promotion.image}" alt="${promotion.content}" onerror="errorImage(this)" loading="lazy" decoding="async">
                    </a>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <div class="swiper-controls">
        <button class="swiper-prev">이전</button>
        <button class="swiper-next">다음</button>
    </div>

    <div class="main-swiper-pagination-wrap">
        <button class="btn-pause">swiper auto control</button>

        <div class="main-swiper-pagination"></div>
    </div>

</div>
