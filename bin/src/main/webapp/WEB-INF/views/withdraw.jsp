<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<p>
	회원 탈퇴시 서비스를 더 이상 이용할수 없습니다 
	탈퇴를 진행하겠습니까 ?
	
	
</p>
<form action="/withdrawProc" method="post">
<div>
	<input type="password" name="password" placeholder="현재 비밀번호 입력" required/>
</div>
	<div>
		<button type="submit">탈퇴하기</button>
	</div>

</form>




</div>






</body>
</html>