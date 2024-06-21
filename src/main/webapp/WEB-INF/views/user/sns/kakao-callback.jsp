<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Kakao SDK -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<layout:base>
<template>

    <body>
    </body>

</template>
    <script src="/static/content/modules/ui/user/sns.js"></script>
    <script type="application/javascript">
    const deviceType = "${salesonContext.deviceType}";
    $(document).ready(function() {
        // 현재 페이지의 URL에서 쿼리 파라미터 추출
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('code');
        const state = urlParams.get('state');
        let req = {
            grantType : "authorization_code",
            clientId : kakaoRestApiKey,
            code : code,
            redirectUri : frontendDomain + kakaoCallBackUrl
        }
        $saleson.api.post("/api/auth/kakao-user" ,req)
        .then(function (response) {
            const {snsId, email, nickname} = response.data;
            let snsUser = {
                "email" : email,
                "snsId" : snsId,
                "snsName" : nickname,
                "snsType" : "kakao",
                "state" : state,
                "token" : ''
            };
            const purpose = state.split("_")[0];
            if(purpose == 'login' || purpose == 'join') {
                snsLogin(snsUser);
            } else if (purpose == 'connect') {
                snsConnect(snsUser);
            }

        })
        .catch(function(error) {
            $saleson.core.api.handleApiExeption(error);
        });
    });




    </script>



</layout:base>