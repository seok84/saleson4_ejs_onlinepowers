<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
    <div class="item-list-page display-page">
        <h1 class="title-h1">MD추천</h1>

        <div id="md-tag" class="swiper category-bubble-swiper swiper-visible">
            <div class="swiper-wrapper">
                <c:forEach var="tag" items="${tags}" varStatus="i">
                    <div class="swiper-slide ${criteria.tag eq tag ? 'on' : ''}" data-tag="${tag}"> #${tag}</div>
                </c:forEach>
            </div>
            <div class="swiper-controls">
                <div class="swiper-prev">이전</div>
                <div class="swiper-next">다음</div>
            </div>
        </div>

        <c:set var="sorting" value="${criteria.orderBy}__${criteria.sort}" scope="request"/>
        <c:set var="totalElements" value="${pageContent.pagination.totalElements}" scope="request"/>
        <jsp:include page="/WEB-INF/views/include/filter/item-list-form.jsp"/>

        <c:set var="itemList" value="${pageContent.content}" scope="request"/>
        <c:set var="itemListName" value="MD" scope="request"/>
        <c:set var="itemListId" value="${criteria.tag}" scope="request"/>
        <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>
        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

        <page:pagination/>
    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>
        <script>
            $(function () {
                salesOnUI.categoryBubbleSwiper();

                const $listForm = $('#itemListForm');
                $listForm.append($('<input type="hidden" name="tag" value="${criteria.tag}"/>'));

                $('#md-tag').on('click', '.swiper-slide', function (e) {
                    e.preventDefault();

                    const tag = $(this).data('tag');

                    $listForm.find('input[name=tag]').val(tag);
                    $listForm.submit();
                });
        });
        </script>
        <script>
            $(() => {
                try {
                    $saleson.analytics.view('MD');
                } catch (e) {}
            });
        </script>
    </page:javascript>

</layout:default>