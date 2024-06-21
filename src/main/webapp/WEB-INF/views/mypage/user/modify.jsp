<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="daum"	tagdir="/WEB-INF/tags/daum" %>


<layout:mypage>

    <section class="mypage-myInfo">
        <div class="title-container">
            <h2 class="title-h2">내 정보 관리</h2>
        </div>
        <input type="hidden" id="isSnsJoined" value="${isSnsJoined}">
        <div class="content">
            <form id="modify-form">
                <!-- 기본정보 -->
                <div class="toggle-title active">
                    <h2>기본정보<span><em>*</em>표시는 필수 입력사항입니다</span></h2>
                    <button class="toggle-arr"></button>
                </div>
                <div class="toggle-content user-page">
                    <input type="hidden" value="${userInfo.userId}" name="userId">
                    <!-- //아이디 -->
                    <h3 class="form-title accent">아이디</h3>
                    <div class="form-line">
                        <input type="text" id="loginId" value="${userInfo.loginId}" name="loginId" class="form-basic required" placeholder="6자~12자 이내 영문, 숫자" readonly />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    <!-- //이름 -->
                    <h3 class="form-title accent">이름</h3>
                    <div class="form-line">
                        <input type="text" id="userName" value="${userInfo.userName}"name="userName" class="form-basic required" placeholder="이름" readonly />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    <!-- //휴대폰번호 -->
                    <h3 class="form-title accent">휴대폰번호</h3>
                    <div class="form-line">
                        <input type="text" id="phoneNumber" value="${userInfo.phoneNumber}" name="phoneNumber" class="form-basic required" placeholder="'-'제외 번호 입력" />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    <!-- //전화번호 -->
                    <c:if test="${!isSnsJoined}">
                    <h3 class="form-title accent" >전화번호</h3>
                    <div class="form-line">
                        <input type="text" id="telNumber" value="${userInfo.telNumber}" name="telNumber" class="form-basic required" placeholder="'-'제외 번호 입력" />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    <!-- //이메일 -->
                    <h3 class="form-title accent">이메일</h3>
                    <div class="form-line">
                        <input type="text" id="email" name="email" value="${userInfo.email}" class="form-basic required" placeholder="example@company.com" />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    </c:if>
                    <!-- //생년월일 -->
                    <h3 class="form-title accent">생년월일</h3>
                    <div class="select-wrap">
                        <select class="input-select required" name="birthdayYear" id="birthdayYear" title="생년월일 년">
                            <option value="">선택</option>
                            <c:forEach begin="0" end="100" step="1" var="index">
                                <option value="${years - index}" ${userInfo.birthdayYear eq years - index ? 'selected' : ''} label="${years - index}"/>
                            </c:forEach>
                        </select>
                        <select class="input-select required" name="birthdayMonth" id="birthdayMonth" title="생년월일 월">
                            <option value="">선택</option>
                            <c:forEach begin="1" end="12" step="1" var="index">
                                <c:set var="addIndex" value="${String.format('%02d', index)}" />
                                <option value="${addIndex}" ${userInfo.birthdayMonth eq addIndex ? 'selected' : ''}>${addIndex}</option>
                            </c:forEach>
                        </select>
                        <select class="input-select required" name="birthdayDay" id="birthdayDay" title="생년월일 일">
                            <option value="">선택</option>
                            <c:forEach begin="1" end="31" step="1" var="index">
                                <c:set var="addIndex" value="${String.format('%02d', index)}" />
                                <option value="${addIndex}" ${userInfo.birthdayDay eq addIndex ? 'selected' : ''}>${addIndex}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- //성별 -->
                    <h3 class="form-title ">성별</h3>
                    <div class="radio-wrap">
                        <label class="input-radio"><input type="radio" name="gender" value="" ${userInfo.gender == '' ? 'checked' : ''}><i></i>미선택</label>
                        <label class="input-radio"><input type="radio" name="gender" value="F" ${userInfo.gender == 'F' ? 'checked' : ''}><i></i>여성</label>
                        <label class="input-radio"><input type="radio" name="gender" value="M" ${userInfo.gender == 'M' ? 'checked' : ''}><i></i>남성</label>
                    </div>
                    <!-- //주소 -->
                    <c:if test="${!isSnsJoined}">
                    <h3 class="form-title accent">주소</h3>
                    <div class="form-line mb-10">
                        <div class="flex">
                            <input type="text" name="newPost" value="${userInfo.newPost}" dirname="newPost" id="newPost" class="form-basic required" readonly="readonly" placeholder="기본주소" />
                            <button type="button" class="btn btn-black m-w-118" onclick="openDaumPostcode()">우편번호</button>
                        </div>
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    <div class="form-line mb-10">
                        <input type="text" name="address" value="${userInfo.address}"id="address" title="주소" maxlength="100" class="form-basic required" readonly="readonly" placeholder="주소" />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    <div class="form-line">
                        <input type="text" name="addressDetail" value="${userInfo.addressDetail}"id="addressDetail" class="form-basic required" placeholder="상세주소" />
                        <span class="feedback invalid" style="display:none;">유효성 메시지</span>
                    </div>
                    </c:if>
                </div>

                <!-- //수신동의 -->
                <div class="toggle-title active">
                    <h2>수신동의</h2>
                    <button type="button" class="toggle-arr"></button>
                </div>
                <div class="toggle-content user-page accept-content">
                    <div class="wrap">
                        <h4>문자메시지 수신동의</h4>
                        <ul class="dot-list large-dot">
                            <li>수신동의시 쇼핑몰에서 제공하는 이벤트 및 다양한 정보를 SMS(문자메시지)로 받아볼 수 있습니다.</li>
                            <li>회원가입, 거래정보-결제/배송/교환/환불 등과 같은 운영정보는 수신동의 여부와 관계없이 발송됩니다.</li>
                        </ul>
                        <div class="radio-wrap">
                            <label class="input-radio"><input type="radio" name="receiveSms" value="Y" ${userInfo.receiveSms == 'Y' ? 'checked' : ''}><i></i>수신동의</label>
                            <label class="input-radio"><input type="radio" name="receiveSms" value="N" ${userInfo.receiveSms == 'N' ? 'checked' : ''}><i></i>동의안함</label>
                        </div>
                    </div>
                    <div class="wrap">
                        <h4>이메일 수신동의</h4>
                        <ul class="dot-list large-dot">
                            <li>수신동의시 쇼핑몰에서 제공하는 이벤트 및 다양한 정보를 E-mail(이메일)로 받아볼 수 있습니다.</li>
                            <li>회원가입, 거래정보-결제/배송/교환/환불 등과 같은 운영정보는 수신동의 여부와 관계없이 발송됩니다.</li>
                        </ul>
                        <div class="radio-wrap">
                            <label class="input-radio"><input type="radio" name="receiveEmail" value="Y" ${userInfo.receiveEmail == 'Y' ? 'checked' : ''}><i></i>수신동의</label>
                            <label class="input-radio"><input type="radio" name="receiveEmail" value="N" ${userInfo.receiveEmail == 'N' ? 'checked' : ''}><i></i>동의안함</label>
                        </div>
                    </div>
                    <div class="wrap mobile">
                        <!-- // mobile -->
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
                <div class="link-wrap">
                    <button type="submit" class="btn btn-primary link-item w-half">저장</button>
                    <a href="/mypage/user/secede" class="btn btn-default link-item w-half">회원탈퇴</a>
                </div>
            </form>
        </div>
        <daum:address />

    </section>
    <page:javascript>
        <script>
            let isSnsJoined = ${isSnsJoined};

            $(() => {
                let passwordChecked = $saleson.store.session.get("passwordChecked");
                if (!passwordChecked) {
                    $saleson.core.alert("비밀번호 인증 바랍니다", function () {
                        $saleson.core.redirect('/mypage/user/check-password')
                    })
                } else {
                    $saleson.store.session.remove("passwordChecked");
                }
                $('#check_password').validator(function () {
                    checkPassword();
                    return false;
                });

                $('#modify-form').validator(function () {
                    modifyForm();
                    return false;
                })
            })
                function modifyForm() {
                    const formDataArray = $("#modify-form").serializeArray();
                    const formDataObject = {};
                    formDataArray.forEach(item => {
                        formDataObject[item.name] = item.value;
                    });
                    $saleson.api.post("/api/auth/me", formDataObject)
                    .then(function (response) {
                        if (response.status == "200") {
                            $saleson.core.alert("수정되었습니다.", function () {
                                $saleson.store.session.set("passwordChecked", true);
                                $saleson.core.redirect('/mypage/user/modify');

                            })
                        }
                    }).catch(function (error) {
                        $saleson.core.alert(error);
                    });

                }


                function openDaumPostcode() {

                    const tagNames = {
                        'newZipcode': 'newPost',
                        'zipcode': 'post',
                        'zipcode1': 'post1',
                        'zipcode2': 'post2',
                    };

                    openDaumAddress(tagNames);
                }


        </script>
    </page:javascript>
    <page:model>

    </page:model>
</layout:mypage>
