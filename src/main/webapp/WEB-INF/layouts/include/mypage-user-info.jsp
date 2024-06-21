<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="mypage-container-top">
    <div class="user-info">
        <p class="user-name"><strong class="user">${mypageHeader.userName}님,</strong>안녕하세요!</p>
        <div class="user-grade">
            <div class="grad-wrap">
                <i class="ico"><img src="/static/content/image/mypage/grade_welcome.svg" alt="${mypageHeader.levelName}"></i>
                <strong>${mypageHeader.levelName}</strong>
            </div>
            <span class="divider"></span>
            <a href="/mypage/benefit/grade">
                <span>회원등급별 혜택<i class="arrow"></i></span>
            </a>
        </div>
    </div>
    <div class="user-benefits">
        <div class="box">
            <a href="/mypage/benefit/point?pointType=EARN_POINT" class="title">
                <i class="ico"><img src="/static/content/image/mypage/ico_point.svg" alt="포인트"></i><span>포인트</span><i class="arrow"></i>
            </a>
            <p class="amount">
                <strong><fmt:formatNumber value="${mypageHeader.point}" pattern="#,###"/></strong><span class="unit en">P</span>
            </p>
        </div>
        <span class="divider"></span>
        <div class="box">
            <a href="/mypage/benefit/coupon?complete=false" class="title">
                <i class="ico"><img src="/static/content/image/mypage/ico_coupon.svg" alt="쿠폰"></i><span>쿠폰</span><i class="arrow"></i>
            </a>
            <p class="amount">
                <strong>${mypageHeader.couponCount}</strong><span class="unit kr">장</span>
                <span class="able-alert" onclick="downloadCouponAll();">다운가능쿠폰</span>
            </p>
        </div>
        <span class="divider"></span>
        <div class="box liked-item">
            <a href="/mypage/info/wishlist" class="title">
                <i class="ico"><img src="/static/content/image/mypage/ico_heart.svg" alt="관심상품"></i><span>관심상품</span><i class="arrow"></i>
            </a>
            <p class="amount"><strong>6</strong></p>
        </div>
    </div>
    <div class="user-event">
        <i class="ico"></i>
        <strong>이벤트</strong>
        <span>플러스 친구 추가하면 3,000원 쿠폰 증정!</span>
    </div>
</div>

<page:model>
    <div class="modal modal-coupon"></div>
</page:model>
<script>
    function downloadCouponAll(page){
        let param = {
            page : page == null ? '1' : page
        };

        $saleson.handler.getPopup(param, '/mypage/benefit/popup/coupon-down', '.modal-coupon');
    }
</script>