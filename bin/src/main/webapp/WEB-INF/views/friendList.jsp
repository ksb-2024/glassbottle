<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>친구 목록</title>
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
</head>
<body>
    <h1>친구 목록</h1>
    <input type="text" id="searchInput" placeholder="친구 이름 검색">
    <button onclick="searchFriends()">검색</button>

    <div id="friendList"></div>

    <script>
        function loadFriends() {
            // 사용자의 친구 목록 가져오기
    		
            // 서버 사이드에서 설정된 사용자 ID
    		var currentUserId = '${loggedInUserId}'; // JSP ID 예시

            fetch('/api/friends/list/' + currentUserId) // currentUserId는 현재 로그인한 사용자의 ID
            .then(function(response) {
                return response.json();
            })
            .then(function(friends) {
                var list = document.getElementById("friendList");
                list.innerHTML = ""; // 리스트 초기화
            	 // 친구 목록을 렌더링하는 부분
                friends.forEach(function(friend) {
                    var friendDiv = document.createElement('div');
                    friendDiv.className = 'friend-item';
                    friendDiv.id = 'friend-' + friend.id; // 친구의 고유한 사용자 ID를 설정
                    friendDiv.innerHTML = `<span>${friend.name}</span>`; // 친구 이름

                    var deleteBtn = document.createElement('button');
                    deleteBtn.innerText = '친구 삭제';
                    deleteBtn.onclick = function() {
                        deleteFriend(friend.id); // 친구 삭제 함수 호출
                    };

                    friendDiv.appendChild(deleteBtn);
                    list.appendChild(friendDiv);
                });
            .catch(function(error) {
                console.error('Error:', error);
            });
        }

        function deleteFriend(friendId) {
            fetch('/api/friends/delete/' + friendId, {
                method: 'DELETE', 
                headers: {
                    'Content-Type': 'application/json',
                    // 필요한 경우 인증 토큰(security 사용하니까 필요함)
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(response => {
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

</body>
</html>
