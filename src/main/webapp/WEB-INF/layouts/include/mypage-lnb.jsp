<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="mypage-lnb">
    <div class="mobile list-divider">
        <ul class="quick-link">
            <li>
                <a href="/mypage/info/order">
                <img src="/static/content/image/mypage/ico_quick_order.png" alt="주문배송 조회">
                </a>
                <p>주문/배송 조회</p>
            </li>
            <li>
                <a href="/mypage/info/wishlist">
                <img src="/static/content/image/mypage/ico_quick_liked.png" alt="관심상품">
                <p>관심상품</p>
                </a>
            </li>
            <li>
                <a href="/customer/inquiry">
                <img src="/static/content/image/mypage/ico_quick_inquiry.png" alt="1: 1 문의">
                <p>1: 1 문의</p>
                </a>
            </li>
            <li>
                <a href="/mypage/info/recent-item">
                <img src="/static/content/image/mypage/ico_quick_latest.png" alt="최근 본 상품">
                <p>최근 본 상품</p>
                </a>
            </li>
        </ul>
    </div>
    <h4 class="title">쇼핑정보</h4>
    <ul class="list list-divider">
        <li>
            <a href="/mypage/info/order">주문/배송 조회</a>
        </li>
        <li>
            <a href="/mypage/info/claim?statusType=cancel-process">취소/교환/반품 조회</a>
        </li>
        <li><a href="/mypage/info/wishlist">관심상품</a></li>
        <li><a href="/mypage/info/recent-item">최근 본 상품</a></li>
        <li><a href="/mypage/info/delivery">배송주소록 관리</a></li>
    </ul>
    <h4 class="title">쇼핑혜택</h4>
    <ul class="list list-divider">
        <li><a href="/mypage/benefit/coupon?complete=false">쿠폰</a></li>
        <li><a href="/mypage/benefit/point?pointType=EARN_POINT">포인트</a></li>
        <li><a href="/mypage/benefit/grade">나의 등급/혜택</a></li>
    </ul>
    <h4 class="title">정보관리</h4>
    <ul class="list list-divider">
        <li><a href="/mypage/user/check-password">내 정보 관리</a></li>
        <li><a href="/mypage/user/change-password">비밀번호 변경</a></li>
        <li><a href="/mypage/user/connect-sns">SNS 연동관리</a></li>
        <li><a href="/mypage/user/inquiry-item">상품문의</a></li>
        <li><a href="/mypage/user/review">이용후기</a></li>
    </ul>
    <a href="/customer/inquiry" class="customer-link">
        <div class="ico">
            <img src="/static/content/image/common/ico_customer.svg" alt="고객센터">
        </div>
        <div class="info">
            <p>
                <strong>${aboutUs.companyName}</strong><span>고객센터 바로가기</span><i class="arrow"></i>
            </p>
            <p>운영시간 09:00~18:00 주말, 공휴일 휴무</p>
        </div>
    </a>
</div>
