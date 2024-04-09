package com.springproj.emotionshare.glassBottle.controller;


import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.glassBottle.DTO.BlacklistDto;
import com.springproj.emotionshare.glassBottle.DTO.FriendRequestDto;
import com.springproj.emotionshare.glassBottle.DTO.UserDto;
import com.springproj.emotionshare.glassBottle.repository.FriendListRepository;
import com.springproj.emotionshare.glassBottle.service.BlacklistService;
import com.springproj.emotionshare.glassBottle.service.FriendService;
import com.springproj.emotionshare.securityConfig.CustomUserDetails;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/friends")
public class FriendController {
	
	 	@Autowired
	    private FriendService friendService;
	 	@Autowired
	 	private BlacklistService blacklistService;
	 	@Autowired
	 	private FriendListRepository friendListRepository;
	 	
	 	
	 	//전체 유저 중  검색 
	       @GetMapping("/searchWithStatus/{currentUserId}")
	       public ResponseEntity<List<Map<String, Object>>> searchFriendsWithStatus(@PathVariable Long currentUserId, @RequestParam("name") String name) {
	           List<UserDto> users = friendService.searchFriendsByName(name);

	           return ResponseEntity.ok(users.stream().map(user -> {
	               Map<String, Object> userWithStatus = new HashMap<>();
	               userWithStatus.put("user", user);
	               userWithStatus.put("isFriendRequestSent", friendService.isFriendRequestSent(currentUserId, user.getId()));
	               userWithStatus.put("isBlacklisted", friendService.isBlacklisted(currentUserId, user.getId()));
	               userWithStatus.put("isFriend", friendService.isFriend(currentUserId, user.getId()));
	               return userWithStatus;
	           }).collect(Collectors.toList()));
	       }

			/*
			 * @GetMapping("/searchById") public ResponseEntity<List<UserDto>>
			 * searchFriends(@RequestParam String Id) { List<UserDto> users =
			 * friendService.searchFriendsById(Id); return ResponseEntity.ok(users); }
			 * 
			 * @GetMapping("/searchBy") public ResponseEntity<List<UserDto>>
			 * searchFriends(@RequestParam String PhoneNum) { List<UserDto> users =
			 * friendService.searchFriendsByPhoneNum(PhoneNum); return
			 * ResponseEntity.ok(users); }
			 */
	   
	 	 
	 	//친구 리스트 불러오기
	 	@GetMapping("/list/{userId}")
	    public ResponseEntity<List<UserDto>> getFriendList(@PathVariable Long userId) {
	        List<UserDto> friends = friendService.getAllFriends(userId);
	        System.out.println("getFriedList디버깅 userId 체크" + userId);
	        if (friends.isEmpty()) {
	        	System.out.println("getFriedList디버깅");
	            return ResponseEntity.notFound().build();
	        }

        	System.out.println("getFriedList디버깅" + friends);
	        return ResponseEntity.ok(friends);
	    }
	 	
	 	//친구 요청 api
	 	@GetMapping("/requests/{userId}")
	 	public List<FriendRequestDto> getFriendRequests(@PathVariable Long userId) {
	 	    System.out.println("성공" + userId);

	 	    List<FriendRequestDto> requests = friendService.getFriendRequests(userId);

	 	    if (requests.isEmpty()) {
	 	        // 비어있는 경우 빈 리스트를 반환할 수 있습니다.
	 	        return Collections.emptyList();
	 	    }

	 	    System.out.println("성공 5" + requests);
	 	    return requests;
	 	}
	 	
	 	//수정 버전
	 	//친구리스트 내에서 본인의 친구 검색
	 	@GetMapping("/searchInList/{userId}")
	 	public ResponseEntity<List<UserDto>> searchFriendsInList(@PathVariable Long userId, @RequestParam("name") String name) {
	 	    List<UserDto> friends = friendService.searchFriendsInList(userId, name);
	 	    if (friends.isEmpty()) {
	 	        return ResponseEntity.notFound().build();
	 	    }
	 	    return ResponseEntity.ok(friends);
	 	}
	 	
