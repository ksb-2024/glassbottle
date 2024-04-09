<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.springproj.emotionshare.chat.ChatRoom"%>
<%@ page import="com.springproj.emotionshare.domain.UserEntity"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${chatRoom.name}</title>
<link rel="stylesheet"
   href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
<style type="text/css">
.middle {
   width: 600px; /* 또는 px/ems/rem 단위 사용 가능 */
   margin: 0 auto; /* 중앙 정렬 */
   background-color: #fff; /* 연한 회색 배경, 필요에 따라 변경 */
   padding: 20px; /* 내부 패딩 */
   border-radius: 10px; /* 모서리 둥글게 */
   box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 박스 그림자 */
   border: 1px solid #e1e1e1; /* 경계선 */
}

.chat-input-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}
/* 입력 필드 스타일 */
.chat-input {
    flex-grow: 1; /* 입력 필드가 가능한 공간을 모두 차지하도록 */
    margin-right: 10px; /* 전송 버튼과의 간격 */
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 10px;
}

/* 전송 버튼 스타일 */
.chat-send-button {
    padding: 10px 20px;
    background-color: #007BFF; /* Bootstrap의 기본 파란색 */
    color: white;
    border: none;
    border-radius: 10px;
    cursor: pointer;
}

/* 전송 버튼 hover 효과 */
.chat-send-button:hover {
    background-color: #0056b3; /* 버튼 호버 시 색상 변경 */
}
.con {
   width: 100px;
   margin: 0 auto;
}

.chat-Message {
   height: 600px;
   overflow-y: auto;
   border: 1px solid #ccc;
   margin-bottom: 10px;
   background: #fff;
}

.message {
   word-break: break-word; /* 긴 단어도 줄바꿈 */
   background-color: #fff; /* 메시지 배경색 */
   border: 1px solid #e1e1e1; /* 메시지 경계선 */
   margin-bottom: 10px; /* 메시지 사이의 간격 */
   padding: 5px;
   margin: 5px;
   border-radius: 10px;
   display: block;
   max-width: 60%;
}

.me {
   font-size: 15px; background-color : #eff;
   margin-left: auto; /* 오른쪽 정렬 */
   text-align: right;
   background-color: #eff;
}

