package com.springproj.emotionshare.glassBottle.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.glassBottle.DTO.UserDto;
import com.springproj.emotionshare.glassBottle.model.Blacklist;
import com.springproj.emotionshare.glassBottle.repository.BlacklistRepository;
import com.springproj.emotionshare.repository.UserRepository;

@Service
public class BlacklistService {
	
    @Autowired
    private BlacklistRepository blacklistRepository;

    @Autowired
    private UserRepository userRepository;

    // 블랙리스트에 사용자 추가
    public void addUserToBlacklist(Long ownerId, Long userId) {
        UserEntity owner = userRepository.findById(ownerId)
            .orElseThrow(() -> new RuntimeException("Owner not found"));
        UserEntity blockedUser = userRepository.findById(userId)
            .orElseThrow(() -> new RuntimeException("Blocked user not found"));

        Blacklist blacklist = new Blacklist();
        blacklist.setOwner(owner);
        blacklist.setBlockedUser(blockedUser);
        blacklistRepository.save(blacklist);
    }

    
    public List<UserDto> getBlacklist(Long currentUserId) {
        // 현재 로그인한 사용자의 블랙리스트만 조회
    	 return blacklistRepository.findByOwnerId(currentUserId).stream()
    		        .map(blacklist -> new UserDto(
    		            blacklist.getBlockedUser().getId(),
    		            blacklist.getBlockedUser().getUsername(),
    		            blacklist.getBlockedUser().getNick(),
    		            blacklist.getBlockedUser().getName(),
    		            blacklist.getBlockedUser().getTel(),
    		            blacklist.getBlockedUser().getBirth(),
    		            blacklist.getBlockedUser().getGender(),
    		            blacklist.getBlockedUser().getUseremail(),
    		            blacklist.getBlockedUser().getRole()
    		        ))
    		        .collect(Collectors.toList());
    }



 // 블랙리스트 검색 로직
    public List<UserDto> searchBlacklist(Long ownerId, String name) {
        return blacklistRepository.findByOwnerIdAndBlockedUserNameContaining(ownerId, name).stream()
                .map(blacklist -> new UserDto(
                        blacklist.getBlockedUser().getId(),
                        blacklist.getBlockedUser().getUsername(),
                        blacklist.getBlockedUser().getNick(),
                        blacklist.getBlockedUser().getName(),
                        blacklist.getBlockedUser().getTel(),
                        blacklist.getBlockedUser().getBirth(),
                        blacklist.getBlockedUser().getGender(),
                        blacklist.getBlockedUser().getUseremail(),
                        blacklist.getBlockedUser().getRole()
                ))
                .collect(Collectors.toList());
    }

    // 수정 버전
    // 블랙리스트에서 사용자 제거
    public void removeUserFromBlacklist(Long ownerId, Long userId) {
        Blacklist blacklist = blacklistRepository.findByOwnerIdAndBlockedUserId(ownerId, userId)
            .orElseThrow(() -> new RuntimeException("블랙리스트 항목을 찾을 수 없음"));
        blacklistRepository.delete(blacklist);
    }


}
