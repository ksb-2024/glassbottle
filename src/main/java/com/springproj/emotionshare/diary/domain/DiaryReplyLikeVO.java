package com.springproj.emotionshare.diary.domain;

import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "DIARY_REPLY_LIKE")
public class DiaryReplyLikeVO {
	
	@EmbeddedId
	private DiaryReplyLikeID id;
}
