<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Kakao SDK -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- Apple SDK -->
<script src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>

<layout:mypage>
    <c:set var="naver" value="" />
    <c:set var="kakao" value="" />
    <c:set var="apple" value="" />
    <c:forEach var="userSnsList" items="${snsInfo.list}" varStatus="i">
        <c:choose>
            <c:when test='${userSnsList.snsType eq "naver"}'>
                <c:set var="naver" value="${userSnsList}"/>
            </c:when>

            <c:when test='${userSnsList.snsType eq "kakao"}'>
                <c:set var="kakao" value="${userSnsList}"/>
            </c:when>
            <c:when test='${userSnsList.snsType eq "apple"}'>
                <c:set var="apple" value="${userSnsList}"/>
            </c:when>
        </c:choose>
    </c:forEach>

    <section class="mypage-sns">
        <div class="title-container">
            <h2 class="title-h2">SNS 연동관리</h2>
        </div>
        <ul class="sns-interlock">
            <li style="">
                <p><img src="/static/content/image/common/sns_kakao.svg" alt="kakao" class="ico">
                    <span>
                    <strong>카카오</strong>
                        <span class="status">
                            <c:choose>
                            <c:when test="${!empty kakao}">
                                <fmt:parseDate value="${kakao.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                                <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </c:when>
                                <c:otherwise>
                                    연동정보가 없습니다.
                                </c:otherwise>
                            </c:choose>
                            </span>
                </span>
                </p>
                <button type="button" onclick="connectSns('kakao','connect','${!empty kakao ? kakao.snsUserId : ""}')" class="switch-btn ${!empty kakao ? 'active' : ""} "><span class="circle"></span></button>
            </li>
            <li>
                <p><img src="/static/content/image/common/sns_naver.svg" alt="naver" class="ico">
                    <span>
                    <strong>네이버</strong><span class="status">
                         <c:choose>
                             <c:when test="${!empty naver}">
                                 <fmt:parseDate value="${naver.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                                 <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                             </c:when>
                             <c:otherwise>
                                 연동정보가 없습니다.
                             </c:otherwise>
                         </c:choose>
                            </span>
                    </span>
                </span>
                </p>
                <button type="button" onclick="connectSns('naver','connect','${!empty naver ? naver.snsUserId : ""}')" class="switch-btn ${!empty naver ? 'active' : ""}"><span class="circle"></span></button>
            </li>
            <li>
                <p><img src="/static/content/image/common/sns_apple.svg" alt="apple" class="ico">
                    <span>
                    <strong>애플</strong><span class="status">
                         <c:choose>
                             <c:when test="${!empty apple}">
                                 <fmt:parseDate value="${apple.createdDate}" var="dateValue" pattern="yyyyMMddHHmmss"/>
                                 <fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm:ss"/>
                             </c:when>
                             <c:otherwise>
                                 연동정보가 없습니다.
                             </c:otherwise>
                         </c:choose>
                            </span>
                    </span>

                </p>
                <button type="button" onclick="connectSns('apple','connect','${!empty apple ? apple.snsUserId : ""}')" class="switch-btn ${!empty apple ? 'active' : ""}"><span class="circle"></span></button>
            </li>

        </ul>
        &nbsp;
        <ul class="dot-list large-dot">
            <li>SNS연결 해제는 'SNS 연동관리' 메뉴 또는 각 SNS 설정에서 가능합니다.</li>
            <li>네이버 / 카카오/ 애플 로그인을 할 때 각 SNS 플랫폼 인증 절차가 필요합니다.</li>
        </ul>
    </section>
    <page:javascript>
        <script src="/static/content/modules/ui/user/sns.js"></script>
    <script>
        const deviceType = '${salesonContext.deviceType}';
        $(document).ready(function(){
            // swichBtn ui sample
            salesOnUI.swichBtn();
        });


    </script>



    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
