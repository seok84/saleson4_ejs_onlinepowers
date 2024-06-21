<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">
        쿠폰 다운로드
    </div>
    <div class="modal-body p-2">
        <button type="button" class="btn btn-default-line btn-all-down" onclick="downloadAllCoupons();">
            <img src="/static/content/image/ico/ico_download_black_02.svg" class="ico-down"><span>모든 쿠폰 다운</span>
        </button>
        <p class="all-items">총 <strong>${pageContent.pagination.totalElements}</strong>개</p>
        <!-- 쿠폰리스트 -->
        <ul class="coupon-list-container">
            <c:forEach items="${pageContent.content}" var="coupon">
                <li class="coupon-list line">
                    <div class="coupon-list-wrap">
                        <div class="item">
                            <div class="price-area"><span class="number"><em>10</em>%</span></div>
                            <div class="tag-area product"></div>
                        </div>
                        <div class="info">
                            <strong class="desc title">${coupon.couponName}</strong>
                            <span class="desc sub">${coupon.couponComment}</span>
                            <p class="pc">
                                <span class="desc  date">
                                    <c:if test="${coupon.couponApplyType == '1'}">
                                        ${coupon.couponApplyStartDate} ~ ${coupon.couponApplyEndDate} /
                                    </c:if>
                                    <c:if test="${coupon.couponPayRestriction > 0}">
                                        ${coupon.couponPayRestriction} 원 이상 구매시 사용가능
                                    </c:if>
                                </span>
                            </p>
                        </div>
                    </div>
                    <button type="button" class="download" onclick="downloadCoupon('${coupon.couponId}');">
                        <img src="/static/content/image/ico/ico_download_black.svg" class="ico-down"><span>쿠폰받기</span>
                    </button>
                    <div class="mobile">
                        <span class="desc  date">
                            <c:if test="${coupon.couponApplyType == '1'}">
                               ${coupon.couponApplyStartDate} ~ ${coupon.couponApplyEndDate} /
                            </c:if>
                            <c:if test="${coupon.couponPayRestriction > 0}">
                             ${coupon.couponPayRestriction} 원 이상 구매시 사용가능
                            </c:if>
                        </span>
                    </div>
                </li>
            </c:forEach>
        </ul>
        <page:pagination/>
        <c:if test="${empty pageContent.content}">
            <div class="no-contents">
                다운로드 가능한 쿠폰이 없습니다.
            </div>
        </c:if>
        <ul class="dot-list large-dot">
            <li>다운로드한 쿠폰은 마이페이지 > 쿠폰에서 확인하실 수 있습니다.</li>
            <li>다운로드한 쿠폰의 유효기간 경과 시 사용할 수 없습니다.</li>
        </ul>
    </div>
</div>
<script>

    function paginationCouponDownList(page) {
        downloadCouponAll(page);
    }

    function downloadCoupon(couponId){
        $saleson.core.confirm("쿠폰을 다운받으시겠습니까?", function (){

            let param = {
                couponId : couponId
            };

            $saleson.api.post("/api/coupon/download", param)
            .then(function (response) {
                if (response.status === 200){
                    $saleson.core.alert("쿠폰을 다운받았습니다.", function(){
                        location.reload();
                    });
                }
            }).catch(function(error) {
                $saleson.core.alert(error);
            });

        });
    }

    function downloadAllCoupons(){
        $saleson.core.confirm("쿠폰을 다운받으시겠습니까?", function (){
            $saleson.api.post("/api/coupon/download-all-coupons", {})
            .then(function (response) {
                if (response.status === 200){
                    $saleson.core.alert("쿠폰을 다운받았습니다.", function(){
                        location.reload();
                    });
                }
            }).catch(function(error) {
                $saleson.core.alert(error);
            });

        });

    }
</script>