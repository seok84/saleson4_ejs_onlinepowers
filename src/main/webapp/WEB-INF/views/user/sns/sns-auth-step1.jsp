<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<!-- Kakao SDK -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- Apple SDK -->
<script src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>
<layout:default>
<div class="sns-auth-page step1">
    <h1 class="title-h1">회원가입</h1>
    <p class="title-auth">SNS 인증</p>
    <div class="sns-auth-wrap">
        <button onclick="loginWithSns('kakao','join','${target}');">
            <div class="img-wrap"><img src="/static/content/image/ico/ico_sns_kakao.svg" alt="kakao"></div>
            <p>카카오톡</p>
        </button>
        <button onclick="loginWithSns('naver','join','${target}');">
            <div class="img-wrap"><img src="/static/content/image/ico/ico_sns_naver.svg" alt="naver"></div>
            <p>네이버</p>
        </button>
        <button onclick="loginWithSns('apple','join','${target}');">
            <div class="img-wrap"><img src="/static/content/image/ico/ico_sns_apple.svg" alt="apple"></div>
            <p>애플</p>
        </button>
    </div>
    <button type="button" class="btn btn-default btn-prev" onclick="window.history.back()">이전으로</button>
</div>


    <page:javascript>
        <script src="/static/content/modules/ui/user/sns.js"></script>
        <script>
            const deviceType = "${salesonContext.deviceType}";
        </script>



    </page:javascript>


</layout:default>