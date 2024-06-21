<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="errorMessage" value="${errorMessage}" scope="request"/>
<c:set var="errorCode" value="${errorCode}" scope="request"/>
<jsp:include page="./include/error.jsp"/>
