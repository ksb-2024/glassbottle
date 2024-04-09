package com.springproj.emotionshare.glassBottle.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Table(name = "FriendRequest")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
public class FriendRequest {
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;
		private Long requesterId; // 요청자의 ID
	    private Long requestedId; // 요청받은 사람의 ID
	    private FriendRequestStatus status;
		
}
