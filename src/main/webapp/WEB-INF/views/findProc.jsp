<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="https://lib.yongin.go.kr/include/js/jquery-1.12.4.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="findpwstyle.css">
</head>
<body>
	<div class="container" id="container">
		<div class="form-container sign-in">
			<div>
				<form action="/changePassword" method="post" id="changePassword">
					 <input type="hidden" name="username" value="${username}">
   					 <input type="hidden" name="birth" value="${birth}">
   					 <input type="hidden" name="name" value="${name}">
					<div>
						<label for="password">비밀번호 :</label> <input type="password"
							placeholder="PW" name="password" id="password">
						<div id="passwordLengthMessage"></div>
					</div>
					<div>
						<label for="confirmPassword">비밀번호 확인 :</label> <input
							type="password" placeholder="PW를 다시 입력해주세요"
							name="confirmPassword" id="confirmPassword">
							</div>
						<div id="passwordCheck"></div>
						<button type="submit">변경하기</button>
				</form>
			</div>

		</div>
	</div>

</body>
</html>