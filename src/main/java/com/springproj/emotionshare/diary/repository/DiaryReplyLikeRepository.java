package com.springproj.emotionshare.diary.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.springproj.emotionshare.diary.domain.DiaryReplyLikeID;
import com.springproj.emotionshare.diary.domain.DiaryReplyLikeVO;

public interface DiaryReplyLikeRepository  extends JpaRepository<DiaryReplyLikeVO, DiaryReplyLikeID>{

}
