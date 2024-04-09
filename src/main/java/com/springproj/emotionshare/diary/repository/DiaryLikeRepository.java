package com.springproj.emotionshare.diary.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.springproj.emotionshare.diary.domain.DiaryLikeID;
import com.springproj.emotionshare.diary.domain.DiaryLikeVO;

public interface DiaryLikeRepository extends JpaRepository<DiaryLikeVO, DiaryLikeID>{
	
	// 좋아요 누른 사람들 목록
	@Query("select dl.id.uID from DiaryLikeVO dl, DiaryVO d where dl.id.dID = d.dID and dl.id.uID != d.dFROMID and dl.id.dID = :dID")
	public List<String> getLikePeople(@Param("dID") Long dID);
}
