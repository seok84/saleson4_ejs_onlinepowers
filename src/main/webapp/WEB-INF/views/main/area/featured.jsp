<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="main-title-wrap">
    <a class="main-title" href="/featured">눈여겨볼 ᴥ 만한 기획전</a>
    <p>풍성한 이벤트를 만나보세요!</p>
</div>
<section class="event-list-wrap" id="main-featured-banner">
    <ul class="event-list">
        <%--<c:forEach var="featured" items="${promotion.featured}">
            <c:if test="${not empty featured.image}">
                <li class="event-item">
                    <a href="${featured.url}">
                        <div class="event-thumbnail">
                            <img src="${featured.image}" alt="${featured.content}" onerror="errorImage(this)" loading="lazy" decoding="async">
                        </div>
                    </a>
                </li>
            </c:if>
        </c:forEach>
        <c:if test="${empty promotion.featured}">
            <div class="no-contents">
                <p>진행중인 이벤트가 없습니다.</p>
            </div>
        </c:if>--%>
    </ul>
</section>



<div class="main-title-wrap">
    <a class="main-title" href="/featured">눈여겨볼 ᴥ 만한 기획전</a>
    <p>풍성한 이벤트를 만나보세요!</p>
</div>
<section class="event-list-wrap" id="main-featured">

</section>
