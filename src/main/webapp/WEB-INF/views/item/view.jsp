<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>
    <h1 class="title-h1" style="display: none"></h1>
    <div class="item-detail-page">
        <jsp:include page="/WEB-INF/views/include/category/nav.jsp"/>
        <c:set var="itemDetail" value="${item.item}" scope="request"/>
        <input id="isLogin" type="hidden" value="${isLogin}">
        <!-- 상단컨텐츠 -->
        <div class="detail-content-area top">
            <!-- 타임딜 -->
            <c:if test="${itemDetail.spotFlag}">

                <c:choose>
                    <c:when test="${'1' eq itemDetail.spotDateType}">
                        <div class="timedeal top mobile">
                            <p>
                                <span>TIME</span>
                                <span>SALE</span>
                            </p>
                            <p>
                                <span>${itemDetail.displaySpotStartTime} ~ ${itemDetail.displaySpotEndTime}</span>
                                <span>${itemDetail.weekDays}</span>
                            </p>
                        </div>
                    </c:when>
                    <c:when test="${'2' eq itemDetail.spotDateType}">
                        <div class="timedeal top spot-timer mobile" data-spot-countdown-date="${itemDetail.spotCountdownDate}">
                            <p>
                                <span>TIME</span>
                                <span>SALE</span>
                            </p>
                            <p class="d-day">
                                <span class="timer-day">D-00</span>
                                <span class="timer-time">00 : 00 : 00</span>
                            </p>
                        </div>
                    </c:when>
                </c:choose>
            </c:if>
            <!-- 상단-썸네일 영역 -->
            <div class="thumbnail-detail">
                <!-- 썸네일 메인 -->
                <div class="swiper thumbnail-main-swiper">
                    <div class="swiper-wrapper">
                        <c:forEach items="${itemDetail.images}" var="image">
                            <div class="swiper-slide">
                                <!-- 아이템 썸네일 영역 -->
                                <div class="thumbnail-container sold-out">
                                    <c:if test="${itemDetail.itemSoldOutFlag eq 'Y'}">
                                        <div class="sold-out-wrap">
                                            <span>
                                                <img src="/static/content/image/sample/sold-out.png" alt="품절">
                                            </span>
                                        </div>
                                    </c:if>
                                    <div class="thumbnail-wrap">
                                        <img class="thumbnail" src="${image}" onerror="errorImage(this)" alt="썸네일">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- 썸네일 리스트 -->
                <div class="swiper thumbnail-list-swiper swiper-visible">
                    <div class="swiper-wrapper">
                        <c:forEach items="${itemDetail.images}" var="image">
                            <div class="swiper-slide">
                                <!-- 아이템 썸네일 영역 -->
                                <div class="thumbnail-container sold-out">
                                    <!-- <div class="sold-out-wrap">
                                        <span>
                                            <img src="/static/content/image/sample/sold-out.png" alt="품절">
                                        </span>
                                    </div> -->
                                    <div class="thumbnail-wrap">
    <%--                                    <img class="thumbnail" src="/static/content/image/sample/thum.png" alt="썸네일">--%>
                                            <img class="thumbnail" src="${image}" onerror="errorImage(this)" alt="썸네일">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="swiper-controls">
                        <div class="swiper-prev">이전</div>
                        <div class="swiper-next">다음</div>
                    </div>
                </div>
            </div>
            <!-- 상단-정보 영역 -->
            <div class="info-detail">
                <!-- 태그 -->
                <c:if test="${not empty itemDetail.labels}">
                    <div class="tag-wrap">
                        <c:forEach var="label" items="${itemDetail.labels}">
                            <div class="tag" style="background-color: ${label.color}">${label.label}</div>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- 타임딜 -->
                <c:if test="${itemDetail.spotFlag}">

                    <c:choose>
                        <c:when test="${'1' eq itemDetail.spotDateType}">
                            <div class="timedeal top pc weekend">
                                <p>
                                    <span>TIME</span>
                                    <span>SALE</span>
                                </p>
                                <p>
                                    <span>${itemDetail.displaySpotStartTime} ~ ${itemDetail.displaySpotEndTime}</span>
                                    <span>${itemDetail.weekDays}</span>
                                </p>
                            </div>
                        </c:when>
                        <c:when test="${'2' eq itemDetail.spotDateType}">
                            <div class="timedeal top spot-timer pc time-limit" data-spot-countdown-date="${itemDetail.spotCountdownDate}">
                                <p>
                                    <span>TIME</span>
                                    <span>SALE</span>
                                </p>
                                <p class="d-day">
                                    <span class="timer-day">D-00</span>
                                    <span class="timer-time">00 : 00 : 00</span>
                                </p>
                            </div>
                        </c:when>
                    </c:choose>
                </c:if>
                <!-- 브랜드 -->
                <div class="brand-area">
                    <div class="brand-name">
                        <c:if test="${not empty itemDetail.brand && not empty itemDetail.brandId}">
                            <span>${itemDetail.brand}</span>
                            <a href="/brand/${itemDetail.brandId}">
                                <span class="ico-link"></span>
                            </a>
                        </c:if>
                    </div>
                    <div class="brand-action">
                        <span class="ico-heart2" onclick="$saleson.handler.addToWishlist('${itemDetail.itemId}', $(this))"></span> <!-- active class 추가시 활성화 -->
                        <span class="link-copy" onclick="$saleson.handler.copyText('${itemDetail.eventViewUrl}')"></span>
                    </div>
                </div>
                <!-- 타이틀 -->
                <div class="title-area">
                    <p class="title-main paragraph-ellipsis">${itemDetail.displayItemName}</p>
                    <c:if test="${not empty itemDetail.originCountry}">
                        <p class="title-option paragraph-ellipsis">원산지 : ${itemDetail.originCountry}</p>
                    </c:if>
                    <p class="title-sub paragraph-ellipsis">${itemDetail.itemSummary}</p>
                </div>
                <!-- 가격 -->
                <div class="price-area">
                    <div class="price-info">
                        <c:if test="${itemDetail.discountRate > 0}">
                            <div class="cost"><fmt:formatNumber value="${itemDetail.salePrice}" pattern="#,###"/><strong>원</strong></div>
                        </c:if>
                        <div class="price">
                            <span><fmt:formatNumber value="${itemDetail.presentPrice}" pattern="#,###"/><strong>원</strong></span>
                            <c:if test="${itemDetail.discountRate > 0}">
                                <span>
                                    ${itemDetail.discountRate}<strong>%</strong>
                                </span>
                                <span class="tooltip-handler">?</span>
                            </c:if>
                            <div class="tooltip-wrap">
                                <div class="dimmed-bg" data-dismiss-tooltip></div>
                                <div class="tooltip-content tooltip-benefit">
                                    <button type="button" class="btn-tooltip-close" data-dismiss-tooltip>닫기</button>
                                    <p class="text-center tooltip-tit">할인혜택</p>
                                    <ul>
                                        <li class="default">
                                            <p>정상가</p>
                                            <p><fmt:formatNumber value="${itemDetail.itemPrice}" pattern="#,###"/>원</p>
                                        </li>
                                        <li class="txt1 sale">
                                            <p>판매가</p>
                                            <p><fmt:formatNumber value="${itemDetail.salePrice}" pattern="#,###"/>원</p>
                                        </li>
                                        <c:if test="${itemDetail.spotDiscountAmount > 0}">
                                            <li class="txt2">
                                                <p>타임세일</p>
                                                <p><fmt:formatNumber value="${itemDetail.spotDiscountAmount}" pattern="#,###"/>원</p>
                                            </li>
                                        </c:if>
                                        <c:if test="${itemDetail.sellerDiscountFlag eq 'Y'}">
                                            <li class="txt2">
                                                <p>즉시할인</p>
                                                <p><fmt:formatNumber value="${itemDetail.sellerDiscountPrice}" pattern="#,###"/>원</p>
                                            </li>
                                        </c:if>
                                        <c:if test="${itemDetail.userLevelDiscountAmount > 0}">
                                            <li class="txt2">
                                                <p>회원추가할인</p>
                                                <p><fmt:formatNumber value="${itemDetail.userLevelDiscountAmount}" pattern="#,###"/>원</p>
                                            </li>
                                        </c:if>
                                        <li class="txt1 max">
                                            <p>최대혜택가</p>
                                            <p><fmt:formatNumber value="${itemDetail.presentPrice}" pattern="#,###"/>원</p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <c:if test="${salesonContext.hasToken && itemDetail.couponUseFlag eq 'Y'}">
                        <button type="button" class="btn btn-round btn-primary-line btn-coupondown" onclick="downloadCouponAll()">쿠폰다운<i></i></button>
                    </c:if>
                </div>
                <!-- 카드혜택 -->
                <c:if test="${not empty item.cardBenefits.subject}">
                    <div class="select-wrap card-benefit-wrap">
                        <div class="input-select">카드혜택<p>${item.cardBenefits.subject}</p></div>
                        <div class="select-option card-benefit hidden">
                                ${item.cardBenefits.content}
                        </div>
                    </div>
                </c:if>
                <!-- 상품정보 -->
                <div class="item-info-area">
                    <table>
                        <tr>
                            <th>적립예정포인트</th>
                            <td>
                                <c:set value="${item.itemEarnPoint}" var="point"/>
                                <c:choose>
                                    <c:when test="${point.point eq 0}">
                                        0P
                                    </c:when>
                                    <c:when test="${point.point != 0}">
                                        <c:choose>
                                            <c:when test="${empty point.levelName}">
                                                ${point.point}P (${point.pointRate}% 적립)
                                            </c:when>
                                            <c:when test="${not empty point.levelName and not empty point.levelPointRate}">
                                                ${point.point}P (${point.pointRate}% 적립 + ${point.levelName} + ${point.levelPointRate}%)
                                            </c:when>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>상품코드</th>
                            <td>${itemDetail.itemUserCode}</td>
                        </tr>
                        <tr>
                            <th>배송정보</th>
                            <td>
                                <c:choose>
                                    <c:when test="${itemDetail.shippingType eq '1'}">
                                        무료배송
                                    </c:when>
                                    <c:when test="${itemDetail.shippingType == '2' || itemDetail.shippingType == '3' || itemDetail.shippingType == '4'}">
                                        <fmt:formatNumber value="${itemDetail.shipping}" pattern="#,###"/>원(<fmt:formatNumber value="${itemDetail.shippingFreeAmount}" pattern="#,###"/>원 이상 무료배송)
                                    </c:when>
                                    <c:when test="${itemDetail.shippingType == '5'}">
                                        ${itemDetail.shippingItemCount} 개당 <fmt:formatNumber value="${itemDetail.shipping}" pattern="#,###"/>원
                                    </c:when>
                                    <c:when test="${itemDetail.shippingType == '6'}">
                                        <fmt:formatNumber value="${itemDetail.shipping}" pattern="#,###"/>원
                                    </c:when>
                                </c:choose>
                                <br>
                                <span class="delivery-info" onclick="islandInfoModal(1)">도서산간 지역보기</span>
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- 옵션 선택 영역컨테이너 -->
                <article class="select-option-container option-top">
                    <div class="dimmed-bg mobile"></div>
                    <p class="product-title mobile">${itemDetail.displayItemName}</p>
                    <form id="cartForm">
                        <div class="form-inner">
                            <div id="cart-item" style="display: none">
                                <!-- 옵션 미사용 - 수량 -->
                                <c:if test="${itemDetail.itemOptionFlag == 'N' && itemDetail.itemSoldOutFlag != 'Y'}">
                                    <c:choose>
                                        <c:when test="${itemDetail.itemType == '3'}">
                                            <%--                                            <input type="hidden" name="itemSets[0].itemId" value="${itemDetail.itemId}" />--%>
                                            <%--                                            <input type="hidden" name="itemSets[0].quantity" value="1" />--%>
                                            <%--                                            <c:forEach items="${itemDetail.itemSets}" var="itemSet" varStatus="i">--%>
                                            <%--                                                <input type="hidden" name="itemSets[0].arrayItemSets" value="${itemSet.item.itemId}||${itemSet.quantity}||" />--%>
                                            <%--                                            </c:forEach>--%>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="arrayRequiredItems" value="${itemDetail.itemId}||${itemDetail.orderMinQuantity < 0 ? 1 : itemDetail.orderMinQuantity}||" />
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                            <jsp:include page="/WEB-INF/views/item/include/option-buy.jsp"/>
                            <div class="total-price" style="display: none">
                                <p>
                                    합계
                                </p>
                                <p>
                                    <span class="total-amount">0</span>
                                    <span>원</span>
                                </p>
                            </div>
                        </div>
                    </form>
                    <!-- 버튼 -->
                    <div class="btn-option-buy btn-wrap gap">
                        <button type="button" class="btn btn-round btn-primary-line cart" >장바구니</button>
                        <button type="button" class="btn btn-round btn-primary buyNow" >구매하기</button>
                        <button class="btn-option-open">옵션열기</button>
                    </div>

                </article>
            </div>
        </div>
        <!-- 연관상품 -->
        <div class="recommend-container"></div>
        <!-- 하단컨텐츠 -->
        <section class="detail-contents-area bottom">
            <div class="contents-left">
                <!-- 탭메뉴 -->
                <div class="tabs type-b">
                    <a class="tab-item active" data-target="detail-info-contents">상세정보</a>
                    <a class="tab-item" data-target="detail-basic-contents">기본정보</a>
                    <a class="tab-item" data-target="detail-review-contents">후기</a>
                    <a class="tab-item" data-target="detail-inquire-contents">상품문의</a>
                    <a class="tab-item" data-target="detail-notice-contents">상품고시</a>
                </div>
                <!-- 상세정보 -->
                <jsp:include page="./area/info.jsp"/>

                <!-- 기본정보 -->
                <jsp:include page="./area/basic.jsp"/>

                <!-- 후기(1,955) -->
                <jsp:include page="./area/review.jsp"/>

                <!-- 상품문의 -->
                <jsp:include page="./area/inquiry.jsp"/>

                <!-- 상품고시 -->
                <jsp:include page="./area/notice.jsp"/>
            </div>
            <div class="contents-right">
                <article class="select-option-container">
                    <form>
                        <div class="scroll-y option-bottom">
                            <jsp:include page="/WEB-INF/views/item/include/option-buy.jsp"/>
                        </div>
                        <!-- 옵션총금액 -->
                        <div class="total-price" style="display: none">
                            <p>
                                합계
                            </p>
                            <p>
                                <span class="total-amount">0</span>
                                <span>원</span>
                            </p>
                        </div>
                        <!-- 버튼 -->
                        <div class="btn-option-buy btn-wrap gap">
                            <button type="button" class="btn btn-round btn-primary-line cart">장바구니</button>
                            <button type="button" class="btn btn-round btn-primary buyNow">구매하기</button>
                        </div>
                    </form>
                </article>
            </div>
        </section>
    </div>

    <page:model>
        <!-- 쿠폰다운로드 모달 -->
        <div class="modal modal-coupon"></div>
        <!-- 배송산간지역 모달 -->
        <div class="modal modal-delivery"></div>

        <jsp:include page="/WEB-INF/views/include/modal/image-view.jsp"/>
        <jsp:include page="/WEB-INF/views/include/modal/report.jsp"/>
    </page:model>
    <page:javascript>
        <script src="/static/content/modules/ui/modal/report.js"></script>
        <script>
            let itemCalculator = null;
            $(document).ready(function() {
                // item detail thumbnailSwiper ui
                salesOnUI.thumbnailSwiper();
                salesOnUI.tooltip('.tooltip-handler');
                // selectBox ui
                salesOnUI.selectBox();

                // item Detail Scroll ui
                salesOnUI.itemDetailScroll('.detail-contents-area');

                // mobile item option open ui
                salesOnUI.itemOptionEvent();
                // 카드혜택
                $(".card-benefit-wrap").on("click", ".input-select", function (e) {
                    $(this).toggleClass("active");
                });

                itemCalculator = new ItemCalculator();
                //초기 이벤트 실행
                itemCalculator.initEvent();
            });
        </script>

        <script>

            const MOBILE_FLAG = '${salesonContext.mobileFlag}' === 'true';

            const ITEM = {
                itemId: Number('${itemDetail.itemId}'),
                itemUserCode : '${itemDetail.itemUserCode}',
                itemType : '${itemDetail.itemType}',
                stockFlag : '${itemDetail.stockFlag}',
                stockQuantity : Number('${itemDetail.stockQuantity}' < 0 ? '99999' : '${itemDetail.stockQuantity}'),
                orderMinQuantity: Number('${itemDetail.orderMinQuantity}' < 0 ? '1' : '${itemDetail.orderMinQuantity}'),
                orderMaxQuantity: Number('${itemDetail.orderMaxQuantity}' < 0 ? '99999' : '${itemDetail.orderMaxQuantity}'),
                itemOptionFlag: '${itemDetail.itemOptionFlag}',
                itemOptionType: '${itemDetail.itemOptionType}',
                itemOptionTitle1: '${itemDetail.itemOptionTitle1}',
                itemOptionTitle2: '${itemDetail.itemOptionTitle2}',
                itemOptionTitle3: '${itemDetail.itemOptionTitle3}',
                isItemSoldOut: '${itemDetail.itemSoldOutFlag}' == 'Y' ? true : false,		<%-- 품절여부 : 상품 + 옵션 조건 ('true', 'false') --%>
                stockScheduleType: '${itemDetail.stockScheduleType}',
                stockScheduleText: '${itemDetail.stockScheduleText}',
                presentPrice : Number('${itemDetail.presentPrice}'),
                imageSrc: '${itemDetail.itemImage}',
                nonmemberOrderType: '${itemDetail.nonmemberOrderType}',
                isSet: '${itemDetail.itemType}' === '3'
            }
            console.log(ITEM, 'ITEM');
            let itemOptions = [];
            <c:forEach items="${itemDetail.itemOptions}" var="itemOption" varStatus="i">itemOptions[${i.index}] = {'itemOptionId': '${itemOption.itemOptionId}', 'optionType': '${itemOption.optionType}', 'optionName1': '${itemOption.optionName1}', 'optionName2': '${itemOption.optionName2}', 'optionName3': '${itemOption.optionName3}', 'optionPrice': Number('${itemOption.optionPrice}'), 'optionStockFlag': '${itemOption.optionStockFlag}', 'optionStockQuantity': Number('${itemOption.optionStockQuantity}'), 'soldOutFlag': '${itemOption.optionSoldOutFlag}', 'isSoldOut': '${itemOption.soldOut}'};</c:forEach>
            console.log(itemOptions, 'itemOptions');

            let itemSets = [];
            <c:forEach items="${itemDetail.itemSets}" var="itemSet" varStatus="i">
                itemSets[${i.index}] = {
                    'item': {
                        'itemId': Number('${itemSet.item.itemId}'),
                        'itemName': '${itemSet.item.itemName}',
                        'itemUserCode': '${itemSet.item.itemUserCode}',
                        'nonmemberOrderType': '${itemSet.item.nonmemberOrderType}',
                        'price' : Number('${itemSet.item.exceptUserDiscountPresentPrice}'.replace(/,/g, "")),
                        'stockFlag': '${itemSet.item.stockFlag}',
                        'stockQuantity' : Number('${itemSet.item.stockQuantity}' == '-1' ? '99999' : '${itemSet.item.stockQuantity}'),
                        'orderMinQuantity': Number('${itemSet.item.orderMinQuantity}' == '-1' ? '1' : '${itemSet.item.orderMinQuantity}'),
                        'orderMaxQuantity': Number('${itemSet.item.orderMaxQuantity}' == '-1' ? '99999' : '${itemSet.item.orderMaxQuantity}'),
                        'itemOptionFlag': '${itemSet.item.itemOptionFlag}',
                        'itemOptionType': '${itemSet.item.itemOptionType}',
                        'itemOptionTitle1': '${itemSet.item.itemOptionTitle1}',
                        'itemOptionTitle2': '${itemSet.item.itemOptionTitle2}',
                        'itemOptionTitle3': '${itemSet.item.itemOptionTitle3}',
                        'isItemSoldOut': '${itemSet.item.itemSoldOutFlag}' == 'Y' ? true : false,		<%-- 품절여부 : 상품 + 옵션 조건 ('true', 'false') --%>
                        'stockScheduleType': '${itemSet.item.stockScheduleType}',
                        'stockScheduleText': '${itemSet.item.stockScheduleText}',
                        'presentPrice' : Number('${itemSet.item.presentPrice}'),
                        'itemOptions': [],
                        'itemOptionImages': []
                    },
                    'quantity': '${itemSet.quantity}'
                };

                <c:forEach items="${itemSet.item.itemOptions}" var="itemOption" varStatus="j">itemSets[${i.index}].item.itemOptions[${j.index}] = {'itemOptionId': '${itemOption.itemOptionId}', 'optionType': '${itemOption.optionType}', 'optionName1': '${itemOption.optionName1}', 'optionName2': '${itemOption.optionName2}', 'optionName3': '${itemOption.optionName3}', 'optionPrice': Number('${itemOption.optionPrice}'), 'optionStockFlag': '${itemOption.optionStockFlag}', 'optionStockQuantity': Number('${itemOption.optionStockQuantity}'), 'soldOutFlag': '${itemOption.optionSoldOutFlag}', 'isSoldOut': '${itemOption.soldOut}'};</c:forEach>
                <c:forEach items="${itemSet.item.images}" var="itemOptionImage" varStatus="j">itemSets[${i.index}].item.itemOptionImages[${j.index}] = {'itemOptionImageId': '${itemOptionImage.itemOptionImageId}', 'itemOptionId': '${itemOptionImage.itemOptionId}', 'itemId': '${itemOptionImage.itemId}', 'optionName': '${itemOptionImage.optionName}', 'optionImage': '/upload/item/${item.itemUserCode}/option/${itemOptionImage.optionImage}'};</c:forEach>
            </c:forEach>
            console.log(itemSets, 'itemSets');

            $(function () {
                    //관련상품 목록
                    relationItems();
                    //탭
                    //item_tab();
                    //구매수량
                    //initItemQuantityEvent();


                try {
                    $saleson.handler.addLatelyValue($saleson.const.const.LATELY_ITEM, ITEM.itemId + '', {
                            limit: 24,
                            expiresDays: 3
                        },
                        (lately) => {
                            const count = lately.length;

                            $('#aside-lately-item-count').data('count', count);
                            $('#aside-lately-item-count').text($saleson.core.formatNumber(count));
                        });
                } catch (e) {}

                try {
                    $saleson.analytics.itemView('${itemDetail.itemUserCode}');
                } catch (e){}

                try {
                    $saleson.ev.log.item('${itemDetail.itemUserCode}');
                } catch (e){}

                try {
                    const $spotTimer = $('.spot-timer');

                    if ($spotTimer.length > 0) {
                        $saleson.handler.startSpotItemCountdown($spotTimer);
                    }
                } catch (e){}
            });

        </script>
        <script src="/static/content/modules/ui/item/item-calculator.js"></script>
        <script src="/static/content/modules/ui/item/view.js"></script>
        <script src="/static/content/modules/ui/modal/image-view.js"></script>
        <script src="/static/content/modules/ui/item/inquiry.js"></script>
        <script src="/static/content/modules/ui/item/review.js"></script>
    </page:javascript>

</layout:default>