package com.springproj.emotionshare.glassBottle.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springproj.emotionshare.domain.UserEntity;



@Controller
public class FriendListController {

    @GetMapping("/friends")
    public String showFriendsPage(Model model) {
    	  Authentication auth = SecurityContextHolder.getContext().getAuthentication();
          String currentUsername = auth.getName(); // 현재 로그인한 사용자의 유저네임 혹은 ID

          model.addAttribute("loggedInUserId", currentUsername); // JSP에 변수 전달


        return "friends"; //friends.jsp 이동
    }
    
    @GetMapping("/friendsList")
    public String showFriendsListPage(Model model, Authentication authentication) {
        if (authentication != null && authentication.getPrincipal() instanceof UserEntity) {
            UserEntity currentUser = (UserEntity) authentication.getPrincipal();
            String currentUserId = currentUser.getId().toString(); // Long 타입의 ID String으로 변환
            
            model.addAttribute("loggedInUserId", currentUserId);
        }
        return "friendsList"; // friendList.jsp로 이동
    }

    @GetMapping("/blacklist")
    public String showBlacklistPage(Model model, Authentication authentication) {
        if (authentication != null && authentication.getPrincipal() instanceof UserEntity) {
            UserEntity currentUser = (UserEntity) authentication.getPrincipal();
            String currentUserId = currentUser.getId().toString(); // Long 타입의 ID String으로 변환

            model.addAttribute("loggedInUserId", currentUserId);
        }
        return "blacklist"; // blacklist.jsp로 이동
    }
    
    @GetMapping("/friendsRequests")
    public String showFriendRequestsPage(Model model, Authentication authentication) {
        if (authentication != null && authentication.getPrincipal() instanceof UserEntity) {
            UserEntity currentUser = (UserEntity) authentication.getPrincipal();
            Long currentUserId = currentUser.getId(); // Long 타입의 ID

            model.addAttribute("loggedInUserId", currentUserId);
        }
        return "friendsRequests"; // friendRequests.jsp 이동
    }
}