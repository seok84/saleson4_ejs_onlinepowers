<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>

    <section class="customer customer-notice">
        <div class="title-h1">고객센터</div>

        <c:set var="activeType" value="notice" scope="request"/>
        <jsp:include page="include/tab.jsp"/>

        <ul class="board">
            <c:forEach var="notice" items="${pageContent.content}">
                <li class="list">
                    <div class="flex space-between notice-title">
                        <p class="title-wrap">
                            <c:if test="${notice.noticeFlag}">
                                <span class="label">공지</span>
                            </c:if>

                            <strong class="title">${notice.subject}</strong>
                        </p>
                        <span class="date">${notice.createdDate}</span>
                    </div>
                    <c:if test="${not empty notice.link}">
                        <a class="notice-link" style="display: none"
                           href="${notice.link}"
                            ${"Y" eq notice.targetOption? 'target="_blank"' :''}
                            ${"Y" eq notice.relOption? 'rel="nofollow"' :''}
                        ><img src="/static/content/image/ico/ico_rink.svg" alt="링크"/>${notice.link}</a>
                    </c:if>

                    <div class="content">
                        ${notice.content}
                    </div>
                </li>
            </c:forEach>
        </ul>
        <c:if test="${empty pageContent.content}">
            <div class="no-contents">
                <p>공지사항이 없습니다.</p>
            </div>
        </c:if>
        <page:pagination/>
    </section>

    <page:javascript>
        <script>
            $(function () {
                $('.board').on('click', '.notice-title', function (e) {
                    e.preventDefault();

                    $('.board').find('li').removeClass('open');
                    $('.board').find('li').find('.notice-link').hide();
                    $(this).closest('li').addClass('open');
                    $(this).closest('li').find('.notice-link').show();
                });

                try {
                    $saleson.analytics.view('공지사항');
                } catch (e) {}

            });
        </script>
    </page:javascript>
</layout:default>