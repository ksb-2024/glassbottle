package com.springproj.emotionshare.chat;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.springproj.emotionshare.domain.UserEntity;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, Integer> {
   // Optional<ChatRoom> findByName(String name);
    Optional<ChatRoom> findByUser1AndUser2(UserEntity user1, UserEntity user2);
    
    @Query("SELECT cr FROM ChatRoom cr LEFT JOIN FETCH cr.messages msg ORDER BY msg.messageTime DESC")
    List<ChatRoom> findAllOrderedByLastMessageTimeDesc();
    
    List<ChatRoom> findByUser1OrUser2(UserEntity user1, UserEntity user2);
    
}

