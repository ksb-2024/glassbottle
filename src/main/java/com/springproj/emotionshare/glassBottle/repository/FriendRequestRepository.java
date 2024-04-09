package com.springproj.emotionshare.glassBottle.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springproj.emotionshare.glassBottle.model.FriendRequest;
import com.springproj.emotionshare.glassBottle.model.FriendRequestStatus;

public interface FriendRequestRepository extends JpaRepository<FriendRequest, Long> {

	    
	    List<FriendRequest> findByRequestedId(Long requestedId);
	  
	    //친구요청을 했는지 확인요청
	    boolean existsByRequesterIdAndRequestedId(Long requesterId, Long requestedId);
	   
	    Optional<FriendRequest> findByRequesterIdAndRequestedId(Long requesterId, Long requestedId);
	    Optional<FriendRequest> findByRequesterIdAndRequestedIdAndStatus(Long requesterId, Long requestedId, FriendRequestStatus status);
	    
	    void deleteByRequesterIdAndRequestedIdAndStatus(Long requesterId, Long requestedId, FriendRequestStatus status);

}

