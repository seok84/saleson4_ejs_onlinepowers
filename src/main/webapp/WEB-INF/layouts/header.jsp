<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="fixed-header ${displayTopBanner ? '':'show-lnb'}">

    <c:if test="${displayTopBanner}">
        <div id="top-banner">
            <section>
                <%--비동기로 전환--%>
                <%--<!-- 텍스트형 -->
                <div class="flex type-text hidden">
                    <button type="button" class="tob-banner-close">닫기</button>
                    탑배너 영역입니다.
                </div>--%>
            </section>
        </div>
    </c:if>

    <c:set var="headerStyleClass" value="header-default"/>

    <c:choose>
        <c:when test="${'SEARCH' eq headerStyleType}">
            <c:set var="headerStyleClass" value="header-search"/>
        </c:when>

        <c:when test="${'DETAIL' eq headerStyleType}">
            <c:set var="headerStyleClass" value="header-detail"/>
        </c:when>
        <c:when test="${'ITEM_DETAIL' eq headerStyleType}">
            <c:set var="headerStyleClass" value="header-items-detail"/>
        </c:when>
    </c:choose>

    <c:set var="historyBackUrl" value="history.back();"/>

    <c:if test="${not empty headerHistoryBackUrl}">
        <c:set var="historyBackUrl" value="location.href='${headerHistoryBackUrl}'"/>
    </c:if>

    <header id="header" class="${headerStyleClass}" data-test="${headerStyleType}">
        <section class="flex space-between">

            <div class="col-left">
                <button type="button" class="btn-gnb">메뉴 열기</button>
                <button type="button" class="btn-back btn-history" onclick="${historyBackUrl}">
                    <img src="/static/content/image/ico/ico_arr_back.svg" alt="뒤로가기">
                </button>
                <a href="/" class="brand"><img src="/static/content/image/common/brand.svg" alt="세일즈온"></a>

                <h1 class="title-h1-mobile">${headerTitle}</h1>
            </div>

            <div class="col-right">
                <div class="searching-area"
                     data-recommend-link=""
                     data-recommend-blank-flag=""
                >
                    <form id="header-search-form">
                        <button type="button" class="btn-close">
                            <img src="/static/content/image/ico/ico_arr_back.svg" alt="뒤로가기">
                        </button>
                        <input type="search"  placeholder="" name="query"/>
                        <button type="submit"  class="btn-search">
                            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48">
                                <g id="그룹_42756" data-name="그룹 42756" transform="translate(-302 -1)">
                                    <rect id="사각형_26362" data-name="사각형 26362" width="48" height="48" transform="translate(302 1)" fill="rgba(255,133,133,0)" opacity="0.36"/>
                                    <g id="ic_search_02" transform="translate(311 10)">
                                        <g id="ic_search">
                                            <path id="패스_11033" data-name="패스 11033" d="M0,0H30V30H0Z" fill="rgba(255,133,133,0)" opacity="0.36"/>
                                            <g id="그룹_22074" data-name="그룹 22074" transform="translate(-1.337 -1.337)">
                                                <g id="그룹_36081" data-name="그룹 36081" transform="translate(4 4)">
                                                    <g id="타원_58" data-name="타원 58" fill="none" stroke="#8559ee" stroke-width="1.5">
                                                        <circle cx="10.5" cy="10.5" r="10.5" stroke="none"/>
                                                        <circle cx="10.5" cy="10.5" r="9.75" fill="none"/>
                                                    </g>
                                                    <line id="선_1" data-name="선 1" x2="7" y2="7" transform="translate(17.674 17.674)" fill="none" stroke="#8559ee" stroke-width="1.5"/>
                                                </g>
                                            </g>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                        </button>
                        <button id="mobile-search-button" type="button" class="btn-search mobile-search-open">
                            <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48">
                                <g id="그룹_42756" data-name="그룹 42756" transform="translate(-302 -1)">
                                    <rect id="사각형_26362" data-name="사각형 26362" width="48" height="48" transform="translate(302 1)" fill="rgba(255,133,133,0)" opacity="0.36"/>
                                    <g id="ic_search_02" transform="translate(311 10)">
                                        <g id="ic_search">
                                            <path id="패스_11033" data-name="패스 11033" d="M0,0H30V30H0Z" fill="rgba(255,133,133,0)" opacity="0.36"/>
                                            <g id="그룹_22074" data-name="그룹 22074" transform="translate(-1.337 -1.337)">
                                                <g id="그룹_36081" data-name="그룹 36081" transform="translate(4 4)">
                                                    <g id="타원_58" data-name="타원 58" fill="none" stroke="#8559ee" stroke-width="1.5">
                                                        <circle cx="10.5" cy="10.5" r="10.5" stroke="none"/>
                                                        <circle cx="10.5" cy="10.5" r="9.75" fill="none"/>
                                                    </g>
                                                    <line id="선_1" data-name="선 1" x2="7" y2="7" transform="translate(17.674 17.674)" fill="none" stroke="#8559ee" stroke-width="1.5"/>
                                                </g>
                                            </g>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                        </button>
                    </form>
                </div>
                <ul class="util-menu">
                    <li class="favorite">
                        <a href="/mypage/info/wishlist">찜 상품</a>
                    </li>
                    <li class="mypage">
                        <a href="/mypage">마이페이지</a>
                    </li>
                    <li class="mycart">
                        <a href="/cart">장바구니
                            <span class="count" id="header-cart-quantity">0</span>
                        </a>
                    </li>
                </ul>
                <div class="searching-list hidden">
                    <button type="button" class="delete-all">전체삭제</button>
                    <div class="list list-popular">
                        <p>인기검색어</p>
                        <ol>

                        </ol>
                    </div>
                    <div class="list list-recent">
                        <p>최근 검색어</p>
                        <ul>
                            <c:forEach var="latelySearch" items="${latelySearchList}" varStatus="i">
                                <li>
                                    <a href="/item/result?query=${latelySearch}" class="text">${latelySearch}</a>
                                    <button class="delete" data-word="${latelySearch}"></button>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="list-footer"><button type="button" class="searching-list-close">닫기</button></div>
                </div>
            </div>
        </section>

        <section class="quick-link">
            <div class="link-area" ref="linkAreaSwiper">
                <div class="swiper-wrapper">
                    <a href="/display/new" class="swiper-slide">신상품</a>
                    <a href="/display/best" class="swiper-slide">베스트</a>
                    <a href="/display/timedeal" class="swiper-slide">타임세일</a>
                    <a href="/display/md" class="swiper-slide">MD</a>
                    <a href="/featured" class="swiper-slide">이벤트</a>
                    <c:if test="${not empty gnbList and not empty gnbList.list}">
                        <c:forEach var="gnb" items="${gnbList.list}">
                            <a href="${gnb.target}" class="swiper-slide">${gnb.title}</a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="my-menu">
                <a href="/mypage/info/order">주문배송</a>
                <a href="/customer/notice">고객센터</a>
                <c:choose>
                    <c:when test="${salesonContext.login}">
                        <a href="#" onclick="$saleson.auth.logout('/')">로그아웃</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/user/login">로그인</a>
                    </c:otherwise>
                </c:choose>

            </div>
        </section>

        <nav class="gnb">
            <section class="depth1">
                <c:forEach items="${shopCategories}" var="category1" varStatus="i">

                    <div class="menu-item">
                        <a>${category1.name}</a>
                        <div class="depth2">
                            <ul>
                                <li>
                                    <a href="/category/${category1.url}">전체</a>
                                </li>
                                <c:forEach items="${category1.childCategories}" var="category2">
                                    <c:if test="${not empty category1.childCategories}">
                                        <li>
                                            <a href="/category/${category2.url}">${category2.name}</a>

                                            <c:if test="${not empty category2.childCategories}">

                                                <div class="depth3">
                                                    <c:forEach items="${category2.childCategories}" var="category3">
                                                        <div class="depth3-menu">
                                                            <a href="/category/${category3.url}">${category3.name}</a>

                                                            <c:if test="${not empty category3.childCategories}">
                                                                <div class="depth4">
                                                                    <c:forEach items="${category3.childCategories}"
                                                                               var="category4">
                                                                        <div class="depth4-menu">
                                                                            <a href="/category/${category4.url}">${category4.name}</a>
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:if>


                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:if>

                                        </li>
                                    </c:if>

                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                </c:forEach>
            </section>
        </nav>

    </header>
</div>