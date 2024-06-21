<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="category-tab-all">
    <!-- deps1에 클래스 on으로 토글 -->
    <div class="deps1">홈</div>
    <c:if test="${not empty current.pathCategories}">
        <c:forEach var="path" items="${current.pathCategories}">
            <div class="deps1">
                    ${path.categoryName}
                <i></i>
                <div class="select-wrap">
                    <ul class="select-option">
                        <c:forEach items="${path.sibling}" var="sibling" varStatus="i">
                            <li><a href="/category/${sibling.id}">${sibling.label}</a></li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </c:forEach>
    </c:if>
</div>
