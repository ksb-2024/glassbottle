package com.springproj.emotionshare.chat;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.glassBottle.service.UserService;
import com.springproj.emotionshare.repository.UserRepository;

@Controller
public class ChatController {
   @Autowired
   ChatService chatService;
   @Autowired
   private ChatRoomRepository chatRoomRepository;
   @Autowired
   private SimpMessagingTemplate simpMessagingTemplate;
   @Autowired
   private ChatMessageRepository chatMessageRepository;
   @Autowired
   private ChatUserService chatUserService;

   @Autowired
   private UserRepository userRepository;

   @Autowired
   private UserService userService;

   @RequestMapping("/chat/room")
   public String showRoom(@RequestParam("roomId") Integer roomId, Model model, Authentication authentication) {
      Optional<ChatRoom> chatRoomOpt = chatRoomRepository.findById(roomId);
      String username = authentication.getName();
      // Optional을 직접 전달하는 대신, 실제 ChatRoom 객체를 모델에 추가
      chatRoomOpt.ifPresent(room -> model.addAttribute("chatRoom", room));
      UserEntity currentUser = userService.findUser(authentication.getName());
      // roomId도 모델에 추가
      model.addAttribute("currentUser", currentUser); // 현재 사용자 정보를 모델에 추가
      model.addAttribute("roomId", roomId);
      model.addAttribute("username", username);

      return "chat/chat_room";
   }

   @RequestMapping("/chat/doAddMessage")
   @ResponseBody
   public Map doAddMessage(Integer roomId, String writer, String body, LocalDateTime localDateTime) {
      Map rs = new HashMap<>();

      chatService.addMessage(roomId, writer, body, localDateTime);

      rs.put("resultCod", "S-1");
      rs.put("msg", "채팅 메시지가 추가되었습니다.");

      return rs;
   }

   @RequestMapping("/chat/getMessages")
   @ResponseBody
   public List getMessages(ChatRoom roomId, String writer, String body) {

      return chatService.getMessages();
   }

   @RequestMapping("/chat/getMessagesFrom")
   @ResponseBody
   public Map getMessages(@RequestParam("roomId") Integer roomId, int from) {
      List<ChatMessage> messages = chatService.getMessagesFrom(roomId, from);
      Map rs = new HashMap<>();

      rs.put("resultCode", "S-1");
      rs.put("msg", "새 메세지들을 가져왔습니다.");
      rs.put("messages", messages);

      return rs;

   }

   @RequestMapping("/chat/getRecentMessages")
   @ResponseBody
   public Map getRecentMessages(@RequestParam("roomId") Integer roomId) {
      //
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
      String currentUserName = authentication.getName();
      //
      Optional<ChatRoom> roomOpt = chatRoomRepository.findById(roomId);
      if (!roomOpt.isPresent()) {
         throw new IllegalArgumentException("채팅방을 찾을 수 없습니다. roomId: " + roomId);
      }
      List<ChatMessage> messages = chatService.getRecentMessages(roomId);
      Map rs = new HashMap<>();

      rs.put("resultCode", "S-1");
      rs.put("msg", "최근 메세지들을 가져왔습니다.");
      rs.put("messages", messages);
      //
      chatService.markMessagesAsRead(roomId, currentUserName);
      //
      return rs;

   }

   @RequestMapping("/chat/doClearAllMessages")
   @ResponseBody
   public Map doClearAllMessages() {
      chatService.clearAllMessages();

      Map rs = new HashMap<>();

      rs.put("resultCode", "S-1");
      rs.put("msg", "모든 메세지들을 삭제 하였습니다.");
      return rs;
   }

   @MessageMapping("/chat.sendMessage")
   @SendTo("/topic/public")
   public ChatMessage sendMessage(@Payload ChatMessage chatMessage) {
      LocalDateTime now = LocalDateTime.now(); // 현재 시간을 가져옵니다.
      chatService.addMessage(chatMessage.getRoomId(), chatMessage.getWriter(), chatMessage.getBody(), now); // 현재 시간을
                                                                                    // 넘깁니다.
      chatMessage.setMessageTime(now); // chatMessage 객체에도 시간을 설정합니다.

      // 채팅방 목록 업데이트를 위해 마지막 메시지 정보를 전송
      simpMessagingTemplate.convertAndSend("/topic/lastMessage", chatMessage);

      //Integer roomId = chatMessage.getRoomId();
      //chatService.markMessagesAsRead(roomId, chatMessage.getWriter());
      return chatMessage;
   }

   /*
    * @MessageMapping("/chat.sendMessage")
    * 
    * @SendTo("/topic/public") public ChatMessage sendMessage(@Payload ChatMessage
    * chatMessage) { LocalDateTime now = LocalDateTime.now();
    * chatService.addMessage(chatMessage.getRoomId(), chatMessage.getWriter(),
    * chatMessage.getBody(), now); chatMessage.setMessageTime(now); // 채팅방 목록 업데이트를
    * 위해 마지막 메시지 정보를 전송 simpMessagingTemplate.convertAndSend("/topic/lastMessage",
    * chatMessage);
    * 
    * // 메시지를 보낼 때, 해당 채팅방의 모든 사용자에게 메시지를 읽음으로 표시 Integer roomId =
    * chatMessage.getRoomId(); chatService.markMessagesAsRead(roomId,
    * chatMessage.getWriter());
    * 
    * return chatMessage; }
    */
   @MessageMapping("/chat.enterRoom")
   public void enterChatRoom(@Payload Map<String, Object> payload, SimpMessageHeaderAccessor headerAccessor) {
      Integer roomId = (Integer) payload.get("roomId");
      String username = headerAccessor.getUser().getName();
      chatUserService.enterRoom(username, roomId);

      // 채팅방에 들어오면 해당 채팅방의 메시지를 읽음 처리
      chatService.markMessagesAsRead(roomId, username);
   }

