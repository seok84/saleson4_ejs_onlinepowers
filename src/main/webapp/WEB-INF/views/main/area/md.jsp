<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="main-title-wrap">
    <a class="main-title" href="/display/md">취향 단박에 캐치ఇ</a>
    <p>세일즈온에서 추천하는 제품들을 모았어요</p>
</div>
<section class="main-tabs" id="md-tag">
    <div class="swiper-wrap">
        <div class="swiper main-tab-swiper">
            <div class="swiper-wrapper">
                <c:forEach var="tag" items="${mdTags.tags}" varStatus="i">
                    <div class="swiper-slide">
                        <a class="main-tabitem" data-tag="${tag}" >#${tag}</a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</section>
<div class="main-tabcontent" id="md-item-list-container"
     data-list-name="메인/MD"
     data-list-id="main-md"
     data-analytics-flag="true"
>

</div>