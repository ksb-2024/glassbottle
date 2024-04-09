package com.springproj.emotionshare.diary.controller;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class DiaryForm {
	
	private Long dID; 		 	    // 글아이디,
	private String dTITLE;   		    // 글제목 NOT NULL
	private String dFROMID;  		    // 보내는사람, 사용자아이디(uID), NOT NULL
	private Long dGROUPID;    		// 받는 그룹 번호, 그룹 번호(dsGROUPID)
	private LocalDateTime dDATE;      // 작성날짜, NOT NULL 
    private String dCONTENT; 	        // 글내용, NOT NULL
	private String dEMOTION;          // 감정, TYPE 즐거움 , 슬픔...
	private String dWEATHER;          // 날씨, TYPE 맑음 , 흐림...
    private Long dCNT;                // 조회수, DEFAULT:0
	private Long dLIKE;               // 추천수, DEFAULT:0
	private String dSHARECHECK;       // 송신자 share 체크, DEFAULT:NO_SHARE 공유 SHARE
	private String dDELETECHECK;      // 송신자 삭제 체크, DEFAULT:NO_DELETE 삭제 DELETE
	private String dFILENAME;	 	  // 업로드 파일 이름
}