   @MessageMapping("/chat.leaveRoom")
   public void leaveChatRoom(@Payload Map<String, Object> payload, SimpMessageHeaderAccessor headerAccessor) {
      String username = headerAccessor.getUser().getName();
      chatUserService.leaveRoom(username);
   }

   // 채팅방 관련

   @RequestMapping("/chat/roomlist")
   public String chatRooms() {

      return "chat/chat_rooms";
   }

   @RequestMapping("/chat/rooms")
   public String showChatRooms(Model model, Authentication authentication) {
      // 현재 로그인된 사용자의 정보를 가져옵니다.
      String username = authentication.getName();
      UserEntity currentUser = userService.findUser(username);
      model.addAttribute("currentUser", currentUser); // 현재 사용자 정보를 모델에 추가

      // 모든 채팅방을 가져옵니다.
      List<ChatRoom> chatRooms = chatService.getAllChatRoomsOrderedByLastMessage();

      // 현재 사용자가 속한 채팅방만 필터링합니다.
      List<ChatRoom> userChatRooms = chatRooms.stream()
            .filter(room -> room.getUser1().getId().equals(currentUser.getId())
                  || room.getUser2().getId().equals(currentUser.getId()))
            .collect(Collectors.toList());

      // 마지막 메시지
      List<Object[]> latestMessages = chatService.getLatestMessageForEachRoom();

      // 모든 사용자 정보를 가져옵니다.
      List<UserEntity> allUsers = userService.findAllUsers().stream()
            .filter(user -> !user.getId().equals(currentUser.getId())) // 현재 사용자를 제외
            .collect(Collectors.toList());

      // 모델에 속성을 추가합니다.
      model.addAttribute("chatRooms", userChatRooms); // 필터링된 채팅방 목록을 추가
      model.addAttribute("latestMessages", latestMessages);
      model.addAttribute("username", username);
      model.addAttribute("allUsers", allUsers); // 모든 사용자 목록을 모델에 추가

      latestMessages.forEach(message -> {
         // message[3]가 LocalDateTime 타입이라고 가정하고 적절히 캐스팅
         LocalDateTime localDateTime = (LocalDateTime) message[3];

         // LocalDateTime을 Date로 변환
         Date date = java.sql.Timestamp.valueOf(localDateTime);

         // 변환된 Date 객체를 다시 message[3]에 할당
         message[3] = date;
      });
      Map<Integer, Long> unreadMessageCounts = new HashMap<>();
      for (ChatRoom room : chatRooms) {
         Long unreadCount = chatService.getUnreadMessageCount(room.getRoomId(), username);
         unreadMessageCounts.put(room.getRoomId(), unreadCount);
      }
      model.addAttribute("unreadMessageCounts", unreadMessageCounts);

      return "chat/chat_rooms"; // chat_rooms.jsp 페이지로 이동
   }

//   @RequestMapping("/chat/room/create")
//   @ResponseBody
//   public Map createChatRoom(String name) {
//      Map rs = new HashMap<>();
//      ChatRoom chatRoom = chatService.createChatRoom(name);
//      rs.put("resultCode", "S-1");
//      rs.put("msg", "채팅방이 생성되었습니다.");
//      rs.put("chatRoom", chatRoom);
//      
//      return rs;
//   }

   @RequestMapping("/chat/room/createOrGet")
   @ResponseBody
   public Map<String, Object> createOrGetChatRoom(@RequestParam("userId") Long userId, Authentication authentication) {
      Map<String, Object> rs = new HashMap<>();
      UserEntity currentUser = userService.findUser(authentication.getName());
      UserEntity participantUser = userRepository.findById(userId)
            .orElseThrow(() -> new IllegalArgumentException("Invalid participant Id:" + userId));

      // 채팅방 이름을 상대방 이름으로 설정
      String roomName = participantUser.getName();

      // 채팅방 생성 또는 검색 로직
      ChatRoom chatRoom = chatService.createOrGetChatRoom(currentUser, participantUser, roomName);

      rs.put("resultCode", "S-1");
      rs.put("msg", "채팅방에 접근하였습니다.");
      rs.put("chatRoom", chatRoom);
      return rs;
   }

   @RequestMapping("/chat/rooms/all")
   @ResponseBody
   public List<ChatRoom> getAllChatRooms() {
      return chatService.getAllChatRooms();
   }
   
   @RequestMapping("/chat/getUnreadCount")
   @ResponseBody
   public Long getUnreadMessageCount(@RequestParam("roomId") Integer roomId, Authentication authentication) {
       String username = authentication.getName();
       return chatService.getUnreadMessageCount(roomId, username);
   }

//   @MessageMapping("/chat.addUser")
//   @SendTo(".topic/public")
//   public ChatMessage addUser(ChatMessage chatMessage, SimpMessageHeaderAccessor headerAccessor) {
//      headerAccessor.getSessionAttributes().put("username", chatMessage.getSender());
//   }
}