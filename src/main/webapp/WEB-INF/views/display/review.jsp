<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <div class="item-list-page display-page display-review">
        <h1 class="title-h1">리뷰</h1>

        <div class="display-tab-wrap">
            <ul class="display-tab">
                <c:forEach var="group" items="${groups}">
                    <li class="${group.url eq criteria.tag ? 'on': ''}" data-key="${group.url}">${group.name}</li>
                </c:forEach>
            </ul>
            <div class="mobile">
            <div class="btn-display-tab-more" onclick="salesOnUI.toggleOn('.display-tab-wrap')"><i></i></div>
            </div>
        </div>

        <div class="filter-wrap">
            <p>총 <b><fmt:formatNumber value="${pageContent.pagination.totalElements}" pattern="#,###"/></b>개</p>
        </div>

        <section class="review-container">
            <!-- item 01 -->
            <c:forEach var="review" items="${pageContent.content}">
                <div class="review-box">
                    <div class="thumbnail" onclick="$saleson.core.redirect('/item/${review.itemUserCode}')">
                        <img src="${review.image}" alt="" onerror="errorImage(this)">
                    </div>
                    <div class="content">
                        <img src="/static/content/image/ico/ico_review_quotes.svg" class="ico-quotes">
                        <p class="review-text">
                                ${review.content}
                        </p>
                        <div class="score-wrap">
                            <c:forEach begin="1" end="5" var="score">
                                <span class="star ${review.score >= score ? 'active' : ''}"></span>
                            </c:forEach>
                        </div>
                        <p class="item-title">${review.itemName}</p>
                    </div>
                </div>
            </c:forEach>

        </section>

        <page:pagination/>
    </div>

    <page:javascript>
        <script>
            $(() => {
                $('.display-tab').on('click', 'li', function (e) {
                    e.preventDefault();

                    const tag = $(this).data('key');

                    $saleson.core.redirect('/display/review?tag='+tag)
                });

                try {
                    $saleson.analytics.view('리뷰');
                } catch (e) {}
            });
        </script>
    </page:javascript>
</layout:default>