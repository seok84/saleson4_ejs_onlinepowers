<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="main-title-wrap">
    <a id="redirect-best" class="main-title" href="/display/best">핫해핫해~ 베스트상품</a>
    <p>BEST상품만 골라서 모았어요!</p>
</div>
<div class="main-bestitem-area">
    <section class="swiper-wrap">
        <div class="swiper main-bestitem">
            <div class="swiper-wrapper">
                <c:forEach items="${shopCategories}" var="category" varStatus="i">
                    <div class="swiper-slide category${i.count}" data-key="${category.url}">${category.name}</div>
                </c:forEach>
            </div>
        </div>
    </section>

    <div class="swiper-controls">
        <button class="swiper-prev">이전</button>
        <button class="swiper-next">다음</button>
    </div>

    <div id="best-item-list-container"
         data-list-name="메인/베스트"
         data-list-id="main-best"
         data-analytics-flag="true"
    >

    </div>


</div>