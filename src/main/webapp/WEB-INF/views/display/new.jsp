<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <div class="item-list-page display-page">
        <h1 class="title-h1">신상품</h1>
        <div class="display-ad pc">
            <img src="/static/content/image/item/new_banner_top.png" alt="banner-pc">
        </div>
        <div class="display-ad mobile">
            <img src="/static/content/image/item/new_banner_top_mo.png" alt="banner-mobile">
        </div>

        <c:set var="sorting" value="${criteria.orderBy}__${criteria.sort}" scope="request"/>
        <c:set var="totalElements" value="${pageContent.pagination.totalElements}" scope="request"/>
        <jsp:include page="/WEB-INF/views/include/filter/item-list-form.jsp"/>

        <c:set var="itemList" value="${pageContent.content}" scope="request"/>
        <c:set var="itemListName" value="신상품" scope="request"/>
        <c:set var="itemListId" value="display-new" scope="request"/>
        <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>

        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

        <page:pagination/>

    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>
        <script>
            $(() => {
                try {
                    $saleson.analytics.view('신상품');
                } catch (e) {}
            });
        </script>
    </page:javascript>
</layout:default>