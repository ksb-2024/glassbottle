package com.springproj.emotionshare.glassBottle.model;


public enum FriendRequestStatus {
    PENDING, // 대기
    ACCEPTED, // 수락됨
    DECLINED;  // 거절됨
    
    @Override
    public String toString() {
        return name();
    }
}