	 	// 친구 요청 보내기
	    @PostMapping("/request")
	    public ResponseEntity<String> sendFriendRequest(@RequestBody FriendRequestDto requestDto) {
	        friendService.sendFriendRequest(requestDto);
	        return ResponseEntity.ok("친구 요청 전송");
	    }
	    
	    //친구 요청 수락 api
	    @PostMapping("/accept")
	    public ResponseEntity<String> acceptFriendRequest(@RequestBody FriendRequestDto requestDto, Authentication authentication) {
	        // 현재 로그인한 사용자 정보를 얻지만, FriendService에는 전달하지 않음
	        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
	        UserEntity currentUser = userDetails.getUserEntity();

	        // FriendService 호출 시 requestDto만 전달
	        friendService.acceptFriendRequest(requestDto);
	        System.out.println("성공 6" + requestDto);
	        System.out.println("성공 7" + currentUser);
	        return ResponseEntity.ok("Friend request accepted.");
	    }
	    
	    //수정 버전
	    //친구 요청 거절 api
	    @DeleteMapping("/reject/{currentUserId}/{requestId}")
	    public ResponseEntity<?> rejectFriendRequest(@PathVariable Long currentUserId, @PathVariable Long requestId) {
	        friendService.rejectFriendRequest(currentUserId, requestId);
	        return ResponseEntity.ok().build();
	    }

	    //수정 버전
	    //유저 본인의 친구리스트에서 친구 삭제
	    @DeleteMapping("/delete/{currentUserId}/{friendId}")
	    public ResponseEntity<?> deleteFriend(@PathVariable Long currentUserId, @PathVariable Long friendId) {
	    
	
	    		 	friendService.deleteFriend(currentUserId, friendId); // 서비스에서 친구 삭제 처리
	    		 	return ResponseEntity.ok().build(); // 성공 응답 반환
	    	
	    }

	    // 수정 버전
	    //블랙리스트 추가
	    @PostMapping("/blacklistUser")
	    public ResponseEntity<String> blacklistRequest(@RequestBody BlacklistDto blacklistDto) {
	        blacklistService.addUserToBlacklist(blacklistDto.getOwnerId(), blacklistDto.getUserId());
	        return ResponseEntity.ok("사용자가 블랙리스트에 추가되었습니다.");
	    }

	    
	    // 수정된 버전
	    //블랙리스트 조회 
	    @GetMapping("/blacklist/{currentUserId}")
	    public ResponseEntity<List<UserDto>> getBlacklist(@PathVariable Long currentUserId) {
	        List<UserDto> blacklist = blacklistService.getBlacklist(currentUserId);
	        if (blacklist.isEmpty()) {
	            return ResponseEntity.notFound().build();
	        }
	        return ResponseEntity.ok(blacklist);
	    }

	    // 수정버전
		//블랙리스트 삭제
	    @DeleteMapping("/removeFromBlacklist/{ownerId}/{userId}")
	    public ResponseEntity<?> removeFromBlacklist(@PathVariable Long ownerId, @PathVariable Long userId) {
	        blacklistService.removeUserFromBlacklist(ownerId, userId);
	        return ResponseEntity.ok().build();
	    }
	    
	    //수정버전
	    //블랙리스트 내에서 검색 api
	    @GetMapping("/blacklist/search/{currentUserId}")
	    public ResponseEntity<List<UserDto>> searchBlacklist(@PathVariable Long currentUserId, @RequestParam("name") String name) {
	        List<UserDto> blacklist = blacklistService.searchBlacklist(currentUserId, name);
	        if (blacklist.isEmpty()) {
	            return ResponseEntity.notFound().build();
	        }
	        return ResponseEntity.ok(blacklist);
	    }
	    
}
