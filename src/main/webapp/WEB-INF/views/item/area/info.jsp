<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="detail-info-contents tabs-content">

    <div class="admin-content-wrap">
        <div class="admin-content active">
            ${itemDetail.detailContent}
        </div>
        <button class="btn btn-primary-line btn-round btn-more"
                onclick="salesOnUI.toggleActive('.detail-info-contents')">
            <span>상품정보 더보기</span>
        </button>
    </div>

</section>