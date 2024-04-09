<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 목록</title> 
    <style>
        #blacklist { /* 대소문자 일치 */
            overflow-y: auto;
            max-height: 400px;
        }
        .black-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <h1>블랙리스트</h1>
    <div id="blacklist"></div>

    <script>
        function loadBlacklist() {
            var currentUserId = '${loggedInUserId}'; // 서버 사이드에서 설정된 사용자 ID

            fetch('/api/friends/blacklist/' + currentUserId) // 블랙리스트 조회 API
            .then(function(response) {
                return response.json();
            })
            .then(function(blacklistUsers) {
                var list = document.getElementById("blacklist");
                list.innerHTML = "";
                
                blacklistUsers.forEach(function(user) {
                    var userDiv = document.createElement('div');
                    userDiv.className = 'blacklist-item';
                    userDiv.id = 'blacklist-user-' + user.id; // ID 할당
                    userDiv.innerHTML = `<span>${user.name}</span>`;

                    var removeBtn = document.createElement('button');
                    removeBtn.innerText = '제거';
                    removeBtn.onclick = function() {
                        removeFromBlacklist(user.id);
                    };

                    userDiv.appendChild(removeBtn);
                    list.appendChild(userDiv);
                });
            })
            .catch(function(error) {
                console.error('Error:', error);
            });
        }

        function removeFromBlacklist(userId) {
        	var token = '';
        	fetch('/api/friends/removeFromBlacklist/' + userId, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(response => {
                if (response.ok) {
                    var userDiv = document.getElementById('blacklist-user-' + userId);
                    if (userDiv) {
                        userDiv.remove();
                    }
                    alert("사용자가 블랙리스트에서 제거되었습니다.");
                } else {
                    throw new Error('Something went wrong on api server!');
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }

        window.onload = loadBlacklist;
    </script>

</body>
</html>