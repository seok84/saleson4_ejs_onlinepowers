<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${not empty pageContent.content}">
        <ul class="review-content" data-total-elements="${pageContent.pagination.totalElements}">
            <c:forEach var="review" items="${pageContent.content}">
                <li class="review-item">
                    <!-- 작성자 정보 -->
                    <div class="creation-info">
                        <div>
                            <p>${review.maskUsername}</p>
                            <p>
                                <fmt:parseDate value="${review.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd"/>

                            </p>
                        </div>
                        <c:if test="${not review.writtenMeFlag}">
                            <p class="review-report-btn" data-id="${review.itemReviewId}" data-blockFlag="${review.blockFlag}">신고/차단</p>
                        </c:if>

                    </div>
                    <!-- 별점 -->
                    <div class="star-group">
                        <div class="star-wrap">
                            <div class="star">
                                <i class="star${review.score}"></i>
                            </div>
                        </div>
                        <div class="score">${review.score}</div>
                    </div>
                    <c:if test="${not empty review.images}">

                        <ul class="photo-list">
                            <c:forEach var="image" items="${review.images}">
                                <li class="photo-item">
                                    <img src="${image}" alt="fileName" class="thumbnail" onerror="errorImage(this)">
                                </li>
                            </c:forEach>
                        </ul>

                    </c:if>

                    <!-- 썸네일 -->

                    <!-- 사용자리뷰 -->
                    <div class="user-writing">
                        <p class="content">
                                ${review.content}
                        </p>
                    </div>
                    <!-- 관리자 답변 -->
                    <c:if test="${not empty review.adminComment}">
                        <div class="admin-answer">
                            <p class="administrator">관리자 답변</p>
                            <div class="content">
                                    ${review.adminComment}
                            </div>
                        </div>
                    </c:if>

                </li>
            </c:forEach>


        </ul>

        <page:pagination/>
    </c:when>
    <c:otherwise>
        <div class="no-contents">
            <p>상품리뷰가 없습니다.</p>
        </div>
    </c:otherwise>
</c:choose>
