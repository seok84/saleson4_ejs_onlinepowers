<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form id="itemListForm" method="get">
    <div class="filter-wrap">
        <p>총 <b><fmt:formatNumber value="${totalElements}" pattern="#,###"/></b>개 상품</p>
        <div class="select-wrap">
            <input type="hidden" name="sort" value="">
            <input type="hidden" name="orderBy" value="">
            <select class="input-select" id="itemListSorting">
                <option ${sorting eq '__' ?'selected':''} value="__">추천순</option>
                <option ${sorting eq 'ORDERING__ASC' ?'selected':''} value="ORDERING__ASC">최신순</option>
                <option ${sorting eq 'SALE_PRICE__DESC' ?'selected':''} value="SALE_PRICE__DESC">높은 가격순</option>
                <option ${sorting eq 'SALE_PRICE__ASC' ?'selected':''} value="SALE_PRICE__ASC">낮은 가격순</option>
            </select>
        </div>
    </div>
</form>
