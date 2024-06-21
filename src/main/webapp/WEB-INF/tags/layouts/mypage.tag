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

<c:set var="indexCalss" value=""/>
<c:if test="${salesonContext.requestUri eq '/mypage'}">
    <c:set var="indexCalss" value="mypage-index"/>
</c:if>
<div class="content-inner">
    <div class="mypage ${indexCalss}">
        <c:if test="${salesonContext.user.loginType ne 'ROLE_GUEST'}">
            <a href="/mypage" class="title-h1">마이페이지</a>
            <jsp:include page="/WEB-INF/layouts/include/mypage-user-info.jsp"/>
            <jsp:include page="/WEB-INF/layouts/include/mypage-lnb.jsp"/>
        </c:if>
        <div class="mypage-inner">
            <jsp:doBody/>
        </div>
    </div>
</div>

<aside id="aside-menu">
    <jsp:include page="/WEB-INF/layouts/aside.jsp"/>
</aside>

<jsp:include page="/WEB-INF/layouts/footer.jsp"/>

<div class="mobile-category">
    <jsp:include page="/WEB-INF/layouts/mobile-gnb.jsp"/>
</div>

<jsp:include page="/WEB-INF/layouts/scripts.jsp"/>
<script defer src="/static/content/modules/ui/header.js"></script>
<jsp:include page="/WEB-INF/layouts/modals.jsp"/>
</body>
</html>
