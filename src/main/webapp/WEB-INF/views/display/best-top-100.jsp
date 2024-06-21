<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
    <div class="item-list-page display-page display-best">
        <h1 class="title-h1">베스트</h1>
        <div class="display-ad pc">
            <img src="/static/content/image/item/best_bg_banner.png" alt="banner-pc">
        </div>
        <div class="display-ad mobile">
            <img src="/static/content/image/item/best_bg_banner_mo.png" alt="banner-mobile">
        </div>

        <!-- 아이템리스트 -->

        <c:set var="itemList" value="${itemList}" scope="request"/>
        <c:set var="itemListClass" value="item-best" scope="request"/>

        <c:set var="itemListName" value="베스트" scope="request"/>
        <c:set var="itemListId" value="display-best" scope="request"/>
        <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>

        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>

        <script>
            $(() => {
                try {
                    $saleson.analytics.view('베스트');
                } catch (e) {}
            });
        </script>
    </page:javascript>
</layout:default>