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
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.1.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
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
  
			<div class="search-bar">
					<i class="uil uil-search"></i> <input type="search"
					placeholder="검색어를 입력하세요">
			</div>
			<div class="create">
				<label class="btn btn-primary" for="create-post" onclick="logout()">로그아웃</label>

			</div>

		

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
                    <a class="menu-item" href="/mainpage">
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
                    <a class="menu-item" href="/diary/lastDiary">
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
			<!-- Chat Room List -->
			<div class="heading">	
			
			<button class="active" onclick="location.href='/friendsList'">친구 목록</button>
		
			<button onclick="location.href='/blacklist'">블랙리스트</button>
			
			<button onclick="location.href='/friendRequest'">친구 요청</button>

			</div>
			<div id="chatRoomSection" class="chatRoomSection">
				<script>
	function goBackToFriends() {
	    window.location.href = '/friends'; // friends.jsp 페이지로 이동
	}
	</script>
<%--     <h1>친구 목록</h1>
    <h1>${username}</h1> --%>
   
<!--     <input type="text" id="searchInput" placeholder="친구 이름 검색">
    <button onclick="searchFriends()">검색</button> -->
	<div class="search-bar">
	<i class="uil uil-search"></i> <input type="search"
	placeholder="이름 검색" id="user-search" onkeydown="handleKeyDown(event)">
	</div>
	
	<!-- 기존의 코드에 이 부분을 추가 -->
	<div id="searchResultsContainer"></div>
	<div></div>
    <div id="friendList"></div>

    <script>
    function handleKeyDown(event) {
        if (event.key === 'Enter') {
            searchFriends();
        }
    }
    function createOrGetChatRoom(friendId) {
        $.ajax({
            url: '/chat/room/createOrGet',
            method: 'GET',
            data: { userId: friendId },
            success: function(response) {
                if(response.resultCode === 'S-1') {
                    window.location.href = '/chat/room?roomId=' + response.chatRoom.roomId;
                } else {
                    alert("Error occurred: " + response.msg);
                }
            },
            error: function(xhr, status, error) {
                alert("An error occurred: " + error);
            }
        });
    }
    //유저 본인의 친구 목록 불러오기
    function loadFriends() {
        var currentUserId = '${userid}'; // 로그인한 사용자의 ID
        console.log(currentUserId);
     	// 로그인한 사용자의 ID 값이 제대로 설정되었는지 확인
        if (!currentUserId) {
            console.error('The logged-in user ID is not set.');
            return;
        }

        fetch('/api/friends/list/' + currentUserId)
        .then(function(response) {
            console.log("loadFriends의 첫번째 디버깅" + response);
            return response.json();
        })
        .then(function(friends) {
            var list = document.getElementById("friendList");
            list.innerHTML = ""; // 리스트 초기화

            friends.forEach(function(friend) {
                var friendDiv = document.createElement('div');
                friendDiv.className = 'friend-item';
                friendDiv.id = 'friend-' + friend.id; // 친구의 고유한 사용자 ID를 설정

                // 프로필 사진
                var profileDiv = document.createElement('div');
                profileDiv.className = 'profile-div';

                var profilePhotoDiv = document.createElement('div');
                profilePhotoDiv.className = 'profile-photo';

                var profilePhotoImg = document.createElement('img');
                profilePhotoImg.src = './images/profile-' + ${id} + '.jpg';
                profilePhotoImg.onerror = function() {
                    this.src = './images/profile-1.jpg';
                };

                profilePhotoDiv.appendChild(profilePhotoImg);
                profileDiv.appendChild(profilePhotoDiv);
                friendDiv.appendChild(profileDiv);

                // 친구 이름
                var friendNameDiv = document.createElement('div');
                friendNameDiv.className = 'friend-name';

                var friendNameSpan = document.createElement('span');
                friendNameSpan.textContent = friend.name;

                friendNameDiv.appendChild(friendNameSpan);
                profileDiv.appendChild(friendNameDiv);

                // 버튼들을 포함할 div
                var buttonsDiv = document.createElement('div');

             // ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★"메세지 보내기" 버튼 추가★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
                var messageBtn = document.createElement('button');
                 messageBtn.innerHTML = '<i class="fi fi-rr-envelope"></i>';
               messageBtn.onclick = function() {
                createOrGetChatRoom(friend.id); // friend.id는 해당 친구의 ID
               };
               buttonsDiv.appendChild(messageBtn);

                // "친구 삭제" 버튼 추가
                 var deleteBtn = document.createElement('button');
                deleteBtn.innerHTML = '<i class="fi fi-br-cross"></i>';
                deleteBtn.onclick = function() {
                    deleteFriend(currentUserId, friend.id); // 현재 사용자 ID와 친구 ID를 함께 전달
                };
                buttonsDiv.appendChild(deleteBtn);
                // 버튼들을 friendDiv에 추가
                friendDiv.appendChild(buttonsDiv);

                list.appendChild(friendDiv);
            });
        })
        	.catch(function(error) {
            	console.error('Error:', error);
        	});
    }
    
    // 수정 버전
    //우저 본인의 친구 목록에서 유저의 친구 찾기 api
    function searchFriends() {
    var input = document.getElementById("searchInput");
    var name = input.value;
    var currentUserId = '${username}';

    // 검색 결과 컨테이너와 기존 친구 목록 컨테이너를 찾기
    var searchResultsContainer = document.getElementById("searchResultsContainer");
    var friendListContainer = document.getElementById("friendList");
	
 	// 검색 결과 컨테이너 초기화 및 기존 친구 목록 숨기기
    searchResultsContainer.innerHTML = '';
    friendListContainer.style.display = 'none'; // 기존 친구 목록을 숨기기

    fetch('/api/friends/searchInList/' + currentUserId + '?name=' + encodeURIComponent(name))
        .then(function(response) {
            if (!response.ok) {
                throw new Error('네트워크 에러 : ' + response.statusText);
            }
            return response.json();
        })
        .then(function(searchResults) {
            if (searchResults.length === 0) {
            	searchResultsContainer.innerHTML = '<p>검색 결과 없음</p>';
                friendListContainer.style.display = 'block'; // 검색 결과가 없을 때 기존 친구 목록을 다시 보여주기
            } else {
            	searchResults.forEach(function(friend) {
                    var friendDiv = document.createElement('div');
                    friendDiv.innerHTML = '<p>이름:   ' + friend.name + '</p>';
                    searchResultsContainer.appendChild(friendDiv);
                });
            }
        })
        .catch(function(error) {
        	 searchResultsContainer.innerHTML = '<p>에러</p>';
             friendListContainer.style.display = 'block'; // 에러 발생 시 기존 친구 목록을 다시 보여주기
             console.error('Error:', error);
        });
	}

    	
		// 수정 버전 
		//친구 삭제 api
       // 유저 본인의 친구 목록에서 친구 삭제 매서드
    	function deleteFriend(currentUserId, friendId) {
        	fetch('/api/friends/delete/' + currentUserId + '/' + friendId, {
            	method: 'DELETE',
            	headers: {
                	'Content-Type': 'application/json'
            		}
        		})
        		.then(response => {
        	        if (response.ok) {
        	            // 서버에서 요청이 성공적으로 처리됐을 때
        	            var friendDiv = document.getElementById('friend-' + friendId);
        	            if (friendDiv) {
        	                friendDiv.remove(); // 친구 항목 삭제
        	            }
        	            alert("친구가 목록에서 삭제되었습니다.");
        	        } else {
        	            throw new Error('Something went wrong on api server!');
        	        }
        	    })
        	    .catch(error => {
        	        console.error(error);
        	    });
        	}

        // 페이지 로드 시 친구 목록을 불러오도록 설정
        window.onload = loadFriends;
    
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
    

    </script>
		
		
			</div>
			<!--  -----------END OF MESSAGES------------ -->



			<!--  ----------- FRIEND REQUESTS ------------ -->

		</div>

</main>