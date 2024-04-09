<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script>
    $('#checkPwd').click(function() {
        const checkPassword = $('#password').val();
        if(!checkPassword || checkPassword.trim() === ""){
            alert("비밀번호를 입력하세요.");
        } else{
            $.ajax({
                type: 'GET',
                url: '/checkpwd',
                data: {'checkPassword': checkPassword},
                datatype: "text"
            }).done(function(result){
                console.log(result);
                if(result){
                    console.log("비밀번호 일치");
                    window.location.href="/settings/update";
                } else if(!result){
                    console.log("비밀번호 틀림");
                    // 비밀번호가 일치하지 않으면
                    alert("비밀번호가 맞지 않습니다.");
                    window.location.reload();
                }
            }).fail(function(error){
                alert(JSON.stringify(error));
            })
        }
    });
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="card-body">
		<div class="text-start">

			<div class="input-group input-group-outline my-3">
				<label class="form-label">비밀번호 확인</label> <input type="password"
					id="password" name="password" class="form-control">
			</div>
		</div>
		<div class="text-center">
			<button class="btn bg-gradient-primary w-100 my-4 mb-2" id="checkPwd">
				비밀번호 확인</button>
</body>
</html>