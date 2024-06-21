<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<div class="m-category-menu">
    <a class="m-category-menu-item m-category-open">메뉴</a>
    <a class="m-category-menu-item" href="/mypage/info/wishlist">즐겨찾기</a>
    <a class="m-category-menu-item" href="/">홈</a>
    <a class="m-category-menu-item" href="/mypage">마이페이지</a>
    <a class="m-category-menu-item m-searching" href="javascript:;">검색</a>
</div>

<div class="m-gnb-wrap">
    <header>
        <button type="button" class="m-gnb-close">닫기</button>
        <div class="my-mneu">
            <c:choose>
                <c:when test="${salesonContext.login}">
                    <a onclick="$saleson.auth.logout('/')">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="/user/login">로그인</a>
                </c:otherwise>
            </c:choose>
            <c:if test="${salesonContext.login}">
                <a href="/mypage">마이페이지</a>
            </c:if>

        </div>
    </header>

    <div class="m-gnb">
        <div class="depth1">
            <c:forEach items="${shopCategories}" var="category1" varStatus="category1Index">
                <button class="menu-item">${category1.name}</button>
            </c:forEach>
        </div>

        <div class="depth2">
            <c:forEach items="${shopCategories}" var="category1" varStatus="category1Index">
            <ul>
                <li>
                    <button class="submenu-item" data-url="/category/${category1.url}">전체</button>
                </li>
                <c:if test="${not empty category1.childCategories}">
                    <c:forEach items="${category1.childCategories}" var="category2" varStatus="category2Index">
                        <li>
                            <button class="submenu-item" data-url="/category/${category2.url}">${category2.name}</button>
                            <c:if test="${not empty category2.childCategories}">
                                <div class="depth3">
                                    <a href="/category/${category2.url}" class="thirdmenu-item">전체</a>
                                    <c:forEach items="${category2.childCategories}" var="category3">
                                        <a href="/category/${category3.url}" class="thirdmenu-item">${category3.name}</a>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
             </c:forEach>
        </div>
    </div>

    <div class="service-area">
        <h3 class="service-title">서비스</h3>
        <div class="flex">
            <a class="service-link" href="/display/new">NEW</a>
            <a class="service-link" href="/display/best">BEST</a>
            <a class="service-link" href="/display/timedeal">TIME SALE</a>
            <a class="service-link" href="/display/md">MD PICK</a>
            <a class="service-link" href="/featured">EVENT</a>
            <a class="service-link" href="/mypage/user/review">REVIEW</a>
        </div>
    </div>

    <div class="footer">
        <h3 class="footer-title">고객 서비스 센터</h3>
        <a class="tel" href="tel:${aboutUs.counselTelNumber}">${aboutUs.counselTelNumber}</a>
        <ul class="cs-time">
            <li>상담시간. 평일 오전 8시 30분 ~ 오후 4시 30분 (주말, 공휴일 휴무)</li>
            <li>점심시간. 오후 12시 ~ 오후 1시</li>
        </ul>
    </div>

</div>

<page:javascript>
    <script>
        $(() => {
            $('.m-gnb .depth2').on('click', '.submenu-item', function(e) {
                e.preventDefault();
                const $depth3 = $(this).closest('li').find('.depth3');
                if ($depth3.length <= 0) {
                    const url = $(this).data('url');
                    $saleson.core.redirect(url);
                }
            });
        });
    </script>
</page:javascript>