.other {
   font-size: 15px;
   background-color: #fee;
   margin-right: auto; /* 왼쪽 정렬 */
}
</style>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
   var Chat__roomId = parseInt('${param.roomId}');
   
   //parseInt('${chat.roomId}');
   //var roomId = '${param.roomId}'; 이렇게 해도 상관없음

   var stompClient = null;
   function logout() {
        // Perform any additional logout actions if needed

        // Redirect to the "/logout" URL
        window.location.href = "/logout";
    }
   function enterChatRoom(roomId) {
       // 서버에 채팅방 입장 알림
       stompClient.send("/app/chat.enterRoom", {}, JSON.stringify({'roomId': roomId}));
   }

   function leaveChatRoom(roomId) {
       // 서버에 채팅방 퇴장 알림
       stompClient.send("/app/chat.leaveRoom", {}, JSON.stringify({'roomId': roomId}));
   }

   

   // 페이지를 떠날 때 채팅방에서 나감
   $(window).on('beforeunload', function() {
       leaveChatRoom(Chat__roomId);
   });

   
   

   

   function connect() {
      var socket = new SockJS('/ws');
      stompClient = Stomp.over(socket);

      stompClient.connect({}, function(frame) {
         console.log('Connected: ' + frame);
         
         // 여기에 stompClient.subscribe 코드 추가
         stompClient.subscribe('/topic/public', function(chatMessage) {
            console.log('Received raw message: ', chatMessage); // 원시 메시지 로깅
            console.log('Received message body: ', chatMessage.body); // 수신된 메시지 로깅
            var message = JSON.parse(chatMessage.body); // 수신된 메시지를 JSON 객체로 변환
            Chat__drawMessage(message); // 메시지를 화면에 그리는 함수 호출
            location.reload(true);
         });
         // 채팅방에 입장할 때 서버에 이전 메시지 요청
         $.ajax({
            url : '/chat/getRecentMessages', // 메세지를 요청할 서버의 URL
            method : 'GET', // HTTP 메소드
            data : {
               roomId : Chat__roomId, // 지금 방 ID
            },
            success : function(data) {
               // 성공적으로 메세지를 받으면, 각 메세지에 대해 화면에 draw
               data.messages.forEach(function(message) {
                  Chat__drawMessage(message);
               });
            }
         });
      });
   }

   function disconnect() {
      if (stompClient != null) {
         stompClient.disconnect();
      }
      console.log("DisConnected");
   }

   // 폼이 발송되기 전에 한번씩 실행.
   // 즉 엔터 한번 칠떄 마다 실행.
   function Chat__addMessage(body) {
      var writer = '${username}'; // 모델에서 username 사용
      console
            .log(`Sending message to /app/chat.sendMessage: roomId=${Chat__roomId}, writer=${writer}, body=${body}`);
      //console.log(`Sending message to /app/chat.sendMessage: roomId=${Chat__roomId}, writer=${writer}, body=${body}`);
      stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
         'roomId' : Chat__roomId,
         'writer' : writer,
         'body' : body
      }));
      //location.reload(true);
      /* $.post(
            '/chat/doAddMessage',
            {
               roomId:Chat__roomId,
               writer:writer,
               body:body
            },
            function(data) {
               //console.log(data.msg)
               
            },
            'json'
         ); */
   }

   $(document).ready(function() {
      connect();
      
   });
   
   
   $('#chat_rooms').click(function() {
      window.location.href = '/chat/rooms'; // chat/rooms로 이동
   });
   $(window).on('beforeunload', function() {
      disconnect();
   });

   function Chat__drawMessage(chatMessage) {
      // 현재 방의 roomId와 메시지가 속한 roomId가 다른 경우, 메시지를 무시합니다.
      if (chatMessage.roomId !== Chat__roomId) {
         return;
      }

      var messageElement;
      var readStatusHtml = '';
       var username = '${username}';
      // 여기서 'myName' 대신 실제 현재 사용자의 이름을 어떻게 알 수 있는지에 따라 로직을 추가합니다.
      // 'myName'은 예시이므로, 실제 구현에서는 현재 사용자의 실제 이름을 가져오는 코드로 대체해야 합니다.
      if (chatMessage.writer === '${username}') {
         messageElement = $('<div class="message me"></div>');               // 읽음                                              // 읽지않음
         var readStatusHtml1 = chatMessage.isRead ? '<span class="read-status"><i class="uil uil-check-circle"></i></span>' : '<span class="read-status"><i class="uil uil-circle"></i></span>';
         //alert(readStatusHtml1);      
         console.log(readStatusHtml1);
      } else {
         messageElement = $('<div class="message other"></div>');
         readStatusHtml1 = "";
         readStatusHtml = '<strong>' + chatMessage.writer + '</strong>: ';
      }

      var timeStr = '시간 정보 없음';
      if (chatMessage.messageTime) {
         var date = new Date(chatMessage.messageTime);
         timeStr = date.toLocaleString('ko-KR', {
            hour : '2-digit',
            minute : '2-digit',
            hour12 : true
         });
      }
      
       var html = readStatusHtml + chatMessage.body + ' (' + timeStr + ')' + readStatusHtml1;
          messageElement.html(html);

      $('.chat-Message').append(messageElement);
      scrollToBottom();
   }

   //var Chat__lastLoadedMessageId = 0;

   // loadMessage => 이때까지 쓴 모든 채팅을 불러오는것, 내가 원하는건 새로운 메세지만 읽어오기.
   /* function Chat__loadNewMessages() {
    $.get(
    './getMessagesFrom',
    {
    roomId:Chat__roomId,
    // 1~9번까지 불러왔으니 10번 이후로 있으면 줘라.
    //   from:10
    from:Chat__lastLoadedMessageId + 1
    },
    function(data) {
    for(var i = 0; i <data.messages.length; i++){
    Chat__drawMessage(data.messages[i]);
   
    Chat__lastLoadedMessageId = data.messages[i].id;
    }      
    },
    'json'
    );   
    }
   
    setInterval(Chat__loadNewMessages, 1000); */

   function scrollToBottom() {
      var chatMessageContainer = $('.chat-Message');
      chatMessageContainer.scrollTop(chatMessageContainer
            .prop('scrollHeight'));
   }

   function submitChatMessageForm(form) {
      /* form.writer.value = form.writer.value.trim(); */

      /* if(form.writer.value.length == 0 ){
         alert('작성자를 입력해주세요.');
         form.writer.focus();
         
         return false;
      } */

      if (form.body.value.length == 0) {
         alert('내용을 입력해주세요.');
         form.body.focus();

         return false;
      }

      /* var writer = form.writer.value; */
      var body = form.body.value;

      form.body.value = '';
      form.body.focus();

      /* Chat__addMessage(writer, body); */
      Chat__addMessage(body);
   }
