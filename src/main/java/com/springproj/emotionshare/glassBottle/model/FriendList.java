package com.springproj.emotionshare.glassBottle.model;

import com.springproj.emotionshare.domain.UserEntity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Table(name = "FRIEND_LIST")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class FriendList {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
  
    @ManyToOne
    private UserEntity user1;

    @ManyToOne
    private UserEntity user2;
}

