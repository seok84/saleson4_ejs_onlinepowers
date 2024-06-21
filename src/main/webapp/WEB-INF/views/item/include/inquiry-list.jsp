<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<div class="content-sub-list" data-total-elements="${pageContent.pagination.totalElements}">
    <!-- 상품문의 리스트 -->
    <c:choose>
        <c:when test="${not empty pageContent.content}">
            <ul class="review-content">
                <c:forEach var="inquiry" items="${pageContent.content}">
                    <c:set var="inquiry" value="${inquiry}" scope="request"/>
                    <li class="review-item">
                        <div class="creation-info">
                            <div>
                                <p>${inquiry.userName}</p>
                                <p>${inquiry.date}</p>
                            </div>
                            <c:if test="${not inquiry.writtenMeFlag}">
                                <p class="inquiry-report-btn" data-id="${inquiry.id}" data-blockFlag="${inquiry.blockFlag}">신고/차단</p>
                            </c:if>
                        </div>

                        <c:choose>
                            <c:when test="${inquiry.secretFlag}">
                                <p class="administrator-secret">비밀글입니다.</p>
                            </c:when>
                            <c:otherwise>
                                <!-- 답변 상태 -->
                                <jsp:include page="/WEB-INF/views/include/inquiry/inquiry.jsp"/>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <div class="no-contents">
                <img src="/static/content/image/common/img_noQna.png" alt="게시글 없음">
                <p>상품문의가 없습니다.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <page:pagination/>
</div>
