<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="main-title-wrap">
    <a class="main-title" href="/display/new">갓- 들어 온 신상품</a>
    <p>나오자마자 호감도 상승</p>
</div>
<section class="main-new-item-list"
         data-list-name="메인/신상품"
         data-list-id="main-new"
         data-analytics-flag="true"
>
    <c:set var="newItems" value="${newItems}" scope="request"/>
    <jsp:include page="./include/new-item-list.jsp"/>
</section>
