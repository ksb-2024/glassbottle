package com.springproj.emotionshare.diary.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.springproj.emotionshare.diary.domain.DiaryShareVO;

public interface DiaryShareRepository extends JpaRepository<DiaryShareVO, Long>{
	
	
	// 해당 유저의 수신받은 일기 목록 조회
	@Query("select ds from DiaryShareVO ds where ds.dsID = :uID order by dsDID desc")
	public List<DiaryShareVO> getDiaryShareList(@Param("uID")String uID);
	
	// 최신 DIARY_SHARE(dsCODE) 조회하기
	@Query("select MAX(ds.dsCODE) from DiaryShareVO ds")
	public Long getDsCODE();
	
	// 최신 DIARY_SHARE(dsGROUPID) 조회하기
	@Query("SELECT MAX(ds.dsGROUPID) from DiaryShareVO ds")
	public Long getDsGROUPID();
	
	// 글번호(dID) 해당하는 글을 수신받은 유저들 아이디 목록 조회
	@Query("select ds.dsID from DiaryVO d, DiaryShareVO ds where d.dID = ds.dsDID and d.dID = :dID")
	public List<String> getGroupUserIDs(@Param("dID")Long dID);
	
	// 수신 받은 일기 읽기체크 수행
	@Modifying
	@Query("update DiaryShareVO ds set ds.dsREADCHECK = 'READ' where ds.dsGROUPID = :dGROUPID and ds.dsDID = :dID and ds.dsID = :uID ")
	public void updateReceivedDiaryReadCheck(@Param("dGROUPID")Long dGROUPID,
											 @Param("dID")Long dID,
											 @Param("uID")String uID);
	
	// 수신 받은 일기 삭제체크 수행
	@Modifying
	@Query("update DiaryShareVO ds set ds.dsDELETECHECK = 'DELETE' where ds.dsGROUPID = :dGROUPID and ds.dsDID = :dID and ds.dsID = :uID")
	public void updateReceivedDiaryDeleteCheck(@Param("dGROUPID")Long dGROUPID,
											   @Param("dID")Long dID,
											   @Param("uID")String uID);
	
	// select count(*) from diary_share where dsid = 'USER2' and dsreadcheck = 'NO_READ'; read체크
	@Query("select COUNT(ds) from DiaryShareVO ds where ds.dsID = :username and ds.dsREADCHECK = 'NO_READ' and ds.dsDELETECHECK = 'NO_DELETE'")
	public Long getNoReadCheckSharedDiary(String username);
	
	// select * from diary_share where dsgroupid = 1 and dsdid = 11111111 and dsid = 'USER2'; 블랙리스트 처리용
	@Query("select ds from DiaryShareVO ds where ds.dsGROUPID = :dsGROUPID and ds.dsDID = :dID and ds.dsID = :username")
	public DiaryShareVO getDiaryShareByGroupIDNdidNid(@Param("dsGROUPID") Long dsGROUPID,
													  @Param("dID") Long dID,
													  @Param("username") String username);

}
