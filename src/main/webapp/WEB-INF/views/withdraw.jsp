<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="loginstyle.css">
<title>유리병-탈퇴진행</title>
</head>
<body>
    <div class="container" id="container">
        <form action="/withdrawProc" method="post" id="withdrawProc">
            <h2>회원 탈퇴시 서비스를 더 이상 이용할 수 없습니다.</h2><br>
               <h2>탈퇴를 진행하겠습니까?</h2>

            <div>
                <input type="password" name="password" placeholder="현재 비밀번호 입력" required />
            </div>
            
            <div>
                <button type="submit" onclick="return checkPasswordMatch()">탈퇴하기</button>
                <a href="/mypage"><button type="button">돌아가기</button></a>
            </div>

     
        </form>
    </div>
</body>
</html>