<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty groupBestItems}">

    <section class="item-list-container">
        <c:set var="itemListClass" value="main-item-best" scope="request"/>
        <div class="col-left">
            <c:forEach var="item" items="${groupBestItems.content}" varStatus="i">
                <c:set var="item" value="${item}" scope="request"/>

                <c:if test="${i.first}">
                    <c:set var="itemImage" value="${item.itemBigImage}" scope="request"/>
                    <jsp:include page="/WEB-INF/views/include/item/item.jsp"/>
                </c:if>
            </c:forEach>
        </div>
        <div class="col-right">
            <c:forEach var="item" items="${groupBestItems.content}" varStatus="i">
                <c:set var="item" value="${item}" scope="request"/>
                <c:if test="${not i.first}">
                    <c:set var="itemImage" value="${item.itemImage}" scope="request"/>
                    <jsp:include page="/WEB-INF/views/include/item/item.jsp"/>
                </c:if>
            </c:forEach>
        </div>
    </section>
</c:if>
