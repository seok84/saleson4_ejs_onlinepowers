<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="itemListClass" value="item-list-5" scope="request"/>

<c:set var="itemList" value="${mdItems}" scope="request"/>

<c:set var="itemListName" value="메인/MD" scope="request"/>
<c:set var="itemListId" value="main-md" scope="request"/>
<c:set var="itemListAnalyticsFlag" value="true" scope="request"/>

<jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>