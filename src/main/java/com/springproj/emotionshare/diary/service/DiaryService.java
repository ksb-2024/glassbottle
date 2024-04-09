package com.springproj.emotionshare.diary.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.springproj.emotionshare.diary.controller.DiaryForm;
import com.springproj.emotionshare.diary.controller.DiaryReplyForm;
import com.springproj.emotionshare.diary.domain.DiaryLikeID;
import com.springproj.emotionshare.diary.domain.DiaryLikeVO;
import com.springproj.emotionshare.diary.domain.DiaryReplyLikeID;
import com.springproj.emotionshare.diary.domain.DiaryReplyLikeVO;
import com.springproj.emotionshare.diary.domain.DiaryReplyVO;
import com.springproj.emotionshare.diary.domain.DiaryShareVO;
import com.springproj.emotionshare.diary.domain.DiaryVO;
import com.springproj.emotionshare.diary.domain.Diary_DiaryShareVO;
import com.springproj.emotionshare.diary.repository.DiaryLikeRepository;
import com.springproj.emotionshare.diary.repository.DiaryReplyLikeRepository;
import com.springproj.emotionshare.diary.repository.DiaryReplyRepository;
import com.springproj.emotionshare.diary.repository.DiaryRepository;
import com.springproj.emotionshare.diary.repository.DiaryShareRepository;
import com.springproj.emotionshare.domain.UserEntity;
import com.springproj.emotionshare.glassBottle.model.Blacklist;
import com.springproj.emotionshare.glassBottle.model.FriendList;
import com.springproj.emotionshare.glassBottle.repository.BlacklistRepository;
import com.springproj.emotionshare.glassBottle.repository.FriendListRepository;
import com.springproj.emotionshare.repository.UserRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class DiaryService{

	private final DiaryRepository diaryRepository;
	
	private final DiaryShareRepository diaryShareRepository;
	
	private final DiaryReplyRepository diaryReplyRepository;
	
	private final DiaryLikeRepository diaryLikeRepository;
	
	private final DiaryReplyLikeRepository diaryReplyLikeRepository;
	
	private final UserRepository userRepository;
	
	private final FriendListRepository friendListRepository;
	
	private final BlacklistRepository blacklistRepository;
	
	// 일기 저장(사용)
	public Long saveDiary(String dTITLE, String uID, String dCONTENT, String dEMOTION, String dWEATHER, String dFILENAME) {
		//java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//String dDATE = sdf.format(new java.util.Date());
		LocalDateTime dDATE = LocalDateTime.now();
		Long primeDID = 0L; 
		if(diaryRepository.getPrimeDID() == null) { primeDID = 0L;} 
		else {primeDID = diaryRepository.getPrimeDID() + 1;}
		DiaryVO diary = DiaryVO.builder()
									.dID(primeDID)
									.dTITLE(dTITLE)
									.dFROMID(uID)
									.dCONTENT(dCONTENT)
									.dDATE(dDATE)
									.dEMOTION(dEMOTION)
									.dWEATHER(dWEATHER)
									.dCNT(0L)
									.dLIKE(0L)
									.dSHARECHECK("NO_SHARE")
									.dDELETECHECK("NO_DELETE")
									.dFILENAME(dFILENAME)
									.build();
		log.info("insert Diary(DiaryServiceImpl):" + diary.toString());
		diaryRepository.save(diary);
		return diary.getDID();
	}

	// 일기 수정(사용)
	@Transactional
	public Long updateDiary(DiaryForm diary) {
		DiaryVO saveDiary = getDiary(diary.getDID());
		saveDiary.setDTITLE(diary.getDTITLE());
		saveDiary.setDCONTENT(diary.getDCONTENT());
		saveDiary.setDEMOTION(diary.getDEMOTION());
		saveDiary.setDWEATHER(diary.getDWEATHER());
		if(diary.getDFILENAME() != null)
		saveDiary.setDFILENAME(diary.getDFILENAME());
		diaryRepository.flush();
		
		return diary.getDID();
	}
	
	// 일기 삭제(사용)
	@Transactional
	public void deleteDiary(Long dID) {
		diaryRepository.deleteDiary(dID);
	}
	// 일기 조회(사용)
	public DiaryVO getDiary(Long dID) {
		DiaryVO findDiary = diaryRepository.getDiary(dID);
		return findDiary;
	}
	// 일기 목록 조회(사용)
	public List<DiaryForm> getDiaryList(String uID) {
		List<DiaryVO> diaryList = diaryRepository.getDiaryList(uID);
		List<DiaryForm> diaryFormList = new ArrayList<>();
		for(DiaryVO diary : diaryList) {
			DiaryForm diaryForm = changeDiaryToForm(diary);
			
			diaryFormList.add(diaryForm);
		}
		return diaryFormList;
	}
	
	// 오늘의 일기 조회(사용)
	public DiaryForm getTodayDiary(String uID) {
		DiaryVO todayDiary = diaryRepository.getTodayDiary(uID);
		DiaryForm todayDiaryForm = changeDiaryToForm(todayDiary);
		return todayDiaryForm;
	}
	
	// 이미지 파일 경로 처리
	public String makeImgFileDownloadURI(String dFILENAME) {
		
		String fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/downloadFile/")
                .path(dFILENAME)
                .toUriString();
		
		return fileDownloadUri;
	}
	
	// 일기 삭제(하는척)(사용)
	@Transactional
	public void updateMyOldDiaryDeleteCheck(Long dID, String username) {
		DiaryVO todayDiary = diaryRepository.getTodayDiary(username);
		if(todayDiary != null) { 
			if(dID.longValue() == todayDiary.getDID().longValue()) {
				diaryRepository.deleteDiary(dID);
				return;
			}
		}
		diaryRepository.updateMyOldDiaryDeleteCheck(dID);
	}
	
	//조회수 증가
	@Transactional
	public void updateDiaryCount(Long dID) {
		DiaryVO findDiary = getDiary(dID);
		findDiary.setDCNT(findDiary.getDCNT()+1);
	}
	
	// 일기 좋아요(사용)
	@Transactional
	public void likeDiary(String uID, Long dID) {
		DiaryLikeID likeID = new DiaryLikeID(uID, dID);
		log.info("likeDiary likeID : " + likeID.toString());
		try {
			//이미 좋아요 누름
			diaryLikeRepository.findById(likeID).get();
		}catch(Exception e) {
			//없으면 NoSuchElementException
			DiaryLikeVO diarylike = new DiaryLikeVO();
			diarylike.setId(likeID);
			log.info("likeDiary diarylike : " + diarylike.getId().toString());
			diaryLikeRepository.save(diarylike);
			
			DiaryVO findDiary = getDiary(dID);
			findDiary.setDLIKE(findDiary.getDLIKE() + 1);
		}
	}
	
	// 일기 좋아요 누른 사람 한명(사용)
	public String getLikeMan(Long dID){
		String likeman = null;
		List<String> likePeople = diaryLikeRepository.getLikePeople(dID);
		if(likePeople.size() != 0) likeman = likePeople.get(0);
		
		return likeman;
	}

	
	///////////////////////////////////
	/// diaryshare
	
	// 전체 회원 중 랜덤(사용)
	public List<String> choiceRandomUser(String username){
		UserEntity me = userRepository.findByUsername(username);
		Long myId = me.getId();
		
		List<UserEntity> userList = userRepository.findAll();
		List<String> userNameList = new ArrayList<>();
		int size = userList.size();
		
		if(size < 3) {
			for(int i = 0; i < size; i++) {
				UserEntity user = userList.get(i);
				if(user.getUsername().equals(username)) continue;
				userNameList.add(user.getUsername());
			}
			return userNameList;
		}
		
		int myIndex = 0;
		for(UserEntity user : userList) {
			if(user.getId() == myId) {break;}
				myIndex++;
		}
		
		long[] arr = new long[3];
		for(int i = 0; i < 3; i++) {
			arr[i] = (int)(Math.random() * size);
			for(int j = 0; j < i; j++) {
				if(arr[i] == arr[j] || arr[i] == myIndex) i--;
			}
			if(arr[0] == myIndex) i--;
		}
		log.info("random numbers : " + Arrays.toString(arr));
		UserEntity user1 = userList.get((int)arr[0]);
		UserEntity user2 = userList.get((int)arr[1]);
		UserEntity user3 = userList.get((int)arr[2]);
		
		userNameList.add(user1.getUsername());
		userNameList.add(user2.getUsername());
		userNameList.add(user3.getUsername());
		
		return userNameList;
	}
	// 블랙리스트 체크
	public boolean checkBlockedList(String dsID, String username){
		UserEntity target = userRepository.findByUsername(dsID);
		Long targetid = target.getId();
		
		// 상대방의 블랙리스트
		List<Blacklist> blacklist = blacklistRepository.findByOwnerId(targetid);
		if(blacklist != null) {
			for(Blacklist blocked : blacklist) {
				log.info("blocked  ownername : " + blocked.getOwner().getUsername() + ", blockedUsername : " + blocked.getBlockedUser().getUsername());
				if(username.equals(blocked.getBlockedUser().getUsername())) {
					return true;
				}
			}
		}
		
		return false;
	}
	
	// 오늘의 일기 공유(사용)
	@Transactional
	public void shareTodayDiary(Long dID, String username) {
		List<DiaryShareVO> shareList = new ArrayList<>();
		// 유저는 USER3 USER4 USER5 (랜덤으로 뽑았다고 가정)
		List<String> randomUserList = choiceRandomUser(username);
		
		log.info("randomUserList : " + randomUserList);
		
		Long findDsCODE = diaryShareRepository.getDsCODE(); 
		if(findDsCODE == null) findDsCODE = 0L; 
		Long findDsGROUPID = diaryShareRepository.getDsGROUPID();
		if(findDsGROUPID == null) findDsGROUPID = 0L;
		
		//java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//String date = sdf.format(new java.util.Date());
		LocalDateTime date = LocalDateTime.now();
		
		for(String dsID : randomUserList) {
			if(checkBlockedList(dsID, username) == true) continue;
			findDsCODE++;
			
			DiaryShareVO diaryShare = DiaryShareVO.builder()
												  .dsCODE(findDsCODE)
												  .dsGROUPID(findDsGROUPID + 1)
												  .dsDID(dID)
												  .dsID(dsID)
												  .dsDATE(date)
												  .dsREADCHECK("NO_READ")
												  .dsDELETECHECK("NO_DELETE")
												  .build();
			shareList.add(diaryShare);
		}
		log.info("shareList : " + shareList);
		
		saveDiaryShare(shareList);
		
		updateDiaryShareCheckANDGroupID(dID, findDsGROUPID+1);
//		diaryRepository.updateDiaryShareCheck(dID);
//		diaryRepository.updateDiaryGroupID(dID,findDsGROUPID);
	}
	// 일기 share(사용)
	public void saveDiaryShare(List<DiaryShareVO> list) {
		for(DiaryShareVO diaryShare : list) {
			diaryShareRepository.save(diaryShare);
		}
	}
	// share할때 share인원 지정 및 그룹 지정(사용)
	public void updateDiaryShareCheckANDGroupID(Long dID,Long dsGROUPID) {
		diaryRepository.updateDiaryShareCheck(dID);
		log.info("dsGROUPID (SHARESHARE) : " + dsGROUPID + ", dID : " + dID);
		diaryRepository.updateDiaryGroupID(dsGROUPID,dID);
	}
	
	// READ 체크(사용)
	@Transactional
	public void sharecheckDiary(DiaryShareVO diaryShare) {
		if(diaryShare.getDsDELETECHECK().equals("NO_DELETE")) {
			diaryShare.setDsREADCHECK("READ");
			diaryShareRepository.flush();
		}
	}
	
	// share 블랙리스트 처리
	public boolean deleteShareBlockedPeople(DiaryVO diary, String username){
		UserEntity me = userRepository.findByUsername(username);
		Long userid = me.getId();
		
		List<Blacklist> blacklist = blacklistRepository.findByOwnerId(userid);
		if(blacklist != null) {
			for(Blacklist blockedPerson : blacklist) {
				log.info("shared block ownername : " + blockedPerson.getOwner().getUsername() + ", block blocked targetname : " + blockedPerson.getBlockedUser().getUsername());
				if(diary != null) {
					if(diary.getDFROMID().equals(blockedPerson.getBlockedUser().getUsername())) {
						DiaryShareVO findDiaryShare = diaryShareRepository.getDiaryShareByGroupIDNdidNid(diary.getDGROUPID(), diary.getDID(), username);	
						findDiaryShare.setDsDELETECHECK("DELETE");
						diaryShareRepository.flush();
						return true;
					}
				}
			}
		}
		return false;
	}

	// 공유된 일기 목록 조회(사용)
	public List<Diary_DiaryShareVO> getReceivedDiaryList(String uID) {
		List<DiaryShareVO> diaryShareList = diaryShareRepository.getDiaryShareList(uID);
		log.info("diaryShareList : " + diaryShareList);
		List<Diary_DiaryShareVO> findDDShareList = new ArrayList<>();
		
		
		for(DiaryShareVO diaryShare : diaryShareList) {
			DiaryVO findDiary = diaryRepository.getDiary(diaryShare.getDsDID());
			log.info("ddshare.did DiaryService : " + findDiary.getDID());
			
			// 블랙리스트 처리 
			if(deleteShareBlockedPeople(findDiary , uID) == true) continue;
			
			//shared 체크
			sharecheckDiary(diaryShare);
			
			Diary_DiaryShareVO ddshareVO = Diary_DiaryShareVO.builder()
												.dID(findDiary.getDID())
												.dTITLE(findDiary.getDTITLE())
												.dFROMID(findDiary.getDFROMID())
												.dGROUPID(findDiary.getDGROUPID())
												.dDATE(findDiary.getDDATE())
												.dCONTENT(findDiary.getDCONTENT())
												.dCNT(findDiary.getDCNT())
												.dLIKE(findDiary.getDLIKE())
												.dsREADCHECK(diaryShare.getDsREADCHECK())
												.dsDELETECHECK(diaryShare.getDsDELETECHECK())
												.build();
			// 이미지 파일 처리
			String oldDFILENAME = findDiary.getDFILENAME();
			if(oldDFILENAME != null && oldDFILENAME != "") {
				String newDFILENAME = makeImgFileDownloadURI(oldDFILENAME);
				ddshareVO.setDFILENAME(newDFILENAME);	
			}else {
				ddshareVO.setDFILENAME(findDiary.getDFILENAME());
			}
			
			
			findDDShareList.add(ddshareVO);
		}
		
		return findDDShareList;
	}
	// shared 일기 읽음처리 (사용)
	@Transactional
	public void updateReceivedDiaryReadCheck(Long dGROUPID, Long dID, String uID) {
		log.info("dGROUPID : " + dGROUPID + ", dID : " + dID + ", uID : " + uID);
		diaryShareRepository.updateReceivedDiaryReadCheck(dGROUPID, dID, uID);
	}
	
	// share 일기 삭제처리(사용할 예정..)
	@Transactional
	public void updateReceivedDiaryDeleteCheck(Long dGROUPID, Long dID, String uID) {
		diaryShareRepository.updateReceivedDiaryDeleteCheck(dGROUPID, dID, uID);
	}
	
	public Long getNoReadCheckSharedDiary(String username) {
		return diaryShareRepository.getNoReadCheckSharedDiary(username);
	}
	
	////////////////////////////////
	//// DiaryReply
	// 댓글 생성(사용)
	@Transactional
	public void saveDiaryReply(DiaryReplyForm form) {
		Long id = diaryReplyRepository.getMaxDRID();
		if(id == null) {
			id = 1L;
		}else {
			id++;
		}
		
		Long depth = 0L;
		Long step = 0L;
		form.setDepth(depth);
		form.setStep(step);
		log.info("DiaryReplyForm : " + form.toString());
		
		DiaryReplyVO saveDiaryReply = new DiaryReplyVO();
		saveDiaryReply.setId(id);
		saveDiaryReply.setDid(form.getDid());
		saveDiaryReply.setWriter(form.getWriter());
		saveDiaryReply.setContent(form.getContent());
		saveDiaryReply.setDate(form.getDate());
		saveDiaryReply.setLike(form.getLike());
		saveDiaryReply.setGroupnum(id);
		saveDiaryReply.setDepth(form.getDepth());
		saveDiaryReply.setStep(form.getStep());
		saveDiaryReply.setDeleteCheck(form.getDeleteCheck());
		
		diaryReplyRepository.save(saveDiaryReply);
	}
	
	// 댓글 목록 조회(사용)
	public List<DiaryReplyVO> getDiaryReplyList(Long did){
		return diaryReplyRepository.getDiaryReplyListByDID(did);
	}
	
	// 대댓글 작성
	@Transactional
	public void saveLoopDiaryReply(DiaryReplyForm form, Long rID) {
		Long id = diaryReplyRepository.getMaxDRID();
		if(id == null) {
			id = 1L;
		}else {
			id++;
		}
		DiaryReplyVO findDiaryReply = diaryReplyRepository.getDIDByRID(rID);
		Long step = diaryReplyRepository.getMaxStepReply(findDiaryReply.getGroupnum()) + 1L;
		//log.info("LoopDiaryReply (service) step : " + step);
		
		DiaryReplyVO saveDiaryReply = new DiaryReplyVO();
		saveDiaryReply.setId(id);
		saveDiaryReply.setDid(findDiaryReply.getDid());
		saveDiaryReply.setWriter(form.getWriter());
		saveDiaryReply.setContent(form.getContent());
		saveDiaryReply.setDate(form.getDate());
		saveDiaryReply.setLike(form.getLike());
		saveDiaryReply.setGroupnum(findDiaryReply.getGroupnum());
		saveDiaryReply.setDepth(form.getDepth());
		saveDiaryReply.setStep(step);
		saveDiaryReply.setDeleteCheck(form.getDeleteCheck());
		
		//log.info("saveDiaryReply" + saveDiaryReply.toString());
		diaryReplyRepository.save(saveDiaryReply);
	}
	
	// 댓글 수정(사용)
	@Transactional
	public void updateDiaryReply(String content, Long rID) {
		DiaryReplyVO updateDiaryReply = diaryReplyRepository.findById(rID).get();
		updateDiaryReply.setContent(content);
	}
	
	//댓글 삭제(사용)
	@Transactional
	public void deleteDiaryReply(Long rID) {
		DiaryReplyVO updateDiaryReply = diaryReplyRepository.findById(rID).get();
		updateDiaryReply.setContent("삭제된 댓글입니다.");
		updateDiaryReply.setDeleteCheck("DELETE");
	}
	
	// 댓글 좋아요(사용)
	@Transactional
	public void likeDiaryReply(String uID, Long rID) {
		DiaryReplyLikeID likeID = new DiaryReplyLikeID(uID, rID);
		log.info("likeReplyDiary likeID : " + likeID.toString());
		try {
			//이미 좋아요 누름
			diaryReplyLikeRepository.findById(likeID).get();
		}catch(Exception e) {
			//없으면 NoSuchElementException
			DiaryReplyLikeVO diaryReplylike = new DiaryReplyLikeVO();
			diaryReplylike.setId(likeID);
			log.info("likeDiary diarylike : " + diaryReplylike.getId().toString());
			diaryReplyLikeRepository.save(diaryReplylike);
			
			DiaryReplyVO findReply = diaryReplyRepository.findById(rID).get();
			findReply.setLike(findReply.getLike() + 1);
		}
	}
	
	// 댓글 조회(사용)
	public DiaryReplyVO getDiaryReply(Long rID) {
		return diaryReplyRepository.findById(rID).get();
	}
	
	
	//////////////////////
	////// Main 페이지
	
	// 중앙 상단 스토리 게시용 메서드(사용)
	public List<DiaryForm> getTodayOurStories(Long userid, String username) {
		List<DiaryForm> friendDiaries = new ArrayList<>();
		DiaryForm myTodayDiary = changeDiaryToForm(diaryRepository.getTodayDiary(username));
		friendDiaries.add(myTodayDiary);
		log.info("myTodayDiary : " + friendDiaries);
		 
		// 친구리스트에서 나의 친구들 조회(user1id)
		List<FriendList> friendListList = friendListRepository.findByUser1Id(userid);
		int count = 1;
		if(friendListList != null) {
			for(FriendList friendList : friendListList) {
				UserEntity findFriend = friendList.getUser2();
				log.info("내 친구1 : " + findFriend.getUsername());
				
				DiaryVO friendDiary = diaryRepository.getTodayDiary(findFriend.getUsername());
				if(friendDiary != null) {
					log.info("내 친구의 일기1 : " + friendDiary);
					DiaryForm friendDiaryForm = changeDiaryToForm(friendDiary);
					friendDiaries.add(friendDiaryForm);
					count++;
					if(count > 5) break;
				}
			}
		}
		
		// 친구리스트에서 나의 친구들 조회(user2id)
		List<FriendList> friendListList2 = friendListRepository.findByUser2Id(userid);
		if(friendListList2 != null) {
			for(FriendList friendList : friendListList2) {
				UserEntity findFriend = friendList.getUser1();
				log.info("내 친구2 : " + findFriend.getUsername());
				
				DiaryVO friendDiary = diaryRepository.getTodayDiary(findFriend.getUsername());
				if(friendDiary != null) {
					log.info("내 친구의 일기2 : " + friendDiary);
					DiaryForm friendDiaryForm = changeDiaryToForm(friendDiary);
					count++;
					if(count > 5) break;
					friendDiaries.add(friendDiaryForm);
				}
			}
		}
		log.info("friendDiaries : " + friendDiaries);
		return friendDiaries;
	}
	
	// DiaryVO(엔티티, 민감하고 중요한 객체) -> DiaryForm(controller에서 쓰는 데이터 전달용)(사용)
	public DiaryForm changeDiaryToForm(DiaryVO diary) {
		if(diary == null) return null;
		DiaryForm diaryForm = new DiaryForm();
		diaryForm.setDID(diary.getDID());
		diaryForm.setDTITLE(diary.getDTITLE());
		diaryForm.setDFROMID(diary.getDFROMID());
		diaryForm.setDGROUPID(diary.getDGROUPID());
		diaryForm.setDDATE(diary.getDDATE());
		diaryForm.setDCONTENT(diary.getDCONTENT());
		diaryForm.setDEMOTION(diary.getDEMOTION());
		diaryForm.setDWEATHER(diary.getDWEATHER());
		diaryForm.setDCNT(diary.getDCNT());
		diaryForm.setDLIKE(diary.getDLIKE());
		diaryForm.setDSHARECHECK(diary.getDSHARECHECK());
		diaryForm.setDDELETECHECK(diary.getDDELETECHECK());
		
		// 이미지 파일 처리
		String oldDFILENAME = diary.getDFILENAME();
		if(oldDFILENAME != null && oldDFILENAME != "") {
			String newDFILENAME = makeImgFileDownloadURI(oldDFILENAME);
			diaryForm.setDFILENAME(newDFILENAME);	
		}else {
			diaryForm.setDFILENAME(diary.getDFILENAME());
		}
		
		return diaryForm;
	}
	
	// 메인페이지 랜덤 일기 목록 조회(사용)
	public List<DiaryForm> getAllDiaryList(Long userid){
		List<DiaryForm> randomList = new ArrayList<>();
		List<DiaryVO> allList = diaryRepository.getAllDiaryList();
		log.info("allDiaryList : " + allList);
		
		//블랙리스트 처리
		List<DiaryVO> blockedList =  deleteBlockedPeople(allList, userid);
		
		
		
		int size = blockedList.size();
		
		long[] arr = new long[5];
		if(size < 5) {
			for(int i = 0; i < size; i++) {
				DiaryForm diaryForm = changeDiaryToForm(blockedList.get(i));
				randomList.add(diaryForm);
			}
			return randomList;
		}else {
			for(int i = 0; i < 5; i++) {
				arr[i] = (int)(Math.random() * size);
				for(int j = 0; j < i; j++) {
					if(arr[i] == arr[j]) i--;
				}
			}
			log.info("random numbers : " + Arrays.toString(arr));
			
			for(int i = 0; i < 5; i++) {
				DiaryForm diaryForm = changeDiaryToForm(blockedList.get((int)arr[i]));
				randomList.add(diaryForm);
			}
		}
		
		return randomList; 
	}
	
	// 블랙리스트 처리 메서드
	public List<DiaryVO> deleteBlockedPeople(List<DiaryVO> allList, Long userid){
		List<DiaryVO> diaryList = allList;
		List<DiaryVO> removed = new ArrayList<>();
		List<Blacklist> blacklist =  blacklistRepository.findByOwnerId(userid);
		if(blacklist != null) {
			for(Blacklist black : blacklist) {
				log.info("blacklist ownerid : " + black.getOwner().getId() + ", blockedUsername : " + black.getBlockedUser().getUsername());
				
				if(diaryList != null) {
					for(DiaryVO diary : diaryList) {
						if(diary.getDFROMID().equals(black.getBlockedUser().getUsername())) {
							removed.add(diary);
						}
					}
				}
			}
		}
		if(diaryList != null) diaryList.removeAll(removed);
		
		return diaryList;
	}
}
