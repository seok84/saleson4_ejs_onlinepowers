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

        <div class="display-tab-wrap">
            <ul class="display-tab">
                <c:forEach var="category" items="${categories}">
                    <li class="${category.url eq criteria.tag ? 'on': ''}" data-key="${category.url}">${category.name}</li>
                </c:forEach>
            </ul>
            <div class="mobile">
                <div class="btn-display-tab-more" onclick="salesOnUI.toggleOn('.display-tab-wrap')">
                    <i></i></div>
            </div>
            </div>

        <!-- 아이템리스트 -->

        <c:set var="itemList" value="${pageContent.content}" scope="request"/>
        <c:set var="itemListClass" value="item-best" scope="request"/>

        <c:set var="itemListName" value="베스트" scope="request"/>
        <c:set var="itemListId" value="${criteria.tag}" scope="request"/>
        <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>

        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>

        <script>
            $(() => {

                $('.display-tab').on('click', 'li', function (e) {
                    e.preventDefault();

                    const tag = $(this).data('key');

                    $saleson.core.redirect('/display/best?tag='+tag)
                });

                try {
                    $saleson.analytics.view('베스트');
                } catch (e) {}
            });
        </script>
    </page:javascript>
</layout:default>