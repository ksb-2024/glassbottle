package com.springproj.emotionshare.diary.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springproj.emotionshare.diary.domain.DiaryReplyVO;
import com.springproj.emotionshare.diary.domain.DiaryVO;
import com.springproj.emotionshare.diary.domain.Diary_DiaryShareVO;
import com.springproj.emotionshare.diary.service.DiaryService;
import com.springproj.emotionshare.diary.service.FileService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DiaryController {
	
	@Autowired
	private DiaryService diaryService;
	
	@Autowired
	private FileService fileService;
	
	String username = "";
	
	public void checkCurrentUsername(HttpServletRequest request) {
			username = (String)request.getSession().getAttribute("username");
	}
	
// 서브메뉴 todayDiary(사용)
	@GetMapping("/diary/todayDiary")
	public String goTodayDiary(HttpServletRequest request, Model model) {
		checkCurrentUsername(request);
		String likeMan = "";
		
		DiaryForm diaryForm = diaryService.getTodayDiary(username);
		if(diaryForm != null) {
			List<DiaryReplyVO> diaryReplyList =	diaryService.getDiaryReplyList(diaryForm.getDID());
			model.addAttribute("replyList", diaryReplyList);
		}
		
		// 좋아요 누른사람 조회
		if(diaryForm != null) {
			likeMan = diaryService.getLikeMan(diaryForm.getDID());
		}
		log.info("likeMan : " + likeMan);
		
		
		model.addAttribute("diary", diaryForm);
		model.addAttribute("likeMan", likeMan);
		
		return "diary/todaydiaryhome";
	}
	// 일기 작성(사용)
	@PostMapping("/diary/write")
	public String insertTodayDiary(@RequestParam("file") MultipartFile file,
								   DiaryForm diaryForm) {
		log.info("diaryForm : " + diaryForm + ", file : " + file.getOriginalFilename());
		String filename = null;
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			filename = fileService.storeFile(file);
			log.info("filename = " + filename);
		}
		diaryService.saveDiary(diaryForm.getDTITLE(), username, diaryForm.getDCONTENT(), diaryForm.getDEMOTION(), diaryForm.getDWEATHER(), filename);
		return "redirect:/diary/todayDiary";
	}
	
	//일기 삭제(사용)
	@PostMapping("/diary/today/delete")
	public String deleteTodayDiary(@RequestParam("dID") Long dID) {
		diaryService.deleteDiary(dID);
		return "redirect:/diary/todayDiary";
	}
	
	//일기 수정 화면 이동(사용)
	@PostMapping("/diary/todayupdateForm")
	public String goUpdateTodayDiary(@RequestParam("did") Long dID,
									Model model) {
		log.info("goUpdateTodayDiary");
		log.info(String.valueOf(dID));
		DiaryVO findDiary = diaryService.getDiary(dID);
		model.addAttribute("diary", findDiary);
		return "diary/todaydiaryupdateform";
	}
	//일기 수정(사용)
	@PostMapping("/diary/update")
	public String updateTodayDiary(@RequestParam("file") MultipartFile file,
			   						DiaryForm diaryForm) {
		log.info("diaryForm : " + diaryForm + ", file : " + file.getOriginalFilename());
		String filename = null;
		if(file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
			filename = fileService.storeFile(file);
			log.info("filename = " + filename);
		}
		diaryForm.setDFILENAME(filename);
		diaryService.updateDiary(diaryForm);
		return "redirect:/diary/todayDiary";
	}
	
	
// 서브메뉴 sharedDiary(사용)
	@GetMapping("/diary/sharedDiary")
	public String goSharedDiary(HttpServletRequest request,Model model) {
		checkCurrentUsername(request);
		List<Diary_DiaryShareVO> receivedDDShare = diaryService.getReceivedDiaryList(username);
		HashMap<Long, List<DiaryReplyVO>> map = new HashMap<>();
		HashMap<Long, String> likePeople = new HashMap<>();  
		//댓글 목록 조회
		for(Diary_DiaryShareVO findDiary : receivedDDShare) {
			List<DiaryReplyVO> diaryReplyList =	diaryService.getDiaryReplyList(findDiary.getDID());
			map.put(findDiary.getDID(), diaryReplyList);
		}
		
		// 좋아요 누른사람 조회
		for(Diary_DiaryShareVO findDiary : receivedDDShare) {
			String likeMan = diaryService.getLikeMan(findDiary.getDID());
			likePeople.put(findDiary.getDID(), likeMan);
		}
		log.info("likePeople : " + likePeople);
		
		model.addAttribute("diaryList", receivedDDShare);
		model.addAttribute("replyMap", map);
		model.addAttribute("likePeople", likePeople);
		
		return "diary/shareddiaryhome";
	}
	
// 서브메뉴 lastDiary(사용)
	@GetMapping("/diary/lastDiary")
	public String goLastDiary(HttpServletRequest request,Model model) {
		checkCurrentUsername(request);
		List<DiaryForm> findDiarys = diaryService.getDiaryList(username);
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
		
		return "diary/lastdiaryhome";
	}
	
	//////////////////////
	//// Mainpage 스토리
	
	@GetMapping("/story/{did}")
	public String goStoryInto(@PathVariable("did") Long did, Model model) {
		DiaryVO diary = diaryService.getDiary(did);
		DiaryForm diaryForm = diaryService.changeDiaryToForm(diary);
		String likeMan = "";
		
		//댓글 목록 조회
	      if(diaryForm != null) {
	         List<DiaryReplyVO> diaryReplyList =   diaryService.getDiaryReplyList(diaryForm.getDID());
	         model.addAttribute("replyList", diaryReplyList);
	      };
		
		// 좋아요 누른사람 조회
		if(diaryForm != null) {
			likeMan = diaryService.getLikeMan(diaryForm.getDID());
		}
		log.info("likeMan : " + likeMan);
		
		model.addAttribute("diary",diaryForm);
		model.addAttribute("likeMan", likeMan);
		
		return "diary/storyinto";
	}
}
