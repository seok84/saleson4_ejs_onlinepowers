<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:mypage>

    <section class="mypage-point">
        <div class="title-container">
            <h2 class="title-h2">포인트</h2>
        </div>
        <div class="m-line-divider">
            <div class="useable-point-box">
                <p>사용가능 포인트<em><fmt:formatNumber value="${content.userPoint}" pattern="#,###"/></em></p>
            </div>
        </div>
        <!-- // 활성화 -->
        <div class="tabs">
            <a class="tab-item ${tabClass == "possible" ? "active":""}" onclick="pointTab('EARN_POINT')">사용 가능</a>
            <a class="tab-item ${tabClass == "complete" ? "active":""}" onclick="pointTab('USED_POINT')">사용 완료</a>
        </div>
        <div class="tabs-content">
            <jsp:include page="/WEB-INF/views/include/mypage/search.jsp"/>

            <p class="all-items">총 <strong>${pageContent.pagination.totalElements}</strong>개</p>
            <ul class="point-list">
                <c:forEach items="${pageContent.content}" var="point">
                    <c:choose>
                        <c:when test="${tabClass == 'possible'}">
                            <li class="list">
                                <p class="title">
                                    <strong>${point.reason}</strong>
                                    <span class="point">+<fmt:formatNumber value="${point.savedPoint}" pattern="#,###"/> P</span>
                                </p>
                                <p class="info">
                                    <span class="sub">잔여포인트</span>
                                    <span><fmt:formatNumber value="${point.point}" pattern="#,###"/> P</span>
                                </p>
                                <p class="info">
                                    <fmt:parseDate value="${point.createdDate}" var="cdValue" pattern="yyyyMMddHHmmss"/>
                                    <span class="sub">적립일</span>
                                    <span><fmt:formatDate value="${cdValue}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                </p>
                                <p class="info">
                                    <fmt:parseDate value="${point.expirationDate}" var="edValue" pattern="yyyyMMdd"/>
                                    <span class="sub">소멸예정일</span>
                                    <span><fmt:formatDate value="${edValue}" pattern="yyyy-MM-dd"/></span>
                                </p>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="list">
                                <p class="title">
                                    <strong>${point.reason}</strong>
                                    <span class="point used">-<fmt:formatNumber value="${point.point}" pattern="#,###"/>P</span>
                                </p>
                                <p class="info">
                                    <fmt:parseDate value="${point.createdDate}" var="cdValue" pattern="yyyyMMddHHmmss"/>
                                    <span class="sub">사용일</span>
                                    <span><fmt:formatDate value="${cdValue}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                </p>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </div>
        <c:if test="${empty pageContent.content}">
            <div class="no-contents">
                <p>포인트 내역이 없습니다.</p>
            </div>
        </c:if>
        <ul class="dot-list large-dot">
            <li>조회기간 설정 시, 최근 1년까지의 적립 내역이 제공됩니다.</li>
            <li>한번에 조회 가능한 최대 기간은 6개월 입니다.</li>
        </ul>
        <!-- 페이징 -->
        <page:pagination/>
    </section>
    <page:javascript>
    <script src="/static/content/modules/ui/mypage/search.js"></script>
    <script>
        $(() => {

        })
        function pointTab(type){
            location.href = "/mypage/benefit/point?pointType="+type;
        }

        $('#searchFilterForm').submit(function (e) {
            const pointInput = $('<input>').attr({
                type: 'hidden',
                name: 'pointType',
                value: `${param.pointType}`
            });

            // 폼에 새로운 input 추가
            $(this).append(pointInput);
        });

    </script>



    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
