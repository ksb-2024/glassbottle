<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
</script>
<script>
$(document).ready(function(){
	console.log("left!");
	$.ajax({
		url:"/diary/noReadCheck",
		type:"GET",
		success:function(data){
			console.log(data);
			if(data != '0'){ 
				var text = "<small class='notification-count' id='noReadCount'>" + data + "</small>";
				$(".uil-bell").append(text);
			}
		},
		error:function(){
			console.log("noReadCheck error");
		}
	});
});
</script>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE-edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유리병-친구</title>
<!-- ICONSCOUT CDN 아이콘 사이트 CDN -->

<link rel="stylesheet"
	href="https://unicons.iconscout.com/release/v4.0.8/css/line.css">
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.1.0/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel='stylesheet'
	href='https://cdn-uicons.flaticon.com/2.1.0/uicons-bold-rounded/css/uicons-bold-rounded.css'>
<!-- STYLESHEET 스타일 시트 css 적용-->
<link rel="stylesheet" href="friendsstyle.css">
</head>

 <!---  상단 ---->
    <nav>
        <div class="container">
                	    <img class="logimg" src="./images/log.png">	
            
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
					         <img src="./images/profile-1.jpg">
				</div>
				<div class="handle">
					<h4>${username}님</h4>
					<p class="text-muted"></p>
				</div>

			</a>
			<!-------------- 사이드바 ---------------------->
	                <div class="sidebar">
                    <a class="menu-item " href="/mainpage">
                        <span><i class="uil uil-home"></i></span><h3>Home</h3>
                    </a>
                    <a class="menu-item" href="/diary/todayDiary">
                        <span><i class="uil uil-compass"></i></span><h3>todayDiary</h3>
                    </a>
                    <a class="menu-item" id="notifications" href="/diary/sharedDiary">
                        <span><i class="uil uil-bell"></i></span><h3>sharedDiary</h3>
				 <!------------------- NOTIFICATION POPUP ---------------------->
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
					</div>
				   <!----------------------- END NOTIFICATION POPUP -------------------->
                    </a>
                    <a class="menu-item" id="messages-notifications" href="/chat/rooms">
                        <span><i class="uil uil-envelope-alt" ><small class="notification-count">6</small></i></span><h3>Message</h3>
                    </a>
                    <a class="menu-item active" href="/friends">
                        <span><i class="uil uil-bookmark"></i></span><h3>friends</h3>
                    </a>
                    <a class="menu-item">
                        <span><i class="uil uil-chart-line"></i></span><h3>lastDiary</h3>
                    </a>
                    <a class="menu-item">
                        <span><i class="uil uil-palette"></i></span><h3>미정</h3>
                    </a>
                    <a class="menu-item">
                        <span><i class="uil uil-setting"></i></span><h3>미정</h3>
                    </a>
                </div>
			<!--------------------- 사이드바 끝 ----------------------->

		</div>



		<!-------================= 중앙 ===============-------->
		<div class="middle">
			<div class="heading">	
			<button onclick="location.href='/friendsList'">친구 목록</button>
			<button onclick="location.href='/blacklist'">블랙리스트</button>
			<button class="active" onclick="location.href='/friendRequest'">친구 요청</button>
			</div>


