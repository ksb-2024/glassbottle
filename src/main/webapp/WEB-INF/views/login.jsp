<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://lib.yongin.go.kr/include/js/jquery-1.12.4.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="loginstyle.css">
<title>유리병-로그인</title>
</head>
<body>

	<div class="container" id="container">
		<div class="form-container sign-up">
			<form action="/signupProc" method="post" id="signupForm">
				
				<div>
				<label for="uid">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;아이디 :</label>
				<input type="text"
				placeholder="ID " name="username" id="uid">
				<button id="duplicateID" type="button">중복</button>
				<div id="usernameAvailabilityMessage"></div>
				</div>
				<div>
				<label for="password">&emsp;&emsp;비밀번호 :</label>
				<input type="password"
				placeholder="PW" name="password" id="password">
				<div id="passwordLengthMessage"></div>
				</div>
				<div>
				<label for="confirmPassword">비밀번호 확인 :</label>
				<input type="password"
				placeholder="PW를 다시 입력해주세요" name="confirmPassword" id="confirmPassword">
				<div id="passwordCheck"></div>
				</div>
				<div>
				<label for="name">&emsp;&emsp;&emsp;&emsp;&nbsp;이름 :</label>
				<input type="text"
				placeholder="이름" name="name" id="name">
				</div>
				<div>
				<label for="nick">&emsp;&emsp;&emsp;&nbsp;닉네임 :</label>
				<input type="text"
				placeholder="닉네임" name="nick" id="nick">
				</div>
				<div>
				<label for="birth">&emsp;&emsp;&nbsp;&nbsp;생년월일 :</label>
				<input type="text"
				placeholder="생년월일 ex)19950111" name="birth" id="birth">
				</div>
				<div>
				<label for="tel">&emsp;&emsp;&nbsp;&nbsp;전화번호 :</label>
				<input type="text"
				placeholder="전화번호 ex)01012341234" name="tel" id="tel">
				</div>
				<div>
				<div id="genderController">
				<label for="genderController">&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;성별 :</label>
				   <button id="maleButton" type="button" onclick="setGender('남자')">남자</button>
    				<button id="femaleButton" type="button" onclick="setGender('여자')">여자</button>
        		</div>
        		 <input type="hidden" name="gender" id="gender" value="남자">
        		</div>
        		<div>
        		<label for ="email">&emsp;&emsp;&emsp;&emsp;이메일 :</label>
				<input type="text"
				placeholder="EMAIL" name="useremail" id="useremail">
				</div>
				<button type="submit">Sign Up</button>
			</form>
		</div>
		<div class="form-container sign-in">
					
			<!-- <form action="<c:url value='j_spring_security_check'/>" method="post"> -->
			<c:url value='j_spring_security_check' var="loginUrl"/>
		 	<form action="${loginUrl}" method="post"> 
				<img class="logimg" src="./images/log.png">	
				<h1>로그인</h1>
				<c:if test="${param.error != null}">
				<p>
					login Error!<br>
					${error_message}
				</p>
				</c:if>
				<input type="text" name="username"
				placeholder="아이디">
				<input type="password" name="password"
				placeholder="비밀번호">
				<a href="#" onclick="window.open('/findpw', '비밀번호찾기', 'width=600,height=400,top=100,left=100,resizable=yes,scrollbars=yes,toolbar=no,location=no,status=no'); return false;">비밀번호 찾기</a>
				<button type="submit" value="LOGIN">Sign In</button>
			</form>
		</div>
		<div class="toggle-container">
			<div class="toggle">
				<div class="toggle-panel toggle-left">
					<h1>회원가입</h1>
					<p><br>지금 로그인하여 일기공유를 시작하세요!</p>
					<button class="hidden" id="login">Sign In</button>
				</div>
				<div class="toggle-panel toggle-right">
					<h1>반가워요!</h1>
					<p>친구와의 일기공유부터 , 말할수없는 속마음을 익명으로  <br>지금 시작해보세요!</p>
					<button class="hidden" id="register">Sign Up</button>
				</div>
			</div>
		</div>
	</div>

	<script src="./script.js"></script>

</body>
</html>