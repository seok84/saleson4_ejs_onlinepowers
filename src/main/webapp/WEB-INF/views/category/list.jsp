<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<layout:default>
    <div class="item-list-page item-index-page">
        <jsp:include page="/WEB-INF/views/category/include/navigation.jsp"/>
        <jsp:include page="/WEB-INF/views/category/include/title.jsp"/>
        <jsp:include page="/WEB-INF/views/category/include/child-categories.jsp"/>

        <c:set var="sorting" value="${criteria.orderBy}__${criteria.sort}" scope="request"/>
        <c:set var="totalElements" value="${pageContent.pagination.totalElements}" scope="request"/>
        <jsp:include page="/WEB-INF/views/include/filter/item-list-form.jsp"/>
        <!-- 아이템리스트 -->
        <c:set var="itemList" value="${pageContent.content}" scope="request"/>

        <c:set var="itemListName" value="카테고리" scope="request"/>
        <c:set var="itemListId" value="${current.categoryPath}" scope="request"/>
        <c:set var="itemListAnalyticsFlag" value="true" scope="request"/>

        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>
        <!-- 페이징 -->
        <page:pagination/>
    </div>
    <page:javascript>
        <script>
            $(document).ready(function () {
                salesOnUI.categorySwiper();
                salesOnUI.selectBox('.category-tabs-current h2');
                const toggleTarget = $('.deps1');
                toggleTarget.click(function () {
                    if ($(this).hasClass('on')) {
                        toggleTarget.removeClass('on');
                    } else {
                        toggleTarget.removeClass('on');
                        $(this).toggleClass('on');
                    }
                });
                // 상품 하위 카테고리 더보기
                const moreCategory = $(".btn-more-category");
                moreCategory.click(function() {
                    $(".category-tabs-next").toggleClass("active");
                });

                try {
                    $saleson.analytics.view('${current.categoryPath}');
                } catch (e) {}
            });
        </script>
        <script src="/static/content/modules/ui/item/list.js"></script>
    </page:javascript>
</layout:default>