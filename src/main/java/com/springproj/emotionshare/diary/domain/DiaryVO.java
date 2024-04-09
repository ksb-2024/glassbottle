package com.springproj.emotionshare.diary.domain;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@Table(name = "diary")
public class DiaryVO {
	
	@Id
	@Column(name = "dID")     	  private Long dID; 		 	    // 글아이디,
	@Column(name = "dTITLE")  	  private String dTITLE;   		    // 글제목 NOT NULL
	@Column(name = "dFROMID") 	  private String dFROMID;  		    // 보내는사람, 사용자아이디(uID), NOT NULL
	@Column(name = "dGROUPID")    private Long dGROUPID;    		// 받는 그룹 번호, 그룹 번호(dsGROUPID)
	@Column(name = "dDATE")   	  private LocalDateTime dDATE;      // 작성날짜, NOT NULL 
	@Column(name = "dCONTENT")	  private String dCONTENT; 	        // 글내용, NOT NULL
	@Column(name = "dEMOTION")	  private String dEMOTION;          // 감정, TYPE 즐거움 , 슬픔...
	@Column(name = "dWEATHER")	  private String dWEATHER;          // 날씨, TYPE 맑음 , 흐림...
	@Column(name = "dCNT")	  	  private Long dCNT;                // 조회수, DEFAULT:0
	@Column(name = "dLIKE")	      private Long dLIKE;               // 추천수, DEFAULT:0
	@Column(name = "dSHARECHECK") private String dSHARECHECK;       // 송신자 share 체크, DEFAULT:NO_SHARE 공유 SHARE
	@Column(name = "dDELETECHECK")private String dDELETECHECK;      // 송신자 삭제 체크, DEFAULT:NO_DELETE 삭제 DELETE
	@Column(name = "dFILENAME")   private String dFILENAME;         // 업로드 파일 이름
}
