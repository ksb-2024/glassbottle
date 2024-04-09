package com.springproj.emotionshare.chat;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChatMessageRepository extends CrudRepository<ChatMessage, Long>{
   // roomId에 해당하는 메시지를 최신순으로 정렬하여 조회
   // roomId 타입이 Integer인 경우 메소드 시그니처 변경
   List<ChatMessage> findByRoomIdOrderByMessageTimeAsc(Integer roomId, Pageable pageable);

   @Query("SELECT c.roomId as roomId, c.writer as writer, c.body as body, c.messageTime as messageTime FROM ChatMessage c WHERE c.messageTime IN (SELECT MAX(cm.messageTime) FROM ChatMessage cm GROUP BY cm.roomId)")
   List<Object[]> findLatestMessageForEachRoom();
   
   @Query("SELECT c.roomId as roomId, c.writer as writer, c.body as body, MAX(c.messageTime) as lastMessageTime " +
              "FROM ChatMessage c GROUP BY c.roomId ORDER BY lastMessageTime DESC")
   List<Object[]> findChatRoomsWithLastMessages();
   
   List<ChatMessage> findByRoomId(Integer roomId);
   // roomId와 writer를 기준으로 안 읽은 메시지의 수를 반환하는 쿼리
    Long countByRoomIdAndIsReadFalseAndWriterNot(Integer roomId, String writer);

}