package com.springproj.emotionshare.chat;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springproj.emotionshare.domain.UserEntity;

public interface UserMessageRepository extends JpaRepository<UserMessage, Long>{

	 // 특정 사용자와 특정 채팅방에 대한 읽지 않은 메시지의 수를 반환하는 메서드
    Long countByMessageRoomIdAndUserAndIsRead(Integer roomId, UserEntity user, Boolean isRead);

    // 특정 사용자와 특정 메시지에 대한 UserMessage 엔터티를 검색하는 메서드
    UserMessage findByUserAndMessage(UserEntity user, ChatMessage message);

	UserMessage findByUserAndMessageId(UserEntity user, Long messageId);
}
