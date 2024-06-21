<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<layout:mypage>
    <section class="mypage-favorite">
        <div class="title-container">
            <h2 class="title-h2">${headerTitle}</h2>
        </div>
        <!-- // 상품 영역 -->
        <div class="check-wrap m-line-divider">
            <label class="circle-input-checkbox"><input type="checkbox" id="checkAll"><i></i> 전체선택(${pageContent.pagination.totalElements}개)</label>
            <div class="btn btn-default btn-round btn-delete btn-action" id="deleteAll">선택삭제</div>
        </div>
        <div class="item-list-container vertical">
            <c:set var="itemList" value="${pageContent.content}" scope="request"/>
            <c:set var="itemListClass" value="item-list-3" scope="request"/>
            <c:set var="wishCheckBoxFlag" value="true" scope="request"/>
            <c:set var="showWishFlag" value="true" scope="request"/>
            <c:forEach var="itemResponse" items="${itemList}" varStatus="i">
                <c:set var="wishlistId" value="${itemResponse.wishlistId}" scope="request"/>
                <c:set var="item" value="${itemResponse.item}" scope="request"/>
                <jsp:include page="/WEB-INF/views/include/item/item.jsp"/>
            </c:forEach>
        </div>
        <c:if test="${empty pageContent.content}">
            <div class="no-contents">
                <p>관심 상품이 없습니다.</p>
            </div>
        </c:if>
                       <page:pagination/>
    </section>



    <page:javascript>
        <script src="/static/content/modules/ui/item/list.js"></script>

        <script>
            $(() => {

                $('#checkAll').change(function() {
                    $("input[type='checkbox']").prop("checked", this.checked);
                });

                $('#deleteAll').click(function() {
                    deleteAll();
                });
            });

            function deleteAll() {

                if ($("input[type='checkbox']:checked").length == 0) {
                    $saleson.core.toast('삭제할 상품을 선택해주세요.');
                    return false;
                }
                let ids = [];
                $(".item-list input[type='checkbox']:checked").each(function(){
                    ids.push(this.value);
                });



                $saleson.core.confirm("삭제하시겠습니까?", function () {
                    $saleson.api.post("/api/wishlist/delete-wishlist", ids)
                    .then(function (response) {
                        console.log(response);
                        if(response.status === 200) {
                            $saleson.core.alert("삭제되었습니다.", function () {
                                location.reload();
                            })
                        }
                    })
                    .catch(function (error) {
                        $saleson.core.alert(error);
                    })
                })



            }

        </script>
    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
