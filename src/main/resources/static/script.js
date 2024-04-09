const container = document.getElementById('container');
const registerBtn = document.getElementById('register');
const loginBtn = document.getElementById('login');

registerBtn.addEventListener('click', () => { container.classList.add("active"); });

loginBtn.addEventListener('click', () => { container.classList.remove("active"); });

function setGender(selectedGender) {
	const maleButton = document.getElementById('maleButton');
	const femaleButton = document.getElementById('femaleButton');

	if (selectedGender === '남자') {
		maleButton.style.backgroundColor = '#512da8';
		femaleButton.style.backgroundColor = '#eee';
	} else if (selectedGender === '여자') {
		maleButton.style.backgroundColor = '#eee';
		femaleButton.style.backgroundColor = '#512da8';
	}

	document.getElementById('gender').value = selectedGender;
}

// 유효성검사...


$(document).ready(function() {
	// 추가: 중복 확인 버튼 클릭 여부 변수
	let duplicateIDChecked = false;

	$('#duplicateID').on('click', function() {
		const username = $('#uid').val();
		if (!username) {
			alert('아이디를 입력해주세요.');
			return;
		}

		$.ajax({
			type: 'GET',
			url: '/checkDuplicateUsername',
			data: { username: username },
			success: function(response) {
				if (response.available) {
					$('#usernameAvailabilityMessage').html('<span style="color:green;">사용 가능한 아이디입니다.</span>');
					duplicateIDChecked = true; // 중복 확인 완료
				} else {
					$('#usernameAvailabilityMessage').html('<span style="color:red;">이미 사용 중인 아이디입니다.</span>');
					duplicateIDChecked = false; // 중복 확인 실패
				}
			}
		});
	});
	$('#birth').on('input', function() {
		const value = $(this).val();
		if (!isNumeric(value)) {
			alert('숫자만 입력해주세요');
		}
	});

	// Real-time validation for Phone number
	$('#tel').on('input', function() {
		const value = $(this).val();
		if (!isNumeric(value)) {
			alert('숫자만 입력해주세요.');
		}
	});

	// 추가: 모든 필드가 입력되었는지 확인 및 중복 확인 여부 체크
	$('#signupForm').on('submit', function() {
		const fields = ['uid', 'password', 'confirmPassword', 'name', 'nick', 'birth', 'tel', 'gender'];

		// 중복 확인이 완료되었는지 확인
		if (!duplicateIDChecked) {
			alert('아이디 중복을 확인해주세요.');
			return false;
		}
		for (const field of fields) {
			const value = $('#' + field).val();

			if (!value) {
				alert('빈칸이 없는지 다시 한번 확인해주세요.');
				return false;
			}
		}
	return true;
	});

	// 비밀번호 확인
	$('#confirmPassword').on('blur', function() {
		const password = $('#password').val();
		const confirmPassword = $(this).val();

		if (password !== confirmPassword) {
			$('#passwordCheck').html('<span style="color:red;">비밀번호가 일치하지 않습니다!</span>');
		} else {
			$('#passwordCheck').html('');
		}
	});

	// 비밀번호 길이
	$('#password').on('blur', function() {
		const password = $(this).val();
		if (password.length < 6) {
			$('#passwordLengthMessage').html('<span style="color:red;">비밀번호 길이는 최소 6자 이상이여야합니다.</span>');
		} else {
			$('#passwordLengthMessage').html('');
		}
	});
});