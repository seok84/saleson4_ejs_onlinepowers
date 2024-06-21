<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:mypage>

    <section class="mypage-coupon">
        <div class="title-container m-line-divider">
            <h2 class="title-h2">쿠폰</h2>
            <div class="btn-wrap">
                <button type="button" class="btn btn-black btn-action" onclick="downloadCouponAll();">
                    <img src="/static/content/image/ico/ico_download.png" class="ico-down">쿠폰 다운
                </button>
                <button type="button" class="btn btn-default btn-action" onclick="salesOnUI.toggleCoupon('.coupon-input-area')">오프라인쿠폰등록</button>
            </div>
            <div class="coupon-input-area">
                <h3 class="form-title">등록할 쿠폰이 있으신가요?</h3>
                <div class="form-line">
                    <form id="offlineCouponForm">
                        <div class="flex">
                            <input type="text" id="offlineCode" class="form-basic required" placeholder="'-'없이 쿠폰 번호 입력" title="쿠폰번호" />
                            <button type="submit" class="btn btn-black">적용</button>
                        </div>
                        <span class="feedback invalid" style="display: none">유효성 메시지</span>
                    </form>
                </div>
            </div>
        </div>
        <!-- // 활성화 -->
        <div class="tabs">
            <a class="tab-item ${tabClass == "false" ? "active":""}" onclick="couponTab('false')">사용 가능</a>
            <a class="tab-item ${tabClass == "true" ? "active":""}" onclick="couponTab('true')">사용 완료</a>
        </div>
        <div class="tabs-content">
            <!-- 정렬 -->
            <div class="sort-wrap">
                <c:choose>
                    <c:when test="${tabClass == 'false'}">
                        <p class="all-items">사용가능 쿠폰 (${availableCount})</p>
                    </c:when>
                    <c:otherwise>
                        <p class="all-items">사용한 쿠폰 (${completedUserCouponCount})</p>
                    </c:otherwise>
                </c:choose>
                <ul class="sort-list">
                    <li><button type="button" class="sort-item active">전체</button></li>
                    <%--<li><button type="button" class="sort-item">상품 쿠폰</button></li>--%>
                    <%--<li><button type="button" class="sort-item">주문서 쿠폰</button></li>
                    <li><button type="button" class="sort-item">카테고리쿠폰</button></li>--%>
                </ul>
            </div>
            <!-- 쿠폰 영역 -->
            <ul class="coupon-container ${tabClass == "true" ? "deactive":""}">
                <c:forEach items="${pageContent.content}" var="coupon">
                    <li class="coupon-item">
                        <div class="flex">
                            <p class="discount"><b><fmt:formatNumber value="${coupon.couponPay}" pattern="#,###"/></b>${coupon.couponPayType == '1' ? '원' : '%'}</p>
                            <span class="coupon-type item">상품 쿠폰</span>
                        </div>
                        <p class="title">
                            ${coupon.couponName}
                            <span class="sub-title">${coupon.couponComment}</span>
                        </p>
                        <p class="condition">쿠폰 사용 조건(ex.3,000원 이상 사용가능)</p>
                        <c:if test="${coupon.couponPayRestriction > 0}">
                            <p class="condition">
                                <fmt:formatNumber value="${coupon.couponPayRestriction}" pattern="#,###"/> 원 이상 사용가능
                            </p>
                        </c:if>
                        <c:if test="${coupon.couponApplyType == '1'}">
                            <fmt:parseDate value="${coupon.couponApplyStartDate}" var="couponApplyStartDate" pattern="yyyyMMddHHmmss"/>
                            <fmt:parseDate value="${coupon.couponApplyEndDate}" var="couponApplyEndDate" pattern="yyyyMMddHHmmss"/>
                            <p class="condition">사용가능기간 :
                                <fmt:formatDate value="${couponApplyStartDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                ~ <fmt:formatDate value="${couponApplyEndDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </p>
                        </c:if>
                        <div class="flex align-end">
                            <c:choose>
                                <c:when test="${'2' eq coupon.couponTargetItemType}">
                                    <button type="button" class="coupon-btn" data-coupon-id="${coupon.couponId}">적용 상품 보기<i class="arrow"></i></button>
                                </c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>

                            <c:if test="${tabClass eq 'true'}">
                                <c:choose>
                                    <c:when test="${!empty coupon.couponUseDate}">
                                        <span class="used-complete">
                                            <fmt:parseDate value="${coupon.couponUseDate}" var="couponUseDate" pattern="yyyyMMddHHmmss"/>
                                            사용완료 <fmt:formatDate value="${couponUseDate}" pattern="yyyy-MM-dd"/>
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="used-complete">기한 만료</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            <!-- 페이징 -->
        </div>
        <c:if test="${empty pageContent.content}">
            <div class="no-contents">
                <p>쿠폰 내역이 없습니다.</p>
            </div>
            &nbsp;
        </c:if>
        <ul class="dot-list large-dot">
            <li>사용 기간 내에 사용하지 않은 쿠폰은 삭제됩니다.</li>
            <li>사용 가능 금액 이상으로 주문 시 쿠폰 혜택 적용이 가능합니다.</li>
        </ul>
        <page:pagination/>
    </section>

    <script>
        $(document).ready(function(){
            salesOnUI.tabs();
        });
    </script>

    <page:javascript>
        <script>

            let CURRENT_COUPON_ID = 0;

            function couponTab(type){
                location.href = "/mypage/benefit/coupon?complete="+type;
            }

            $(function(){
                $("#offlineCouponForm").validator({
                    'requiredClass' : 'required',
                    'submitHandler' : function() {

                        const offlineCode = $("#offlineCode").val();
                        $saleson.core.confirm("오프라인 쿠폰을 등록하시겠습니까?", () => {

                            const param = { "offlineCode" : offlineCode };
                            $saleson.api.get("/api/coupon/exchange-offline-coupon", param)
                            .then(function (response) {
                                if (response.status === 200){
                                    $saleson.core.alert("쿠폰이 등록되었습니다.", function(){
                                        location.reload();
                                    });
                                }
                            }).catch(function(error) {
                                $saleson.core.api.handleApiExeption(error);
                            });
                        });
                        return false;
                    }
                });

                $('.coupon-btn').on('click', function() {
                    CURRENT_COUPON_ID = $(this).data('coupon-id');
                    paginationAppliesToCoupon(1);
                });


            })

            function paginationAppliesToCoupon(page) {
                const couponId = CURRENT_COUPON_ID;
                const selector = '#applies-to-coupon-item-list';
                const $selector = $(selector);

                const param = {
                    page: page,
                    size: 12
                }

                $selector.empty();

                $.get('/mypage/benefit/coupon/popup/'+couponId+'/applies-to', param, function (response) {
                    $selector.append(response);

                    if (!$selector.hasClass('show')) {
                        salesOnUI.modal().show('#applies-to-coupon');
                    }

                    $saleson.handler.itemEventHandler(selector);
                    $saleson.handler.redirectItemHandler($selector);
                }, 'html');
            }
        </script>
    </page:javascript>
    <page:model>
        <div class="modal item-grid" id="applies-to-coupon">
            <div class="modal-wrap">
                <button class="modal-close" data-dismiss>닫기</button>
                <div class="modal-header">적용상품 보기</div>
                <div class="modal-body" id="applies-to-coupon-item-list">
                </div>
            </div>
            <div class="dimmed-bg" data-dismiss></div>
        </div>
    </page:model>
</layout:mypage>
