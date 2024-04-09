package com.springproj.emotionshare.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import com.springproj.emotionshare.Dto.SignupDTO;
import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.repository.UserRepository;

@Service
public class SignupService {

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Autowired
	private UserRepository userRepository;

	public void signupProcess(SignupDTO signupDTO) {

		// db에 아이디중복확인
		boolean isUser = userRepository.existsByUsername(signupDTO.getUsername());
		if (isUser) {
			return;
		}

		UserEntity data = new UserEntity();

		data.setUsername(signupDTO.getUsername());
		data.setPassword(bCryptPasswordEncoder.encode(signupDTO.getPassword())); // 비밀번호 암호화 저장
		data.setRole("ROLE_USER");

		data.setNick(signupDTO.getNick());
		data.setName(signupDTO.getName());
		data.setTel(signupDTO.getTel());
		data.setBirth(signupDTO.getBirth());
		data.setGender(signupDTO.getGender());
		data.setUseremail(signupDTO.getUseremail());
		
		
		

		
		
		userRepository.save(data);
	}
	
	
	
}
