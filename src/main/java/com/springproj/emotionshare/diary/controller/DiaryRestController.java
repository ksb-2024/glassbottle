package com.springproj.emotionshare.diary.controller;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.springproj.emotionshare.diary.domain.DiaryReplyVO;
import com.springproj.emotionshare.diary.domain.DiaryVO;
import com.springproj.emotionshare.diary.domain.Diary_DiaryShareVO;
import com.springproj.emotionshare.diary.service.DiaryService;
import com.springproj.emotionshare.diary.service.FileService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class DiaryRestController {
	
	@Autowired
	private DiaryService diaryService;
	
	@Autowired
	private FileService fileService;
	
	// 과거 나의 일기 상세
	@GetMapping("/diary/into/{dID}")
	@ResponseBody
	public HashMap<String,Object> intoDiary(@PathVariable("dID") Long dID) {
		log.info("dID(Controller): " + dID);
		DiaryVO findDiary = diaryService.getDiary(dID);
		
		//조회수 증가 처리
		diaryService.updateDiaryCount(dID);
		
		//댓글 목록 조회
		List<DiaryReplyVO> diaryReplyList =  diaryService.getDiaryReplyList(dID);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("diary", findDiary);
		map.put("replyList", diaryReplyList);
		
		return map;
	}
	
	//lastDiary 삭제체크(사용)
	@PostMapping("/diary/deleteDiary")
	public void deleteLastDiary(@RequestParam("dID") Long did,
								HttpServletRequest request) {
		String username = (String)request.getSession().getAttribute("username");
		log.info("dID(deleteLastDiary Controller):" + did);
		diaryService.updateMyOldDiaryDeleteCheck(did, username);
	}
	
	// 오늘 나의 일기 조회
	@GetMapping("/diary/today")
	public DiaryForm getTodayDiary(HttpServletRequest request) {
		String uID = (String)request.getSession().getAttribute("userID");
		log.info("uID(Controller.todayDiary):" + uID);
		DiaryForm todayDiary = diaryService.getTodayDiary(uID);
			
		return todayDiary;
	}
	
	// 일기 좋아요(사용)
	@PostMapping("/diary/likeDiary")
	public Long likeDiary(@RequestParam("dID") Long dID,
						HttpServletRequest request) {
		String uID = (String)request.getSession().getAttribute("username");
		log.info("likeDiary (DiaryController) dID : " + dID + ", uID : " + uID);
		
		diaryService.likeDiary(uID, dID);
		Long like = diaryService.getDiary(dID).getDLIKE();
		return like;
	}
	
	// 일기 좋아요 누른 사람 조회(사용)
	@PostMapping("/diary/likeMan")
	public String likeDiaryMan(@RequestParam("dID") Long dID) {
		
		return diaryService.getLikeMan(dID);
	}
	
	
	///////////////////////
	//diaryshare
	
	// 오늘 나의 일기 share(사용)
	@PostMapping("/diary/todayShare")
	public void shareTodayDiary(@RequestParam("dID") Long dID,HttpServletRequest request) {
		log.info("dID(shareTodayDiary : Controller ) : " + dID);
		diaryService.shareTodayDiary(dID, String.valueOf(request.getSession().getAttribute("username")));
	}
	
	// 수신 받은 읽기 목록 조회
	@GetMapping("/diary/received/{uID}")
	@ResponseBody
	public List<Diary_DiaryShareVO> getReceivedDiarys(@PathVariable("uID") String uID){
		//log.info("uID(Controller):" + uID);
		List<Diary_DiaryShareVO> receivedDDShare = diaryService.getReceivedDiaryList(uID);
		//log.info(receivedDiarys.toString());
		return receivedDDShare;
	}
	
	// 수신 받은 일기 상세
	@GetMapping("/diary/received/into/{dID}")
	@ResponseBody
	public DiaryVO receivedIntoDiary(@PathVariable("dID") Long dID,
									HttpServletRequest request) {
		log.info("dID(receivedIntoDiary : Controller): " + dID);
		DiaryVO findDiary = diaryService.getDiary(dID);
		
		//조회수 증가 처리
		diaryService.updateDiaryCount(dID);
		
		// 읽기 체크
		String uID = (String)request.getSession().getAttribute("userID");
		Long dGROUPID = findDiary.getDGROUPID();
		diaryService.updateReceivedDiaryReadCheck(dGROUPID, dID, uID);
		return findDiary;
	}
	
	
	//sharedDiary 삭제체크(사용)
	@PostMapping("/diary/deleteSharedDiary")
	public void deleteSharedDiary(@RequestParam("dID") Long did,
								HttpServletRequest request) {
		String username = (String)request.getSession().getAttribute("username");
		log.info("dID(deleteSharedDiary Controller):" + did);
		DiaryVO findDiary = diaryService.getDiary(did);
		
		// 삭제 체크
		Long dGROUPID = findDiary.getDGROUPID();
		diaryService.updateReceivedDiaryDeleteCheck(dGROUPID, did, username);
	}
	
	// 안읽은 shared 일기 수 체크(사용)
	@GetMapping("/diary/noReadCheck")
	public String noReadDiaryCheck(HttpServletRequest request) {
		String username = (String)request.getSession().getAttribute("username");
		String noReadCount = String.valueOf(diaryService.getNoReadCheckSharedDiary(username));
		return noReadCount;
	}
	
	//////////////////////////
	///// DiaryReply
	
	// 댓글 기본 작성(사용)
	@PostMapping("/diary/writeReply")
	public void writeDiaryReply(@RequestParam("dID") String dID,
								@RequestParam("content") String content,
								HttpServletRequest request) {
		String uID = (String)request.getSession().getAttribute("username");
		//log.info("writeReply DiaryController!!!!");
		//log.info("dID : " + dID + ", content : " + content + ", userID : " + uID);
		DiaryReplyForm diaryReplyForm = DiaryReplyForm.builder()
													.did(Long.parseLong(dID))
													.content(content)
													.writer(uID)
													.date(LocalDateTime.now())
													.like(0L)
													.deleteCheck("NO_DELETE")
													.build();
		diaryService.saveDiaryReply(diaryReplyForm);
	}
	
	// 대댓글 작성
	@PostMapping("/diary/into/replyLoop")
	public void loopDiaryReply(@RequestParam("rID") String rID,
							   @RequestParam("rCONTENT") String content,
							   HttpServletRequest request) {
		String uID = (String)request.getSession().getAttribute("userID");
		//log.info("loopDiaryReply DiaryController!!!!");
		//log.info("rID : " + rID + ", content : " + content + ", userID : " + uID);
		DiaryReplyForm diaryReplyForm = DiaryReplyForm.builder()
													.content(content)
													.writer(uID)
													.date(LocalDateTime.now())
													.like(0L)
													.depth(1L)
													.deleteCheck("NO_DELETE")
													.build();
		diaryService.saveLoopDiaryReply(diaryReplyForm, Long.parseLong(rID));
	}
	
	// 댓글 수정(사용)
	@PostMapping("/diary/updateReply")
	public void updateDiaryReply(@RequestParam("rID") String rID,
								 @RequestParam("rCONTENT") String content,
								 @RequestParam("dID") String did) {
		//log.info("updateDiaryReply DiaryController!!!!");
		//log.info("rID : " + rID + ", content : " + content);
		diaryService.updateDiaryReply(content, Long.parseLong(rID));
		
	}
	
	// 댓글 삭제(사용)
	@PostMapping("/diary/deleteReply")
	public DiaryReplyVO deleteDiaryReply(@RequestParam("rID") String rID) {
		//log.info("deleteDiaryReply DiaryController!!!!");
		
		diaryService.deleteDiaryReply(Long.parseLong(rID));
		DiaryReplyVO reply = diaryService.getDiaryReply(Long.parseLong(rID));
		return reply;
	}
	
	// 댓글 좋아요(사용)
	@PostMapping("/diary/into/replyLike")
	public void likeDiaryReply(@RequestParam("rID") String rID,
								HttpServletRequest request) {
		String uID = (String)request.getSession().getAttribute("userID");
		//log.info("likeDiaryReply DiaryController!!!!");
		//log.info("uID : " + uID + ", rID : " + rID);
		
		diaryService.likeDiaryReply(uID, Long.parseLong(rID));
	}
	
	// 특정 댓글 목록 조회(사용)
	@GetMapping("/diaryReply/{did}")
	public List<DiaryReplyVO> getReplys(@PathVariable("did") String did){
			log.info("did : " + did);
			List<DiaryReplyVO> replyList = diaryService.getDiaryReplyList(Long.parseLong(did));
			log.info("replyList : " + replyList);
		return replyList;
	}
	
	//////////////////
	/// Mainpage
	
	@GetMapping("/diary/ourDiaries")
	public List<DiaryForm> getOurDiaries(HttpServletRequest request) {
		String username = (String)request.getSession().getAttribute("username");
		Long userid = (Long)request.getSession().getAttribute("userid"); 
		log.info("userid : " + userid);
		List<DiaryForm> diaryList = diaryService.getTodayOurStories(userid,username);
		log.info("story diaryList : " + diaryList);
		return diaryList;
	}

}
