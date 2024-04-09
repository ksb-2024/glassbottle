package com.springproj.emotionshare.diary.controller;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder
public class DiaryReplyForm {
	
	private Long id;				// 댓글번호
	private Long did;				// 일기 글번호(dID)
	private String writer;			// 작성자(uID)
	private String content;			// 내용
	private LocalDateTime date;		// 등록날짜
	private Long like;				// 추천수, default 0
	private Long groupnum;			// 댓글 그룹번호
	private Long depth;				// 댓글 깊이
	private Long step;				// 댓글 출력 순서
	private String deleteCheck;	 	// 댓글 삭제 체크
}
