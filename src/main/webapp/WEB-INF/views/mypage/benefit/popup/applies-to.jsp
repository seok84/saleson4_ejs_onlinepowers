<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<c:set var="itemList" value="${pageContent.content}" scope="request"/>
<jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

<!-- 페이징 -->
<page:pagination/>