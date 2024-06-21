<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="review" items="${reviewList.list}">
    <div class="swiper-slide">
        <div class="thum" onclick="$saleson.core.redirect('/item/${review.itemUserCode}')">
            <img src="${review.image}" alt="" onerror="errorImage(this)" loading="lazy" decoding="async">
        </div>
        <div class="review">
            <p>
                ${review.content}
            </p>
            <div class="star-wrap">
                <div class="star">
                    <i class="star${review.score}"></i>
                </div>
            </div>
            <p class="text-ellipsis">
                ${review.itemName}
            </p>
        </div>
    </div>
</c:forEach>
