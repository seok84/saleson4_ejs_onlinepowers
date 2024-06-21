<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<!-- 배송지 목록 -->
<div class="dimmed-bg" data-dismiss></div>
<div class="modal-wrap">
    <button class="modal-close" data-dismiss>닫기</button>
    <div class="modal-header">
        배송지 목록
    </div>
    <div class="modal-body">
        <section id="address-list-section"></section>
        <div class="btn-wrap gap">
            <button class="btn btn-primary" type="button" onclick="addressApply()">적용</button>
            <button class="btn btn-default" data-dismiss>취소</button>
        </div>
        <button class="btn btn-default btn-add-address" onclick="addressAddPopup()">배송지 추가</button>
    </div>



</div>
<script src="/static/content/js/common.js"></script>
<script>
    $(function () {

        paginationShippingList(1);

    })

    function addressApply() {

        const $info = $('.address-list.active .address-content');

        let userName = $info.data('userName');
        let zipcode = $info.data('zipcode');
        let address = $info.data('address');
        let addressDetail = $info.data('addressDetail');
        let mobile = $info.data('mobile');
        let sido = $info.data('sido');
        let sigungu = $info.data('sigungu');
        let eupmyeondong = $info.data('eupmyeondong');
        let newZipcode = $info.data('newZipcode');

        $('input[name="receivers[0].receiveName"]').val(userName);
        $('input[name="receivers[0].receiveMobile"]').val(mobile);
        $('input[name="receivers[0].receiveZipcode"]').val(zipcode);
        $('input[name="receivers[0].receiveAddress"]').val(address);
        $('input[name="receivers[0].receiveAddressDetail"]').val(addressDetail);
        $('input[name="receivers[0].receiveNewZipcode"]').val(newZipcode);
        $('input[name="receivers[0].receiveSido"]').val(sido);
        $('input[name="receivers[0].receiveSigungu"]').val(sigungu);
        $('input[name="receivers[0].receiveEupmyeondong"]').val(eupmyeondong);


        OrderHandler.buy.receivers[0].zipcode = zipcode;

        OrderHandler.getIslandType();

        OrderHandler.setAmountText();

        salesOnUI.modal().dismiss('.modal-address-list');
    }

    function paginationShippingList(page) {
        const param = {
            page: page,
            size: 10
        }

        $('#address-list-section').empty();

        $.get('/shipping/address-list', param, function(response) {
            $('#address-list-section').append(response);
        }, 'html');

    }
</script>
