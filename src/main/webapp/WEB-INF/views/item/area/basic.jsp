<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="detail-basic-contents tabs-content">

    <div class="detail-table">
        <table>
            <tbody>
            <tr>
                <th>대표자명</th>
                <td>${itemDetail.representativeName}</td>
            </tr>

            <tr>
                <th>사업자번호</th>
                <td>${itemDetail.businessNumber}</td>
            </tr>
            <%--                            <tr>--%>
            <%--                                <th>통신판매업 신고</th>--%>
            <%--                                <td>2015-서울구로-12345</td>--%>
            <%--                            </tr>--%>
            <%--                            <tr>--%>
            <%--                                <th>연락처</th>--%>
            <%--                                <td>02-6737-9200</td>--%>
            <%--                            </tr>--%>
            <%--                            <tr>--%>
            <%--                                <th>응대가능시간</th>--%>
            <%--                                <td>09:00 ~ 18:00</td>--%>
            <%--                            </tr>--%>
            <%--                            <tr>--%>
            <%--                                <th>E-mail</th>--%>
            <%--                                <td>abcc@onlinepowers.com</td>--%>
            <%--                            </tr>--%>
            <%--                            <tr>--%>
            <%--                                <th>FAX</th>--%>
            <%--                                <td>02-6737-3330</td>--%>
            <%--                            </tr>--%>
            <tr>
                <th>소재지</th>
                <td>${itemDetail.businessLocation}</td>
            </tr>

            </tbody>
        </table>
    </div>

    <div class="detail-title-main">배송 반품교환 상세정보</div>
    <div>
        ${item.deliveryInfo}
    </div>
</section>