</script>
<!-- ICONSCOUT CDN 아이콘 사이트 CDN -->


<!-- STYLESHEET 스타일 시트 css 적용-->
<!--  link rel="stylesheet" href="./style.css"-->
<link rel="stylesheet" type="text/css" href="/chat_style.css" />


</head>
  <!---  상단 ---->
    <nav>
        <div class="container">
                	    <img class="logimg" src="/images/log.png">	
            
                <!-- 상단 왼쪽 로고 -->
            
                    
              
         <div class="search-bar">
           	<i class="uil uil-search"></i> <input type="search"
					placeholder="검색어를 입력하세요">
         </div>
         <div class="create">
            <label class="btn btn-primary" for="create-post" onclick="logout()">로그아웃</label>

         </div>

      </h2>

   </div>
</nav>

<!------------------ MAIN ------------------------>
<main>
   <div class="container">
      <!-----===========  왼쪽  =================-------->
      <div class="left">
         <!---- 프로필 ----->
         <a class="profile" href="/mypage">>
            <div class="profile-photo">
               <img src="/images/profile-${currentUser.id}.jpg">
            </div>
            <div class="handle">
               <h4>${username}님</h4>
               <p class="text-muted"></p>
            </div>

         </a>
        <!-------------- 사이드바 ---------------------->
			<div class="sidebar">
				<a href="/mainpage" class="menu-item"> <span><i
						class="uil uil-home"></i></span>
					<h3>Home</h3>
				</a> <a class="menu-item" href="/diary/todayDiary"> <span><i
						class="uil uil-compass"></i></span>
					<h3>todayDiary</h3>
				</a> <a class="menu-item" id="notifications" href="/diary/sharedDiary">
					<span><i class="uil uil-bell"></i></span>
					<h3>sharedDiary</h3> <!------------------- NOTIFICATION POPUP ---------------------->
               <div class="notifications-popup">
                  <div>
                     <div class="profile-photo">
                        <img src="/images/profile-2.jpg">
                     </div>
                     <div class="notification-body">
                        <b>Keke Benjamin</b> accepted your friend request <small
                           class="text-muted">2 DAYS AGO</small>
                     </div>
                  </div>
                  <div>
                     <div class="profile-photo">
                        <img src="/images/profile-3.jpg">
                     </div>
                     <div class="notification-body">
                        <b>John Doe</b> commented on your post <small class="text-muted">1
                           HOUR AGO</small>
                     </div>
                  </div>
                  <div>
                     <div class="profile-photo">
                        <img src="/images/profile-4.jpg">
                     </div>
                     <div class="notification-body">
                        <b>Mary Oppong</b> and <b>283 others</b> liked your post <small
                           class="text-muted">4 MINUTES AGO</small>
                     </div>
                  </div>
                  <div>
                     <div class="profile-photo">
                        <img src="/images/profile-5.jpg">
                     </div>
                     <div class="notification-body">
                        <b>Doris Y. Lartey</b> commented on a post you are tagged <small
                           class="text-muted">2 DAYS AGO</small>
                     </div>
                  </div>
                  <div>
                     <div class="profile-photo">
                        <img src="/images/profile-6.jpg">
                     </div>
                     <div class="notification-body">
                        <b>Donald Trump</b> commented on a post you are tagged <small
                           class="text-muted">1 HOUR AGO</small>
                     </div>
                  </div>
                  <div>
                     <div class="profile-photo">
                        <img src="/images/profile-7.jpg">
                     </div>
                     <div class="notification-body">
                        <b>jane Doe</b> commented on your post <small class="text-muted">1
                           HOUR AGO</small>
                     </div>
                  </div>
               </div> <!----------------------- END NOTIFICATION POPUP -------------------->
           	</a> <a class="menu-item active" id="messages-notifications"
					href="/chat/rooms"> <span><i
						class="uil uil-envelope-alt"><small
							class="notification-count">6</small></i></span>
				<h3>Message</h3>
				</a> <a class="menu-item" href="/friends"> <span><i
						class="uil uil-bookmark"></i></span>
				<h3>friends</h3>
				</a> <a class="menu-item" href="/diary/lastDiary"> <span><i
						class="uil uil-chart-line"></i></span>
				<h3>lastDiary</h3>
				</a> <a class="menu-item"> <span><i class="uil uil-palette"></i></span>
				<h3>미정</h3>
				</a> <a class="menu-item"> <span><i class="uil uil-setting"></i></span>
				<h3>미정</h3>
				</a>
			</div>
         <!--------------------- 사이드바 끝 ----------------------->

      </div>


      <!-------================= 중앙 ===============-------->
      <div class="middle">
         <h1 class="con"> 
        <c:choose>
            <c:when test="${chatRoom.user1.username eq username}">
                ${chatRoom.user1RoomName}
            </c:when>
            <c:otherwise>
                ${chatRoom.user2RoomName}
            </c:otherwise>
        </c:choose>
    </h1>
         <!-- param. 을 사용해 jsp에서 바로 값을 가져올수도 있음.
   <h1 class="con">${param.roomId} 번방</h1>
   -->

         <div class="chat-Message"></div>
         <br>
         <hr>
         <br>
         <form onsubmit="submitChatMessageForm(this); return false;">
            <div class="chat-input-container">
               <input type="text" name="body" placeholder="내용을 입력하세요..."
                  class="chat-input" autocomplete="off" />
               <button type="submit" class="chat-send-button">전송</button>
            </div>
         </form>
      </div>



      <!--  ================= END OF MIDDLE ================= -->
      <!--  ================= END OF MIDDLE ================= -->

      <!--  ============RIGHT ============ -->
      <div class="right">
         <!-- 사용자 목록 -->
         <div class="user-list">
            <div class="heading">
               <h4>사용자 목록</h4>
               <i class="uil uil-edit"></i>
            </div>
            <!-- 사용자 검색창 -->
            <div class="search-bar">
               <i class="uil uil-search"></i> <input type="search"
                  placeholder="사용자 검색" id="user-search">
            </div>
            <!-- 사용자 목록 아이템 -->
            <div class="list">
               <c:forEach var="user" items="${allUsers}">
                  <div class="user" onclick="startChatWith('${user.id}')">
                     <div class="profile-photo">
                        <img src="/images/profile-${user.id}.jpg"
                           onerror="this.src='/images/default-profile.jpg';">
                     </div>
                     <div class="username">
                        <h5>${user.name}</h5>
                     </div>
                  </div>
               </c:forEach>
            </div>
         </div>
         <!--  -----------END OF MESSAGES------------ -->



         <!--  ----------- FRIEND REQUESTS ------------ -->
         <div class="friend-requests">
            <h4>Requests</h4>



         </div>


      </div>
   </div>
</main>