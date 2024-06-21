<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="seo" 	tagdir="/WEB-INF/tags/seo" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta http-equiv="Cache-Control" content="no-store, no-cache, private" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<title><seo:pagination-title />${seo.title} </title>

<c:if test="${seo.indexFlag == 'N'}"><meta name="robots" content="noindex,noarchive"/></c:if>
<c:if test="${!empty seo.keywords}"><meta name="keywords" content="${seo.keywords}" /></c:if>
<c:if test="${!empty seo.description}"><meta name="description" content="<seo:pagination-title />${seo.description}" /></c:if>

<c:if test="${!empty seo.openGraph}">
    <meta name="og:url" property="og:url" content="${seo.openGraph.url}">
    <meta name="og:title" property="og:title" content="${seo.openGraph.title}">
    <meta name="og:description" property="og:description" content="${seo.openGraph.description}">
    <meta name="og:image" property="og:image" content="${seo.openGraph.image}">
</c:if>

<link rel="icon" href="/favicon.ico" />

<link rel="preconnect" href="https://www.googletagmanager.com">
<link rel="preconnect" href="https://www.gstatic.com">
<link rel="preconnect" href="https://cdnjs.cloudflare.com">
<link rel="preconnect" href="https://cdn.jsdelivr.net">
<link rel="preconnect" href="https://fonts.cdnfonts.com">
<link rel="preconnect" href="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js">

<link rel="preload" as="script" href="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js">
<link rel="preload" as="script" href="https://cdn.jsdelivr.net/npm/axios@1.1.2/dist/axios.min.js">
<link rel="preload" as="script" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js">

<link rel="stylesheet preload" as="style" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css">
<link rel="stylesheet preload" as="style" href="https://cdn.jsdelivr.net/npm/noto-sans-kr-font@0.0.6/noto-sans-kr.min.css">
<link rel="stylesheet preload" as="style" href="https://fonts.cdnfonts.com/css/montserrat?styles=17402,170281,17398,17400,17403,17391,17393,17389">

<link rel="preload" as="font" crossorigin href="https://cdn.jsdelivr.net/npm/noto-sans-kr-font@0.0.6/fonts/NotoSansKR-Regular.woff2">
<link rel="preload" as="font" crossorigin href="https://cdn.jsdelivr.net/npm/noto-sans-kr-font@0.0.6/fonts/NotoSansKR-Bold.woff2">
<link rel="preload" as="font" crossorigin href="https://fonts.cdnfonts.com/s/14883/Montserrat-Regular.woff">
<link rel="preload" as="font" crossorigin href="https://fonts.cdnfonts.com/s/14883/Montserrat-Bold.woff">

<jsp:include page="./include/head-link.jsp"/>

<jsp:include page="./include/head-style.jsp"/>

<script>
    const errorImage = (e) => {
        e.src = '/static/content/image/common/no_content.png'
    }

    <c:if test="${not empty socialConfig}">
    const SOCIAL_CONFIG = {
        kakao:{
            appId: '${socialConfig.kakao.appId}',
            callBack: '${socialConfig.kakao.callBack}',
            restApiKey: '${socialConfig.kakao.restApiKey}'
        },
        apple:{
            clientId: '${socialConfig.apple.clientId}',
            redirectUrl: '${socialConfig.apple.redirectUrl}'
        },
        naver:{
            appId: '${socialConfig.naver.appId}',
            callBack: '${socialConfig.naver.callBack}',
            clientSecret: '${socialConfig.naver.clientSecret}'
        }
    };
    </c:if>

</script>