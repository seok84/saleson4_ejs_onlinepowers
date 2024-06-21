<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="sort-wrap">
    <p class="all-items">전체 <strong><fmt:formatNumber value="${pageContent.pagination.totalElements}" pattern="#,###"/></strong>개</p>
</div>
<ul class="reply-list">
    <c:forEach var="reply" items="${pageContent.content}">
        <li class="list">
            <div class="reply-top">
                <p class="user-info">
                    <span class="user-id">${reply.loginId}</span>
                    <span class="divider"></span>
                    <span class="date">${reply.date}</span>
                </p>
                <c:if test="${not reply.writtenMeFlag}">
                    <button type="button" class="reply-report-btn" data-id="${reply.id}" data-blockFlag="${reply.blockFlag}">신고/차단</button>
                </c:if>
            </div>
            <p class="reply-content">
                ${reply.content}
            </p>
        </li>
    </c:forEach>
</ul>

<page:pagination/>