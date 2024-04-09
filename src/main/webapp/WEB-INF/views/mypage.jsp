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
<link rel="stylesheet" href="mypagestyle.css">
<head>
<meta charset="UTF-8">
<title>유리병-마이페이지</title>
</head>
<body>

	<div class="container" id="container">
		<div class="form-container up-date">
			<form action="/updateProfileProc" method="post" id="updateForm">
					<div class="upinfo">
					   <img class="logimg" src="./images/log.png">	
					<div>
					<label for="name">&emsp;&emsp;&nbsp;&nbsp;이름&emsp;&emsp;&nbsp;&nbsp;</label>
					<input type="text" name="name" value="${user.name}"
							placeholder="${name}"	required />
					</div>
					<div>
					<label for="nick">&emsp;&emsp;&nbsp;&nbsp;닉네임&emsp;&nbsp;&nbsp;</label>
					<input type="text" name="nick" value="${user.nick}"
							placeholder=${nick} required />
					</div>
					<div>
					<label for="nick">&emsp;&emsp;&nbsp;&nbsp;전화번호 &nbsp;</label>
					<input type="text" name="tel" value="${user.tel}" 
							placeholder=${tel} required />
					</div>
					<div>
					<label for="birth">&emsp;&emsp;&nbsp;&nbsp;생년월일 &nbsp;</label>
					<input type="text" name="birth" value="${user.birth}"
							placeholder=${birth} required />
					</div>
					<div>
						<div id="genderController">
						<label for="gender">&emsp;&emsp;&nbsp;&nbsp;성별&emsp;&emsp;&nbsp;&nbsp;</label>
					        <button id="maleButton" type="button" onclick="setGender('남자')">남자</button>
    				 		<button id="femaleButton" type="button" onclick="setGender('여자')">여자</button>
        				</div>
        		 		<input type="hidden" name="gender" id="gender" value="남자">
					</div>
					<div>
					<label for="useremail">&emsp;&emsp;&nbsp;&nbsp;이메일&emsp;&nbsp;&nbsp;</label>
					<input type="text" name="useremail" value="${user.useremail}" 
								placeholder=${useremail} required />
					</div>
					<div>
					<label for="password">&emsp;&emsp;&nbsp;&nbsp;비밀번호 &nbsp;</label>
					<input type="password" name="password"
						placeholder="Enter new password" />
					</div>
				<button type="submit">정보 변경</button>
					</div>
			</form>
		</div>
		<div class="form-container sign-in">
			<form id="mymy">
				   <img class="logimg" src="./images/log.png">	
			
				<div class="uinfo">
				 <div class="profile-photo">
                        <img src="./images/profile-1.jpg">
                    </div>
				<div>
					<label for="name">&emsp;이름&emsp;&nbsp;:&emsp;&emsp;&emsp;${name}</label>
				</div>
				<div>
					<label for="nick">&nbsp;닉네임&emsp;:&emsp;&emsp;&emsp;${nick}</label>
				</div>
				<div>
					<label for="tel">전화번호&nbsp;:&emsp;&emsp;&emsp;${tel}</label>
				</div>
				<div>
					<label for="birth">생년월일 :&emsp;&emsp;&emsp;${birth}</label>
				</div>
				<div>
					<label for="gender">&emsp;성별&emsp;&nbsp;:&emsp;&emsp;&emsp;${gender}</label>
				</div>
				<div>
					<label for="useremail">&nbsp;이메일&emsp;:&emsp;&emsp;&emsp;${useremail}</label>
				</div>
				</div>
				
				<div>		
				<button type="button" id="withdrawButton" onclick="location.href='/withdraw'">회원탈퇴</button>
				<button type="button" id="withdrawButton" onclick="location.href='/mainpage'">메인페이지</button>
				</div>
			</form>
		</div>
		<div class="toggle-container">
			<div class="toggle">
				<div class="toggle-panel toggle-left">
					<h1>정보변경</h1>
					<p>정보변경하는페이지.</p>
					<button class="hidden" id="login">돌아가기</button>
				</div>
				<div class="toggle-panel toggle-right">
					<h1>반가워요!</h1>
					<p>정보변경을 원하시면 이쪽을 눌러주세요</p>
					<button class="hidden" id="register">정보변경</button>
				</div>
			</div>
		</div>
	</div>

</body>
<script src="script.js"></script>

</html>