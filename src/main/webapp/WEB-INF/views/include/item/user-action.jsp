<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%--상품목록에서 장바구니 및 관심상품 처리를 위해 해당 부분 분리--%>

<div class="user-action"
     data-item-id="${item.itemId}"
     data-order-min-quantity="${item.orderMinQuantity}"
     data-nonmember-order-type="${item.nonmemberOrderType}"
>
    <c:if test="${!showWishFlag}">
<%--        <c:set var="wishlistFlag" value="${item.wishlistFlag eq true ? 'active' : ''}" />--%>
        <div class="user-ico user-attention">관심상품</div>
    </c:if>
    <c:if test="${item.activeCartFlag}">
        <div class="user-ico user-basket">장바구니</div>
    </c:if>

</div>
