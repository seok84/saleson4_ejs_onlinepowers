<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="delivery-status-wrap">
    <c:choose>
        <c:when test="${not inquiry.answerFlag}">
            <p class="status answer-waiting">답변대기</p>
        </c:when>
        <c:otherwise>
            <p class="status answer-completed">답변완료</p>
        </c:otherwise>
    </c:choose>
    <c:if test="${displayDeliveryUtilFlag}">
        <div class="util">
            <span class="date">${inquiry.date}</span>
            <c:if test="${not inquiry.answerFlag}">
                <span class="divider"></span>
                <button type="button" class="delete-inquiry" data-id="${inquiry.id}">삭제</button>
            </c:if>

        </div>
    </c:if>

</div>
<!-- 사용자 문의 -->
<div class="user-writing">
    <p class="title">
        <strong class="category">[${inquiry.label}]</strong>
        <span class="question">${inquiry.subject}</span>
    </p>
    <p class="content">
        ${inquiry.question}
    </p>
    <c:if test="${not empty inquiry.files}">
        <ul class="photo-list">
            <c:forEach var="image" items="${inquiry.files}">
                <li class="photo-item">
                    <img src="${image}" alt="fileName" class="thumbnail" onerror="errorImage(this)">
                </li>
            </c:forEach>
        </ul>
    </c:if>
</div>
<c:if test="${inquiry.answerFlag}">
    <div class="admin-answer">
        <p class="administrator">관리자 답변</p>
        <div class="content">
                ${inquiry.answer.answer}
        </div>
        <p class="date">답변일 ${inquiry.answer.date}</p>
    </div>
</c:if>