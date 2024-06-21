<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${itemDetail.itemOptionFlag != 'Y'}">
    <div class="quantity-wrap">
        <p>수량</p>
        <div class="quantity-box-round">
            <button type="button" class="btn-quantity btn-minus"></button>
            <input type="number" title="수량" value="${itemDetail.orderMinQuantity < 0 ? 1 : itemDetail.orderMinQuantity}" readonly maxlength="999" class="quantity number">
            <button type="button" class="btn-quantity btn-plus"></button>
        </div>
    </div>
</c:if>
<c:if test="${itemDetail.itemOptionFlag == 'Y'}">
    <!-- 옵션 -->
    <div class="txt_box">
        <p>
            <c:choose>
                <c:when test="${itemDetail.itemOptionType eq 'T'}">
                    *상품을 구매하려면 필수옵션을 작성하세요.
                </c:when>
                <c:otherwise>
                    *상품을 구매하려면 필수 옵션을 선택하세요.
                </c:otherwise>
            </c:choose>

        </p>
    </div>
</c:if>
<c:if test="${itemDetail.itemSoldOutFlag != 'Y'}">
    <c:choose>
        <c:when test="${itemDetail.itemOptionFlag eq 'Y' && itemDetail.itemType != '3'}">
            <c:choose>
                <c:when test="${itemDetail.itemOptionType eq 'S' || itemDetail.itemOptionType eq 'S2' || itemDetail.itemOptionType eq 'S3'}">
                    <!-- 옵션-드롭다운(선택형) -->
                    <div class="option-dropdown">
                        <!-- 버튼 -->
                        <div class="dropdown-title select-wrap">
                            <a class="input-select">필수 상품 옵션을 선택하세요</a>
                        </div>
                        <!-- 내용 -->
                        <div class="option-contents">
                            <div class="select-wrap">
                                <a class="input-select">필수 상품 옵션을 선택하세요</a>
                            </div>
                            <div class="option-inner">
                                <c:choose>
                                    <c:when test="${itemDetail.itemOptionType eq 'S'}">
                                        <c:forEach items="${itemDetail.selectedOption}" var="selectedOption" varStatus="i">
                                            <div class="dropdown-area" >
                                                <button type="button" class="option-title" data-index="${i.index}"> ${selectedOption.optionName}</button>
                                                <div class="option-item">
                                                    <c:forEach items="${selectedOption.options}" var="option">
                                                        <button type="button" class="${option.soldOut == "false" ? "option-btn" : ""}" data-index="${i.index}" data-last="${i.last}">
                                                            <span class="option-label">${option.optionName2}</span>
                                                            <c:if test="${option.optionPrice > 0}">
                                                                ( + <fmt:formatNumber value="${option.optionPrice}" pattern="#,###"/>원 )
                                                            </c:if>
                                                                ${option.soldOut == "false" ? "" : "- 품절"}
                                                        </button>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:when test="${itemDetail.itemOptionType eq 'S2' || itemDetail.itemOptionType eq 'S3'}">
                                        <c:forEach items="${itemDetail.combineOptions}" var="step" varStatus="i">
                                            <c:if test="${itemDetail.itemOptionType eq 'S3' || (itemDetail.itemOptionType eq 'S2' && !i.last)}">
                                                <div class="dropdown-area">
                                                    <button type="button" class="option-title" data-index="${i.index}">
                                                        <c:choose>
                                                            <c:when test="${i.index == 0}">${itemDetail.itemOptionTitle1}</c:when>
                                                            <c:when test="${i.index == 1}">${itemDetail.itemOptionTitle2}</c:when>
                                                            <c:when test="${i.index == 2}">${itemDetail.itemOptionTitle3}</c:when>
                                                        </c:choose>
                                                    </button>
                                                    <div class="option-item">
                                                        <c:forEach items="${step.names}" var="name">
                                                             <button type="button" class="option-btn" data-index="${i.index}" data-last="${i.last}" ><span class="option-label" data-index="${i.index}">${name}</span></button>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:when test="${itemDetail.itemOptionType eq 'T'}">
                    <!-- 옵션-텍스트형 -->
                    <div class="option-text">
                        <c:forEach items="${itemDetail.combineOptions}" var="step" varStatus="i">
                            <c:if test="${i.index == 0}">
                                <c:forEach items="${step.names}" var="name" varStatus="j">
                                    <c:choose>
                                        <c:when test="${j.last}">
                                            <div class="form-line">
                                                <div class="flex">
                                                    <input type="text" class="form-basic text-option" placeholder="${name}" />
                                                    <button type="button" class="btn btn-black text-option-add">추가</button>
                                                </div>
