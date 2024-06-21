<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty childCategories}">
    <div class="swiper category-tabs-next-swiper swiper-visible pc">
        <div class="swiper-wrapper">
            <c:forEach items="${childCategories}" var="category" varStatus="i">
                <div class="swiper-slide"><a href="/category/${category.url}">${category.name}</a></div>
            </c:forEach>
        </div>

        <div class="swiper-controls">
            <div class="swiper-prev">이전</div>
            <div class="swiper-next">다음</div>
        </div>
    </div>

    <ul class="category-tabs-next mobile">
        <c:forEach items="${childCategories}" var="category" varStatus="i">
            <li><a href="/category/${category.url}">${category.name}</a></li>
        </c:forEach>
    </ul>

    <c:set var="childCategoriesLength" value="${not empty childCategories ? fn:length(childCategories) : 0}"/>
    <c:set var="moreLimit" value="6"/>
    <c:if test="${childCategoriesLength > moreLimit}">
        <div class="btn-more-category mobile"><i></i>
        </div>
    </c:if>

</c:if>
