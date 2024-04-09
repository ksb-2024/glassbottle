package com.springproj.emotionshare.diary.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.springproj.emotionshare.diary.domain.DiaryReplyVO;

public interface DiaryReplyRepository extends JpaRepository<DiaryReplyVO, Long>{
	
	//댓글 번호 시퀀스 처리
	@Query("select MAX(id) from DiaryReplyVO")
	public Long getMaxDRID();

	//댓글 그룹번호 처리
	@Query("select MAX(dr.groupnum) from DiaryReplyVO dr where dr.did = :did")
	public Long getMaxDRGROUPNUM(@Param("did") Long did);
	
	//특정 글 소속 댓글 목록 조회
	@Query("select dr from DiaryReplyVO dr where dr.did = :did and dr.deleteCheck = 'NO_DELETE' order by groupnum,depth,step")
	public List<DiaryReplyVO> getDiaryReplyListByDID(@Param("did") Long did);
	
	//댓글 번호로 글번호 조회
	@Query("select dr from DiaryReplyVO dr where id = :rid")
	public DiaryReplyVO getDIDByRID(@Param("rid") Long rid);
	
	// 대댓글 제일 후순위 step 조회
	@Query("select MAX(step) from DiaryReplyVO where groupnum = :rid")
	public Long getMaxStepReply(@Param("rid") Long rid);
	
}
