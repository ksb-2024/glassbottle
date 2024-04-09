package com.springproj.emotionshare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.repository.UserRepository;
import com.springproj.emotionshare.securityConfig.CustomUserDetails;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserRepository userRepository;

	
	//로그인관련 
	@Override 
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		UserEntity userData = userRepository.findByUsername(username);

		if (userData != null) {
			return new CustomUserDetails(userData);
		} else {
			throw new UsernameNotFoundException("등록된 사용자가 아닙니다.: " + username);
		}
	}

	
	//유저 삭제 회원탈퇴
	public void withdrawUser(String username) {

		UserEntity user = userRepository.findByUsername(username);
		userRepository.delete(user);
	}
	
	//유저 ID조회 세션저장용
	public Long getUserIDSaveSession(String username) {
		return userRepository.findByUsername(username).getId();
	}
	
	
}
