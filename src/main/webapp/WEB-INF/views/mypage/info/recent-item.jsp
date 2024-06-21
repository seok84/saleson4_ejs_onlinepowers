<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<layout:mypage>
    <section class="mypage-recent">
        <div class="title-container">
            <h2 class="title-h2">${headerTitle}</h2>
        </div>
        <!-- // 상품 영역 -->
        <div class="all-items">
            총  <c:out value="${fn:length(pageContent.list)}" />개
        </div>
        <c:set var="itemList" value="${pageContent.list}" scope="request"/>
        <c:set var="itemListClass" value="item-list-3" scope="request"/>

        <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>
    </section>


    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>


    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
