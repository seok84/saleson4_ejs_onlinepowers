<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<c:set var="copyright" value="COPYRIGHT © ONLINEPOWERS. All rights reserved." scope="request"/>

<div class="pc">
    <div class="link-area">
        <section class="flex">
            <div class="col-left">
                <a href="javascript:;">회사소개</a>
                <a href="/customer/notice">공지사항</a>
                <a href="/customer/notice">고객센터</a>
                <a href="/policy/agreement">이용약관</a>
            </div>
            <div class="col-right">
                <a href="/policy/protect">개인정보처리방침</a>
                <a href="/customer/store-inquiry">제휴/입점문의</a>
                <a href="/policy/refuse-email">이메일수집거부</a>
                <a href="/customer/faq">자주하는 질문</a>
                <a href="/customer/inquiry">1:1문의</a>
            </div>
        </section>
    </div>
    <section class="footer-info">
        <div class="footer-brand">
            <img src="/static/content/image/common/brand.svg" alt="세일즈온">
        </div>

        <jsp:include page="./footer-info.jsp"/>
    </section>
</div>

<div class="mobile">
    <div class="link-area">
        <a href="javascript:;">회사소개</a>
        <a href="/customer/notice">공지사항</a>
        <a href="/customer/notice">고객센터</a>
        <a href="/policy/agreement">이용약관</a>
    </div>

    <jsp:include page="./footer-info.jsp"/>

    <div class="link-area bottom">
        <a href="/policy/protect">개인정보처리방침</a>
        <a href="/customer/store-inquiry">제휴/입점문의</a>
        <a href="/policy/refuse-email">이메일수집거부</a>
        <a href="/customer/faq">자주하는 질문</a>
        <a href="/customer/inquiry">1:1문의</a>
    </div>
    <p class="copyright">${copyright}</p>

</div>
