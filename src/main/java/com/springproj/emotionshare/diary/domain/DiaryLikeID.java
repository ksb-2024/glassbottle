package com.springproj.emotionshare.diary.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Embeddable
public class DiaryLikeID {

	@Column(name = "dlUSERID")
	private String uID;
	
	@Column(name = "dlDIARYID")
	private Long dID;
}
