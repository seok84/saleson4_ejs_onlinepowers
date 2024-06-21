<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>

    <section class="terms">
        <div class="title-h1">이메일 수신거부</div>

        <c:set var="activeType" value="refuse-email" scope="request"/>
        <jsp:include page="./include/tab.jsp"/>
        <div class="container">

            본 웹사이트에 게시된 이메일 주소가 전자우편 수집 프로그램이나<br/>
            그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며,<br/>
            이를 위반 시 정보통신망 법에 의해 형사처벌 됨을 유념하시기 바랍니다.<br/>
            <br/>
            게시일 : 20xx년 x월 xx일
        </div>
        </div>
    </section>

    <page:javascript>

    </page:javascript>
</layout:default>