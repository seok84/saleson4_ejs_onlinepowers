<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="category-tabs-current">
    <h2>
        ${current.categoryName}
        <i></i>
    </h2>
    <div class="select-wrap hidden">
        <div class="triangle"></div>
        <ul class="select-option">
            <c:if test="${not empty current.pathCategories}">
                <c:forEach var="path" items="${current.pathCategories}" varStatus="pathIndex">
                    <c:if test="${pathIndex.last}">
                        <c:forEach items="${path.sibling}" var="sibling" varStatus="i">
                            <li><a href="/category/${sibling.id}">${sibling.label}</a></li>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </c:if>
        </ul>
    </div>
</div>