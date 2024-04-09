<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="https://lib.yongin.go.kr/include/js/jquery-1.12.4.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="findpwstyle.css">
</head>
<body>
    <div class="container" id="container">
        <div class="form-container sign-in">
    
                <form action="/checksucces" method="post" id="checkform">
                    <label for="uid">아이디 :</label>
                    <input type="text" placeholder="ID " name="username" id="uid">
                    <div id="usernameAvailabilityMessage"></div>
                    <label for="name">이름 :</label>
                    <input type="text" placeholder="이름" name="name" id="name">
                    <label for="birth">생년월일 :</label>
                    <input type="text" placeholder="생년월일 ex)19950111" name="birth" id="birth">
                    <br>
                    <button type="submit" onclick="submitForm()">비밀번호 찾기</button>
                </form>
        
        </div>
    </div>


</body>