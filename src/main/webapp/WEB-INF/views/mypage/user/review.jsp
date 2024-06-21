<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<layout:mypage>
    <section class="mypage-review">
        <div class="title-container">
            <h2 class="title-h2">이용후기</h2>
        </div>
        <jsp:include page="/WEB-INF/views/include/mypage/search.jsp"/>
        <c:choose>
            <c:when test="${!empty reviewList.reviewPageResponse.content}">
        <ul class="review-content">
            <c:forEach var="review" items="${reviewList.reviewPageResponse.content}">
                <li>
                    <!-- 상품영역 -->
                    <div class="item-list-container horizon">
                        <div class="item-list">
                            <!-- 아이템 썸네일 영역 -->
                            <div class="thumbnail-container">
                                <div onclick="$saleson.core.redirect('/item/${review.itemUserCode}')"
                                     class="thumbnail-wrap">
                                    <img class="thumbnail" src="${review.itemImageSrc}" alt="${review.itemName}"
                                         onerror="errorImage(this)">
                                </div>
                            </div>
                            <!-- 아이템 정보 영역 -->
                            <div class="info-container">
                                <div class="title-main paragraph-ellipsis">
                                        ${review.itemName}
                                </div>
                            </div>
                        </div>
                    </div>
                    <span class="divider"></span>
                    <!-- 평점 상태 -->
                    <div class="eval">
                        <div class="score-wrap">
                            <c:forEach var="index" begin="0" end="4">
                                <span class="star${index < review.score ? ' active' : ''}"></span>
                            </c:forEach>
                        </div>
                        <div class="util">
                        <span class="date">
                            <fmt:parseDate value="${review.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                            <span class="divider"></span>
                            <button type="button" onclick="deleteReview(${review.itemReviewId})" class="delete-inquiry">
                                삭제
                            </button>
                        </div>
                    </div>
                    <!-- 사용자 리뷰 -->
                    <div class="user-writing horizon">
                        <div class="content">
                                ${review.content}
                        </div>
                        <div class="thumbnail-container">
                            <c:forEach var="image" items="${review.images}">
                                <div class="thumbnail-wrap">
                                    <img class="thumbnail" src="${image}" onerror="errorImage(this)"/>
                                </div>
                            </c:forEach>

                        </div>
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
            </c:when>
        <c:otherwise>
            <div class="no-contents">
                <p>작성하신 리뷰가 없습니다.</p>
            </div>
        </c:otherwise>
        </c:choose>
        <page:pagination/>
    </section>

    <page:javascript>
        <script src="/static/content/modules/ui/modal/image-view.js"></script>
        <script src="/static/content/modules/ui/mypage/search.js"></script>
        <script>

            $(function () {

                $('.user-writing .thumbnail-container').on('click', '.thumbnail-wrap', function (e) {
                    e.preventDefault();
                    const $list = $(this).closest('.thumbnail-container');
                    const $imgs = $list.find('img');
                    const files = [];

                    $imgs.each(function (idx) {
                        files.push($imgs.eq(idx).attr('src'));
                    });

                    ImageViewHandler.open(files, $(this).index());
                });
            });

            function deleteReview(reviewId) {
                $saleson.core.confirm("리뷰를 삭제하시겠습니까?", function () {
                    $saleson.api.post("/api/mypage/delete-review/" + reviewId)
                    .then(function (response) {
                        $saleson.core.alert(response.data.message, function () {
                            location.reload();
                        })
                    })
                })
            }

        </script>
    </page:javascript>
    <page:model>
        <jsp:include page="/WEB-INF/views/include/modal/image-view.jsp"/>
    </page:model>
</layout:mypage>