<%--                                                <span class="feedback invalid">유효성 메시지</span>--%>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="form-line">
                                                <input type="text" class="form-basic text-option" placeholder="${name}" />
                                                <!-- <span class="feedback invalid">유효성 메시지</span> -->
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:when>
            </c:choose>
        </c:when>
        <c:when test="${itemDetail.itemType == '3'}">
            <!-- 구성상품 -->
            <div class="composition-pruduct active">
                <div class="composition-title">구성상품</div>
                <ul class="composition-list-container">
                    <li class="composition-list">
                        <div class="item-list-container horizon">
                            <!-- 반복요소 item-list -->
                            <c:forEach items="${itemDetail.itemSets}" var="set" varStatus="i">
                                <c:set value="${set.item}" var="setItem" />
                                <div class="item-list" data-item-id="${setItem.itemId}" data-option-type="${setItem.itemOptionType}">
                                    <!-- 아이템 썸네일 영역 -->
                                    <div class="thumbnail-container ${setItem.itemSoldOutFlag == 'Y' ? 'sold-out' : ''}">
                                        <c:if test="${setItem.itemSoldOutFlag == 'Y'}">
                                            <div class="sold-out-wrap">
                                                <span>
                                                    <img src="/static/content/image/sample/sold-out.png" alt="품절">
                                                </span>
                                            </div>
                                        </c:if>
                                        <div class="thumbnail-wrap">
                                            <img class="thumbnail" src="${setItem.itemImage}" alt="썸네일">
                                        </div>
                                    </div>
                                    <!-- 아이템 정보 영역 -->
                                    <div class="info-container">
                                        <div class="title-main paragraph-ellipsis">
                                            ${setItem.itemName}
                                        </div>
<%--                                        <div class="title-sub paragraph-ellipsis">--%>
<%--                                            (구성 상품의 설명)--%>
<%--                                        </div>--%>
                                        <div class="purchase-amount">
                                            <p class="amount-only">
                                                <string>${set.quantity}</string>개
                                            </p>
                                        </div>
                                    </div>
                                    <c:if test="${setItem.itemOptionFlag == 'Y'}">
                                        <div class="option-dropdown">
                                            <!-- 버튼 -->
                                            <div class="dropdown-title select-wrap">
                                                <a class="input-select">[필수] 옵션 선택</a>
                                            </div>
                                            <!-- 내용 -->
                                            <div class="option-contents">
                                                <div class="select-wrap">
                                                    <a class="input-select">필수 상품 옵션을 선택하세요</a>
                                                </div>
                                                <div class="option-inner">
                                                    <c:choose>
                                                        <c:when test="${setItem.itemOptionType == 'S'}">
                                                            <c:forEach items="${setItem.selectedOption}" var="selectedOption" varStatus="j">
                                                                <div class="dropdown-area" >
                                                                    <button type="button" class="option-title" data-index="${j.index}"> ${selectedOption.optionName}</button>
                                                                    <div class="option-item">
                                                                        <c:forEach items="${selectedOption.options}" var="option">
                                                                            <button type="button" class="${option.soldOut == "false" ? "option-btn" : ""}" data-index="${j.index}" data-last="${j.last}">
                                                                                <span class="option-label">${option.optionName2}</span>
                                                                                <c:if test="${option.optionPrice > 0}">
                                                                                    ( + <fmt:formatNumber value="${option.optionPrice}" pattern="#,###"/>원 )
                                                                                </c:if>
                                                                                    ${option.soldOut == "false" ? "" : "- 품절"}
                                                                            </button>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:when test="${setItem.itemOptionType == 'S2' || setItem.itemOptionType == 'S3'}">
                                                            <c:forEach items="${setItem.combineOptions}" var="step" varStatus="j">
                                                                <c:if test="${setItem.itemOptionType eq 'S3' || (setItem.itemOptionType eq 'S2' && !j.last)}">
                                                                    <div class="dropdown-area">
                                                                        <button type="button" class="option-title" data-index="${j.index}">
                                                                            <c:choose>
                                                                                <c:when test="${j.index == 0}">${setItem.itemOptionTitle1}</c:when>
                                                                                <c:when test="${j.index == 1}">${setItem.itemOptionTitle2}</c:when>
                                                                                <c:when test="${j.index == 2}">${setItem.itemOptionTitle3}</c:when>
                                                                            </c:choose>
                                                                        </button>
                                                                        <div class="option-item">
                                                                            <c:forEach items="${step.names}" var="name">
                                                                                <button type="button" class="option-btn" data-index="${j.index}" data-last="${j.last}" ><span class="option-label" data-index="${j.index}">${name}</span></button>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:when>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </li>
                </ul>
            </div>
        </c:when>
    </c:choose>
</c:if>
<!-- 옵션리스트 -->
<ul class="option-list-container"></ul>


