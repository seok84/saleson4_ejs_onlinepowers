<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
    <section class="result-container">
        <c:choose>
            <c:when test="${not empty pageContent.content}">
                <div>
                    <h1 class="title-h1">'<em>${criteria.query}</em>' 검색결과</h1>

                    <c:set var="sorting" value="${criteria.orderBy}__${criteria.sort}" scope="request"/>
                    <c:set var="totalElements" value="${pageContent.pagination.totalElements}" scope="request"/>
                    <jsp:include page="/WEB-INF/views/include/filter/item-list-form.jsp"/>

                    <c:set var="itemList" value="${pageContent.content}" scope="request"/>
                    <jsp:include page="/WEB-INF/views/include/item/item-list.jsp"/>

                    <page:pagination/>

                </div>
            </c:when>
            <c:otherwise>
                <div class="no-result-content">
                    <h1 class="title-h1">'<em>${criteria.query}</em>' 검색결과</h1>
                    <img src="/static/content/image/common/img_noResult.png" alt="검색 결과가 없습니다." class="result-img">
                    <p class="result-text">검색 결과가 없습니다.</p>
                    <span class="result-info">단어의 철자가 정확한지 확인해 보세요.<br/>띄어쓰기 또는 넓은 의미의 단어를 사용해 보세요:D</span>
                    <a href="/" class="btn btn-round btn-primary-line confirm-btn">메인으로</a>
                </div>
            </c:otherwise>
        </c:choose>


    </section>

    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>
        <script>
            $(function () {
                const $listForm = $('#itemListForm');
                $listForm.append($('<input type="hidden" name="query" value="${criteria.query}"/>'));
            });
        </script>
    </page:javascript>
</layout:default>