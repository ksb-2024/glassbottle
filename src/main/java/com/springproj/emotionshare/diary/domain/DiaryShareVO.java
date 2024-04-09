package com.springproj.emotionshare.diary.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Entity
@Table(name = "diary_share")
public class DiaryShareVO {
	@Id
	@Column(name = "dsCODE") 	   private Long    		 dsCODE; 		  // 그냥 기본키, 등록될때마다 1씩 증가
	@Column(name = "dsGROUPID")    private Long    	     dsGROUPID; 	  // 수신자들 그룹번호
	@Column(name = "dsDID")	       private Long    	     dsDID;		      // 일기 아이디(dID)
	@Column(name = "dsID")	  	   private String        dsID;		      // 사용자 아이디(uID)
	@Column(name = "dsDATE")	   private LocalDateTime dsDATE;		  // 등록 시간
	@Column(name = "dsREADCHECK")  private String        dsREADCHECK;     // 수신자 읽음체크, DEFAULT:NO_READ 읽음 READ
	@Column(name = "dsDELETECHECK")private String        dsDELETECHECK;   // 수신자 삭제체크, DEFAULT:NO_DELETE 삭제 DELETE
}
