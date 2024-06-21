<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="uri" value="${salesonContext.requestUri}"/>
<c:set var="commonCssFlag" value="true"/>
<%--
URI 기반으로 CSS 추가
--%>
<c:choose>
    <c:when test='${uri eq "/"}'>
        <link rel="stylesheet preload" as="style" href="/static/content/css/pages/main/main.css">
    </c:when>

    <%-- 마이페이지 기본 --%>
    <c:when test='${fn:startsWith(uri, "/mypage")}'>
        <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_main.css">
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
        <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_order.css">

        <c:choose>
            <%-- 쇼핑혜택 : 쿠폰 --%>
            <c:when test='${uri eq "/mypage/benefit/coupon"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_coupon.css">
            </c:when>
            <%-- 쇼핑혜택 : 포인트 --%>
            <c:when test='${uri eq "/mypage/benefit/point"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_point.css">
            </c:when>
            <%-- 쇼핑혜택 : 나의등급/혜택 --%>
            <c:when test='${uri eq "/mypage/benefit/grade"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_grade.css">
            </c:when>

            <%-- 내정보관리 : 배송주소록 --%>
            <c:when test='${uri eq "/mypage/info/delivery"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_address.css">
            </c:when>

            <%-- 내정보관리 : 이용후기 --%>
            <c:when test='${uri eq "/mypage/user/review"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_review.css">
            </c:when>

            <c:when test='${uri eq "/mypage/user/inquiry-item"}'>
                <link rel="stylesheet" href="/static/content/css/pages/user/user.css">
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_myinfo.css">
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_review.css">
            </c:when>
            <c:when test='${uri eq "/mypage/user/check-password"}'>
                <link rel="stylesheet" href="/static/content/css/pages/user/user.css">
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_myinfo.css">
            </c:when>
            <c:when test='${uri eq "/mypage/user/modify"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_myinfo.css">
            </c:when>
            <c:when test='${uri eq "/mypage/user/connect-sns"}'>
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_myinfo.css">
            </c:when>
            <c:when test='${uri eq "/mypage/user/secede"}'>
                <link rel="stylesheet" href="/static/content/css/pages/user/user.css">
            </c:when>
            <c:when test='${uri eq "/mypage/user/change-password"}'>
                <link rel="stylesheet" href="/static/content/css/pages/user/user.css">
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_myinfo.css">
            </c:when>

             <c:otherwise></c:otherwise>
        </c:choose>
    </c:when>

    <c:when test='${fn:startsWith(uri, "/user/")}'>
        <link rel="stylesheet" href="/static/content/css/pages/user/user.css">
    </c:when>


    <c:when test='${fn:startsWith(uri, "/cart")}'>
        <link rel="stylesheet" href="/static/content/css/pages/cart/cart.css">
        <link rel="stylesheet" href="/static/content/css/pages/cart/cart-modal.css">
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
    </c:when>

    <c:when test='${fn:startsWith(uri, "/display")}'>
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
        <link rel="stylesheet" href="/static/content/css/pages/display/display.css">
    </c:when>

    <c:when test='${fn:startsWith(uri, "/item")}'>

        <c:choose>
            <c:when test='${uri eq "/item/result"}'>
                <link rel="stylesheet" href="/static/content/css/pages/search/search.css">
            </c:when>
            <c:otherwise>
                <link rel="stylesheet" href="/static/content/css/pages/components/modal.css">
                <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
                <link rel="stylesheet" href="/static/content/css/pages/mypage/mypage_coupon.css">
            </c:otherwise>
        </c:choose>
    </c:when>

    <c:when test='${fn:startsWith(uri, "/category")}'>
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
    </c:when>


    <c:when test='${fn:startsWith(uri, "/order")}'>
        <link rel="stylesheet" href="/static/content/css/pages/cart/cart.css">
        <link rel="stylesheet" href="/static/content/css/pages/cart/cart-modal.css">
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
    </c:when>

    <c:when test='${fn:startsWith(uri, "/brand")}'>
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
        <link rel="stylesheet" href="/static/content/css/pages/display/display.css">
    </c:when>

    <c:when test='${fn:startsWith(uri, "/featured")}'>
        <link rel="stylesheet" href="/static/content/css/pages/featured/featured.css">
    </c:when>

    <c:when test='${fn:startsWith(uri, "/customer")}'>
        <link rel="stylesheet" href="/static/content/css/pages/items/item_list.css">
        <link rel="stylesheet" href="/static/content/css/pages/customer/customer_main.css">
    </c:when>

    <c:when test='${fn:startsWith(uri, "/policy")}'>
        <link rel="stylesheet" href="/static/content/css/pages/terms/terms_main.css">
    </c:when>
    <c:otherwise>
        <link rel="stylesheet" as="style" href="/static/content/css/common.css">
    </c:otherwise>
</c:choose>
