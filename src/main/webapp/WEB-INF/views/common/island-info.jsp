<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>

<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">
        제주/도서산간지역
    </div>
    <div class="modal-body">
        <div class="form-wrap">
            <div class="select-wrap">
                <select name="where" class="input-select">
                    <option value="ADDRESS" ${criteria.where eq 'ADDRESS' ? 'selected' : ''} >주소</option>
                    <option value="ZIPCODE" ${criteria.where eq 'ZIPCODE' ? 'selected' : ''} >우편번호</option>
                </select>
            </div>
            <div class="form-line">
                <input type="text" name="query" id="query" class="form-basic" value="${criteria.query}" placeholder="주소를 입력해주세요." />
                <button onclick="islandInfoModal(1)"><i class="ico-search"></i></button>
<%--                <span class="feedback invalid">유효성 메시지</span>--%>
            </div>
        </div>
        <div>
            <table>
                <colgroup>
                    <col style="width: 60%" />
                    <col  />
                    <col  />
                </colgroup>
                <thead>
                <tr>
                    <th>우편번호/주소</th>
                    <th>제주</th>
                    <th>도서산간</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty pageContent.content}">
                        <c:forEach items="${pageContent.content}" var="content">
                            <tr>
                                <td>
                                    <p class="address">${content.zipcode}</p>
                                    <p>${content.address}</p>
                                </td>
                                <td>${content.islandType eq 'JEJU' ? 'O' : ''}</td>
                                <td>${content.islandType eq 'ISLAND' ? 'O' : ''}</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:when test="${empty pageContent.content}">
                        <tr>
                            <td colspan="3">
                                등록된 자료가 없습니다.
                            </td>
                        <tr>
                    </c:when>
                </c:choose>
                </tbody>
            </table>
            <!-- 페이징 -->
            <page:pagination/>

        </div>

    </div>
</div>