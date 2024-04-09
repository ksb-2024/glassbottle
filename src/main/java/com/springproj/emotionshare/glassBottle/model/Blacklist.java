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

@Data
@Table(name = "Blacklist")
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Blacklist {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private UserEntity blockedUser; // 블랙리스트에 추가된 사용자

    @ManyToOne
    private UserEntity owner; // 블랙리스트의 소유자
}