<!--     <input type="text" id="searchInput" placeholder="친구 이름 검색">
    <button onclick="searchFriends()">검색</button> -->
	<div class="search-bar">
	<i class="uil uil-search"></i> <input type="search"
	placeholder="이름 검색" id="user-search" onkeydown="handleKeyDown(event)">
	</div>
	
			<!-- Chat Room List -->
			<div id="chatRoomSection" class="chatRoomSection">

    <div id="friendRequestList"></div>

    <script>
    function loadFriendRequests() {
        var currentUserId = '${userid}';
        fetch('/api/friends/requests/' + currentUserId)
            .then(response => response.json())
            .then(requests => {
                var list = document.getElementById("friendRequestList");
                console.log("friendRequestList = 임형수 " + list)
                list.innerHTML = "";
                console.log("friendRequstList.jsp파일 디버깅 완료");
                console.log(requests)
                console.log("request를 받는가?" + requests)
                requests.forEach(function (request) {
                    console.log("확인" + request);
                    console.log("567");

                    var requestDiv = document.createElement('div');
                    requestDiv.id = 'request-item-' + request.id;
                    requestDiv.className = 'request-item profile-info'; // .request-item 및 .profile-info 클래스 추가

                    // 프로필 사진과 메시지를 담을 div
                    var profileMessageDiv = document.createElement('div');
                    profileMessageDiv.className = 'profile-message-div';

                    // 프로필 사진 추가
                    var profilePhotoDiv = document.createElement('div');
                    profilePhotoDiv.className = 'profile-photo';
                   // ★★★★프로필이미지 수정해야합니다★★★★
                    var profilePhotoImg = document.createElement('img');
                    profilePhotoImg.src = './images/profile-' + ${id} + '.jpg';
                    profilePhotoImg.onerror = function() {
                        this.src = './images/profile-1.jpg';
                    };

                    profilePhotoDiv.appendChild(profilePhotoImg);
                    profileMessageDiv.appendChild(profilePhotoDiv);

                    // 친구 요청 메시지 추가
                    var messageDiv = document.createElement('div');
                    messageDiv.className = 'friend-request-message';
                    messageDiv.innerText = request.requesterName + ' 님이 친구 요청을 보냈습니다.';

                    profileMessageDiv.appendChild(messageDiv);
                    requestDiv.appendChild(profileMessageDiv);

                    // 버튼들을 감싸는 div 추가
                    var buttonsDiv = document.createElement('div');
                    buttonsDiv.className = 'profile-info-buttons'; // 추가한 div에 클래스 추가

                    var acceptBtn = document.createElement('button');
                    acceptBtn.innerHTML = '<i class="fi fi-br-check"></i>';
                    acceptBtn.onclick = function () {
                        acceptFriendRequest(request.id, request.requesterId, currentUserId);
                    };

                    var rejectBtn = document.createElement('button');
                    rejectBtn.innerHTML = '<i class="fi fi-br-cross"></i>';
                    rejectBtn.onclick = function () {
                        rejectFriendRequest(request.id);
                    };

                    buttonsDiv.appendChild(acceptBtn);
                    buttonsDiv.appendChild(rejectBtn);

                    requestDiv.appendChild(buttonsDiv);
                    list.appendChild(requestDiv);
                });

            })
            .catch(error => console.error('Error:', error));
    }
		
        //친구 요청 수락 api
        function acceptFriendRequest(requestId, requesterId, currentUserId) {
            fetch('/api/friends/accept', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    // 인증 토큰이 필요한 경우 여기에 추가합니다.
                },
                body: JSON.stringify({ 
                    id: requestId,
                    requesterId: requesterId,
                    requestedId: currentUserId, // 현재 로그인한 사용자의 ID를 추가
                    status: 'ACCEPTED' 
                })
            })
            .then(response => {
                if (response.ok) {
                    var requestDiv = document.getElementById('request-item-' + requestId);
                    if (requestDiv) {
                        requestDiv.remove(); // 요청 항목 제거
                    }
                    alert("성공");
                } else {
                    throw new Error('Network response was not ok.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
		
        //수정 버전
        //친구 요청 거절 api
    function rejectFriendRequest(requestId) {
        var currentUserId = '${username}';
        console.log("rejectFriendRequest 첫번째 디버깅" + requestId)
        fetch('/api/friends/reject/' + currentUserId + '/' + requestId, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
                // 인증 토큰이 필요한 경우 여기에 추가합니다.
            }
        })
        .then(response => {
            if (response.ok) {
                // 요청 항목을 DOM에서 제거
                var requestDiv = document.getElementById('request-item-' + requestId);
                if (requestDiv) {
                    requestDiv.remove();
                }
                console.log("rejectFriendRequest 두번째 디버깅 요청이 거절 완료")

                alert("친구 요청이 거절되었습니다.");
            } else {
                throw new Error('Network response was not ok.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
    // 페이지 로드 시 친구 요청 목록을 불러오도록 설정
    window.onload = loadFriendRequests;

</script>
			

		</div>
		</div>



		<!--  ================= END OF MIDDLE ================= -->
		<!--  ================= END OF MIDDLE ================= -->

		<!--  ============RIGHT ============ -->
		<div class="right">
		<h4>사용자 검색</h4>
   		<div class="search-bar">
					<i class="uil uil-search"></i> <input type="search"
						placeholder="사용자 검색" id="searchInput" onkeydown="handleKeyDown(event)">
				</div>

  <!--  미관상 검색버튼보다 엔터로 검색하는게 좋아보입니다 .. ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ 
  <button onclick="searchFriends()">검색</button> -->
	
<!--     <h2>검색 결과 페이지</h2> -->
    <div id="searchResults"></div>
	<b></b>
	<b></b>
	<b></b>
	<b></b>
	<b></b>
	<b></b>

    
    <script>
    
    function handleKeyDown(event) {
        if (event.key === 'Enter') {
            searchFriends();
        }
    }
    
    //수정 버전
    //전체 유저 검색
	// 사용자 검색 및 결과 표시
function searchFriends() {
          var name = document.getElementById("searchInput").value;
          var currentUsername = '${username}'; // 서버 사이드에서 설정된 사용자 ID
           var currentUserId = "${userid}"
               fetch('/api/friends/searchWithStatus/' + currentUserId + '?name=' + encodeURIComponent(name))
                .then(response => response.json())
                .then(data => {
                    var results = document.getElementById("searchResults");
                    results.innerHTML = "";

                    data.forEach(item => {
                        var user = item.user;

                        // 현재 로그인한 사용자와 검색된 사용자가 동일한 경우, 결과 목록에 추가하지 않음
                        if (user.id != currentUserId) {
                            var userDiv = document.createElement('div');
                            userDiv.innerHTML = user.username + " - " + user.name;

                            // 친구 관계에 따른 버튼 표시
                            if (!item.isFriend && !item.isFriendRequestSent && !item.isBlacklisted) {
                                var friendRequestBtn = createButton('친구 요청 보내기', () => sendFriendRequest(currentUserId, user.id));
                                var blacklistBtn = createButton('블랙리스트 추가', () => addToBlacklist(currentUserId, user.id));
                                userDiv.appendChild(friendRequestBtn);
                                userDiv.appendChild(blacklistBtn);
                            } else if (item.isFriendRequestSent) {
                                userDiv.appendChild(createButton('친구 요청 보냄', null, true));
                            } else if (item.isFriend) {
                                userDiv.appendChild(createButton('친구', null, true));
                            } else if (item.isBlacklisted) {
                                userDiv.appendChild(createButton('블랙리스트에 추가됨', null, true));
                            }

                            results.appendChild(userDiv);
                        }
                    });
                })
                .catch(error => console.error('Error:', error));
        }

	function createButton(text, onClick, isDisabled = false) {
	    var btn = document.createElement('button');
	    btn.innerText = text;
	    if (onClick && !isDisabled) btn.onclick = onClick;
	    if (isDisabled) btn.disabled = true;
	    return btn;
	}
    
	//친구 요청
    function sendFriendRequest(requesterId, requestedId) {
        fetch('/api/friends/request', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                requesterId: requesterId, 
                requestedId: requestedId,
                status: 'PENDING' // 상태 pending
            })
        })
        .then(response => response.text())
        .catch(error => console.error('Error:', error));
    }
	
	//수정 버전
	//블랙리스트 추가
    
		function addToBlacklist(currentUserId, userId) {
		    fetch('/api/friends/blacklistUser', {
		        method: 'POST',
		        headers: {
		            'Content-Type': 'application/json',
		        },
		        body: JSON.stringify({ 
		            ownerId: currentUserId, 
		            userId: userId 
		        })
		    })
		    .then(response => {
		        if (response.ok) {
		            alert('블랙리스트에 추가되었습니다.');
		            window.location.reload(); // 페이지 리로딩
		        } else {
		            alert('블랙리스트 추가에 실패했습니다.');
		        }
		    })
		    .catch(error => console.error('Error:', error));
		}

	
        function removeUserFromSearchResults(userId) {
            var userDiv = document.getElementById('user-' + userId);
            if (userDiv) {
                userDiv.remove();
            }
        }
    
      //실시간 알림
        var stompClient = null;
        var currentUser = "${userid}"; // 사용자 B의 식별자
        
     // 웹소켓 메시지를 받았을 때 실행되는 함수
        function onMessageReceived(msg) {
            var message = JSON.parse(msg.body);
            displayNotification(message);
        }

        // 알림을 화면에 표시하는 함수
        function displayNotification(message) {
            var notificationsContainer = document.getElementById('notifications-container');
            if (!notificationsContainer) {
                // 알림 컨테이너가 없으면 생성
                notificationsContainer = document.createElement('div');
                notificationsContainer.id = 'notifications-container';
                document.body.appendChild(notificationsContainer);
            }

            // 알림 요소 생성
            var notification = document.createElement('div');
            notification.className = 'notification';
            notification.innerText = message.content; // 메시지 내용 설정

            // 알림을 컨테이너에 추가
            notificationsContainer.appendChild(notification);

            // 일정 시간 후 알림 사라지게 설정
            setTimeout(function() {
                notificationsContainer.removeChild(notification);
            }, 5000); // 5초 후 알림 제거
        }

        // 웹소켓 연결 및 구독 설정
        function connectWebSocket() {
        	  var socket = new SockJS('/ws-glass');
        	    stompClient = Stomp.over(socket);
        	    
        	    stompClient.connect({}, function (frame) {
        	        console.log('Connected to glass bottle: ' + frame);
        	        stompClient.subscribe('/user/' + currentUser + '/queue/notifications', onMessageReceived);
        	    });
        }
        
        connectWebSocket();
        
        function subscribeToNotifications(currentUser) {
            stompClient.subscribe('/user/' + currentUser + '/queue/notifications', function (notification) {
                alert(notification.body);
            });
        } 
        	

    </script>
		
		
			</div>
			<!--  -----------END OF MESSAGES------------ -->



			<!--  ----------- FRIEND REQUESTS ------------ -->

		</div>

</main>