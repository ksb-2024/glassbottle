<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>친구 추가 및 블랙리스트 추가</title>
</head>
<body>
    <h1>사용자 검색</h1>
    <input type="text" id="searchInput" placeholder="사용자 이름 입력">
    <button onclick="searchFriends()">검색</button>

    <h2>검색 결과</h2>
    <div id="searchResults"></div>
	<b></b>
	<b></b>
	<b></b>
	<button onclick="location.href='friendList.jsp'">친구 목록 보기</button>
	<b></b>
	<b></b>
	<b></b>
	<button onclick="location.href='blackList.jsp'">블랙리스트 목록 보기</button>
    <script>
    function searchFriends() {
        var name = document.getElementById("searchInput").value;
        fetch('/api/friends/search?name=' + encodeURIComponent(name))
            .then(function(response) {
                return response.json();
            })
            .then(function(users) {
                var results = document.getElementById("searchResults");
                results.innerHTML = ""; // 이전 검색 결과 초기화
                
                var currentUserId = '${loggedInUserId}'; // 로그인한 사용자의 ID
                /* 이걸 security로 했으면 그에 맞게 고쳐야함. 로그인한 사용자의 ID */;

                users.forEach(function(user) {
                    var userDiv = document.createElement('div');
                    userDiv.innerHTML = user.name + " - " + user.id;

                    var friendRequestBtn = document.createElement('button');
                    friendRequestBtn.innerText = '친구 요청 보내기';
                    friendRequestBtn.onclick = function() {
                        sendFriendRequest(currentUserId, user.id);
                    };

                    var blacklistBtn = document.createElement('button');
                    blacklistBtn.innerText = '블랙리스트 추가';
                    blacklistBtn.onclick = function() {
                        addToBlacklist(user.id);
                    };

                    userDiv.appendChild(friendRequestBtn);
                    userDiv.appendChild(blacklistBtn);

                    results.appendChild(userDiv);
                });
            })
            .catch(function(error) {
                console.error('Error:', error);
            });
    }

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
        .then(text => alert(text))
        .catch(error => console.error('Error:', error));
    }


    function addToBlacklist(userId) {
        fetch('/api/friends/blacklistUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ userId: userId })
        })
        .then(response => response.text())
        .then(text => alert(text))
        .catch(error => console.error('Error:', error));
    }
    </script>

</body>
</html>

