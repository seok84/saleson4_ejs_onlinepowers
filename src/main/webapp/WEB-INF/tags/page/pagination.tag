<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%-- Declaration of page, url and size tag attributes --%>

<%@ attribute name="page" required="false"%>

<%-- The url path before the page request parameter  ==> javascript:pagination([page]) --%>
<%@ attribute name="url" required="false"%>

<%--Number of page numbers to display at once --%>
<%@ attribute name="size" required="false"%>


<c:choose>
    <c:when test="${not empty pageContent}">
        <c:set var="page" value="${pageContent.pagination}"/>
    </c:when>
    <c:otherwise>
        <c:set var="page" value="${pagination}"/>
    </c:otherwise>
</c:choose>

<c:set var="url" value="${empty url ? paginationUrl : url}"/>

<%-- Declaration of the default size value --%>
<c:set var="size" value="${empty size ? 10 : size}"/>

<%-- half_size_floor = floor(size/2)  is used to display the current page in the middle --%>
<c:set var="N" value="${size/2}"/>
<c:set var="half_size_floor">
    <fmt:formatNumber value="${N-(1-(N%1))%1}" type="number" pattern="#"/>
</c:set>

<%-- current variable stands for the current page number  --%>
<c:set var="current" value="${page.currentPage}"/>

<c:set var="startPage" value="${current < half_size_floor + 1 ? 1 : current - half_size_floor }"/>
<c:set var="startPage" value="${current > page.totalPages - half_size_floor ? page.totalPages - size + 1 : startPage }"/>
<c:set var="endPage" value="${startPage + size - 1}"/>
<c:set var="endPage" value="${endPage > page.totalPages ? page.totalPages : endPage}"/>

<%--less pages then the size of the block --%>
<c:set var="startPage" value="${page.totalPages < size ? 1 : startPage}"/>
<c:set var="endPage" value="${page.totalPages < size ? page.totalPages : endPage}"/>

<%-- PAGE NAVIGATION LINKS --%>
<div class="pagination">

    <%-- Previous link --%>
    <c:if test="${current > 1}">
        <a class="page-item" href="${fn:replace(url, '[page]', current - 1)}"><span class="page-prev">이전페이지</span></a>
    </c:if>

    <%-- Numerated page links --%>
    <c:forEach var="pageNumber" begin="${startPage < 0 ? 0 : startPage}" end="${endPage < 0 ? 0 : endPage}">
        <a class="page-item ${current eq pageNumber ? 'active' : ''}"
            href="${fn:replace(url, '[page]', pageNumber)}">
            <span class="page-link">${pageNumber}</span>
        </a>
    </c:forEach>

    <%-- Next link --%>
    <c:if test="${current < endPage}">
        <a class="page-item" href="${fn:replace(url, '[page]', current + 1)}"><span class="page-next">다음페이지</span></a>
    </c:if>
</div>