<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<c:set var="itemListClass" value="${itemListClass}" scope="request"/>

<div class="item-list-container ${not empty itemListContainerClass ? itemListContainerClass : 'vertical'}"
     data-list-name="${not empty itemListName ? itemListName : '상품목록'}"
     data-list-id="${not empty itemListId ? itemListId : 'shop'}"
     data-analytics-flag="${not empty itemListAnalyticsFlag and itemListAnalyticsFlag}"
>
    <c:forEach var="item" items="${itemList}" varStatus="i">
        <c:set var="item" value="${item}" scope="request"/>
        <jsp:include page="item.jsp"/>
    </c:forEach>
</div>
<c:if test="${empty itemList}">
    <div class="no-contents">
        <p>상품이 없습니다.</p>
    </div>
</c:if>
