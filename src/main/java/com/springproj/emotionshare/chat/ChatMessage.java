package com.springproj.emotionshare.chat;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Table(name = "chat_messages")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatMessage {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column(name = "room_id") // 외래 키를 저장할 컬럼
	private Integer roomId; // 실제 정수 ID

	@ManyToOne
	@JoinColumn(name = "room_id", insertable = false, updatable = false)
	@JsonBackReference
	private ChatRoom chatRoom; // ChatRoom 객체
//	private Integer roomId;
	private String writer;
	private String body;
	private LocalDateTime messageTime;

	private Boolean isRead = false; // 메시지 읽음 상태, 기본값은 false

    // 메시지 읽음 상태를 설정하는 메소드
    public void setRead(Boolean read) {
        isRead = read;
    }

    // 메시지 읽음 상태를 반환하는 메소드
    public Boolean isRead() {
        return isRead;
    }
	
	@PrePersist
    protected void onCreate() {
		if (messageTime == null) {
        messageTime = LocalDateTime.now();
		}
    }
	
}
