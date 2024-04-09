package com.springproj.emotionshare.diary.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Embeddable
public class DiaryReplyLikeID {
	
	@Column(name = "drlUSERID")
	private String uID;
	
	@Column(name = "drlDIARYREPLYID")
	private Long rID;
}
