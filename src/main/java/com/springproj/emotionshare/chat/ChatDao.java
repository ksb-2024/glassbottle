package com.springproj.emotionshare.chat;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.springproj.emotionshare.chat.ChatMessage;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class ChatDao {

	private List<ChatMessage> chatMessages;
	
	ChatDao() {
		chatMessages = new ArrayList<>();
	}
	
	public void addMessage(Integer roomId, String writer, String body, LocalDateTime localDateTime) {
        ChatMessage aChatMessage = new ChatMessage();
        aChatMessage.setRoomId(roomId);
        aChatMessage.setWriter(writer);
        aChatMessage.setBody(body);
        aChatMessage.setMessageTime(localDateTime);
        // id는 데이터베이스에 객체가 저장될 때 자동으로 생성되므로 설정할 필요가 없습니다.
        
        chatMessages.add(aChatMessage);
    }

	public List getMessages() {
		
		return chatMessages;
	}

	public List getMessagesFrom(Integer roomId, int from) {
		List<ChatMessage> messages = new ArrayList<>();
		
		for( ChatMessage chatMessage : chatMessages) {
			if(chatMessage.getRoomId() == roomId && chatMessage.getRoomId() >= from ) {
				messages.add(chatMessage);
			}
		}
		
		return messages;
	}

	public void clearAllMessages() {
		chatMessages.clear();
	}

}
