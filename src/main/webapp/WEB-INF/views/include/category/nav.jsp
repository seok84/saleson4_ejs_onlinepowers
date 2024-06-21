<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="category-tab-all">
    <!-- deps1에 클래스 on으로 토글 -->
    <div class="deps1">홈</div>
    <c:if test="${fn:length(item.breadcrumbs[0].breadcrumbCategories) ge 1}">
        <div class="deps1">
            <c:forEach items="${item.breadcrumbs[0].breadcrumbCategories}" var="selectedCate" varStatus="i">
                <c:if test="${i.index eq 0}">
                    ${selectedCate.categoryName}
                </c:if>
            </c:forEach>
            <i></i>
            <div class="select-wrap">
                <ul class="select-option">
                    <c:forEach items="${shopCategoryGroups}" var="group" varStatus="i">
                        <c:forEach items="${item.breadcrumbs}" var="breadcumb">
                            <c:if test="${group.url eq breadcumb.groupUrl}">
                                <c:forEach items="${group.categories}" var="category">
                                    <li><a href="/category/${category.url}">${category.name}</a></li>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:if>
    <c:if test="${fn:length(item.breadcrumbs[0].breadcrumbCategories) ge 2}">
        <div class="deps1">
            <c:forEach items="${item.breadcrumbs[0].breadcrumbCategories}" var="selectedCate" varStatus="i">
                <c:if test="${i.index eq 1}">
                    ${selectedCate.categoryName}
                </c:if>
            </c:forEach>
            <i></i>
            <div class="select-wrap">
                <ul class="select-option">
                    <c:forEach items="${shopCategoryGroups}" var="group" varStatus="i">
                        <c:forEach items="${item.breadcrumbs}" var="breadcumb">
                            <c:if test="${group.url eq breadcumb.groupUrl}">
                                <c:forEach items="${group.categories}" var="category">
                                    <c:if test="${category.url eq breadcumb.breadcrumbCategories[0].categoryUrl}">
                                        <c:forEach items="${category.childCategories}" var="category2">
                                            <li><a href="/category/${category2.url}">${category2.name}</a></li>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:if>
    <c:if test="${fn:length(item.breadcrumbs[0].breadcrumbCategories) ge 3}">
        <div class="deps1">
            <c:forEach items="${item.breadcrumbs[0].breadcrumbCategories}" var="selectedCate" varStatus="i">
                <c:if test="${i.index eq 2}">
                    ${selectedCate.categoryName}
                </c:if>
            </c:forEach>
            <i></i>
            <div class="select-wrap">
                <ul class="select-option">
                    <c:forEach items="${shopCategoryGroups}" var="group" varStatus="i">
                        <c:forEach items="${item.breadcrumbs}" var="breadcumb">
                            <c:if test="${group.url eq breadcumb.groupUrl}">
                                <c:forEach items="${group.categories}" var="category">
                                    <c:if test="${category.url eq breadcumb.breadcrumbCategories[0].categoryUrl}">
                                        <c:forEach items="${category.childCategories}" var="category2">
                                            <c:if test="${category2.url eq breadcumb.breadcrumbCategories[1].categoryUrl}">
                                                <c:forEach items="${category2.childCategories}" var="category3">
                                                    <li><a href="/category/${category3.url}">${category3.name}</a></li>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:if>
</div>
<page:javascript>
<script>
    $(document).ready(function(){
        const toggleTarget = $( '.category-tab-all' );
        toggleTarget.click(function (){
            if ($(this).hasClass('on')) {
                toggleTarget.removeClass('on');
            } else {
                toggleTarget.removeClass('on');
                $(this).toggleClass('on');
            }
        });
    });
</script>
</page:javascript>