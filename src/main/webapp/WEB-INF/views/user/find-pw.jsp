<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="layout" tagdir="/WEB-INF/tags/layouts" %> <%@ taglib prefix="page" tagdir="/WEB-INF/tags/page" %>
<layout:default>
	<div class="user-page find-idpw">
		<h1 class="title-h1">비밀번호 찾기</h1>
		<form id="find-password-form" class="sns-auth-form">
			<div class="form-line mb-10">
				<input type="text" id="loginId" class="form-basic required" title="아이디" placeholder="아이디를 입력하세요" />
				<span class="feedback invalid" style="display: none">유효성 메시지</span>
			</div>
			<div class="form-line mb-10">
				<input type="text" id="name" class="form-basic required" title="이름" placeholder="이름을 입력하세요" />
				<span class="feedback invalid" style="display: none">유효성 메시지</span>
			</div>
			<div class="form-line mb-10">
				<div class="flex">
					<input type="text" id="phoneNumber" class="form-basic required" placeholder="휴대폰 번호를 입력하세요" title="휴대폰 번호" />
					<button type="button" id="send_auth_number" class="btn btn-black">인증요청</button
					><!-- 인증요청 -> 재전송 -->
				</div>
				<span class="feedback invalid" style="display: none">유효성 메시지</span>
				<input type="hidden" id="requestToken" />
			</div>
			<div class="form-line mb-10">
				<div class="flex">
					<span class="time-limit"></span>
					<input id="authNumber" type="text" class="form-basic required" placeholder="인증번호를 입력하세요" title="인증 번호" />
					<button id="check_auth_number" class="btn btn-black">인증 확인</button>
				</div>
			</div>
			<div class="link-wrap">
				<button type="submit" class="btn btn-primary confirm-btn">임시 비밀번호 발송</button>
			</div>
		</form>
	</div>

	<page:javascript>
		<script src="/static/content/modules/ui/auth/auth.js"></script>
		<script>
			$(() => {
				$("#send_auth_number").click(function () {
					SmsAuthHandler.sendAuthNumber($("#name").val(), $("#phoneNumber").val(), $("#check_auth_number"), $(".time-limit"), (token) => {
						$("#requestToken").val(token);
					});
					console.log($("#requestToken").val());
					return false;
				});

				$("#check_auth_number").click(function () {
					SmsAuthHandler.checkAuthNumber($("#authNumber").val(), $("#requestToken").val(), $(".time-limit"), (successFlag) => {
						if (successFlag) {
							$("#check_auth_number").text("인증완료");
						} else {
							$saleson.core.alert("인증에 실패하였습니다");
						}
					});
					return false;
				});

				$("#find-password-form").validator(function () {
					findPw();
					return false;
				});
			});

			function findPw() {
				let request = {
					requestToken: $("#requestToken").val(),
					authNumber: $("#authNumber").val(),
					userName: $("#name").val(),
					phoneNumber: $("#phoneNumber").val(),
					loginId: $("#loginId").val(),
				};
				$saleson.api
					.post("/api/auth/find-password-step1", request)
					.then(function (response) {
						$saleson.core.redirect("/user/find-pw-complete");
					})
					.catch(function (error) {
						$saleson.core.alert(error.response.data.message, function () {
							$saleson.core.redirect("/user/login");
						});
					});
			}
		</script>
	</page:javascript>
</layout:default>
