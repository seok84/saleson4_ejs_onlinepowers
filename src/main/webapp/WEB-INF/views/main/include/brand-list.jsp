<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="swiper-wrapper">
    <c:if test="${not empty brandList}">
        <c:forEach var="brand" items="${brandList.list}" varStatus="i">
            <div class="swiper-slide" data-brand-id="${brand.id}">
                <div class="thum"><img src="${brand.image}" alt="" onerror="errorImage(this)" loading="lazy" decoding="async"></div>
                <div class="text">${brand.name}</div>
            </div>
        </c:forEach>
    </c:if>
</div>