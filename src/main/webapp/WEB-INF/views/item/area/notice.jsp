<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="detail-notice-contents tabs-content">

    <div class="detail-table">
        <table>
            <tbody>
            <c:forEach items="${itemDetail.infos}" var="info">
                <tr>
                    <th>${info.title}</th>
                    <td>${info.description}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

</section>