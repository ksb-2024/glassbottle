<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js">
</script>
<script>
$(document).ready(function(){
	//메인페이지, 오늘 일기 작성후 저장요청
	
	//메인페이지, 오늘 일기를 작성했다면 조회
		$.ajax({
			url:"/diary/today",
			type:"GET",
			dataType:"json",
			success:function(data){
				//console.log(data);
				var dID = data.did;
				$(".part2").empty();
				$(".part2").html("<h1>제목: " + data.dtitle + "</h1>"
								+"<h3>날짜: " + data.ddate + "</h3>"
								+"<p>" + data.dcontent + "</p>"
								+"<button id='updateTD'>수정</button>&nbsp;&nbsp;"
								+"<button id='deleteTD'>삭제</button>&nbsp;&nbsp;"
								+"<button id='shareTD'>share</button>"
								);
								// 오늘의 일기 수정
								$("#updateTD").click(function(){
									//alert("updateTD clicked!");
									$(".part2").empty();
									$(".part2").html(  "제목: <input type='text' name='dtitle' id='dtitle' size='30' maxlength='100' value='" + data.dtitle +"'><br>"
												+"<textarea name='dcontent' id='dcon'>" + data.dcontent + "</textarea><br>"
												+"<button class='updateDiary' type='button'>작성</button>&nbsp;&nbsp;"
												+"<button class='goMain' type='button'>취소</button>"
											  );
											 $(".updateDiary").click(function(){
												//alert("작성완료!");
												data = "";
												var dTITLE = $("#dtitle").val();
												var dCONTENT = $("#dcon").val();
												
												if(dTITLE == "" || dTITLE == null){
													alert("제목을 입력하세요.");
													location.href="/main.do";
													return ;
												}
												if(dCONTENT == "" || dCONTENT == null){
													alert("내용을 입력하세요.");
													location.href="/main.do";
													return ;
												}
												
												$.ajax({
													url:"/diary/today/update",
													type:"PUT",
													data:{
														dID:dID,
														dTITLE:dTITLE,
														dCONTENT:dCONTENT
													},
													success:function(){
														console.log('updateTodayDiary success');
														location.href='/main.do';
													},
													error:function(){
														alert('updateTodayDiary Error');
													}
												});
											 });
											 $(".goMain").click(function(){
												location.href='/main.do'; 
											 });
								});
								// 오늘의 일기 삭제
								$("#deleteTD").click(function(){
									//alert("deleteTD clicked!");
									$.ajax({
										url:"/diary/today/delete",
										type:"DELETE",
										data:{
											dID:dID
										},
										success:function(){
											//console.log('deleteTodayDiary success');
											location.href='/main.do';
										},
										error:function(){
											alert('deleteTodayDiary Error');
										}
									});
								});
								$("#shareTD").click(function(){
									alert("shareTD clicked!");
								});
			},
			error:function(){
				//alert("todayDiary Error");
				console.log("오늘 작성된 일기가 없습니다.");
			}
		});
	
	
	
	//서브메뉴 채팅창 클릭시
	//중앙 오른쪽 공간에 ajax결과 보여줌
	$("#chat").click(function(){
		//alert('click');
		
		$.ajax({
			url:"/myChat.do",
			type:"GET",
			success: function(data){
				$(".part2").empty();
				$(".part2").html('<h1>' + data + '</h1>');
			},
			error:function(){
				alert('error');
			}
		});
	})
	// 서브메뉴 과거나의일기 클릭시
	// 중앙 오른쪽 공간에 ajax결과 보여줌
	$("#lastDiary").click(function(){
		var userID = $("#userID").text().slice(0,-1);
		console.log("userID:" + userID);
		//alert('click');
		
		$.ajax({
			url:"/diary/get/"+userID,
			type:"GET",
			dataType:"json",
			success: function(data){
				//console.log(data);
				$(".part2").empty();
				 for(var i=0; i<data.length;i++){
					 $(".part2").append("<ul>");
					 $(".part2").append("<li>no." + data[i].did + "</li>").css('list-style-type', 'none').css('line-height','30px');
					 $(".part2").append("<li class='into'>" + data[i].dtitle + "</li>");
					 $(".part2").append("<li>" + data[i].ddate + "</li>");
					 $(".part2").append("</ul>");
					 $(".part2").append("<hr>");
				 }
				 // 과거 나의 일기 상세페이지 요청
				 $(document).on("click", ".into", function() {
					    var did = $(this).prev().text().slice(3);
					    $.ajax({
					    	url:"/diary/into/"+did,
					    	type:"GET",
					    	dataType:"json",
					    	success: function(data){
					    		//console.log(data);
					    		$(".part2").empty();
					    		$(".part2").append("<h5>no. " + data.did +"</h5>");
					    		$(".part2").append("<h1>title: "+data.dtitle+"</h1>");
					    		$(".part2").append("<h3>writer: " + data.dfromid + "</h3>");
					    		$(".part2").append("<h3>date: " + data.ddate + "</h3>");
					    		$(".part2").append("<p>" + data.dcontent+"</p>");
					    		$(".part2").append("<button class='deleteDiary'>삭제</button>&nbsp;&nbsp;");
					    		$(".part2").append("<button class='goMain'>메인</button>");
					    		$(document).on("click", ".deleteDiary", function() {
					    			//alert('deleteDiary');
					    			$.ajax({
					    				url:"/diary/into/delete",
					    				type:"DELETE",
					    				data:{
					    					dID:data.did
					    				},
					    				success: function(){
					    					console.log("deleteMyOldDiary success");
					    					location.href='/main.do';
					    				},
					    				error: function(){
					    					alert("deleteMyOldDiary fail");
					    				}
					    			})
					    		})
								$(document).on("click", ".goMain", function(){
									location.href='/main.do';
								})
					    		
					    	},
					    	error:function(){
					    		alert('intoError');
					    	}
					    })
				});
			},
			error:function(){
				alert('diaryGetError');
				$(".part2").empty();
			}
		});
	})
	
	// 오늘의 일기 작성창
	$("#writing").click(function(){
		var part2 = $(this).parent()
		part2.empty();
		part2.html(  "제목: <input type='text' name='dtitle' id='dtitle' size='30' maxlength='100'><br>"
					+"<textarea name='dcontent' id='dcon'></textarea><br>"
					+"<button class='writeDiary' type='button'>작성</button>&nbsp;&nbsp;"
					+"<button class='goMain' type='button'>취소</button>"
				  );
		$('.goMain').click(function(){
			location.href='/main.do';
		})
		// 오늘의 일기 작성 처리요청
		$('.writeDiary').click(function(){
			//console.log('제목: ' + $('#dtitle').val());
			//console.log('내용: ' + $('#dcon').val());
			var dtitle = $('#dtitle').val();
			var dcontent = $('#dcon').val();
			
			if(dtitle == null || dtitle == ""){
				alert('제목을 입력하세요!');
				location.href='/main.do';
			}
			
			if(dcontent == null || dcontent == ""){
				alert('내용을 입력하세요!');
				location.href='/main.do';
			}
			
			$.ajax({
				url:'/diary/write',
				type:'POST',
				data: {
					title:dtitle,
					content:dcontent
				},
				success:function(){
					console.log('작성성공!');
					location.href='/main.do';
				},
				error:function(){
					alert('writeError');
				}
				
			})
		})
			
	})
	// 서브메뉴 수신 받은 일기 목록 조회
	$("#comeDiary").click(function(){
		//alert("comeDiary");
		var userID = $("#userID").text().slice(0,-1);
		//console.log("userID:" + userID);
		
		$.ajax({
			url:"/diary/received/"+userID,
			type:"GET",
			dataType:"json",
			success:function(data){
				console.log(data);
				$(".part2").empty();
				 for(var i=0; i<data.length;i++){
					 $(".part2").append("<ul>");
					 $(".part2").append("<li>no." + data[i].did + "</li>").css('list-style-type', 'none').css('line-height','30px');
					 $(".part2").append("<li class='into'>" + data[i].dtitle + "</li>");
					 $(".part2").append("<li>" + data[i].dfromid  + "</li>");
					 $(".part2").append("<li>" + data[i].ddate + "</li>");
					 if(data[i].dsREADCHECK == 0){
						 $(".part2").append("<li> 안읽음 </li>");
					 }else{
						 $(".part2").append("<li> 읽음 </li>");
					 }
					 $(".part2").append("</ul>");
					 $(".part2").append("<hr>");
				 }
				 // 수신 받은 일기 상세보기
				 $(document).on("click", ".into", function() {
					    var did = $(this).prev().text().slice(3);
					    $.ajax({
					    	url:"/diary/received/into/"+did,
					    	type:"GET",
					    	dataType:"json",
					    	success: function(data){
					    		//console.log(data);
					    		$(".part2").empty();
					    		$(".part2").append("<h5>no. " + data.did +"</h5>");
					    		$(".part2").append("<h1>title: "+data.dtitle+"</h1>");
					    		$(".part2").append("<h3>writer: " + data.dfromid + "</h3>");
					    		$(".part2").append("<h3>date: " + data.ddate + "</h3>");
					    		$(".part2").append("<p>" + data.dcontent+"</p>");
					    		$(".part2").append("<button class='deleteDiary'>삭제</button>&nbsp;&nbsp;");
					    		$(".part2").append("<button class='goMain'>메인</button>");
					    		// 수신 받은 일기 삭제
					    		$(document).on("click", ".deleteDiary", function() {
					    			//alert("deleteDiary");
					    			$.ajax({
					    				url:"/diary/received/into/delete",
					    				type:"DELETE",
					    				data:{
					    					dID:data.did
					    				},
					    				success:function(){
					    					console.log("received diary delete success");
					    					location.href='/main.do';
					    				},
					    				error:function(){
					    					alert("received diary delete fail");
					    				}
					    			})
					    		})
								$(document).on("click", ".goMain", function(){
									location.href='/main.do';
								})
					    		
					    	},
					    	error:function(){
					    		alert('intoError');
					    	}
					    })
				});
			},
			error:function(){
				alert("comeDiaryError");
			}
		})
	});
})

