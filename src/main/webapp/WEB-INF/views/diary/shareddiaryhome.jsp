 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
 <!DOCTYPE html>
<html lang="en">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js">
</script>
<script>
    function logout() {
        // Perform any additional logout actions if needed
        
        // Redirect to the "/logout" URL
        window.location.href = "/logout";
    }
    
 //중앙 상단 스토리 보여주기
    $(document).ready(function(){
    	
    	$.ajax({
    		url:"/diary/ourDiaries",
    		type:"GET",
    		success:function(data){
    			console.log(data);
    			
    			$(".stories").empty();
    			if(data[0] == null){
    				var text = '<div class="story" style="background:url(\'../images/bottle-sea.jpg\') no-repeat center center/cover">'
    								+	'<div class="profile-photo">'
    					           		+     '<img src="" >'
    					           		'</div>'
    					            +'<p class="name">Your Story</p>'
    					        +'</div>'
    					
    					
    				$(".stories").append(text);
    				return;
    			}
    			
    			for(var i=0;i<data.length;i++){
    				if(data[i].dfilename == null){
    					var text = "<div class='story' id='" 
    								   + data[i].did 
    								   +"' style='background:url(\"" 
    								   +"../images/bottle-sea.jpg"
    								   +"\") no-repeat center center/cover'><div class='profile-photo'><img src='../images/profile-"
    								   +(i+1) 
    								   +".jpg' >"
    						           +"</div><p class='name'>" + data[i].dfromid + "</p></div>";
    				}else{
    				
    				 var text = "<div class='story' id='" 
    								   + data[i].did 
    								   +"' style='background:url(\"" 
    								   + data[i].dfilename 
    								   +"\") no-repeat center center/cover'><div class='profile-photo'><img src='../images/profile-"
    								   +(i+1) 
    								   +".jpg' >"
    						           +"</div><p class='name'>" + data[i].dfromid + "</p></div>";
    				}
    				    $(".stories").append(text);
    			}
    			$(".story").on("click", function(e){
    				e.stopPropagation();
    				e.preventDefault();
    				var did = $(this).attr('id');
    				location.href = "/story/" + did;
    			})
    		},
    		error:function(){
    			console.log("ourDiaries error");
    		}
    	});
    });
    
    // 일기 좋아요
    $(document).on("click", ".like", function(){
    	var did = $(this).attr('value');
    	console.log("did : " + did);
    	var likedplace = $("b[name = '" + "liked" + did + "']");
    	var likeman = $("b[name = '" + "likeman" + did + "']");
    	console.log("likedplace : " + likedplace.text());
    	var prevlike = likedplace.text();
    	$.ajax({
    		url:"/diary/likeDiary",
			type:"POST",
			data:{
				dID:did,
			},
			success:function(data){
				console.log("likeDiary success");
				likedplace.text("");
				likedplace.text(data);
				$.ajax({
		    		url:"/diary/likeMan",
					type:"POST",
					data:{
						dID:did,
					},
					success:function(data){
						console.log("likeMan success");
						console.log("likeMan : " + data);
						likeman.text(data);
						if(data == null)
						likeman.text("");
		    		},
		    		error:function(){
		    			console.log("likeMan error");
		    		}
		    	})
    		},
    		error:function(){
    			console.log("likeDiary error");
    		}
    	})
    })
    
    // 일기 삭제
	$(document).on("click", ".uil-times", function(){
		console.log("일기 삭제!");
		var did = $(this).attr('value');
		var feed = $(this).parent().parent().parent();
		console.log("did : " + did);
		console.log("feed : " + feed);
		
		$.ajax({
			url:"/diary/deleteSharedDiary",
			type:"POST",
			data:{
				dID:did,
			},
			success:function(){
				console.log("deleteSharedDiary success");
				feed.remove();
			},
			error:function(){
				console.log("deleteSharedDiary error");
			}
		});
	})
    
 // 댓글 작성
	$(document).on("click", ".writeReply", function(){
		var did = $(this).val();
		//var contentPosition = "#userReply" + did; 
		var replyContent = $(this).prev().val();
		 $(this).prev().val('');
		
		
		console.log("댓글작성!");
		console.log("내용 : " + replyContent);
		console.log("did : " + did);
		if(replyContent == "" || replyContent == null) {
			alert("내용을 입력하세요!");
			return;
		}
		$.ajax({
			url:"/diary/writeReply",
			type:"POST",
			data:{
				dID:did,
				content:replyContent
			},
			success:function(){
				console.log("writeReply success!");
				$.ajax({
					url:"/diaryReply/" + did,
					type:"GET",
					success:function(data){
						console.log("getReplys success!");
						console.log(data);
						var username = '${username}';
						var replyposition = '#caption'+did;
						$(replyposition).empty();
						var replyText = "";
						data.forEach(function(reply,index){
								replyText = "<p><b>" + reply.writer + "</b> "
								+ reply.content + " <span class='harsh-tag'>"
								+ reply.date + "</span>"
								if(username == reply.writer && reply.deleteCheck == 'NO_DELETE'){
								 replyText = replyText + "<button class='replyUpdate' id='replyUpdate"+ reply.id + "' style='display:inline'>수정</button>&nbsp;"
					  			     			+ "<button class='replyDelete'  id='replyDelete" + reply.id + "' style='display:inline'>삭제</button>"
					  			     			+"</p>";
								}else{
										 replyText = replyText + "</p>";
								}
							$(replyposition).append(replyText);
						})
						
					},
					error:function(){
						console.log("getReplys Error");
					}
					
				})
			},
			error:function(){
				console.log("writeReply Error");
			}
		
		})
	})
	
	// 댓글 수정
	$(document).on("click", ".replyUpdate", function(e){
			e.stopPropagation();
			e.preventDefault();
			var rid = $(this).attr('id').substring(11);
			console.log("update rid : " + rid);
			var did = $(this).parent().parent().attr('id').substring(7);
			console.log("update did : " + did);
			var writer = $(this).parent().children('b').text();
			console.log("update writer : " + writer); 
			$('.wrp').remove();
			var writeReplyPlace = $(this).parent().after(
					"<div class='wrp'>" + writer + ":<textarea class='userReply' name='userReply' id='userReply" + did + "'></textarea>"
						+ "<button name='updateReply' class='updateReply' value='" + did + "'>update</button>"
						+ "<button name='resetReply' class='resetReply'>취소</button></div>"
			);
			$(document).on("click", ".resetReply", function(){
				$(this).parent().after().remove();
			});
			
			
			console.log("writeReplyPlace : " + writeReplyPlace);
			$(".updateReply").on("click", function(e){
				e.stopPropagation();
				e.preventDefault();
				 var content = $(this).prev().val();
				 console.log("content : " + content);
				 var preContentTag = $(this).parent().prev().children('b').next();
				 
				    ajaxRequest = $.ajax({
					url:"/diary/updateReply",
					type:"POST",
					data:{
						rID:rid,
						rCONTENT:content,
						dID:did
					},
					success:function(data){
						console.log('updateReply success');
						$('.resetReply').click();
						preContentTag.text(" " + content + " ");
					},
					error:function(){
						console.log('updateReply error');
					}
				})
			})
	});
 	// 댓글 삭제
	$(document).on("click", ".replyDelete", function(e){
		e.stopPropagation();
		e.preventDefault();
		var rid = $(this).attr('id').substring(11);
		//console.log("delete rid : " + rid);
		$.ajax({
			url:"/diary/deleteReply",
			type:"POST",
			data:{
				rID:rid
			},
			success:function(data){
				console.log("deleteReply success");
				console.log("did : " + data);
				var did = data.did;
				
				$.ajax({
					url:"/diaryReply/" + did,
					type:"GET",
					success:function(data){
						console.log("getReplys success!");
						console.log(data);
						if(data.length == 0){ 
							var noreplyposition = '#caption'+did; 
							$(noreplyposition).empty(); 
							return;
						}
						var username = '${username}';
						var replyposition = '#caption'+did;
						$(replyposition).empty();
						var replyText = "";
						console.log("username = " + username);
						data.forEach(function(reply,index){
							replyText = "<p><b>" + reply.writer + "</b> "
										+ reply.content + " <span class='harsh-tag'>"
										+ reply.date + "</span>"
							if(username == reply.writer && reply.deleteCheck == 'NO_DELETE'){
							 replyText = replyText + " <button class='replyUpdate' id='replyUpdate"+ reply.id + "' style='display:inline'>수정</button>&nbsp;"
   			  			     			+ "<button class='replyDelete'  id='replyDelete" + reply.id + "' style='display:inline'>삭제</button>"
   			  			     			+"</p>";
							}else{
									 replyText = replyText + "</p>";
							}
							$(replyposition).append(replyText);
						})
					},
					error:function(){
						console.log("getReplys Error");
					}
					
				})
			},
			error:function(){
				console.log("deleteReply error");
			}
		})
	})
    
