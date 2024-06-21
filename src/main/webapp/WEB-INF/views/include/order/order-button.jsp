<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="btn-wrap ">
    <c:choose>
        <%-- 입금대기 --%>
        <c:when test="${i.orderStatus == '0'}">
            <div class="box">
                <button type='button' class="btn btn-default btn-middle btn-cancel" onclick="orderCancel('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '1')">주문취소</button>
            </div>

        </c:when>

        <%-- 결제완료 / 배송준비중 --%>
        <c:when test="${i.orderStatus == '10' || i.orderStatus == '15'}">
            <div class="box">
                <button type='button' class="btn btn-default btn-middle btn-cancel" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '1')">주문취소</button>
            </div>
        </c:when>

        <%-- 30, 35, 55, 59, 69
            배송중, 교환배송시작, 교환거절, 반품거절
        --%>
        <c:when test="${i.orderStatus == '30' || i.orderStatus == '35' || i.orderStatus == '55' || i.orderStatus == '59' || i.orderStatus == '69'}">
            <div class="box">
                <c:if test="${i.confirmDate == '00000000000000'}">
                    <button type='button' class="btn btn-primary btn-middle" onclick="confirm('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}')">구매확정</button>
                </c:if>
                <c:choose>
                    <c:when test="${empty i.deliveryNumber}">
                        <button type='button' class="btn btn-default btn-middle">직접수령</button>
                    </c:when>
                    <c:otherwise>
                        <button type='button' class="btn btn-primary-line btn-middle" onclick="deliverySearch('${i.deliveryCompanyUrl}','${i.deliveryNumber}')">배송조회</button>
                    </c:otherwise>
                </c:choose>
            </div>
            <c:if test="${i.itemReturnFlag != 'N'}">
                <div class="box">
                    <button type='button' class="btn btn-default btn-middle" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '3')">교환신청</button>
                    <button type='button' class="btn btn-default btn-middle" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '2')">반품신청</button>
                </div>
            </c:if>
        </c:when>

        <%-- 구매확정 --%>
        <c:when test="${i.orderStatus == '40'}">
            <div class="box">
                <c:if test="${i.writeReviewFlag}">
                    <button type="button" class="btn btn-primary btn-middle btn-review" onclick="getReviewPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '${i.itemUserCode}')">후기작성</button>
                </c:if>
                <button type="button" class="btn btn-primary-line btn-middle" onclick="deliverySearch('${i.deliveryCompanyUrl}','${i.deliveryNumber}')">배송조회</button>
            </div>
            <c:choose>
                <c:when test="${i.itemReturnFlag != 'N'}">
                    <div class="box">
                        <button type='button' class="btn btn-default btn-middle" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '3')">교환신청</button>
                        <button type='button' class="btn btn-default btn-middle" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '2')">반품신청</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="box">
                        <button type='button' class="btn btn-default btn-middle readonly" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '3')">교환신청</button>
                        <button type='button' class="btn btn-default btn-middle readonly" onclick="getClaimPopup('${o.orderCode}', '${o.orderSequence}', '${i.itemSequence}', '2')">반품신청</button>
                    </div>
                </c:otherwise>
            </c:choose>

        </c:when>
    </c:choose>
</div>