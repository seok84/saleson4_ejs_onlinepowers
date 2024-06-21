<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<layout:default>

    <section class="customer customer-partner">
        <div class="title-h1">고객센터</div>

        <c:set var="activeType" value="store-inquiry" scope="request"/>
        <jsp:include page="include/tab.jsp"/>

        <div class="container">
            <form id="storeApplyForm">
                <div class="form-line">
                    <input type="text" class="form-basic required" name="company" placeholder="업체명" title="업체명"/>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic required" name="userName" placeholder="담당자명" title="담당자명"/>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="number" class="form-basic required" name="phoneNumber" placeholder="담당자 연락처"
                           title="담당자 연락처"/>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic optional _email" name="email" placeholder="담당자 이메일"/>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                    <input type="text" class="form-basic" name="homepage" placeholder="홈페이지url"/>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="form-line">
                <textarea name="content" cols="30" rows="10" class="form-basic text-area required"
                          placeholder="판매하고자 하는 제품"></textarea>
                    <span class="feedback invalid" style="display: none;">유효성 메시지</span>
                </div>
                <div class="upload-wrap">
                    <label for="upload-file" class="btn btn-default-line">
                        <input type="file" name="file" id="upload-file" accept=".gif,.png,.jpg,.jpeg,.pdf">
                        <span>파일선택</span>
                    </label>
                    <p class="file-placeholder">선택된 파일 없음</p>
                        <%--<div class="upload-preview hide"></div>--%>
                </div>
                <ul class="dot-list large-dot">
                    <li>제품리스트를 파일로 첨부하시면 빠른 견적 진행 가능합니다.</li>
                    <li>10MB 이내의 jpg, gif, png, pdf 파일만 업로드 가능합니다.</li>
                </ul>
                <ul class="terms-content">
                    <li class="check-wrap">
                        <label class="circle-input-checkbox" for="agree">
                            <input id="agree" type="checkbox"><i></i>
                            <p class="terms-title">개인정보의 수집·이용목적 및 항목 동의 <em>(필수)</em></p>
                        </label>
                        <div class="terms-list">
                            <button type="button" class="terms-button" onclick="policyModal('POLICY_TYPE_AGREEMENT')">약관보기</button>
                        </div>
                    </li>
                </ul>

                <div class="link-wrap gap">
                    <button type="submit" class="btn btn-primary link-item w-half">저장</button>
                    <button type="button" class="btn btn-primary-line link-item w-half" onclick="location.reload()">취소</button>
                </div>
            </form>
        </div>
    </section>

    <page:javascript>
        <script>
            $(function () {

                const $form = $('#storeApplyForm');

                async function submitAction() {
                    try {

                        if (!$('#agree').is(':checked')) {
                            $saleson.core.alert('이용약관에 동의해주세요.');
                            return false;
                        }

                        const formData = new FormData($form[0]);
                        await $saleson.api.post('/api/store-inquiry', formData);

                        $saleson.core.alert('등록되었습니다.', ()=>{
                            location.reload();
                        });

                    } catch (e) {
                        $saleson.core.alert('제휴/입점문의를 등록시 오류가 발생했습니다.');
                    }
                }

                $form.validator(function () {

                    if (!$('#agree').is(':checked')) {
                        $saleson.core.alert('이용약관에 동의해주세요.');
                        return false;
                    }

                    $saleson.core.confirm('제휴/입점문의를 등록하시겠습니까?', () => {
                        submitAction();
                    });

                    return false;
                });

                $form.on('change', 'input[name=file]', function (e) {
                    const file = e.target.files[0]

                    let fileName = '선택된 파일 없음';

                    if (typeof file !== undefined && file != null) {
                        if (!$saleson.handler.validFiles([file],['gif','png','jpg','jpeg','pdf'], 5)) {
                            $(this).val('');
                        } else {
                            fileName = file.name;
                        }
                    }

                    $form.find('.file-placeholder').text(fileName);
                });

                try {
                    $saleson.analytics.view('제휴/입점문의');
                } catch (e) {}

            });

            function policyModal(policyType) {
                const $modal = $(".policy")
                $saleson.api.get(`/api/policy/` + policyType)
                .then(function (response) {
                    $modal.find('.modal-header').text(response.data.title);
                    $modal.find('.modal-content').html(response.data.content);
                    salesOnUI.modal().show('.policy');
                })
            }
        </script>
    </page:javascript>
    <page:model>
        <div class="modal policy">
            <div class="modal-wrap">
                <button class="modal-close" data-dismiss>닫기</button>
                <div class="modal-header">
                </div>
                <div class="p-2 modal-body">
                    <div class="modal-content">

                    </div>
                </div>
            </div>
            <div class="dimmed-bg"></div>
        </div>

    </page:model>
</layout:default>