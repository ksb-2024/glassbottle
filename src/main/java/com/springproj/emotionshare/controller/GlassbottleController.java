package com.springproj.emotionshare.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GlassbottleController {
	/*
	//메인페이지 
	@GetMapping("/mainpage")
	public String loginForm() {
		return "/glassbottle/member/mainpage";
	}
	*/
	//////////////////메뉴들
	/*
	"lastDiary.do" 과거 나의 일기
	"comeDiary.do" 수신 받을 일기
	"feelMonth.do" 한달 나의 기분
	"myChat.do" 채팅창
	"myFriends.do" 친구목록
	"feelNow.do" 나의 기분 상태
	"myPage.do" 마이페이지
	*/
	
	//과거 나의 일기
	@GetMapping("/lastDiary.do")
	public String lastDiary(Model model) {
		return "/glassbottle/member/mydiarylast";
	}
	
	//수신 받을 일기
	@GetMapping("/comeDiary.do")
	public String comeDiary(Model model) {
		return "/glassbottle/member/comeondiary";
	}
	
	//한달 나의 기분
	@GetMapping("/feelMonth.do")
	public String feelMonth(Model model) {
		return "/glassbottle/member/myfeelmonth";
	}
	
	//채팅창(일단 ajax)
	@GetMapping("/myChat.do")
	@ResponseBody
	public List<String> myChat() {
		//채팅방이 있다고 가정하기 위한 코드(상상)
		//ChatRoomVO chatRoom = new ChatRoomVO();
		//chatRoom.getTitle("");
		
		List<String> chatRoomTitles = new ArrayList();
		chatRoomTitles.add("SKT T1 응원방");
		chatRoomTitles.add("로스트아크 대기방");
		chatRoomTitles.add("옛날메이플 파티방");
		chatRoomTitles.add("해외축구 팬들방");
		chatRoomTitles.add("주식 종합토론방");
		return chatRoomTitles;
	}	
	
	//친구목록
	@GetMapping("/myFriends.do")
	public String myFriends(Model model) {
		return "/glassbottle/member/myfriends";
	}	
	
	//나의 기분 상태
	@GetMapping("/feelNow.do")
	public String feelNow(Model model) {
		return "/glassbottle/member/myfeelnow";
	}	
	
	
}
