<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios@1.1.2/dist/axios.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js"
        integrity="sha512-a+SUDuwNzXDvz4XrIcXHuCf089/iJAoN4lmrXJg18XnduKK6YlDHNRalv4yd1N40OKI80tFidF+rqTFKGPoWFQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="module" src="/static/content/modules/saleson.js"></script>
<script type="module" src="/static/content/modules/core/validator.js"></script>

<jsp:include page="/WEB-INF/layouts/include/analytics/firebase.jsp"/>

<script defer src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script defer src="/static/content/js/common.js"></script>


<%-- JSP 페이지 내 선언된 javascript 출력 (<page:javascript></page:javascript>)  --%>
${JAVASCRIPT_BLOCK_IN_JSP_PAGE}


<script>
    $(() => {
        const errorMessage = '${errorMessage}';
        const errorCode = '${errorCode}';

        if (errorMessage != '') {
            $saleson.core.alert(errorMessage);
        }
    });
</script>
