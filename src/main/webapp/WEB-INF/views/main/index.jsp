<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
    <div class="main">
        <!-- visual -->
        <%@ include file="./area/promotion.jsp"%>
        <!-- 신상품 -->
        <%@ include file="./area/new-item.jsp"%>
        <!-- 타임세일 -->
        <%@ include file="./area/timedeal-item.jsp"%>
        <!-- 배너영역 -->
        <%@ include file="./area/middle-banner.jsp"%>
        <!-- 베스트상품 -->
        <%@ include file="./area/best-item.jsp"%>
        <!-- 브랜드 -->
        <%@ include file="./area/brand.jsp"%>
        <!-- banner -->
        <%@ include file="./area/advertisement.jsp"%>
        <!-- recommend -->
        <%@ include file="./area/md.jsp"%>
        <!-- review -->
        <%@ include file="./area/review.jsp"%>
        <!-- event -->
        <%@ include file="./area/featured.jsp"%>
    </div>

    <page:model>
        <div id="popup-area">

        </div>
    </page:model>
    <page:javascript>
        <script defer src="/static/content/modules/ui/main/view.js"></script>
    </page:javascript>

</layout:default>
