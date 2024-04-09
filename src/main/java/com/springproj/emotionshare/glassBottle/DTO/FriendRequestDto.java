package com.springproj.emotionshare.glassBottle.DTO;

import com.springproj.emotionshare.glassBottle.model.FriendRequestStatus;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FriendRequestDto {
	private Long id;
	private Long requesterId; // 요청자의 ID
    private Long requestedId; // 요청받은 사람의 ID
    private String requesterName; // 요청자 이름
    private FriendRequestStatus status;
    
}

