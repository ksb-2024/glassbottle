-- 테스트 유저 아이디는 USER1, USER2, USER3 입니다.
drop table diary;
drop table diary_share;
drop table diary_reply;
drop table diary_like;
drop table diary_reply_like;

-- DIARY 테이블
create table diary
(
    dID        NUMBER(10) not null primary key, -- 글아이디
    dTITLE     VARCHAR2(100) not null, -- 글제목
    dFROMID    VARCHAR2(20) not null, -- 보내는사람, 사용자아이디(uID)
    dGROUPID   NUMBER(10), -- 받는 그룹 번호, 그룹 번호(dsGROUPID)
    dDATE      DATE not null, -- 작성날짜
    dCONTENT   VARCHAR2(3000) not null, -- 글내용
    dEMOTION   VARCHAR2(10), -- 감정, TYPE : 즐거움 , 슬픔...
    dWEATHER   VARCHAR2(10), -- 날씨, TYPE : 맑음 ,흐림...
    dCNT       NUMBER(10) default 0, -- 조회수, DEFAULT:0
    dLIKE      NUMBER(10) default 0, -- 추천수, DEFAULT:0
    dSHARECHECK VARCHAR2(10) default 'NO_SHARE', -- 송신자 공유 체크, TYPE
    dDELETECHECK VARCHAR2(10) default 'NO_DELETE',-- 송신자 삭제 체크,  TYPE
    dFILENAME   VARCHAR2(100)      -- 파일이름
);

insert into diary(dID,dTITLE,dFROMID,dGROUPID,dDATE,dCONTENT,dEMOTION, dWEATHER, dSHARECHECK, dDELETECHECK)
    values(11111111,'첫글','USER1',1,TO_DATE('20240115201430','YYYYMMDDHH24MISS'),'안녕하세요~ 제가 첫빠입니다ㅎ','HAPPY','SUN','SHARE','NO_DELETE');
insert into diary(dID,dTITLE,dFROMID,dDATE,dCONTENT,dEMOTION, dWEATHER, dSHARECHECK, dDELETECHECK)
    values(22222222,'두번째글','USER2',TO_DATE('20240116221430','YYYYMMDDHH24MISS'),'안녕하세요~ 제가 두번째입니다ㅎ','SAD','RAINY','NO_SHARE','NO_DELETE');
insert into diary(dID,dTITLE,dFROMID,dGROUPID,dDATE,dCONTENT,dEMOTION, dWEATHER, dSHARECHECK, dDELETECHECK)
    values(33333333,'세번째글','USER3',2,TO_DATE('20240117233530','YYYYMMDDHH24MISS'),'안녕하세요~ 제가 세번째입니다ㅎ','SOSO','CLOUD','SHARE','NO_DELETE');
insert into diary(dID,dTITLE,dFROMID,dDATE,dCONTENT,dEMOTION, dWEATHER, dSHARECHECK, dDELETECHECK)
    values(44444444,'네번째글','USER1',TO_DATE('20240117235530','YYYYMMDDHH24MISS'),'네번째글입니다.','SOSO','SUN','NO_SHARE','NO_DELETE');
    

    
--DIARY SHARE 테이블(일기 전송용)
create table diary_share(
    dsCODE    NUMBER(10) primary key, -- 그냥 자동발행되는 기본키 
    dsGROUPID NUMBER(10) not null, -- 수신자들 그룹번호
    dsDID     NUMBER(10) not null, -- 일기 아이디(dID)
    dsID      VARCHAR2(20) not null,  -- 사용자 아이디(uID)
    dsDATE    DATE not null,           -- 시간
    dsREADCHECK VARCHAR2(10) default 'NO_READ',            -- 수신자 읽음체크, TYPE 
    dsDELETECHECK VARCHAR2(10) default 'NO_DELETE'           -- 수신자 삭제체크, TYPE
);

insert into diary_share(dsCODE,dsGROUPID,dsDID,dsID,dsDATE, dsREADCHECK, dsDELETECHECK) values(1, 1, 11111111,'USER2', TO_DATE('20240115230000','YYYYMMDDHH24MISS'),'NO_READ','NO_DELETE');
insert into diary_share(dsCODE,dsGROUPID,dsDID,dsID,dsDATE, dsREADCHECK, dsDELETECHECK) values(2, 1, 11111111,'USER3', TO_DATE('20240115230000','YYYYMMDDHH24MISS'),'NO_READ','NO_DELETE');
insert into diary_share(dsCODE,dsGROUPID,dsDID,dsID,dsDATE, dsREADCHECK, dsDELETECHECK) values(3, 2, 33333333,'USER2', TO_DATE('20240117230000','YYYYMMDDHH24MISS'),'NO_READ','NO_DELETE');


-- DIARY_REPLY 테이블(공유된 일기 댓글)
CREATE TABLE DIARY_REPLY(
    drID NUMBER(10) primary key, -- 기본키, 댓글번호
    drDID NUMBER(10) not null, -- 일기 글번호(dID)
    drWRITER VARCHAR2(20) not null, -- 작성자(uID) 
    drCONTENT VARCHAR2(500),  -- 내용
    drDATE DATE, -- SYSDATE
    drLIKE NUMBER(10) default 0, -- 추천수, DEFAULT:0
    drGROUPNUM NUMBER(10) not null, -- 댓글 그룹번호
    drDEPTH NUMBER(10) not null, -- 댓글 깊이
    drSTEP NUMBER(10) not null, -- 댓글 출력 순서
    drDELETECHECK VARCHAR2(10) default 'NO_DELETE' -- 댓글 삭제 체크
);

-- DIARY_LIKE 테이블(일기 좋아요 테이블)
CREATE TABLE DIARY_LIKE(
    dlUSERID VARCHAR2(20) not null, -- 사용자 아이디(uID)
    dlDIARYID NUMBER(10) not null -- 일기 글번호(dID)
);

-- DIARY_REPLY_LIKE(댓글 좋아요 테이블)
CREATE TABLE DIARY_REPLY_LIKE(
    drlUSERID VARCHAR2(20) not null, -- 사용자 아이디(uID)
    drlDIARYREPLYID NUMBER(10) not null -- 댓글 아이디(rID)
);

commit;







