<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script type="text/javascript"
	src="https://lib.yongin.go.kr/include/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

        // 아이디 중복 확인
    $(document).ready(function () {    
        $('#duplicateID').on('click', function () {
            const username = $('#uid').val();
            $.ajax({
                type: 'GET',
                url: '/checkDuplicateUsername',
                data: { username: username },
                success: function (response) {
                    if (response.available) {
                        $('#usernameAvailabilityMessage').html('<span style="color:green;">사용 가능한 아이디입니다.</span>');
                    } else {
                        $('#usernameAvailabilityMessage').html('<span style="color:red;">이미 사용 중인 아이디입니다.</span>');
                    }
                }
            });
        });

        // 비밀번호 확인
        $('#confirmPassword').on('blur', function () {
            const password = $('#password').val();
            const confirmPassword = $(this).val();

            if (password !== confirmPassword) {
                $('#passwordCheck').html('<span style="color:red;">비밀번호가 일치하지 않습니다!</span>');
            } else {
                $('#passwordCheck').html('');
            }
        });

        // 비밀번호 길이
        $('#password').on('blur', function () {
            const password = $(this).val();
            if (password.length < 6) {
                $('#passwordLengthMessage').html('<span style="color:red;">비밀번호 길이는 최소 6자 이상이여야합니다.</span>');
            } else {
                $('#passwordLengthMessage').html('');
            }
        });
    }); 
</script>
</head>
<body>
	<div align="center">


		<form action="/signupProc" method="post" id="signupForm">
			<div>
				<label for="uid">아이디:</label> <input type="text" name="username"
					id="uid" placeholder="ID를 입력해주세요" />
				<button id="duplicateID" type="button">중복 확인</button>
				<div id="usernameAvailabilityMessage"></div>
			</div>
			<div>
				<label for="password">비밀번호:</label> <input type="password"
					name="password" id="password" placeholder="PW를 입력해주세요" />
				<div id="passwordLengthMessage"></div>
			</div>
			<div>
				<label for="confirmPassword">비밀번호 확인:</label> <input type="password"
					name="confirmPassword" id="confirmPassword"
					placeholder="PW를 다시 입력해주세요" />
				<div id="passwordCheck"></div>
			</div>
			<div>
				<label for="nick">닉네임:</label> <input type="text" name="nick"
					id="nick" />
			</div>
			<div>
				<label for="name">이름:</label> <input type="text" name="name" />
			</div>
			<div>
				<label for="tel">전화번호:</label> <input type="text" name="tel" />
				</td>
			</div>
			<div>
				<label for="birth">생년월일:</label> <input type="text" name="birth"
					placeholder="숫자만입력해주세요 ex)19950111" />
			</div>
			<div>
				<label for="gender">성별:</label> <input type="radio" name="gender"
					value="남자" checked> <font size=2>남</font> <input
					type="radio" name="gender" value="여자"> <font size=2>여</font>
				</td>
			</div>
			<div>
				<label for="email">이메일:</label> <input type="text" name="useremail" />
			
			</div>
			<div id="error-message" style="color: red;">${error}</div>
			<div>
				<input type="submit" value="회원가입">
			</div>



		</form>
	</div>
</body>
</html>