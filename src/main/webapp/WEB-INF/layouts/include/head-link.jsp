<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="preload" as="image" href="/static/content/image/common/brand.svg">

<c:if test="${not empty preloadImageLinkTagList}">
    <c:forEach var="preloadImage" items="${preloadImageLinkTagList}">
        <c:if test="${not empty preloadImage}">
            <link rel="preload" as="image" href="${preloadImage}">
        </c:if>
    </c:forEach>
</c:if>

<c:set var="uri" value="${salesonContext.requestUri}"/>
<%--
URI 기반으로 추가
--%>

<c:choose>
    <c:when test='${uri eq "/"}'>
        <link rel="preload" as="font" crossorigin href="https://cdn.jsdelivr.net/npm/noto-sans-kr-font@0.0.6/fonts/NotoSansKR-Medium.woff2">
        <link rel="preload" as="font" crossorigin href="https://fonts.cdnfonts.com/s/14883/Montserrat-SemiBold.woff">
        <link rel="preload" as="font" crossorigin href="https://fonts.cdnfonts.com/s/14883/Montserrat-Medium.woff">
    </c:when>
</c:choose>
