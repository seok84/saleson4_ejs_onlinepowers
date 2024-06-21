<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${not empty featuredList}">
    <ul class="event-list">
        <c:forEach var="featured" items="${featuredList}">
            <li class="event-item event-information">
                <a href="${featured.link}" ${featured.linkTarget} ${featured.linkRel}>
                    <div class="event-thumbnail">
                        <c:if test="${not empty featured.label}">
                            <span class="label progress">${featured.label}</span>
                        </c:if>

                        <div class="dimmed" style="display: none;"></div>
                        <img src="${featured.image}" alt="${featured.title}" onerror="errorImage(this)" loading="lazy" decoding="async">
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
</c:if>

