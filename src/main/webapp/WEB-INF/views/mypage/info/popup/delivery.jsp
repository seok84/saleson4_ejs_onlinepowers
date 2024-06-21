<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal address-modal">
    <div class="dimmed-bg" data-dismiss></div>
    <div class="modal-wrap">
        <button class="modal-close" data-dismiss>닫기</button>
        <div class="modal-header">
            배송지 추가
        </div>
        <div class="modal-body">
            <form id="deliveryForm">
                <input type="hidden" name="userDeliveryId">
                <div class="btn-wrap gap m-section-divider">
                    <div class="btn btn-default btn-middle check-wrap">
                        <label class="circle-input-checkbox purple">
                            <input type="checkbox" name="defaultFlag" value="Y" checked><i></i>기본 배송지로 설정
                        </label>
                    </div>
                    <div class="btn btn-default btn-middle check-wrap">
                        <label class="circle-input-checkbox purple">
                            <input type="checkbox" class="" onchange="getDefaultAddress(event)"><i></i>기본 배송지 가져오기
                        </label>
                    </div>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic required" name="title" id="title" placeholder="배송지" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="text" name="userName" class="form-basic required" id="userName" placeholder="받는사람" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <div class="flex">
                        <input type="text" name="newZipcode" class="form-basic required" id="newZipcode" readonly placeholder="우편번호 찾기" />
                        <button class="btn btn-black" type="button" onclick="openDaumPostAddress('delivery')">우편번호</button>
                    </div>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="hidden" name="sido">
                    <input type="hidden" name="sigungu">
                    <input type="hidden" name="eupmyeondong">
                    <input type="text" name="address" id="address" class="form-basic required" readonly placeholder="기본주소" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="text" name="addressDetail" id="addressDetail" class="form-basic required" placeholder="상세주소" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="text" name="mobile" id="mobile" class="form-basic required" placeholder="휴대폰 또는 전화번호 숫자만 입력" />
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="btn-wrap">
                    <button type="submit" class="btn btn-primary w-160">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>