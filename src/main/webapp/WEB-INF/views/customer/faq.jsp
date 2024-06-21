<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <section class="customer customer-faq">
        <div class="title-h1">고객센터</div>

        <c:set var="activeType" value="faq" scope="request"/>
        <jsp:include page="include/tab.jsp"/>

        <div class="container">
            <div class="select-wrap">
                <form id="faqForm" method="get">
                    <div class="flex">
                        <input type="hidden" name="page" value="${criteria.page}"/>
                        <select class="input-select" name="faqType">
                            <option value="">문의 유형을 선택하세요</option>
                            <c:forEach var="type" items="${pageContent.types}">
                                <option value="${type.id}" ${criteria.faqType eq type.id ? 'selected="selected"':''}>${type.label}</option>
                            </c:forEach>
                        </select>
                        <button type="submit" class="btn btn-form">조회</button>
                    </div>
                </form>
            </div>
            <div class="sort-wrap">
                <span class="all-items">
                    전체 <strong><fmt:formatNumber value="${pageContent.pagination.totalElements}"
                                                pattern="#,###"/></strong>개
                </span>
            </div>
            <ul class="board">
                <c:forEach var="faq" items="${pageContent.content}">
                    <li class="list">
                        <div class="title-wrap">
                            <span class="category">[${faq.label}]</span>
                            <strong class="title">${faq.title}</strong>
                        </div>
                        <div class="content">${faq.content}</div>
                    </li>
                </c:forEach>
            </ul>
            <page:pagination/>
        </div>


    </section>

    <page:javascript>
        <script>
            $(function () {
                $('.board').on('click', 'li', function (e) {
                    e.preventDefault();

                    $('.board').find('li').removeClass('open');
                    $(this).addClass('open');

                });

                try {
                    $saleson.analytics.view('FAQ');
                } catch (e) {}

            });
        </script>
    </page:javascript>
</layout:default>