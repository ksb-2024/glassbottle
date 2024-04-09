package com.springproj.emotionshare.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springproj.emotionshare.domain.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
	List<UserEntity> findByNameContaining(String name); // UserEntity 반환 타입으로 변경

	Optional<UserEntity> findByName(String name); // UserEntity 반환 타입으로 변경

	UserEntity findByUsername(String username);
	
	UserEntity findByUsernameAndNameAndBirth(String username, String name, String birth);

	// 로그인관련
	boolean existsByUsername(String username); // 존재하면 true ,존재하지않으면 false 커스텀jpa

	

	 
}
