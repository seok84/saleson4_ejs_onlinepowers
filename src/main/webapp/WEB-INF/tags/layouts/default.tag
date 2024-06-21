<%@ tag pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="/WEB-INF/layouts/head.jsp"/>
    <%--<script defer src="/static/content/modules/ui/header.js"></script>--%>
</head>
<body>

<jsp:include page="/WEB-INF/layouts/header.jsp"/>
<div class="content-inner">
    <jsp:doBody/>
</div>

<aside id="aside-menu">
    <jsp:include page="/WEB-INF/layouts/aside.jsp"/>
</aside>

<jsp:include page="/WEB-INF/layouts/footer.jsp"/>

<c:if test="${empty hiddenMobileGnbFlag or not hiddenMobileGnbFlag}">
    <div class="mobile-category">
        <jsp:include page="/WEB-INF/layouts/mobile-gnb.jsp"/>
    </div>
</c:if>


<jsp:include page="/WEB-INF/layouts/scripts.jsp"/>
<script defer src="/static/content/modules/ui/header.js"></script>
<jsp:include page="/WEB-INF/layouts/modals.jsp"/>
</body>
</html>
