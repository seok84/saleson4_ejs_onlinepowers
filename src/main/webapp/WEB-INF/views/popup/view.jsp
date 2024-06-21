<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:base>

    <div class="modal window-modal show">
        <div class="dimmed-bg"></div>
        <div class="modal-wrap">
            <button class="modal-close popup-close">닫기</button>
            <div class="modal-header">알림</div>
            <div class="modal-body">
                <div class="content-wrap">
                    <c:choose>
                        <c:when test="${'IMAGE' eq popup.popupStyle}">
                            <c:if test="${not empty popup.imageLink}">
                                <a href="${popup.imageLink}" target="_blank">
                            </c:if>
                            <img src="${popup.popupImage}" border="0" onerror="errorImage(this)"/>
                            <c:if test="${not empty popup.imageLink}">
                                </a>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            ${popup.content}
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="content-footer">
                    <div class="check-area" style="cursor: pointer;">
                        <label class="checkbox"><input type="checkbox"><i></i></label>
                        <span>오늘 하루 이창을 열지 않음</span>
                    </div>
                    <button type="button" class="popup-close">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <page:javascript>
        <script>
            $(function () {


                $('.popup-close').on('click', function (e) {
                    e.preventDefault();
                    self.close();
                });

                $('.check-area').on('click', function (e) {

                    e.preventDefault();

                    const cacheKey = '${popup.cacheKey}';
                    const expires = new Date();
                    expires.setDate(expires.getDate() + 1);
                    $saleson.store.cookie.set(cacheKey, 'Y', {'expires': expires});

                    self.close();
                });
            });
        </script>
    </page:javascript>
</layout:base>
