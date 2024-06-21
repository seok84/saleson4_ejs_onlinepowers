<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="daum"	tagdir="/WEB-INF/tags/daum" %>

<layout:mypage>
    <section class="mypage-order mypage-order-detail">
        <div class="title-container">
            <h2 class="title-h2">주문/배송 상세조회</h2>
            <button type="button" class="btn btn-default btn-middle btn-action" onclick="printScreen();">화면출력</button>
        </div>
        <h2 class="title-h2 print">주문/배송 상세조회</h2>
        <!-- // 주문 내역 -->
        <div class="order-item-wrapper">
            <c:set var="o" value="${content}" scope="request"/>
            <!-- 복수 아이템 -->
            <div class="order-item">
                <div class="info">
                    <span class="date">
                        <fmt:parseDate value="${content.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                        <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </span>
                    <span class="detail">
					<span>주문번호</span>
					<span>${content.orderCode}</span>
				</span>
                </div>
                <div class="order-status">
                    <c:forEach items="${content.item}" var="i">
                        <div class="wrapper">
                            <p class="delivery-status-wrap"><span class="status deposit-waiting">${i.orderStatusLabel}</span></p>
                            <div class="item-wrap">
                                <c:set var="i" value="${i}" scope="request"/>
                                <jsp:include page="/WEB-INF/views/include/order/order-item.jsp"/>
                                <jsp:include page="../../include/order/order-button.jsp"/>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </div>
        </div>
        <div class="order-info">
            <!-- //배송지 정보 -->
            <h3 class="content-title">
                <i class="ico"><img src="/static/content/image/ico/ico_location.svg" alt="배송지 정보" /></i>배송지 정보
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
            <!-- //주문자 정보 -->
            <h3 class="content-title">
                <i class="ico"><img src="/static/content/image/ico/ico_user.svg" alt="주문자 정보" /></i>주문자 정보
            </h3>
            <div class="content-table list">
                <table>
                    <tr>
                        <th>이름</th>
                        <td>${content.userName}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>${content.mobile}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>${content.email}</td>
                    </tr>
                </table>
            </div>
            <h3 class="content-title">
                <i class="ico"><img src="/static/content/image/ico/ico_money.svg" alt="결제정보" /></i>결제정보
            </h3>
            <div class="payment">
                <div class="payment-info content-table">
                    <dl class="sub-title">
                        <dt>총 상품금액</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="${content.totalItemAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="sub-title">
                        <dt>할인금액</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="-${content.totalDiscountAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="sub">
                        <dt>상품할인</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="-${content.totalItemDiscountAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="sub">
                        <dt>세트할인</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="-${content.totalSetDiscountAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="sub">
                        <dt>회원할인(FAMILY)</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="-${content.totalUserLevelDiscountAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="sub">
                        <dt>쿠폰할인</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="-${content.totalCouponDiscountAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="title"><!-- //배송비 -->
                        <dt>배송비</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="${content.totalShippingAmount}" pattern="#,###"/>
                            </span>원
                        </dd>
                    </dl>
                    <dl class="title">
                        <dt>포인트 사용</dt>
                        <dd>
                            <span>
                                <fmt:formatNumber value="${content.orderUsePoint}" pattern="#,###"/>
                            </span>P
                        </dd>
                    </dl>
                    <dl class="title total">
                        <dt>총 결제금액</dt>
                        <dd>
                            <b><fmt:formatNumber value="${content.totalOrderAmount}" pattern="#,###"/></b> 원
                        </dd>
                    </dl>
                </div>
                <div class="payment-method content-table">
                    <c:forEach items="${content.paymentList}" var="payment">
                        <c:choose>
                            <c:when test="${payment.approvalType == 'bank' || payment.approvalType == 'vbank'}">
                                <dl>
                                    <dt>
                                        <p>
                                            <strong>${payment.approvalTypeLabel}</strong>
                                            <c:choose>
                                                <c:when test="${not empty payment.payDate}">
                                                    <span class="status waiting">결제완료</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status waiting">입금대기</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <p class="amount">
                                            <b><fmt:formatNumber value="${payment.amount}" pattern="#,###"/></b>원
                                        </p>
                                    </dt>
<%--                                    <dd>
                                        <p class="date">2023-01-01 12:00:00</p>
                                    </dd>--%>
                                    <dd class="deposit-table">
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
                                    </dd>
                                </dl>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${payment.paymentType == '1'}">
                                        <dl>
                                            <dt>
                                                <p>
                                                    <strong>${payment.approvalTypeLabel}</strong>
                                                    <span class="status complete">결제완료</span>
                                                    <c:if test="${payment.approvalType == 'card'}">
                                                        <button type="button" class="btn-recipe" onclick="receiptIssuance('${content.nicepayReceipt}')">영수증 보기</button>
                                                    </c:if>
                                                </p>
                                                <p class="amount"><b><fmt:formatNumber value="${payment.amount}" pattern="#,###"/></b>원</p>
                                            </dt>
                                            <dd>
                                                <p class="date">
                                                    <fmt:parseDate value="${payment.payDate}" var="payDate" pattern="yyyyMMddHHmmss"/>
                                                    <fmt:formatDate value="${payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                </p>
                                            </dd>
                                        </dl>
                                    </c:when>
                                    <c:when test="${payment.paymentType == '2'}">
                                        <dl>
                                            <dt>
                                                <p>
                                                    <strong>${payment.approvalTypeLabel}</strong>
                                                    <span class="status complete">결제취소</span>
                                                </p>
                                                <p class="amount"><b><fmt:formatNumber value="${payment.cancelAmount}" pattern="#,###"/></b>원</p>
                                            </dt>
                                            <dd>
                                                <p class="date">
                                                    <fmt:parseDate value="${payment.payDate}" var="payDate" pattern="yyyyMMddHHmmss"/>
                                                    <fmt:formatDate value="${payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                </p>
                                            </dd>
                                        </dl>
                                    </c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </div>
        </div>
        <button type="button" class="btn btn-large btn-primary-line btn-round btn-back" onclick="location.href='/mypage/info/order'">목록으로</button>
    </section>
    <daum:address />
    <page:javascript>
        <script src="/static/content/modules/ui/mypage/order.js"></script>
    </page:javascript>
    <page:model>
        <div class="modal modal-product open-modal-exchange"></div> <!-- 교환신청 -->
        <div class="modal modal-product open-modal-return"></div> <!-- 반품신청 -->
        <div class="modal modal-product open-modal-cancel"></div> <!-- 취소신청 -->
        <div class="modal modal-product modal-review open-modal-review"></div><!-- 리뷰작성 -->
    </page:model>
</layout:mypage>