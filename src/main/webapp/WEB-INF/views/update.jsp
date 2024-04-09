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
	
</script>

<title>유리병-정보변경</title>

</head>
<body>
	<div align="center">
		<h2>정보 변경</h2>
		<form action="/updateProfileProc" method="post">
			<table>
				<tr>
					<td>변경할 이름:</td>
					<td><input type="text" name="name" value="${user.name}"
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
						value="${user.useremail}" required />
					</td>


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