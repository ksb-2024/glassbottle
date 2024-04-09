package com.springproj.emotionshare.diary.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.springproj.emotionshare.diary.domain.DiaryVO;
import com.springproj.emotionshare.diary.domain.Diary_DiaryShareVO;

public interface DiaryRepository extends JpaRepository<DiaryVO, Long>{
	
	// 메인 페이지 랜덤 일기 목록 조회
	@Query("select d from DiaryVO d where d.dDELETECHECK = 'NO_DELETE' order by d.dID desc")
	public List<DiaryVO> getAllDiaryList();
		
	// 오늘 나의 일기 삭제
	@Modifying
	@Query("delete from DiaryVO d where d.dID = :dID")
	public void deleteDiary(@Param("dID") Long dID); 
		
	// 과거 나의 일기 삭제(하는척)
	@Modifying
	@Query("update DiaryVO d set d.dDELETECHECK = 'DELETE' where d.dID = :dID")
	public void updateMyOldDiaryDeleteCheck(@Param("dID") Long dID);
		
	// 과거 나의 일기 목록 조회
	@Query("select d from DiaryVO d where d.dFROMID = :dFROMID and d.dDELETECHECK = 'NO_DELETE' order by d.dID desc")
	public List<DiaryVO> getDiaryList(@Param("dFROMID")String dFROMID); 
		
	// 일기 상세 조회
	@Query("select d from DiaryVO d where d.dID = :dID")
	public DiaryVO getDiary(@Param("dID") Long dID); 
		
	// 일기 최신번호 조회(새로운 일기 등록시 최신번호 입력을 위한)
	@Query("select MAX(d.dID) from DiaryVO d")
	public Long getPrimeDID();
	
	// 오늘 작성한 일기 조회
	@Query("select d from DiaryVO d where d.dDATE > to_date(to_char(sysdate,'YYYYMMDD'),'YYYYMMDDHH24MISS') and d.dFROMID = :uID")
	public DiaryVO getTodayDiary(@Param("uID") String uID);
	
	// 오늘 나의 일기 GROUPID 등록(SHARE할때)
	@Modifying
	@Query("update DiaryVO SET dGROUPID = ?1 WHERE dID = ?2")
	public void updateDiaryGroupID(Long dGROUPID, Long dID);
	
	// 오늘 나의 일기 SHARECHECK 표시
	@Modifying
	@Query("update DiaryVO d set d.dSHARECHECK = 'SHARE' where d.dID = :dID")
	public void updateDiaryShareCheck(@Param("dID") Long dID);
	
	// 수신 받은 일기 목록 조회
	@Query("select d,ds from DiaryVO d, DiaryShareVO ds where d.dGROUPID = ds.dsGROUPID AND ds.dsID = :uID and ds.dsDELETECHECK LIKE 'NO_DELETE' order by d.dID desc")
	public List<Diary_DiaryShareVO> getReceivedDiaryList(@Param("uID")String uID);
	
}
