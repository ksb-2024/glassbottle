<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-----===========  왼쪽  =================-------->
            <div class="left">
                <!---- 프로필 ----->
                <a class="profile" href="/mypage">>
                    <div class="profile-photo">
                        <img src="../images/profile-1.jpg">
                    </div>
                    <div class="handle">
                        <h4>${username}님</h4>
                        <p class="text-muted">
                        </p>
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
                    <a class="menu-item active" id="notifications" href="/diary/sharedDiary">
                        <span><i class="uil uil-bell"></i></span><h3>sharedDiary</h3>
                        <!------------------- NOTIFICATION POPUP ---------------------->
                        <div class="notifications-popup">
                            <div>
                                <div class="profile-photo">
                                        <img src="../images/profile-2.jpg" >
                                </div>
                                <div class="notification-body">
                                    <b>Keke Benjamin</b> accepted your friend request
                                    <small class="text-muted">2 DAYS AGO</small>
                                </div>
                            </div>
                            <div>
                                <div class="profile-photo">
                                        <img src="../images/profile-3.jpg" >
                                </div>
                                <div class="notification-body">
                                    <b>John Doe</b> commented on your post
                                    <small class="text-muted">1 HOUR AGO</small>
                                </div>
                            </div>
                            <div>
                                <div class="profile-photo">
                                        <img src="../images/profile-4.jpg" >
                                </div>
                                <div class="notification-body">
                                    <b>Mary Oppong</b> and <b>283 others</b> liked your post
                                    <small class="text-muted">4 MINUTES AGO</small>
                                </div>
                            </div>
                            <div>
                                <div class="profile-photo">
                                        <img src="../images/profile-5.jpg" >
                                </div>
                                <div class="notification-body">
                                    <b>Doris Y. Lartey</b> commented on a post you are tagged
                                    <small class="text-muted">2 DAYS AGO</small>
                                </div>
                            </div>
                            <div>
                                <div class="profile-photo">
                                        <img src="../images/profile-6.jpg" >
                                </div>
                                <div class="notification-body">
                                    <b>Donald Trump</b> commented on a post you are tagged
                                    <small class="text-muted">1 HOUR AGO</small>
                                </div>
                            </div>
                            <div>
                                <div class="profile-photo">
                                        <img src="../images/profile-7.jpg" >
                                </div>
                                <div class="notification-body">
                                    <b>jane Doe</b> commented on your post
                                    <small class="text-muted">1 HOUR AGO</small>
                                </div>
                            </div>
                        </div>
                        <!----------------------- END NOTIFICATION POPUP -------------------->
                    </a>
                    <a class="menu-item" id="messages-notifications" href="/chat/rooms">
                        <span><i class="uil uil-envelope-alt" ><small class="notification-count">6</small></i></span><h3>Message</h3>
                    </a>
                    <a class="menu-item" href="/friends">
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