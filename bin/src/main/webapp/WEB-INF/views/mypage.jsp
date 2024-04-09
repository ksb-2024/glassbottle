<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 페이지</title>
</head>
<body>
	<h1>마이 페이지</h1>
			
		이름 : ${uname} <br>
		닉네임 : ${nick}<br>
		전화번호 : ${tel}<br>
		생년월일 : ${birth}<br>
		성별 : ${gender}<br>
		이메일 : ${useremail}@${edomain} <br>

<a href="/update">정보변경</a>	<a href="/withdraw">회원탈퇴</a>

</body>


</html>