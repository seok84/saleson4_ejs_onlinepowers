<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>

<layout:default>
<div class="user-page join">
    <form id="sns-join-form">
        <h1 class="title-h1">SNS 간편회원 가입</h1>
        <!-- // 기본정보 -->
        <input type="hidden" id="snsId" name="snsId">
        <input type="hidden" id="snsType" name="snsType">
        <input type="hidden" id="requestToken">
        <input type="hidden" name="ismyPage">
        <input type="hidden" id="phoneNumber" name="phoneNumber">
        <div class="toggle-title active">
            <h2>기본정보<span><em>*</em>표시는 필수 입력사항입니다</span></h2>
            <button type="button" class="toggle-arr"></button>
        </div>
        <div class="toggle-content user-info-content">
            <!-- //이름 -->
            <h3 class="form-title accent">이름</h3>
            <div class="form-line">
                <input type="text" id="snsName" name="snsName" class="form-basic" readonly placeholder="이름" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //이메일 -->
            <h3 class="form-title accent">이메일</h3>
            <div class="form-line">
                <input type="text" id="email" name="email" class="form-basic" placeholder="example@company.com" readonly />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //생년월일 -->
            <h3 class="form-title accent">생년월일</h3>
            <div class="select-wrap">
                <select class="input-select required" name="birthdayYear" id="birthdayYear" title="생년월일 년">
                    <option value="">선택</option>
                    <c:forEach begin="0" end="100" step="1" var="index">
                    <option value="${years - index}" label="${years - index}">
                    </c:forEach>
                </select>
                <select class="input-select required" name="birthdayMonth" id="birthdayMonth" title="생년월일 월">
                    <option value="">선택</option>
                    <c:forEach begin="1" end="12" step="1" var="index">
                        <c:set var="addIndex" value="${String.format('%02d', index)}" />
                        <option value="${addIndex}">${addIndex}</option>
                    </c:forEach>
                </select>
                <select class="input-select required" name="birthdayDay" id="birthdayDay" title="생년월일 일">
                    <option value="">선택</option>
                    <c:forEach begin="1" end="31" step="1" var="index">
                        <c:set var="addIndex" value="${String.format('%02d', index)}" />
                        <option value="${addIndex}">${addIndex}</option>
                    </c:forEach>
                </select>
            </div>
            <!-- //성별 -->
            <h3 class="form-title">성별</h3>
            <div class="radio-wrap">
                <label class="input-radio"><input type="radio" name="gender" value="" checked><i></i>미선택</label>
                <label class="input-radio"><input type="radio" name="gender" value="F"><i></i>여성</label>
                <label class="input-radio"><input type="radio" name="gender" value="M"><i></i>남성</label>
            </div>
        </div>
        <!-- //수신동의 -->
        <div class="toggle-title active">
            <h2>수신동의</h2>
            <button type="button" class="toggle-arr"></button>
        </div>
        <div class="toggle-content accept-content">
            <div class="wrap">
                <h4>문자메시지 수신동의</h4>
                <ul class="dot-list">
                    <li>수신동의시 쇼핑몰에서 제공하는 이벤트 및 다양한 정보를 SMS(문자메시지)로 받아볼 수 있습니다.</li>
                    <li>회원가입, 거래정보-결제/배송/교환/환불 등과 같은 운영정보는 수신동의 여부와 관계없이 발송됩니다.</li>
                </ul>
                <div class="radio-wrap">
                    <label class="input-radio"><input type="radio" name="receiveSms" value="Y" checked><i></i>수신동의</label>
                    <label class="input-radio"><input type="radio" name="receiveSms" value="N"><i></i>동의안함</label>
                </div>
            </div>
            <div class="wrap">
                <h4>이메일 수신동의</h4>
                <ul class="dot-list">
                    <li>수신동의시 쇼핑몰에서 제공하는 이벤트 및 다양한 정보를 E-mail(이메일)로 받아볼 수 있습니다.</li>
                    <li>회원가입, 거래정보-결제/배송/교환/환불 등과 같은 운영정보는 수신동의 여부와 관계없이 발송됩니다.</li>
                </ul>
                <div class="radio-wrap">
                    <label class="input-radio"><input type="radio" name="receiveEmail" value="Y" checked><i></i>수신동의</label>
                    <label class="input-radio"><input type="radio" name="receiveEmail" value="N" ><i></i>동의안함</label>
                </div>
            </div>
            <div class="wrap mobile"><!-- // mobile -->
                <h4>앱 푸쉬 수신동의</h4>
                <ul class="dot-list">
                    <li>다양한 특가상품과 개인 맞춤 이벤트 정보를 가장 빠르게 받아볼 수 있습니다.</li>
                </ul>
                <div class="radio-wrap">
                    <label class="input-radio"><input type="radio" name="receivePush" value="Y" ><i></i>수신동의</label>
                    <label class="input-radio"><input type="radio" name="receivePush" value="N" checked><i></i>동의안함</label>
                </div>
            </div>
        </div>
        <!-- //약관동의 -->
        <div class="toggle-title active">
            <h2>약관동의</h2>
            <button type="button" class="toggle-arr"></button>
        </div>
        <div class="toggle-content ">
            <ul class="terms-content">
                <li class="check-wrap whole-check">
                    <label class="circle-input-checkbox"><input type="checkbox" id="check-all" ><i></i>
                    <p class="terms-title">모든 약관 동의</p>
                    </label>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" name="over14yearsOld" class="terms-checkbox " value="POLICY_TYPE_OVER_14_YEARS_OLD" id="over14yearsOld"><i></i>
                        <p class="terms-title">만 14세 이상 <em>(필수)</em></p>
                    </label>
                    <div class="terms-list">
                    </div>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" name="terms" class="terms-checkbox " value="POLICY_TYPE_AGREEMENT" id="terms"><i></i>
                        <p class="terms-title">서비스 이용 약관 동의 <em>(필수)</em></p>
                    </label>
                    <div class="terms-list">
                        <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_AGREEMENT')">약관보기</a>
                    </div>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" name="privacy" class="terms-checkbox " value="POLICY_TYPE_PROTECT_POLICY" id="privacy"><i></i>
                        <p class="terms-title">개인정보의 수집·이용목적 및 항목 동의 <em>(필수)</em></p>
                    </label>
                    <div class="terms-list">
                        <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_PROTECT_POLICY')">약관보기</a>
                    </div>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" name="marketing" class="terms-checkbox" value="POLICY_TYPE_MARKETING_AGREEMENT" id="marketing"><i></i>
                        <p class="terms-title">마케팅이용약관 동의<span>(선택)</span></p>
                    </label>
                    <div class="terms-list">
                        <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_MARKETING_AGREEMENT')">약관보기</a>
                    </div>
                </li>
            </ul>
        </div>
        <!-- // 회원가입 -->
        <button type="submit" class="btn btn-default btn-primary confirm-btn">회원가입</button>
    </form>
