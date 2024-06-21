<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
    <div class="no-contents error">
        <img src="/static/content/image/common/img_404.png" alt="404" class="img-404">
        <p>요청한 페이지를 찾을 수 없습니다.</p>
        <p class="sub">홈페이지 이용에 불편을 드려 죄송합니다.<br>
            새로고침을 누르시거나, 잠시 후에 이용해 주시기 바랍니다.</p>
        <button class="btn btn-primary-line btn-round btn-home" onclick="$saleson.core.redirect('/')" n>메인으로</button>
    </div>

</layout:default>