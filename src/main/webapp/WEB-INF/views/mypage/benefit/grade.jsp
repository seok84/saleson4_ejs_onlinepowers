<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>


<layout:mypage>

    <section class="mypage-grade">
        <div class="title-container">
            <h2 class="title-h2">나의 등급/혜택</h2>
        </div>
        <div class="grade-info">
            <p class="grade-ico"><img src="/static/content/image/mypage/grade_family.svg" alt="패밀리 등급" class="ico"></p>
            <div class="info">
                <span>고객님의 회원 등급은</span>
                <strong>${content.userLevel}</strong>
                <i class="tooltip"><img src="/static/content/image/ico/ico_tip.svg" alt="tooltip"></i>
                <div class="tooltip-wrap hidden">
                    <button type="button" class="tooltip-close">닫기</button>
                    <div class="text-center">tooltip-sample</div>
                </div>
            </div>
        </div>
        <p class="page-sub-title">회원 등급 혜택</p>
        <!-- pc -->
        <table class="grade-table grade-content">
            <colgroup>
                <col width="13.5%">
                <col>
                <col>
                <col>
                <col>
            </colgroup>
            <thead>
                <tr class="bg">
                    <th></th>
                    <c:forEach items="${content.list}" var="level">
                        <th>
                            <p class="grade">
                                <c:choose>
                                    <c:when test="${level.levelId == 1}">
                                        <img src="/static/content/image/mypage/grade_family.svg" alt="family">
                                    </c:when>
                                    <c:when test="${level.levelId == 2}">
                                        <img src="/static/content/image/mypage/grade_gold.svg" alt="gold">
                                    </c:when>
                                    <c:when test="${level.levelId == 3}">
                                        <img src="/static/content/image/mypage/grade_premium.svg" alt="premium">
                                    </c:when>
                                    <c:when test="${level.levelId == 6}">
                                        <img src="/static/content/image/mypage/grade_vip.svg" alt="vip">
                                    </c:when>
                                    <c:otherwise> - </c:otherwise>
                                </c:choose>
                                <strong>${level.levelName}</strong>
                            </p>
                        </th>
                    </c:forEach>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="property" items="${['discountRate', 'pointRate', 'shippingCouponCount']}" varStatus="typeStatus">
                    <tr class="desc">
                        <c:if test="${typeStatus.index == 0}"><th class="bold">할인</th></c:if>
                        <c:if test="${typeStatus.index == 1}"><th class="bold">구매적립</th></c:if>
                        <c:if test="${typeStatus.index == 2}"><th class="bold">쿠폰혜택</th></c:if>
                        <c:forEach items="${content.list}" var="grade">
                            <td>
                                    ${grade[property]}
                                <c:choose>
                                    <c:when test="${property eq 'discountRate' || property eq 'pointRate'}">
                                        %
                                    </c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- mobile -->
        <div class="grade-list grade-content">
            <dl>
                <dt class="bg">
                    <p class="grade"><img src="/static/content/image/mypage/grade_family.svg" alt="family"><strong>family</strong>
                    </p>
                </dt>
                <dd class="desc">5%</dd>
                <dd class="desc">1%</dd>
                <dd class="desc">배송비 쿠폰 1장<br />상품 쿠폰 1장</dd>
            </dl>
            <dl>
                <dt class="bg">
                    <p class="grade"><img src="/static/content/image/mypage/grade_gold.svg" alt="gold"><strong>gold</strong></p>
                </dt>
                <dd class="desc">5%</dd>
                <dd class="desc">1%</dd>
                <dd class="desc">배송비 쿠폰 1장<br />상품 쿠폰 1장</dd>
            </dl>
            <dl>
                <dt class="bg">
                    <p class="grade"><img src="/static/content/image/mypage/grade_premium.svg"
                                          alt="premium"><strong>premium</strong></p>
                </dt>
                <dd class="desc">5%</dd>
                <dd class="desc">1%</dd>
                <dd class="desc">배송비 쿠폰 1장<br />상품 쿠폰 1장</dd>
            </dl>
            <dl>
                <dt class="bg">
                    <p class="grade"><img src="/static/content/image/mypage/grade_vip.svg" alt="vip"><strong>vip</strong></p>
                </dt>
                <dd class="desc">5%</dd>
                <dd class="desc">1%</dd>
                <dd class="desc">배송비 쿠폰 1장<br />상품 쿠폰 1장</dd>
            </dl>
        </div>
        <ul class="dot-list large-dot">
            <li class="title">회원 등급 선정 기준 및 혜택 이용안내</li>
            <li>회원등급은 등급산정일로부터 6개월간의 구매확정 된 구매실적을 기준으로 산정됩니다.</li>
            <li>구매실적은 쿠폰, 포인트 등을 할인적용한 후의 최종 결제 금액을 기준으로 산정됩니다.</li>
            <li>적립은 '상품 적립', '등급 별 추가 적립'순으로 적립됩니다.</li>
            <li>쿠폰은 등급 변경 후 매월 1일 00:00 시에 적립됩니다.</li>
            <li>회원 등급, 쿠폰, 포인트 이용에 대한 궁금하신 사항은 고객센터의 FAQ를 참고해 주시기 바랍니다.</li>

        </ul>
    </section>

    <script>
        $(document).ready(function(){
            // tooltip ui sample
            salesOnUI.tooltip();
        });
    </script>


    <page:javascript>

    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
