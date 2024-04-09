<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js">
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
<style>
#friendList {
	overflow-y: auto; /* 스크롤 가능하게 */
	max-height: 400px; /* 적당한 최대 높이 설정 */
}

.friend-item {
	display: flex;
	justify-content: space-between; /* 이름 왼쪽, 버튼 오른쪽 정렬 */
	margin-bottom: 10px; /* 각 아이템 사이의 마진 */
}
</style>
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
				<a class="menu-item" href="/mainpage"> <span><i
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
				</a> <a class="menu-item" id="messages-notifications" href="/chat/rooms">
					<span><i class="uil uil-envelope-alt"><small
							class="notification-count">6</small></i></span>
				<h3>Message</h3>
				</a> <a class="menu-item active" href="/friends"> <span><i
						class="uil uil-bookmark"></i></span>
				<h3>friends</h3>
				</a> <a class="menu-item"> <span><i
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
				<div class="heading">
					<button onclick="location.href='/friendsList'">친구 목록</button>
					<button class="active" onclick="location.href='/blacklist'">블랙리스트</button>
					<button onclick="location.href='/friendRequest'">친구 요청</button>
				</div>


				<div class="search-bar">
					<i class="uil uil-search"></i> <input type="search"
						placeholder="이름 검색" id="user-search"
						onkeydown="handleKeyDown(event)">
				</div>
				<div id="blacklist"></div>
				<!-- 	<div id = "searchResults"></div> -->

				<script>
    
    // 수정 버전
    //블랙리스트 전체 리스트 로드하기
window.onload = function loadBlacklist() {
    var currentUserId = '${userid}'; // 서버 사이드에서 설정된 사용자 ID
   console.log('userid : ' + currentUserId);
    fetch('/api/friends/blacklist/' + currentUserId)
        .then(function(response) {
            return response.json();
        })
        .then(function(blacklistUsers) {
            console.log("블랙리스트 전체 리스트 로드하기 첫번째 디버깅" + blacklistUsers);

            var list = document.getElementById("blacklist");
            list.innerHTML = "";

            blacklistUsers.forEach(function(user) {
               var userDiv = document.createElement('div');
                userDiv.className = 'blacklist-item';
                userDiv.id = 'blacklist-user-' + user.id; // ID 할당
               

                // 프로필 사진 및 user.id를 묶는 div
                var profileInfoDiv = document.createElement('div');
                profileInfoDiv.className = 'profile-info';

                // 프로필 사진
                var profilePhotoDiv = document.createElement('div');
                profilePhotoDiv.className = 'profile-photo';

                // ★★★★프로필이미지 수정해야합니다★★★★
                var profilePhotoImg = document.createElement('img');
                profilePhotoImg.src = './images/profile-' + ${id} + '.jpg';
                profilePhotoImg.onerror = function() {
                    this.src = './images/profile-1.jpg';
                };


                profilePhotoDiv.appendChild(profilePhotoImg);
                profileInfoDiv.appendChild(profilePhotoDiv);

                // user.id
                var userIdSpan = document.createElement('span');
                userIdSpan.innerText = user.name;
                profileInfoDiv.appendChild(userIdSpan);

                userDiv.appendChild(profileInfoDiv);

                // 블랙리스트 삭제 버튼
                var removeBtn = document.createElement('button');
                removeBtn.innerHTML = '<i class="fi fi-br-cross"></i>'; // fi-br-cross 아이콘 사용
                removeBtn.onclick = function() {
                    removeFromBlacklist(currentUserId, user.id);
                };

                userDiv.appendChild(removeBtn);
                list.appendChild(userDiv);
            });
        })
        .catch(function(error) {
            console.error('Error:', error);
        });
}


    
  //수정 버전
    //블랙리스트 검색창 api 
	function searchBlacklistUsers() {
    var name = document.getElementById("searchInput").value;
    var currentUserId = '${userid}'; // 현재 사용자 ID
    var blacklistContainer = document.getElementById("blacklist"); // 기존 블랙리스트 컨테이너
    var resultsContainer = document.getElementById("searchResults"); // 검색 결과 컨테이너

    fetch('/api/friends/blacklist/search/' + currentUserId + '?name=' + encodeURIComponent(name))
        .then(response => response.json())
        .then(users => {
            resultsContainer.innerHTML = ""; // 이전 검색 결과 초기화

            // 검색 결과가 있을 경우, 기존 블랙리스트 숨기기
            if (users.length > 0) {
                blacklistContainer.style.display = 'none';
            } else {
                blacklistContainer.style.display = 'block'; // 검색 결과가 없으면 기존 블랙리스트를 다시 보여줌
            }

            users.forEach(user => {
                var userDiv = document.createElement('div');
                userDiv.className = 'blacklist-search-item';
                userDiv.id = 'blacklist-user-' + user.id; // 고유한 ID 할당
                userDiv.innerHTML = '<span>' + user.name + '</span>'; 

                var removeBtn = document.createElement('button');
                removeBtn.innerText = '블랙리스트에서 제거';
                removeBtn.onclick = function() {
                    removeFromBlacklist(currentUserId, user.id);
                };

                userDiv.appendChild(removeBtn);
                resultsContainer.appendChild(userDiv);
            });

            if (users.length === 0) {
                resultsContainer.innerHTML = '<p>검색 결과가 없습니다.</p>';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            resultsContainer.innerHTML = '<p>검색 중 오류가 발생했습니다.</p>'; 
            blacklistContainer.style.display = 'block'; // 오류가 발생하면 기존 블랙리스트를 다시 보여줌
        });
	 }
	
    //수정 버전
 	// 블랙리스트에서 사용자 제거 함수 수정
    function removeFromBlacklist(currentUserId, blockedId) {
        fetch('/api/friends/removeFromBlacklist/' + currentUserId + '/' + blockedId, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => {
            if (response.ok) {
                // 페이지를 새로 고침하여 최신 상태의 블랙리스트를 보여줌
                location.reload();
            } else {
                throw new Error('Something went wrong on api server!');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
 

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
    	
    
        window.onload = loadBlacklist;
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
					placeholder="사용자 검색" id="searchInput"
					onkeydown="handleKeyDown(event)">
			</div>

			<!--  미관상 검색버튼보다 엔터로 검색하는게 좋아보입니다 .. ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ 
  <button onclick="searchFriends()">검색</button> -->

			<!--     <h2>검색 결과 페이지</h2> -->
			<div id="searchResults"></div>
			<b></b> <b></b> <b></b> <b></b> <b></b> <b></b>


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
    

    </script>


		</div>
		<!--  -----------END OF MESSAGES------------ -->


		<!--  ----------- FRIEND REQUESTS ------------ -->

	</div>

</main>