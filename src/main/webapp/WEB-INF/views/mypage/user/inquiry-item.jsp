<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>


<layout:mypage>
    <section class="mypage-inquiry">
        <div class="title-container">
            <h2 class="title-h2">상품문의</h2>
        </div>
        <form id="inquiryItemForm" method="get">
            <div class="select-wrap">
                <div class="flex">
                    <select class="input-select" name="qnaGroup">
                        <option value="">문의 유형을 선택하세요</option>
                        <c:forEach var="type" items="${qnaGroups.list}">
                            <option value="${type.id}" ${criteria.qnaGroup eq type.id ? 'selected="selected"':''}>${type.label}</option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="btn btn-form">조회</button>
                </div>
            </div>
        </form>

        <c:choose>
            <c:when test="${not empty pageContent.content}">
                <ul class="review-content">
                    <c:forEach var="inquiry" items="${pageContent.content}">
                        <c:set var="inquiry" value="${inquiry}" scope="request"/>
                        <c:set var="displayDeliveryUtilFlag" value="true" scope="request"/>
                        <li>
                            <!-- 상품영역 -->
                            <div class="item-list-container horizon">
                                <div class="item-list" onclick="$saleson.core.redirect('/item/${inquiry.itemUserCode}')">
                                    <!-- 아이템 썸네일 영역 -->
                                    <div class="thumbnail-container">
                                        <div class="thumbnail-wrap">
                                            <img class="thumbnail" src="${inquiry.itemImage}" alt="썸네일" onerror="errorImage(this)">
                                        </div>
                                    </div>
                                    <!-- 아이템 정보 영역 -->
                                    <div class="info-container">
                                        <div class="title-main paragraph-ellipsis">
                                            <c:if test="${not empty inquiry.brand}"><b>[${inquiry.brand}]</b></c:if>${inquiry.itemName}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <span class="divider"></span>
                            <!-- 답변 상태 -->
                            <jsp:include page="/WEB-INF/views/include/inquiry/inquiry.jsp"/>
                            <!-- 답변 대기 상태 : 관리자답변 X -->
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="no-contents">
                    <img src="/static/content/image/common/img_noQna.png" alt="게시글 없음">
                    <p>상품문의가 없습니다.</p>
                </div>
            </c:otherwise>
        </c:choose>

        <page:pagination/>
    </section>

    <page:javascript>
        <script>
            $(function () {
                $('.delete-inquiry').on('click', function (e) {
                    e.preventDefault();
                    const id = $(this).data('id');

                    $saleson.core.confirm('상품문의를 삭제 하시겠습니까?', function () {
                        $saleson.api.post('/api/qna/delete-item-inquiry/'+id)
                            .then(function (response) {
                                if (response.status === 200) {
                                    $saleson.core.alert("삭제 되었습니다.", function () {
                                        location.reload();
                                    });
                                }
                            })
                            .catch(function (error) {
                                $saleson.core.api.handleApiExeption(error);
                            });
                    });
                });
            });

        </script>
    </page:javascript>
</layout:mypage>
