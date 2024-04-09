package com.springproj.emotionshare.glassBottle.service;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.glassBottle.DTO.FriendRequestDto;
import com.springproj.emotionshare.glassBottle.DTO.UserDto;
import com.springproj.emotionshare.glassBottle.model.FriendList;
import com.springproj.emotionshare.glassBottle.model.FriendRequest;
import com.springproj.emotionshare.glassBottle.model.FriendRequestStatus;
import com.springproj.emotionshare.glassBottle.repository.BlacklistRepository;
import com.springproj.emotionshare.glassBottle.repository.FriendListRepository;
import com.springproj.emotionshare.glassBottle.repository.FriendRequestRepository;
import com.springproj.emotionshare.repository.UserRepository;

@Service
public class FriendService {
	 @Autowired
	 private FriendRequestRepository friendRequestRepository;
	 @Autowired
	 private UserRepository userRepository;
	 @Autowired
	 private FriendListRepository friendListRepository;
	 @Autowired
	 private BlacklistRepository blacklistRepository;
	 
	 @Autowired
	 private SimpMessagingTemplate messagingTemplate;
	 
	 private static final Logger logger = LoggerFactory.getLogger(FriendService.class);
	 //전체 유저 중 친구 검색
	 public List<UserDto> searchFriendsByName(String name) {
		    return userRepository.findByNameContaining(name).stream()
		        .map(user -> UserDto.builder()
		            .id(user.getId())
		            .username(user.getUsername())
		            .nick(user.getNick()) // 예시 필드
		            .name(user.getName()) // 예시 필드
		            .tel(user.getTel()) // 예시 필드
		            .birth(user.getBirth()) // 예시 필드
		            .gender(user.getGender()) // 예시 필드
		            .useremail(user.getUseremail()) // 예시 필드
		            .role(user.getRole()) // 예시 필드
		            .build())
		        .collect(Collectors.toList());
		}
	 
	
	 //10번째 친구 이미 요청 보내졌으면 안보내지게
	    // 친구 요청 보내기
	    public void sendFriendRequest(FriendRequestDto requestDto) {
	       // DTO를 Entity로 변환
	       FriendRequest friendRequest = convertToEntity(requestDto);
	        friendRequestRepository.save(friendRequest);
	        boolean requestAlreadyExists = friendRequestRepository
	                  .findByRequesterIdAndRequestedIdAndStatus(requestDto.getRequesterId(), requestDto.getRequestedId(), FriendRequestStatus.PENDING)
	                  .isPresent();
	        if (requestAlreadyExists) {
	            throw new IllegalStateException("이미 친구 요청이 존재합니다.");
	        }
	        
	      //이 부분을 수정하는 것임.
	           // 요청자(친구 요청을 보낸 사용자)의 이름 조회
	           String requesterName = userRepository.findById(requestDto.getRequesterId())
	               .map(UserEntity::getUsername)
	               .orElse("알 수 없는 사용자");

	           // 실시간 알림 전송
	           String notification = requesterName + "님에게 친구 요청을 받았습니다";
	           messagingTemplate.convertAndSendToUser(
	               requestDto.getRequestedId().toString(), // 요청받은 사용자 B의 식별자
	               "/queue/notifications",
	               notification // 보낼 메시지
	           );
	    
	    }
	    
	   // 친구 요청 수락
	       public void acceptFriendRequest(FriendRequestDto requestDto) {
	          FriendRequest friendRequest = friendRequestRepository
	                     .findByRequesterIdAndRequestedId(requestDto.getRequesterId(), requestDto.getRequestedId())
	                     .orElseThrow(() -> new RuntimeException("Friend request not found."));
	             friendRequest.setStatus(FriendRequestStatus.ACCEPTED);
	             friendRequestRepository.save(friendRequest);
	           
	           FriendList friendList = new FriendList();
	           UserEntity requester = userRepository.findById(requestDto.getRequesterId())
	                   .orElseThrow(() -> new RuntimeException("Requester user not found."));
	           UserEntity requested = userRepository.findById(requestDto.getRequestedId())
	                   .orElseThrow(() -> new RuntimeException("Requested user not found."));

	           friendList.setUser1(requester);
	           friendList.setUser2(requested); // requestedId로 변경
	           friendListRepository.save(friendList);
	          
	           //수정 실시간 알림
	        // 요청자(사용자 A)와 요청받은 사람(사용자 B)의 정보 조회
	           String requesterName = userRepository.findById(requestDto.getRequesterId())
	                                               .orElseThrow(() -> new RuntimeException("User not found"))
	                                               .getUsername();
	           String acceptedUserName = userRepository.findById(requestDto.getRequestedId())
	                                                   .orElseThrow(() -> new RuntimeException("User not found"))
	                                                   .getUsername();
	   
	           // 알림 메시지 생성 및 전송
	           String notification = acceptedUserName + "와 친구 맺기 성공";
	           messagingTemplate.convertAndSendToUser(
	               requesterName,
	               "/queue/notifications",
	               notification
	           );
	       }



	 
	 // 수정 버전
	 //친구 요청 거절 api
	 public void rejectFriendRequest(Long currentUserId, Long requestId) {
	        FriendRequest request = friendRequestRepository.findById(requestId)
	            .orElseThrow(() -> new RuntimeException("Friend request not found"));

	        if (!request.getRequestedId().equals(currentUserId)) {
	            throw new RuntimeException("Unauthorized to reject this friend request");
	        }

	        friendRequestRepository.delete(request);
	    }
	 

