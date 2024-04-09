<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	<div align="center" />
<c:url value="j_spring_security_check" var="loginUrl" />
		<form action=" ${loginUrl}" method="post">
		<c:if test="${param.error != null }">
			<p>
				Login Error!<br> ${error_message}
			</p>
		</c:if>
		ID: <input type="text" name="username"><br> PW: <input
				type="password" name="password"><br>
		<br> <input type="hidden" name="_csrf" value="{{_csrf.token}}" />
		<input type="submit" value="로그인">
	</form>

	<br>
	<br>
	<a href="/signup">회원가입</a>
	</div>
</body>
</html>