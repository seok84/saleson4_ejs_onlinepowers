<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Naver SDK -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
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
            client_id : naverLoginAppId,
            client_secret : naverClientSecret,
            code : code
        }
        $saleson.api.post("/api/auth/naver-user" ,req)
        .then(function (response) {
            const {id, email, name} = response.data;
            let snsUser = {
                "email" : email,
                "snsId" : id,
                "snsName" : name,
                "snsType" : "naver",
                "state" : state,
                "token" : '',
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