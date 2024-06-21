<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="detail-review-contents tabs-content">
    <!-- 총 평점 -->
    <div class="total-rating">
        <p>총 평점</p>
        <div class="star-group">
            <div class="star-wrap">
                <div class="star">
                    <i class="star${itemDetail.displayReviewScore}"></i>
                </div>
            </div>
            <div class="score">
                <span><fmt:formatNumber value="${itemDetail.displayReviewScore}" pattern="#,###"/></span>/<span>5</span>
            </div>
        </div>
    </div>

    <input type="hidden" name="orderBy" value=""/>
    <!-- 필터 탭 -->
    <div class="filter-wrap">
        <p>총 <b id="item-review-list-count"><fmt:formatNumber value="${itemDetail.reviewCount}" pattern="#,###"/></b>개 후기</p>
        <ul id="item-review-sort">
            <li class="active" data-sort="">전체</li>
            <li data-sort="CREATED_DATE">최신순</li>
            <li data-sort="LIKE_COUNT">추천순</li>
        </ul>
    </div>
    <p class="btn-edit-review">
        <a href="/mypage/info/order">후기작성하기</a>
    </p>
    <div class="view-option">
        <div class="check-wrap">
            <label for="item-review-search-photo" class="circle-input-checkbox">
                <input id="item-review-search-photo" type="checkbox" value="Y" name="photoFlag"><i></i>사진후기 보기
            </label>
        </div>
        <div class="select-wrap">
            <select class="input-select" name="score">
                <option value="0">리뷰점수</option>
                <option value="1">☆☆☆☆★</option>
                <option value="2">☆☆☆★★</option>
                <option value="3">☆☆★★★</option>
                <option value="4">☆★★★★</option>
                <option value="5">★★★★★</option>
            </select>
        </div>
    </div>

    <!-- 리뷰 리스트 -->
    <div id="item-review-list">

    </div>



</section>