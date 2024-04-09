package com.springproj.emotionshare.chat;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.glassBottle.service.UserService;

@Service
public class ChatService {
   @Autowired
   ChatDao chatDao;
   
   @Autowired
    private ChatUserService chatUserService;
   
   @Autowired
   private ChatMessageRepository chatMessageRepository;
   
   @Autowired
    private SimpMessagingTemplate messagingTemplate;

   @Autowired
   private UserService userService;
   @Autowired
   private UserMessageRepository userMessageRepository;

   public void addMessage(Integer roomId, String writer, String body, LocalDateTime localDateTime) {
      ChatRoom chatRoom = chatRoomRepository.findById(roomId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid room Id:" + roomId));
      ChatMessage chatMessage = new ChatMessage();
      chatMessage.setRoomId(roomId);
      chatMessage.setWriter(writer);
      chatMessage.setBody(body);
      chatMessage.setMessageTime(localDateTime);
      ChatMessage savedMessage = chatMessageRepository.save(chatMessage); // 메시지 저장
      // 새 메시지에 대한 UserMessage 엔터티를 각 수신자에 대해 생성
      // 이 예제에서는 채팅방의 모든 사용자를 수신자로 간주합니다. 필요에 따라 로직을 조정하세요.
   }
   
   private void createUserMessage(ChatMessage message, UserEntity recipient, String writer) {
       // 메시지 작성자가 수신자인 경우는 제외
       if (!recipient.getUsername().equals(writer)) {
           UserMessage userMessage = new UserMessage();
           userMessage.setUser(recipient);
           userMessage.setMessage(message);
           userMessage.setIsRead(false); // 초기 상태는 '읽지 않음'
           userMessageRepository.save(userMessage);
       }
   }
   
   

   public List getMessages() {

      return chatDao.getMessages();
   }

   public List getMessagesFrom(Integer roomId, int from) {
      return chatDao.getMessagesFrom(roomId, from);
   }

   public List<ChatMessage> getRecentMessages(Integer roomId) {
      Pageable pageableAsc = PageRequest.of(0, 100, Sort.by(Sort.Direction.ASC, "messageTime"));
      return chatMessageRepository.findByRoomIdOrderByMessageTimeAsc(roomId, pageableAsc);
   }

   public void clearAllMessages() {
      chatDao.clearAllMessages();
   }
   
   
   // 읽음처리
    public void markMessagesAsRead(Integer roomId, String username) {
           // 해당 채팅방에 있는 메시지 중, 현재 사용자가 보낸 메시지가 아닌 것을 가져옵니다.
           List<ChatMessage> messages = chatMessageRepository.findByRoomId(roomId);

           // 각 메시지의 '읽음' 상태를 true로 설정합니다.
           for (ChatMessage message : messages) {
              if (!message.getWriter().equals(username)) {
               message.setIsRead(true);
               chatMessageRepository.save(message);
              }
           }
          
       
       }
   

   // 채팅방 관련

   @Autowired
   public ChatRoomRepository chatRoomRepository;

   public ChatRoom createOrGetChatRoom(UserEntity user1, UserEntity user2, String roomName) {
      // 두 사용자 간의 채팅방이 있는지 확인
      Optional<ChatRoom> existingRoom = chatRoomRepository.findByUser1AndUser2(user1, user2);
      if (!existingRoom.isPresent()) {
         existingRoom = chatRoomRepository.findByUser1AndUser2(user2, user1); // 역순으로 저장된 채팅방도 확인
      }

      // 채팅방이 이미 존재하는 경우
      if (existingRoom.isPresent()) {
         return existingRoom.get();
      }

      // 채팅방이 존재하지 않는 경우, 새로운 채팅방을 생성
      ChatRoom newRoom = new ChatRoom();
      newRoom.setUser1(user1);
      newRoom.setUser2(user2);

      // 채팅방 이름을 상대방의 이름으로 설정
      // 상대방의 이름을 결정합니다. user1이 현재 사용자라고 가정하면, 채팅방 이름은 user2의 이름이 됩니다.
      newRoom.setUser1RoomName(user2.getName()); // user1의 채팅방 이름을 user2의 이름으로 설정
      newRoom.setUser2RoomName(user1.getName()); // user2의 채팅방 이름을 user1의 이름으로 설정

      // 채팅방 저장
      chatRoomRepository.save(newRoom);
      return newRoom;
   }

//   public ChatRoom createChatRoom(String name) {
//      ChatRoom chatRoom = new ChatRoom();
//      chatRoom.setName(name);
//      return chatRoomRepository.save(chatRoom);
//   }

   public Optional<ChatRoom> getChatRoom(Integer roomId) {
      return chatRoomRepository.findById(roomId);
   }

   public List<ChatRoom> getAllChatRooms() {
      return chatRoomRepository.findAll();
   }

   // 마지막 메시지
   public List<Object[]> getLatestMessageForEachRoom() {
      return chatMessageRepository.findLatestMessageForEachRoom();
   }
   public List<ChatRoom> getAllChatRoomsOrderedByLastMessage() {
        return chatRoomRepository.findAllOrderedByLastMessageTimeDesc();
    }
   public List<ChatRoom> getAllChatRoomsForUser(UserEntity user) {
      // 사용자 ID를 기준으로 채팅방을 필터링
      return chatRoomRepository.findByUser1OrUser2(user, user);
   }

   public List<Object[]> getLatestMessageForEachRoomForUser(UserEntity currentUser) {
      return chatMessageRepository.findLatestMessageForEachRoom();
   }
   // 안읽은 메시지 카운트
   public Long getUnreadMessageCount(Integer roomId, String username) {
       return chatMessageRepository.countByRoomIdAndIsReadFalseAndWriterNot(roomId, username);
   }

}