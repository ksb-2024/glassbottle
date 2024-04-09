<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js">
</script> 
<script>
$(document).ready(function(){
		$("#firstClick").click(function(){
			//alert('click');
			
			$.ajax({
				url:"/demo",
				type:"GET",
				success: function(data){
					
					var id = data['id'];
					var name = data['name'];
					var password = data['password'];
					var role = data['role'];
					
					data = id + name + password + role; 
					$("#demo").text(data);
				},
				error:function(){
					alert('error');
				}
			});
		})
		
		$("#clickPlz").click(function(){
			//alert('click');
			
			var inputData = { id:"sbsb", password:"1234"}
			alert(inputData);
			$.ajax({
				url:"/demo",
				type:"POST",
				data: JSON.stringify(inputData),
				contentType:"application/json;charset=UTF-8",
				dataType:"json",
				success: function(data){
					alert("success");
					/* var id = data['id'];
					var name = data['name'];
					var password = data['password'];
					var role = data['role'];
					
					data = id + name + password + role; 
					$("#demo").text(data); */
				},
				error:function(){
					alert('error');
				}
			});
		})
	});
</script>
</head>
<body>
	
	<h1>안녕, ${username}!!!@#$</h1>
	<p id="demo"></p>
    <button type="button" id="firstClick">클릭</button>
    
    <button type="button" id="clickPlz">클릭</button>
	
</body>
</html>