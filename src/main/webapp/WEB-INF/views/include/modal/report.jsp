<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal alert-modal modal-report" id="report-modal-alert">
    <div class="dimmed-bg"></div>
    <div class="modal-wrap">
        <button type="button" class="modal-close">닫기</button>
        <div class="modal-header">신고/차단</div>
        <div class="modal-body">
            <div class="btn-wrap gap">
                <button type="button" class="btn btn-primary open-detail">신고</button>
                <button type="button" class="btn btn-default user-block" data-id="0" data-type="">회원차단</button>
            </div>
        </div>
    </div>
</div>

<div class="modal modal-report detail" id="report-modal-detail">
    <div class="dimmed-bg"></div>
    <div class="modal-wrap">
        <button type="button" class="modal-close">닫기</button>
        <div class="modal-header">신고/차단</div>
        <div class="modal-body">
            <form id="report-modal-form">
                <input type="hidden" name="reportContentType" value="">
                <input type="hidden" name="contentId" value="0">
                <h3 class="form-title">신고사유</h3>
                <div class="radio-wrap">
                </div>
                <h3 class="form-title">신고 상세사유</h3>
                <div class="form-line">
                    <textarea name="content" cols="30" rows="10" class="form-basic text-area required _max_1000"
                              title="신고 상세사유"
                              placeholder="신고하시는 상세이유를 입력해주세요 (최대 글자는 1,000자 입니다)"></textarea>
                </div>
                <div class="btn-wrap gap">
                    <button type="submit" class="btn btn-primary">저장</button>
                    <button type="button" class="btn btn-default close-report">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>