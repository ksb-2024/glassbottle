package com.springproj.emotionshare.chat;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service
public class ChatUserService {
    private Map<String, Integer> userRoomMap = new ConcurrentHashMap<>();

    public void enterRoom(String username, Integer roomId) {
        userRoomMap.put(username, roomId);
    }

    public void leaveRoom(String username) {
        userRoomMap.remove(username);
    }

    public Integer getCurrentRoom(String username) {
        return userRoomMap.get(username);
    }
}
