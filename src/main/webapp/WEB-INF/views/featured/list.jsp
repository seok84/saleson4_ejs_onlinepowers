<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>

    <div class="featured featured-main">
        <h1 class="title-h1">이벤트</h1>
        <div class="container">
            <div class="sort-wrap">
                <div class="all-items">총 <strong><fmt:formatNumber value="${pageContent.pagination.totalElements}" pattern="#,###"/></strong>건 </div>

            </div>
            <ul class="event-list">
                <c:forEach var="featured" items="${pageContent.content}">
                    <li class="event-item">
                        <a href="${featured.link}" ${featured.linkTarget} ${featured.linkRel}>
                            <div class="event-thumbnail">
                                <c:if test="${not empty featured.label}">
                                    <span class="label progress">${featured.label}</span>
                                </c:if>

                                <div class="dimmed" style="display: none;"></div>
                                <img src="${featured.image}" alt="${featured.title}" onerror="errorImage(this)">
                            </div>
                            <div class="event-info">
                                <strong class="title">${featured.title}</strong>

                                <span class="sub" style="${not empty featured.simpleContent? '' : 'display: none;'}">
                                    ${featured.simpleContent}
                                </span>
                                <span class="date">${featured.dateText}</span>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>

            <c:if test="${empty pageContent.content}">
                <div class="no-contents">
                    <p>진행중인 이벤트가 없습니다.</p>
                </div>
            </c:if>
            <page:pagination/>
        </div>
    </div>

    <page:javascript>
        <script>
            $(() => {
                try {
                    $saleson.analytics.view('기획전 목록');
                } catch (e) {}
            });
        </script>

    </page:javascript>
</layout:default>