<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <div class="item-list-page display-page display-brand">

        <h1 class="title-h1">관심 집중 브랜드</h1>

        <div class="brand-tab-wrap">
            <ul class="brand-tab">
                <c:forEach var="tag" items="${brands}">
                    <li class="${tag.brandId eq criteria.brandId ? 'on': ''}" data-brand-id="${tag.brandId}">${tag.brandName}</li>
                </c:forEach>
            </ul>
            <div class="btn-brand-more" onclick="salesOnUI.toggleOn('.brand-tab-wrap')"><i></i></div>
        </div>

        <c:set var="sorting" value="${criteria.orderBy}__${criteria.sort}" scope="request"/>
        <c:set var="totalElements" value="${pageContent.pagination.totalElements}" scope="request"/>
        <jsp:include page="/WEB-INF/views/include/filter/item-list-form.jsp"/>

        <c:set var="itemList" value="${pageContent.content}" scope="request"/>

        <c:set var="itemListName" value="브랜드" scope="request"/>
        <c:set var="itemListId" value="${brand.name}" scope="request"/>
        <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>

        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

        <page:pagination/>

    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>

        <script>
            $(() => {

                const $listForm = $('#itemListForm');
                $listForm.append($('<input type="hidden" name="brandId" value="${criteria.brandId}"/>'));

                $('.brand-tab').on('click', 'li', function (e) {
                    e.preventDefault();

                    const brandId = $(this).data('brand-id');

                    $listForm.find('input[name=brandId]').val(brandId);
                    $listForm.submit();
                });

                try {
                    $saleson.analytics.view('${brand.name}');
                } catch (e) {}
            });
        </script>

    </page:javascript>
</layout:default>