<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="main-timesale-bg">
    <div class="main-timesale-area"
         data-list-name="메인/타임세일"
         data-list-id="main-timedeal"
         data-analytics-flag="true"
    >
        <div class="main-title-wrap">
            <a class="main-title" href="/display/timedeal">찐 혜택 യ 타임세일</a>
            <p>이 순간만 할인하는 상품을 모았어요</p>
        </div>
        <section class="swiper-wrap">
            <div class="swiper main-timesale">
                <div class="swiper-wrapper">
                    <c:set var="timedealItems" value="${timedealItems}" scope="request"/>
                    <jsp:include page="./include/timedeal-item-list.jsp"/>
                </div>
                <div class="timesale-swiper-pagination"></div>
            </div>
        </section>

        <div class="swiper-controls">
            <button class="swiper-prev">이전</button>
            <button class="swiper-next">다음</button>
        </div>

    </div>
</div>