</script>
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
		line-height: 50px;/*높이값을 동일하게 줘서 세로 가운데 정렬*/
		text-align: center;
	}
	
	section .part2 ul li{
		list-style-type: none;
		line-height: 30px;
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
	
	 textarea {
	    width: 100%;
	    height: 38.8em;
	    border: none;
	    resize: none;
	  }
	
</style>
</head>
<body>
<!-- div#wrap>(header>h1+nav>a[#]*1) -->
	<header>
		<h1><a href="#" id="id">${username}님</a></h1>
		<nav>
			<a href="/mypage">MYPAGE</a>
		</nav>
	</header>
<!-- section>article.part$*2 -->
	<section>
		<article class="part1">
			<ul>
				<li><a href="">오늘 나의 일기</a></li>
				<li><a href="#" id="lastDiary">과거 나의 일기</a></li>
				<li><a href="#" id="comeDiary">수신 받은 일기</a></li>
				<li><a href="feelMonth.do">한달 나의 기분</a></li>
				<li><a href="#" id="chat">채팅창</a></li>
				<li><a href="/friends">친구목록</a></li> 
				<li><a href="feelNow.do">나의 기분 상태</a></li>
			</ul>
		</article>
		<article class="part2">
			<h2 id='writing'>일기 작성</h2>
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