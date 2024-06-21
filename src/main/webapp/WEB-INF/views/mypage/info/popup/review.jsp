<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">후기작성</div>
    <div class="modal-body p-2">
        <form id="reviewApplyForm">
            <!-- 아이템 영역 -->
            <c:set var="i" value="${content}" scope="request"/>
            <jsp:include page="/WEB-INF/views/include/order/order-item.jsp"/>

            <input type="hidden" name="orderCode" value="${orderCode}">
            <input type="hidden" name="itemName" value="${i.itemName}">
            <input type="hidden" name="itemId" value="${i.itemId}">

            <span class="article-divider"></span>
            <p class="eval-txt">상품은 어떠셨나요?</p>
            <div class="score-wrap">
                <c:forEach var="i" begin="1" end="5">
                    <span class="star" onclick="addActiveClass(${i});"></span>
                </c:forEach>
            </div>
            <textarea name="content" id="content" cols="30" rows="10" class="form-basic text-area required _filter" placeholder="내용을 입력하세요" title="내용"></textarea>
            <label for="addPhoto" class="btn btn-default btn-add-photo">
                <input type="file" name="reviewImage" id="addPhoto" class="hidden" multiple onchange="fileChange(event, 'review')"/>
                <img src="/static/content/image/ico/ico_camera.svg" alt="사진 첨부하기" class="ico" /><span>사진 첨부하기</span>
                <span class="benefit-balloon">포토후기 +2,000P</span>
            </label>
            <ul class="photo-list"></ul>
            <ul class="dot-list large-dot">
                <li>5MB 이하의 사진 4장까지 첨부 가능</li>
                <li>이용후기는 구매확정 된 상품에 한하여 주문일로부터 90일내 작성 가능합니다.</li>
                <li><em>일반후기 1,000P / 포토후기 2,000P</em> 적립해드립니다.</li>
            </ul>
            <div class="link-wrap">
                <button type="submit" class="btn btn-primary link-item w-half">등록</button>
                <button type="button" class="btn btn-default link-item w-half" data-dismiss="">취소</button>
            </div>
        </form>
    </div>
</div>
<script>
    $(function(){
        $("#reviewApplyForm").validator({
            'requiredClass' : 'required',
            'submitHandler' : function() {
                let formData = new FormData();

                const orderCode = $("input[name=orderCode]").val(); // 주문번호
                const itemName = $("input[name=itemName]").val();   // 상품명
                const itemId = $("input[name=itemId]").val();       // 상품 ID
                const content = $("textarea[name=content]").val();  // 후기 내용
                const score = $(".star.active").length;             // 별점

                formData.append("orderCode", orderCode);
                formData.append("itemName", itemName);
                formData.append("itemId", itemId);
                formData.append("content", content);
                formData.append("score", score);

                let files = $("input[name=reviewImage]")[0].files;  // 이미지

                if (files.length > 0){  // 첨부 이미지가 존재한다면
                    for (let i=0; i < files.length; i++) {
                        formData.append('itemReviewImageFiles[' + i + ']', files[i]);
                    }
                }

                $saleson.api.post("/api/item/review", formData)
                .then(function (response) {
                    if (response.status === 200){
                        $saleson.core.alert("상품후기가 작성되었습니다.", function(){
                            salesOnUI.modal().dismiss('.open-modal-review');
                            $saleson.core.reload();
                        });
                    }
                }).catch(function(error) {
                    $saleson.core.api.handleApiExeption(error);
                });

                return false;
            }
        });
    })

    function addActiveClass(starIndex) {
        const stars = document.querySelectorAll('.star');
        stars.forEach((star, index) => {
            star.classList.remove('active');
        });

        for (let i = 0; i < starIndex; i++) {
            stars[i].classList.add('active');
        }
    }
</script>