<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한달 나의 기분</title>
<style>
	body{
		margin: 0; /*모든 콘텐츠가 인터넷 창에 딱 붙게*/
	}
	header{width:100%; height: 100px; backgroud-color: aquamarine}
	header h1{
		width: 20%; height: 100px;
		text-align: center; line-height: 100px;
		/*줄간격값과 높이값을 동일하게 주면 세로 가운데 정렬된다(콘텐츠가 한줄일때만 가능)*/
		float: left;/*이미지 배치 효율적으로 하기 위한 속성*/
		margin: 0; /*붕뜨게 하는 margin을 없애야함*/
		background-color: antiquewhite
	}
	header h1 a{
		font-size: 30px; color: hotpink;
		text-decoration: none; /*a태그 밑줄 삭제*/
	}
	
	header nav{
		float: left;
		width: 80%;
		height: 100px;
		background-color: cadetblue
	}
	
	header nav a{
		float: right;
		margin: 40px 20px 20px 20px; 
		padding: 0;
		color: orange;
		text-decoration: none;
	}
	
	/* -----------------------------------------------------------------------------------
-----------------------------------------*/
	section{width: 100%; height: 600px; background-color: beige}
	section .part1 {
		width: 20%; float: left; /*가로정렬*/
		height: 640px;
		text-align: center;
	}
	
	section .part1 ul{
		height: 550px;
		margin: 0;
  		padding: 50px 0 0 0;
	}
	
	section .part1 ul li{
		list-style: none;
		margin: 50px 0 50px 0;
		padding: 0;
	}
	
	section .part1 ul li a{
		color: orange;
		text-decoration: none;
		display: block;    
		padding: 5px;    
		font-size: 14px;    
	}
	
	section .part2 {
		width: 80%; float: left; /*가로정렬*/
		line-height: 600px;/*높이값을 동일하게 줘서 세로 가운데 정렬*/
		text-align: center;
	}
	
	section .part1{background-color: lightgreen;}
	section .part2{background-color: lightcyan;}
	
	/* -----------------------------------------------------------------------------------
-----------------------------------------*/
	footer{
		clear: both; /*float초기화 : float의 영향을 받지 않겠다*/
		height: 100px; background-color: #999;
		padding-top: 10px; font-size: 12px;
	}
	footer div{
		width:70%; height: 30px;
		background-color: lightyellow; 
		margin: auto;
		margin-bottom: 10px;
		padding-left: 30px;
		line-height: 30px;
	}
</style>
</head>
<body>
	<!-- div#wrap>(header>h1+nav>a[#]*1) -->
	<header>
		<h1><a href="#">${userID}님</a></h1>
		<nav>
			<a href="myPage.do">MYPAGE</a>
		</nav>
	</header>
<!-- section>article.part$*2 -->
	<section>
		<article class="part1">
			<ul>
				<li><a href="main.do">오늘 나의 일기</a></li>
				<li><a href="lastDiary.do">과거 나의 일기</a></li>
				<li><a href="comeDiary.do">수신 받은 일기</a></li>
				<li><a href="#">한달 나의 기분</a></li>
				<li><a href="myChat.do">채팅창</a></li>
				<li><a href="myFriends.do">친구목록</a></li>
				<li><a href="feelNow.do">나의 기분 상태</a></li>
			</ul>
		</article>
		<article class="part2">
			<h2>한달 나의 기분</h2>
		</article>
	</section>
<!-- footer>div.fo$*2 -->
	<footer>
		<div class="fo1">
			서울 마포구 합정동 02)1234-5678/
			glassbottle@email.com
		</div>
		<div class="fo2">
			Copyright &copy; All rights reserved.
		</div>
	</footer>
</body>
</html>