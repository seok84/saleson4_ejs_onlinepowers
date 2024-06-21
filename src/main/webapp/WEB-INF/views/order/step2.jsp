<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>

<layout:default>

    <div class="order-completed-page">
        <h1 class="title-h1 pc">주문/결제</h1>
        <div class="w-582">
            <div class="info-order">
                <img src="/static/content/image/cart/ico_completed.svg" alt="competed">
                <span>고객님의 주문이 정상적으로 완료되었습니다.</span>
                <div class="order-number">
                    <p>주문번호</p>
                    <p>
                        <a href="#" onclick="$saleson.core.redirect('/mypage/info/order-detail/${content.orderCode}')">${content.orderCode}</a>
                    </p>
                </div>
                <div class="order-date">
                    <fmt:parseDate value="${content.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                    <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
            </div>
            <c:forEach items="${content.paymentList}" var="payment">
                <c:if test="${payment.approvalType == 'vbank' || payment.approvalType == 'bank'}">
                    <div class="content-table list info-freebank">
                        <table>
                            <tr>
                                <th>계좌</th>
                                <td>${payment.bankVirtualNo}</td>
                            </tr>
                            <tr>
                                <th>예금주</th>
                                <td>${payment.bankInName}</td>
                            </tr>
                            <tr>
                                <th>금액</th>
                                <td>
                                    <fmt:formatNumber value="${payment.amount}" pattern="#,###"/>원
                                </td>
                            </tr>
                            <tr>
                                <th>입금기한</th>
                                <td>
                                    <fmt:parseDate value="${payment.bankDate}" var="bankDate" pattern="yyyyMMdd"/>
                                    <fmt:formatDate value="${bankDate}" pattern="yyyy-MM-dd"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </c:if>
            </c:forEach>
            <!-- 배송지 정보 -->
            <h3 class="content-title"><i class="ico"><img src="/static/content/image/ico/ico_location.svg" alt="배송지 정보"></i>배송지 정보
            </h3>
            <div class="content-table list">
                <table>
                    <tr>
                        <th>받는 분</th>
                        <td>${content.shippingInfo.receiveName}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>[${content.shippingInfo.receiveZipcode}] ${content.shippingInfo.receiveAddress} ${content.shippingInfo.receiveAddressDetail}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>${content.shippingInfo.receiveMobile}</td>
                    </tr>
                    <tr>
                        <th>배송메세지</th>
                        <td>${content.shippingInfo.memo}</td>
                    </tr>
                </table>
            </div>
            <!-- 결제정보 -->
            <h3 class="content-title"><i class="ico"><img src="/static/content/image/ico/ico_money.svg" alt="결제정보"></i>결제정보</h3>
            <ul class="info-payment-detail">
                <c:forEach items="${content.paymentList}" var="payment">
                    <c:choose>
                        <c:when test="${payment.approvalType == 'bank' || payment.approvalType == 'vbank'}">
                            <li>
                                <div class="method">
                                    <span>${payment.approvalTypeLabel}</span>
                                    <c:choose>
                                        <c:when test="${not empty payment.payDate}">
                                            <span>결제완료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span>입금대기</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="amount">
                                    <span>
                                        <fmt:formatNumber value="${payment.amount}" pattern="#,###"/><b>원</b>
                                    </span>
                                    <span>
                                        <fmt:parseDate value="${payment.payDate}" var="payDate" pattern="yyyyMMddHHmmss"/>
                                        <fmt:formatDate value="${payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </span>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <div class="method">
                                    <span>${payment.approvalTypeLabel}</span>
                                    <span>결제완료</span>
                                    <c:if test="${payment.approvalType == 'card'}">
                                        <span>
                                            <button type="button" class="btn-recipe" onclick="receiptIssuance('${content.nicepayReceipt}')">영수증 보기</button>
                                        </span>
                                    </c:if>
                                </div>
                                <div class="amount">
                                    <span><fmt:formatNumber value="${payment.amount}" pattern="#,###"/><b>원</b></span>
                                </div>
                                <div class="date">
                                    <fmt:parseDate value="${payment.payDate}" var="payDate" pattern="yyyyMMddHHmmss"/>
                                    <fmt:formatDate value="${payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
            <div class="btn-wrap gap">
                <button class="btn btn-round btn-large btn-primary-line" onclick="$saleson.core.redirect('/mypage/info/order-detail/${content.orderCode}')">주문내역 확인</button>
                <button class="btn btn-round btn-large btn-primary" onclick="$saleson.core.redirect($saleson.const.pages.INDEX)">쇼핑 계속하기</button>
            </div>
        </div>
    </div>

    <page:javascript>
        <script src="/static/content/modules/ui/mypage/order.js"></script>

        <script>
            $(() => {
                try {
                    $saleson.analytics.purchase('${content.orderCode}', '${content.orderSequence}');
                } catch (e) {}

                try {

                    const itemUserCodes = [];
                    <c:forEach var="orderItem" items="${content.item}">
                        itemUserCodes.push('${orderItem.itemUserCode}');
                    </c:forEach>

                    if (itemUserCodes.length > 0) {
                        $saleson.ev.log.order('${content.orderCode}', itemUserCodes);
                    }

                } catch (e) {}
            });
       </script>
    </page:javascript>

</layout:default>