</script>
<style>
	.userReply {
			height:30px;
			box-sizing: border-box;
			border: solid 2px gray;
			border-radius: 5px;
			font-size: 16px;
			resize: both;
			background-color : hsl(252, 30%, 95%);
		}
</style>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE-edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>lastDiary
    </title>
    <!-- ICONSCOUT CDN 아이콘 사이트 CDN -->
   
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
    <!-- STYLESHEET 스타일 시트 css 적용-->
    <link rel="stylesheet" href="../style.css">
</head>
    <!---  상단 ---->
    <%@ include file="index_nav.jsp" %>

    <!------------------ MAIN ------------------------>
    <main>
        <div class="container">
            <!-----===========  왼쪽  =================-------->
            <%@ include file="index_left2.jsp" %>



            <!-------================= 중앙 ===============-------->
            <div class="middle">
                <!-------------------- STORIES --------------------->
                <div class="stories">
                </div>
			<!-- -------END OF STORIES --------- -->

				<!--  -------------FEEDS-------------- -->
				<div class="feeds">
				<c:forEach var='diary' items='${diaryList}'>
					<!--  ------------_FEED 1 ------------- -->
					<c:if test="${diary.getDsDELETECHECK() eq 'NO_DELETE'}">
					<div class="feed">
						<div class="head">
							<div class="user">
								<div class="profile-photo">
									<img src="../images/profile-1.jpg">
								</div>
								<div class="ingo">
									<h3>${diary.getDFROMID()} - ${diary.getDTITLE()}</h3>
									<small>${diary.getDDATE()}</small>
								</div>
							</div>
							<span class="edit"> <i class="uil uil-times" value="${diary.getDID()}" style="cursor:pointer"></i>
							</span>
						</div>
	
						<div class="photo">
							<img src="${diary.getDFILENAME()}">
						</div>
						<div>
							<p>${diary.getDCONTENT()}</p>
						</div>

						<div class="action-button">
							<div class="interaction-buttons">
								<span class="like" value="${diary.getDID()}"><i class="uil uil-heart" style='cursor:pointer'></i></span> <span><i
									class="uil uil-comment-dots"></i></span> <span><i
									class="uil uil-share-alt"></i></span>
							</div>
							<div class="bookmark">
								<span><i class="uil uil-bookmark-full"></i></span>
							</div>
						</div>

						<div class="liked-by">
							<span><img src="../images/profile-10.jpg"></span> <span><img
								src="../images/profile-4.jpg"></span> <span><img
								src="../images/profile-15.jpg"></span>
							<p>
								Liked by<b name = 'likeman${diary.getDID()}'>${likePeople.get(diary.getDID())}</b> and <b name='liked${diary.getDID()}'>${diary.getDLIKE()}</b><b> others</b>
							</p>
						</div>
						<div class="comment">
							<input type="hidden" name="dID" id="dID${diary.getDID()}" value="${diary.getDID()}"/>
							${username}:<textarea name='userReply' class='userReply' id='userReply${diary.getDID()}'></textarea>
							<button name='writeReply' class='writeReply' value='${diary.getDID()}'>Reply</button>
						</div>

						<div class="caption" id="caption${diary.getDID()}">
								<c:if test="${!empty replyMap.get(diary.getDID())}">
									<c:set var='replys' value='${replyMap.get(diary.getDID())}'/>
									<c:forEach var='reply' items='${replys}'>
							<p>
								<b>${reply.getWriter()}</b><span> ${reply.getContent()} </span><span
									class="harsh-tag">${reply.getDate()}</span>
									<c:if test="${username eq reply.getWriter() and reply.getDeleteCheck() eq 'NO_DELETE'}">
									 <button class='replyUpdate'   id='replyUpdate${reply.getId()}' style='display:inline'>수정</button>
	    			  			     <button class='replyDelete'  id='replyDelete${reply.getId()}' style='display:inline'>삭제</button>
	    			  			     </c:if>
							</p>
									</c:forEach>
								</c:if>
						</div>
					</div>
					</c:if>
					<!--  --------------END OF FEED --------------- -->
					</c:forEach>
				</div>
				<!--  --------------END OF FEEDS --------------- -->



			</div>
			<!--  ================= END OF MIDDLE ================= -->
<%-- 			<%@ include file="index_right.jsp" %>
			 --%>

			</div>
		</div>
	</main>
</html>