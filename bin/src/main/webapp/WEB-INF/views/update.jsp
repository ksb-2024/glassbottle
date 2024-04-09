<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 도메인 선택 스크립트 -->
<script src="https://lib.yongin.go.kr/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(function() {
		const domainListEl = document.querySelector('#domain-list');
		const domainInputEl = document.querySelector('#domain-txt');
		// select 옵션 변경 시
		domainListEl.addEventListener('change',function(event) {
		// option에 있는 도메인 선택 시
			if (domainListEl.options[domainListEl.selectedIndex].value != "type") {
		// 선택한 도메인을 input에 입력하고 disabled
			domainInputEl.value = domainListEl.options[domainListEl.selectedIndex].value;
			domainInputEl.disabled = false;
			} else { // 직접 입력 시
		// input 내용 초기화 & 입력 가능하도록 변경
			domainInputEl.value = "";
			domainInputEl.disabled = true;
		}
	  });
	});
</script>

<title>정보 변경</title>

</head>
<body>
	<div align="center">
		<h2>정보 변경</h2>
		<form action="/updateProfileProc" method="post">
			<table>
				<tr>
					<td>변경할 이름:</td>
					<td><input type="text" name="uname" value="${user.uname}"
						required /></td>
				</tr>
				<tr>
					<td>변경할 닉네임:</td>
					<td><input type="text" name="nick" value="${user.nick}"
						required /></td>
				</tr>
				<tr>
					<td>변경할 전화번호:</td>
					<td><input type="text" name="tel" value="${user.tel}" required /></td>
				</tr>
				<tr>
					<td>변경할 생년월일:</td>
					<td><input type="text" name="birth" value="${user.birth}"
						required /></td>
				</tr>
				<tr>
					<td>변경할 성별:</td>
					<td><input type="radio" name="gender" value="male"
						${user.gender eq 'male' ? 'checked' : ''}> Male <input
						type="radio" name="gender" value="female"
						${user.gender eq 'female' ? 'checked' : ''}> Female</td>
				</tr>
				<tr>
					<td>변경할 이메일:</td>
					<td><input type="text" name="useremail"
						value="${user.useremail}" required />@ <input id="domain-txt" type="text"
						name="edomain" value="${user.edomain}" required/> <select
						id="domain-list">
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="kakao.com">kakao.com</option>
							<option value="type">직접 입력</option>
					</select></td>


				</tr>
				<tr>
					<td>변경할 비밀번호:</td>
					<td><input type="password" name="password"
						placeholder="Enter new password" /></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">변경하기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- Add your additional HTML elements, scripts, or footers here -->
</body>
</html>