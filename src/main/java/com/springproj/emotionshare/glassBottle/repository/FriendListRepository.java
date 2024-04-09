package com.springproj.emotionshare.glassBottle.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springproj.emotionshare.glassBottle.model.FriendList;

import jakarta.transaction.Transactional;

public interface FriendListRepository extends JpaRepository<FriendList, Long> {
	  List<FriendList> findByUser1IdOrUser2Id(Long user1Id, Long user2Id);
	  
	  @Transactional
	  void deleteByUser1IdAndUser2Id(Long user1Id, Long user2Id);
	  
	  //수정 버전
	  //이미 친구인지 아닌지 확인 메서드
	  boolean existsByUser1IdAndUser2Id(Long user1Id, Long user2Id);
	
	  //메인페이지 스토리 게시용
	  List<FriendList> findByUser1Id(Long user1Id);
	  
	//메인페이지 스토리 게시용2
	  List<FriendList> findByUser2Id(Long user2Id);
}
