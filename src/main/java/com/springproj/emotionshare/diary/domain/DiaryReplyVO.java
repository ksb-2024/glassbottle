package com.springproj.emotionshare.diary.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "DIARY_REPLY")
public class DiaryReplyVO {
	
	@Id 
	@Column(name = "drID")       private Long id;				// 댓글번호
	@Column(name = "drDID")      private Long did;				// 일기 글번호(dID)
	@Column(name = "drWRITER")   private String writer;			// 작성자(uID)
	@Column(name = "drCONTENT")  private String content;		// 내용
	@Column(name = "drDATE") 	 private LocalDateTime date;	// 등록날짜
	@Column(name = "drLIKE") 	 private Long like;				// 추천수, default 0
	@Column(name = "drGROUPNUM") private Long groupnum;			// 댓글 그룹번호
	@Column(name = "drDEPTH")    private Long depth;			// 댓글 깊이
	@Column(name = "drSTEP")     private Long step;				// 댓글 출력 순서
	@Column(name = "drDELETECHECK")	private String deleteCheck;	// 댓글 삭제 체크
	
}
