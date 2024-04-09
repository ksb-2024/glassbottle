package com.springproj.emotionshare.glassBottle.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.repository.UserRepository;

@Service
public class UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder; //
	}

	public UserEntity createUser(String username, String password, String nick, String name, String tel, String birth,
			String gender, String useremail, String edomain, String role) {
		UserEntity newUser = new UserEntity();

		newUser.setUsername(username);
		newUser.setPassword(passwordEncoder.encode(password)); // 비밀번호 암호화
		newUser.setNick(nick);
		newUser.setName(name);
		newUser.setTel(tel);
		newUser.setBirth(birth);
		newUser.setGender(gender);
		newUser.setUseremail(useremail);
		newUser.setRole(role);

		return userRepository.save(newUser); // userRepository를 통해 데이터베이스에 저장
	}

	public UserEntity getUserInfo(Long userId) {
		// userId를 사용하여 UserRepository에서 사용자 정보를 조회
		Optional<UserEntity> userOptional = userRepository.findById(userId);

		// 사용자 정보를 찾았을 경우 해당 정보를 반환, 없으면 null 반환
		return userOptional.orElse(null);
	}

	public List<UserEntity> findAllUsers() {
		List<UserEntity> users = userRepository.findAll();
		return users;
	}

	public UserEntity findUser(String username) {
		// username을 기반으로 사용자를 데이터베이스에서 검색
		UserEntity user = userRepository.findByUsername(username);

		if (user == null) {
			// 사용자가 데이터베이스에 없으면 UsernameNotFoundException을 발생시킵니다.
			throw new UsernameNotFoundException("User not found with username: " + username);
		}

		// 사용자가 존재하면 반환
		return user;
	}
	
	
	//비밀번호 찾기 (변경)
	public void updateNewPassword(String password, String username) { 
		UserEntity findUser = userRepository.findByUsername(username);
		findUser.setPassword(passwordEncoder.encode(password)); 
		userRepository.flush();
	}

}
