<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<div>
    <div class="modal alert-modal no-head" id="op-alert">
        <div class="modal-wrap">
            <div class="modal-body p-2">
                <div class="modal-content">
                    컨텐츠 내부
                </div>
                <div class="btn-wrap gap alert-type" style="display: none">
                    <button type="button" class="btn btn-primary op-modal-ok">확인</button>
                </div>
                <div class="btn-wrap gap confirm-type" style="display: none">
                    <button type="button" class="btn btn-default op-modal-cancel" onclick="$saleson.core.closeAlert()">취소</button>
                    <button type="button" class="btn btn-primary op-modal-ok">확인</button>
                </div>
            </div>
        </div>
        <div class="dimmed-bg"></div>
    </div>

    <div id="op-toast" class="toast-wrap show" style="display:none;">
        <div class="toast">
            <p class="desc"></p>
            <button class="modal-close"></button>
        </div>
    </div>

    <%-- JSP 페이지 내 선언된 modal 출력 (<page:modal></page:modal>)  --%>
    ${MODAL_BLOCK_IN_JSP_PAGE}
</div>
