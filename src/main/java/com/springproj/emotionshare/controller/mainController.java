package com.springproj.emotionshare.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.springproj.emotionshare.diary.controller.DiaryForm;
import com.springproj.emotionshare.diary.domain.DiaryReplyVO;
import com.springproj.emotionshare.diary.service.DiaryService;
import com.springproj.emotionshare.securityConfig.CustomUserDetails;
import com.springproj.emotionshare.service.CustomUserDetailsService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class mainController {
	
	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
	@Autowired
	private DiaryService diaryService;
	
	@GetMapping("/mainpage")
	public String mainP(Model model,HttpServletRequest request) {

		String username = SecurityContextHolder.getContext().getAuthentication().getName();

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
		Iterator<? extends GrantedAuthority> iter = authorities.iterator();
		GrantedAuthority auth = iter.next();
		String role = auth.getAuthority();
		String Id = SecurityContextHolder.getContext().getAuthentication().getName();
		Long userid = customUserDetailsService.getUserIDSaveSession(username);
		model.addAttribute("username", username);
		request.getSession().setAttribute("username", username);
		request.getSession().setAttribute("userid", userid);
		model.addAttribute("role", role);
		
		// 메인페이지 다이어리 뽑습니다. 실례합니다.
		List<DiaryForm> findDiarys = diaryService.getAllDiaryList(userid);
		HashMap<Long, List<DiaryReplyVO>> map = new HashMap<>();
		HashMap<Long, String> likePeople = new HashMap<>();  
		//댓글 목록 조회
		for(DiaryForm findDiary : findDiarys) {
			List<DiaryReplyVO> diaryReplyList =	diaryService.getDiaryReplyList(findDiary.getDID());
			map.put(findDiary.getDID(), diaryReplyList);
		}
		// 좋아요 누른사람 조회
		for(DiaryForm findDiary : findDiarys) {
			String likeMan = diaryService.getLikeMan(findDiary.getDID());
			likePeople.put(findDiary.getDID(), likeMan);
		}
		log.info("likePeople : " + likePeople);
		
		model.addAttribute("diaryList",findDiarys);
		model.addAttribute("replyMap", map);
		model.addAttribute("likePeople", likePeople);
		
		return "index";

	}

	@GetMapping("/mypage")
	public String myPage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
	    String nick = userDetails.getNick();
	    String name = userDetails.getName();
	    String tel = userDetails.getTel();
	    String birth = userDetails.getBirth();
	    String gender = userDetails.getGender();
	    String useremail = userDetails.getUseremail();
	   
	  
	    model.addAttribute("nick", nick);
	    model.addAttribute("name", name);
	    model.addAttribute("tel", tel);
	    model.addAttribute("birth", birth);
	    model.addAttribute("gender", gender);
	    model.addAttribute("useremail", useremail);
	  
	    return "mypage";
	}
	
	

}