</div>
    <page:javascript>
        <script type="application/javascript">
            $(() => {

                salesOnUI.toggleActive('.toggle-title');
                const snsUser = JSON.parse($saleson.store.session.get("snsUser"));
                const phoneNumber = $saleson.store.session.get("phoneNumber");
                if ( $.validator.isEmpty(snsUser))  {
                    $saleson.core.alert("인증 해주시기 바랍니다.", function () {
                        $saleson.core.redirect('/user/certify-join');
                    });
                }
                $("#snsName").val(snsUser.snsName);
                $("#email").val(snsUser.email);
                $("#snsId").val(snsUser.snsId);
                $("#snsType").val(snsUser.snsType);
                $("#phoneNumber").val(phoneNumber);
                $(".terms-checkbox").change(function () {
                    $("#check-all").prop('checked',
                        $(".terms-checkbox:checked").length === $(".terms-checkbox").length);
                });

                $("#check-all").change(function () {
                    $(".terms-checkbox").prop('checked', this.checked);
                });



                $('#sns-join-form').validator(function () {
                    // if(!$('#marketing').prop('checked') && !$('#privacy').prop('checked')){
                    //     $saleson.core.alert("약관에 동의해주세요");
                    //     return false;
                    // }
                    if (!$('#over14yearsOld, #privacy, #terms').prop('checked')) {
                        $saleson.core.alert("필수 약관에 동의해주세요");
                        return false;
                    }
                    $saleson.core.confirm("가입하시겠습니까?", function () {
                        snsJoin();

                    })
                    return false;
                });


            });


            function snsJoin() {

                const formDataArray = $("#sns-join-form").serializeArray();

                formDataArray.push({ name: 'agreedPolicyTypes', value: getCheckedPolicy()})
                const formDataObject = {};
                formDataArray.forEach(item => {
                    formDataObject[item.name] = item.value;
                });

                $saleson.api.post("/api/auth/sns-join", formDataObject)
                .then(function (response) {
                    if (response.status == 200) {
                        $saleson.core.alert(response.data.message, function () {
                            try{
                                $saleson.ev.log.joinUser(response.data.userId);
                            } catch (e) {}
                            $saleson.store.session.remove("snsUser");
                            $saleson.store.session.remove("phoneNumber");
                            $saleson.core.redirect("/user/join-complete");
                        });



                    }
                }).catch(function (error) {
                    $saleson.core.alert(error);
                });
            }

            function getCheckedPolicy() {
                let checkedPolicy = [];

                $(".terms-checkbox:checked").each(function () {
                    checkedPolicy.push($(this).val());
                });
                return checkedPolicy;
            }

            function policyModal(policyType) {
                const $modal = $(".policy")
               $saleson.api.get(`/api/policy/` + policyType)
                .then(function (response) {

                    $modal.find('.modal-header').text(response.data.title);
                    $modal.find('.modal-content').html(response.data.content);
                    // salesOnUI.modal('.policy').show();
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