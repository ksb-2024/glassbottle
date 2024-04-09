package com.springproj.emotionshare.chat;

import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.springproj.emotionshare.domain.UserEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "chat_rooms")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChatRoom {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer roomId;

    private String name;
    // 사용자별 채팅방 이름 저장을 위한 필드 추가
    private String user1RoomName;
    private String user2RoomName;

    @Column(nullable = false, updatable = false)
    private LocalDateTime creationTime;
    
    @OneToMany(mappedBy = "roomId")
    @JsonManagedReference
    private List<ChatMessage> messages;
    
    
    @ManyToOne
    @JoinColumn(name = "user1_id")  // 첫 번째 사용자의 외래 키
    private UserEntity user1;

    @ManyToOne
    @JoinColumn(name = "user2_id")  // 두 번째 사용자의 외래 키
    private UserEntity user2;
    @PrePersist
    protected void onCreate() {
        if (creationTime == null) {
            creationTime = LocalDateTime.now();
        }
    }
}


