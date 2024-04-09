<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.springproj.emotionshare.chat.ChatRoom"%>
<%@ page import="com.springproj.emotionshare.domain.UserEntity"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	// 채팅방 목록을 업데이트하는 함수
	function updateChatRoomList(message) {
		// 채팅방 목록에서 해당 채팅방을 찾아 마지막 메시지를 업데이트
		var roomId = message.roomId;
		var writer = message.writer;
		var body = message.body;
		var messageTime = new Date(message.messageTime); // Date 객체로 변환
		var chatRoomElement = $("#room-" + roomId);
		if (chatRoomElement.length) {
			// 이미 목록에 있는 채팅방인 경우, 목록의 맨 위로 이동
			$("#chatRoomSection ul").prepend(chatRoomElement);
		} else {
			// 새 채팅방이라면 목록의 맨 위에 추가

		}

		// 날짜 포매팅
		var lastMessageTimeStr = messageTime.toLocaleString('ko-KR', {
			hour : '2-digit',
			minute : '2-digit',
			hour12 : true,
			timeZone : 'Asia/Seoul'
		});

		var lastMessage = writer + ": " + body + " (" + lastMessageTimeStr
				+ ")";
		$("#room-" + roomId + " .last-message").text(lastMessage);

	}
	function startChatWith(userId) {
		// 채팅방 생성 또는 이동 로직
		$.get("/chat/room/createOrGet", {
			userId : userId
		}, function(data) {
			if (data.resultCode === 'S-1') {
				// 채팅방으로 이동
				window.location.href = "/chat/room?roomId="
						+ data.chatRoom.roomId;
			} else {
				alert("Error occurred: " + data.msg);
			}
		});
	}

	$(document).ready(function() {
		// WebSocket 연결 및 구독 설정
		var socket = new SockJS('/ws');
		var stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			console.log('Connected: ' + frame);

			// 채팅방 목록 업데이트를 위한 구독
			stompClient.subscribe('/topic/lastMessage', function(chatMessage) {
				var message = JSON.parse(chatMessage.body);
				updateChatRoomList(message);
			});
		});
	});

	$(document).ready(function() {
		// 채팅방 생성
		$("#createRoomBtn").click(function() {
			var roomName = $("#roomName").val();
			$.post("/chat/room/create", {
				name : roomName
			}, function(data) {
				if (data.resultCode === 'S-1') {
					alert(data.msg);
					location.reload(); // 페이지 새로고침
				} else {
					alert("Error occurred: " + data.msg);
				}
			});
		});

		// 채팅방 입장
		$(".enterRoom").click(function() {
			var roomId = $(this).attr("data-roomId");
			window.location.href = "/chat/room?roomId=" + roomId; // 해당 채팅방 페이지로 이동
		});
	});
	function logout() {
		// Perform any additional logout actions if needed

		// Redirect to the "/logout" URL
		window.location.href = "/logout";
	}
</script>
<script>
	$(document)
			.ready(
					function() {
						console.log("left!");
						$
								.ajax({
									url : "/diary/noReadCheck",
									type : "GET",
									success : function(data) {
										console.log(data);
										if (data != '0') {
											var text = "<small class='notification-count' id='noReadCount'>"
													+ data + "</small>";
											$(".uil-bell").append(text);
										}
									},
									error : function() {
										console.log("noReadCheck error");
									}
								});
					});
</script>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ChatMessage</title>
<!-- ICONSCOUT CDN 아이콘 사이트 CDN -->

<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
<!-- STYLESHEET 스타일 시트 css 적용-->
<!--  link rel="stylesheet" href="./style.css"-->
<link rel="stylesheet" type="text/css" href="/chat_style.css" />

</head>
<!---  상단 ---->
<nav>
	<div class="container">
		<img class="logimg" src="/images/log.png">

		<!-- 상단 왼쪽 로고 -->


		<!-- 상단 검색창 -->
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
			<!-- Chat Room List -->
			<div id="chatRoomSection" class="chatRoomSection">
				<h1 class="heading">채팅방 목록</h1>
				<ul id="chatRoomList">
					<c:forEach var="room" items="${chatRooms}">
						<li id="room-${room.roomId}"
							onclick="location.href='/chat/room?roomId=${room.roomId}'"
							class="chat-room">

							<div class="room-info">
								<div class="profile-photo">
									<img src="/images/profile-${room.roomId }.jpg"
										onerror="this.src='/images/default-profile.jpg';">

								</div>
								<!-- 안 읽은 메시지 수를 표시하는 부분-->
								<c:if test="${unreadMessageCounts[room.roomId] > 0}">
									<span class="unread-count">${unreadMessageCounts[room.roomId]}</span>
								</c:if>
								<%-- 사용자별 채팅방 이름 표시 조건부 로직 --%>
								<c:choose>
									<c:when test="${room.user1.username eq username}">
										<span>${room.user1RoomName}</span>
									</c:when>
									<c:otherwise>
										<span>${room.user2RoomName}</span>
									</c:otherwise>
								</c:choose>
								<a href="/chat/room?roomId=${room.roomId}"></a>
								<div class="last-message">
									<c:forEach items="${latestMessages}" var="message">
										<c:if test="${message[0] == room.roomId}">
											<p>${message[1]}
												: ${message[2]} (
												<fmt:formatDate value="${message[3]}" pattern="a HH:mm"
													type="both" timeZone="Asia/Seoul" />
												)
											</p>
										</c:if>
									</c:forEach>
								</div>
							</div>

						</li>
					</c:forEach>
				</ul>
			</div>
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