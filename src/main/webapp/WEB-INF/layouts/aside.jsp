<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<nav class="quick-menu">
    <div class="toggle-area on">
        <a href="/mypage" class="menu ico-mypage"><span>마이페이지</span></a>
        <a href="/mypage/info/wishlist" class="menu ico-heart">
            <i class="number" id="aside-wishlist-count" data-count="0">0</i>
            <span>관심상품</span></a>
        <a href="/mypage/info/recent-item" class="menu ico-recent">
            <i data-count="${latelyItemCount}" id="aside-lately-item-count">
                <fmt:formatNumber value="${latelyItemCount}" pattern="#,###"/>
            </i>
            <span>최근 본 상품</span></a>
        <a href="/customer/inquiry" class="menu ico-talk"><span>1:1문의</span></a>
    </div>
    <button type="button" class="btn-toggle">접기</button>
</nav>

<button type="button" class="btn-top">TOP</button>