	 //친구 목록 리스트 
	 // 현재 사용자의 모든 친구 목록
	    public List<UserDto> getAllFriends(Long userId) {
	        return friendListRepository.findByUser1IdOrUser2Id(userId, userId).stream()
	            .flatMap(friendList -> Stream.of(friendList.getUser1(), friendList.getUser2()))
	            .filter(user -> !user.getId().equals(userId))
	            .map(user -> UserDto.builder()
	                .id(user.getId())
	                .username(user.getUsername())
	                .nick(user.getNick()) // 예시 필드
	                .name(user.getName()) // 예시 필드
	                .tel(user.getTel()) // 예시 필드
	                .birth(user.getBirth()) // 예시 필드
	                .gender(user.getGender()) // 예시 필드
	                .useremail(user.getUseremail()) // 예시 필드
	                .build())
	            .collect(Collectors.toList());
	    }
	    
	    //수정 버전
	    //이미 친구인지 확인하는 메서드
	    public boolean isFriend(Long currentUserId, Long otherUserId) {
	        return friendListRepository.existsByUser1IdAndUser2Id(currentUserId, otherUserId)
	            || friendListRepository.existsByUser1IdAndUser2Id(otherUserId, currentUserId);
	    }
	    
	    //수정 버전
	    // 친구 요청 확인 메서드
	    public boolean isFriendRequestSent(Long currentUserId, Long otherUserId) {
	        return friendRequestRepository.existsByRequesterIdAndRequestedId(currentUserId, otherUserId);
	    }
	    
	    //수정 버전
	    // 이미 친구 요청을 받은 것을 확인하는 메서드
	    public boolean isFriendRequestReceived(Long currentUserId, Long otherUserId) {
	        return friendRequestRepository.existsByRequesterIdAndRequestedId(otherUserId, currentUserId);
	    }
	    
	    //수정 버전
	    //블랙리스트 확인 메서드
	    public boolean isBlacklisted(Long currentUserId, Long otherUserId) {
	        return blacklistRepository.existsByOwnerIdAndBlockedUserId(currentUserId, otherUserId);
	    }


	    
	    // 수정 버전
	    //친구 본인의 리스트 내에서 친구 검색
		 public List<UserDto> searchFriendsInList(Long userId, String name) {
		     List<UserDto> allFriends = getAllFriends(userId);
		     return allFriends.stream()
		                      .filter(friend -> friend.getName().toLowerCase().contains(name.toLowerCase()))
		                      .collect(Collectors.toList());
		 }
	
		 public void deleteFriend(Long userId, Long friendId) {
		        try {
		            friendListRepository.deleteByUser1IdAndUser2Id(userId, friendId);
		        } catch (Exception e) {
		            logger.error("Failed to delete friend relationship: userId={}, friendId={}", userId, friendId, e);
		        }

		        try {
		            friendListRepository.deleteByUser1IdAndUser2Id(friendId, userId);
		        } catch (Exception e) {
		            logger.error("Failed to delete friend relationship: userId={}, friendId={}", friendId, userId, e);
		        }
		    }
		 
		 public void deleteFriendAndFriendRequest(Long userId, Long friendId) {
		        deleteFriend(userId, friendId); // 기존 친구 관계 삭제 메서드 호출
		        deleteFriendRequests(userId, friendId, FriendRequestStatus.ACCEPTED); // 친구 요청도 삭제
		    }

		    private void deleteFriendRequests(Long requesterId, Long requestedId, FriendRequestStatus status) {
		        friendRequestRepository.deleteByRequesterIdAndRequestedIdAndStatus(requesterId, requestedId, status);
		    }
	
		   // 친구 요청 목록을 가져오는 메서드
		   public List<FriendRequestDto> getFriendRequests(Long userId) {
		       // FriendRequestRepository에 정의된 메서드를 사용하여 친구 요청 데이터를 가져온 후,
		       // 필요한 경우 DTO로 변환하여 반환합니다.
			   List<FriendRequest> requestEntities = friendRequestRepository.findByRequestedId(userId);
			    return requestEntities.stream()
			        .filter(request -> request.getStatus() != FriendRequestStatus.ACCEPTED)
			        .map(request -> {
			            FriendRequestDto dto = convertToDto(request);
			            String requesterName = userRepository.findById(request.getRequesterId())
			                                 .map(UserEntity::getUsername)
			                                 .orElse("알 수 없는 사용자");
			            dto.setRequesterName(requesterName);
			            return dto;
			        })
			        .collect(Collectors.toList());
			}
	
	//엔티티를 dto로
	private FriendRequestDto convertToDto(FriendRequest entity) {
	    return FriendRequestDto.builder()
	            .id(entity.getId())
	            .requesterId(entity.getRequesterId())
	            .requestedId(entity.getRequestedId())
	            .status(entity.getStatus())
	            .build();
	}

	 
	 // DTO를 Entity로 변환하는 메소드
	 private FriendRequest convertToEntity(FriendRequestDto requestDto) {
		 FriendRequest friendRequest = new FriendRequest();
	     friendRequest.setId(requestDto.getId());
	     friendRequest.setRequesterId(requestDto.getRequesterId());
	     friendRequest.setRequestedId(requestDto.getRequestedId());
	        
	     // DTO의 status를 그대로 Entity에 설정
	     friendRequest.setStatus(requestDto.getStatus() != null ? requestDto.getStatus() : FriendRequestStatus.PENDING);

	     return friendRequest;
	     }
	

}

