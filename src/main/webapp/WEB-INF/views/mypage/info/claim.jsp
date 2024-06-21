<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:mypage>

    <section class="mypage-order order-cancel">
        <div class="title-container">
            <h2 class="title-h2">취소/반품/교환 신청</h2>
        </div>
        <ul class="dot-list pc">
            <li>제품 구매 후, 14일이 지나면 자동으로 '구매확정'이 됩니다.</li>
            <li>[주문상세]를 클릭하시면 주문 상세 내역 및 상품별 배송현황을 조회하실 수 있습니다.</li>
        </ul>
        <div class="tabs">
            <a class="tab-item ${tabClass == "tab-cancel" ? "active": ""}" onclick="claimTab('cancel-process')">취소신청</a>
            <a class="tab-item ${tabClass == "tab-return" ? "active": ""}" onclick="claimTab('return-process')">반품신청</a>
            <a class="tab-item ${tabClass == "tab-exchange" ? "active": ""}" onclick="claimTab('exchange-process')">교환신청</a>
        </div>
        <div class="tabs-content ${tabClass}">
            <form id="orderSearchParam">
                <input type="hidden" name="statusType" value="${orderCriteria.statusType}">
                <div class="period-container">

                    <label class="date"><input type="date" class="form-basic" id="searchStartDate" name="searchStartDate" value="${orderCriteria.viewStartDate}"><i></i></label>
                    <span class="divider">~</span>
                    <label class="date"><input type="date" class="form-basic" id="searchEndDate" name="searchEndDate" value="${orderCriteria.viewEndDate}"><i></i></label>
                    <div class="select-wrap box">
                        <select class="input-select">
                            <option value="">조회기간</option>
                            <option value="week-1">1주일</option>
                            <option value="month-1">1개월</option>
                            <option value="month-3">3개월</option>
                            <option value="month-6">6개월</option>
                        </select>
                    </div>
                    <div class="form-line box">
                        <div class="flex">
                            <input type="text" id="query" name="query" class="form-basic" placeholder="검색어를 입력하세요" />
                            <button type="submit" class="btn btn-black">조회</button>
                        </div>
                    </div>
                </div>
            </form>
            <!-- // 주문 내역 -->
            <div class="order-item-wrapper">
                <c:forEach items="${pageContent.content}" var="o">
                    <c:set var="o" value="${o}" scope="request"/>
                    <div class="order-item">
                        <div class="info">
                        <span class="date">
                            <fmt:parseDate value="${o.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                            <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                            <a href="/mypage/info/order-detail/${o.orderCode}" class="detail">
                                <span>${o.orderCode}</span>
                                <span class='detail-linked'>주문상세</span>
                                <i class="arrow"></i>
                            </a>
                        </div>
                        <div class="order-status">
                            <c:forEach items="${o.items}" var="i">
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
                </c:forEach>
            </div>
            <c:if test="${empty pageContent.content}">
                <div class="no-contents">
                    <p>
                        <c:choose>
                            <c:when test='${tabClass == "tab-cancel"}'>취소</c:when>
                            <c:when test='${tabClass == "tab-return"}'>반품</c:when>
                            <c:otherwise>교환</c:otherwise>
                        </c:choose>
                        내역이 없습니다.
                    </p>
                </div>
            </c:if>
            <!-- // 페이징 -->
            <c:if test="${not empty pageContent.content}">
                <page:pagination/>
            </c:if>
        </div>
    </section>

    <script>
        function claimTab(type){
            location.href = "/mypage/info/claim?statusType="+type;
        }
    </script>

    <page:javascript>
        <script src="/static/content/modules/ui/mypage/order.js"></script>
        <script src="/static/content/modules/ui/mypage/search.js"></script>
    </page:javascript>
    <page:model>
        <div class="modal modal-product open-modal-exchange"></div> <!-- 교환신청 -->
        <div class="modal modal-product open-modal-return"></div> <!-- 반품신청 -->
        <div class="modal modal-product open-modal-cancel"></div> <!-- 취소신청 -->
    </page:model>
</layout:mypage>
