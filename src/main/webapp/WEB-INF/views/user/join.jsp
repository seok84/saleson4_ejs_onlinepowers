<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daum"	tagdir="/WEB-INF/tags/daum" %>

<layout:default>

<div class="user-page join">
    <form id="join-form">
        <h1 class="title-h1">회원가입</h1>
        <!-- // 기본정보 -->
        <div class="toggle-title active">
            <h2>기본정보<span><em>*</em>표시는 필수 입력사항입니다</span></h2>
            <button type="button" class="toggle-arr"></button>
        </div>
        <div class="toggle-content user-info-content">
            <!-- //아이디 -->
            <h3 class="form-title">아이디<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <div class="flex">
                    <input type="text" id="loginId" name="loginId" class="form-basic required" title="ID" placeholder="6자~12자 이내 영문, 숫자" />
                    <button id="check_id_duplicate" class="btn btn-black m-w-118">중복검사</button>
                </div>
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //비밀번호 -->
            <h3 class="form-title">비밀번호<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <input type="password" id="password" name="password" class="form-basic required" title="비밀번호" placeholder="8~16자 이내 영문, 숫자, 특수문자" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //비밀번호 재입력-->
            <h3 class="form-title">비밀번호 재입력<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <input type="password" id="password_confirm" name="passwordConfirm" title="비밀번호 재입력" class="form-basic required" placeholder="비밀번호 재입력" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //이름 -->
            <h3 class="form-title">이름<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <input type="text" id="name" name="userName" title="이름" class="form-basic required readonly"  placeholder="이름" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //휴대폰번호 -->
            <h3 class="form-title">휴대폰번호<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <input type="text" id="phoneNumber" name="phoneNumber" title="휴대폰번호" class="form-basic required readonly" placeholder="'-'제외 번호 입력" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //전화번호 -->
            <h3 class="form-title">전화번호<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <input type="text" id="telNumber" name="telNumber" title="전화번호" class="form-basic required" placeholder="'-'제외 번호 입력" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //이메일 -->
            <h3 class="form-title">이메일<em class="mandatory-mark">*</em></h3>
            <div class="form-line">
                <input type="text" id="email" name="email" title="이메일" class="form-basic required" placeholder="example@company.com" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <!-- //생년월일 -->
            <h3 class="form-title">생년월일<em class="mandatory-mark">*</em></h3>
            <div class="select-wrap">
                <select class="input-select required" id="birthdayYear" name="birthdayYear" title="생년월일 년도">
                    <option value="">선택</option>
                    <c:forEach begin="0" end="100" step="1" var="index">
                    <option value="${years - index}" label="${years - index}">
                        </c:forEach>
                </select>
                <select class="input-select required" id="birthdayMonth" name="birthdayMonth" title="생년월일 월">
                    <option value="">선택</option>
                    <c:forEach begin="01" end="12" step="1" var="index">
                         <c:set var="addIndex" value="${String.format('%02d', index)}" />
                        <option value="${addIndex}">${addIndex}</option>
                        </c:forEach>
                </select>
                <select class="input-select required" id="birthdayDay" name="birthdayDay" title="생년월일 일">
                    <option value="">선택</option>
                    <c:forEach begin="01" end="31" step="1" var="index">
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
            <!-- //주소 -->
            <h3 class="form-title">주소<em class="mandatory-mark">*</em></h3>
            <div class="form-line mb-10">
                <div class="flex">
                    <input type="text" name="newPost" dirname="newPost" id="newPost" title="주소" class="form-basic required" readonly="readonly" placeholder="기본주소" />
                    <button type="button" class="btn btn-black m-w-118" onclick="openDaumPostcode()">우편번호</button>
                </div>
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <div class="form-line mb-10">
                <input type="text" name="address" id="address" title="주소" maxlength="100" class="form-basic required" readonly="readonly" placeholder="주소" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
            </div>
            <div class="form-line">
                <input type="text" name="addressDetail" id="addressDetail" title="상세 주소" class="form-basic required" placeholder="상세주소" />
                <span class="feedback invalid" style="display:none;">유효성 메시지</span>
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
                        <input type="checkbox" name="over14yearsOld" title="만 14세 이상" class="terms-checkbox required" value="POLICY_TYPE_OVER_14_YEARS_OLD" id="over14yearsOld"><i></i>
                        <p class="terms-title">만 14세 이상 <em>(필수)</em></p>
                    </label>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" title="서비스 이용 약관" name="terms" class="terms-checkbox required" value="POLICY_TYPE_AGREEMENT" id="terms"><i></i>
                        <p class="terms-title">서비스 이용 약관 동의 <em>(필수)</em></p>
                    </label>
                    <div class="terms-list">
                        <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_AGREEMENT')">약관보기</a>
                    </div>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" name="privacy" class="terms-checkbox required" title="개인정보의 수집·이용목적 및 항목" value="POLICY_TYPE_PROTECT_POLICY" id="privacy"><i></i>
                        <p class="terms-title">개인정보의 수집·이용목적 및 항목 동의 <em>(필수)</em></p>
                    </label>
                    <div class="terms-list">
                        <a class="terms-button" href="javascript:void(0)" onclick="policyModal('POLICY_TYPE_PROTECT_POLICY')">약관보기</a>
                    </div>
                </li>
                <li class="check-wrap">
                    <label class="circle-input-checkbox">
                        <input type="checkbox" name="marketing" title="마케팅 이용약관" class="terms-checkbox" value="POLICY_TYPE_MARKETING_AGREEMENT" id="marketing"><i></i>
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

    <daum:address />

<page:javascript>
<script>
        let idChecked = false;
    $(() => {
        let userName = $saleson.store.session.get("userName");
        let phoneNumber = $saleson.store.session.get("phoneNumber");
        if ( $.validator.isEmpty(userName) && $.validator.isEmpty(phoneNumber)) {
            $saleson.core.alert("인증 해주시기 바랍니다.", function () {
                $saleson.core.redirect('/user/sms-certify');
            });
        }
        $('#name').val(userName);
        $('#phoneNumber').val(phoneNumber);

        salesOnUI.toggleActive('.toggle-title');
        salesOnUI.inputPasswordUI();

        $('#check_id_duplicate').click(function() {
            checkIdDuplicate();
            return false;
        });

        $('#join-form').validator(function() {

            confirmJoin();
            return false;
        });

        $(".terms-checkbox").change(function () {
            $("#check-all").prop('checked',
                $(".terms-checkbox:checked").length === $(".terms-checkbox").length);
        });

        $("#check-all").change(function () {
            $(".terms-checkbox").prop('checked', this.checked);
        });
    });


    function checkIdDuplicate () {
        const loginId = $("#loginId").val();
        if($.validator.isEmpty(loginId)) {
            $saleson.core.alert("아이디를 입력해주세요");
            return false;
        }
        $saleson.api.post("/api/auth/find-user", loginId)
        .then(function (response) {
          if(response.data > 0) {
              $saleson.core.alert("사용중인 아이디 입니다.");
          } else {
              $saleson.core.alert("사용 가능한 아이디 입니다.");
              idChecked = true;
          }

        })
        .catch(function(error) {
            $saleson.core.api.handleApiExeption(error);
        });
    }



        function confirmJoin() {
         if ($("#password").val() != $("#password_confirm").val()) {
               $saleson.core.alert("비밀번호가 일치하지않습니다");
               $("#password_confirm").focus();
                return false;
            }

            const formDataArray = $("#join-form").serializeArray();
        formDataArray.push({ name: 'agreedPolicyTypes', value: getCheckedPolicy()})
        const formDataObject = {};
        formDataArray.forEach(item => {
            formDataObject[item.name] = item.value;
        });
        console.log(formDataObject);
        $saleson.api.post("/api/auth/join", formDataObject)
        .then(function (response) {
            if (response.status == "200"){
                $saleson.core.alert("가입되었습니다.", function () {
                    try{
                        $saleson.ev.log.joinUser(response.data.userId);
                    } catch (e) {}
                    $saleson.store.session.remove("userName");
                    $saleson.store.session.remove("phoneNumber");
                    $saleson.core.redirect('/user/join-complete');
                })
            }
        }).catch(function(error) {
            $saleson.core.alert(error.response.data.message);
            // $saleson.core.redirect('/');
        });
    }


    function openDaumPostcode () {

        const tagNames = {
            'newZipcode': 'newPost',
            'zipcode': 'post',
            'zipcode1': 'post1',
            'zipcode2': 'post2',
        };

        openDaumAddress(tagNames);
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