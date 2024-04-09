-- 테스트 유저 아이디는 USER1, USER2, USER3 입니다.


-- DIARY 테이블
create table diary
(
    dID        NUMBER(10) not null primary key, -- 글아이디, 전화번호(uTel)+sysdate
    dTITLE     VARCHAR2(100) not null, -- 글제목
    dFROMID    VARCHAR2(20) not null, -- 보내는사람, 사용자아이디(uID)
    dGROUPID   NUMBER(10), -- 받는 그룹 번호, 그룹 번호(dsGROUPID)
    dDATE      DATE not null, -- 작성날짜
    dCONTENT   VARCHAR2(3000) not null, -- 글내용
    dEMOTION   NUMBER(2), -- 감정, 0:즐거움 1:슬픔...
    dWEATHER   NUMBER(2), -- 날씨, 0:맑음 1:흐림...
    dCNT       NUMBER(10) default 0, -- 조회수, DEFAULT:0
    dLIKE      NUMBER(10) default 0, -- 추천수, DEFAULT:0
    dDELETECHECK NUMBER(1) default 0-- 송신자 삭제 체크, DEFAULT:0 보유 1:삭제
);

insert into diary(dID,dTITLE,dFROMID,dGROUPID,dDATE,dCONTENT)
    values(11111111,'첫글','USER1',1,TO_DATE('20240115201430','YYYYMMDDHH24MISS'),'안녕하세요~ 제가 첫빠입니다ㅎ');
insert into diary(dID,dTITLE,dFROMID,dDATE,dCONTENT)
    values(22222222,'두번째글','USER2',TO_DATE('20240116221430','YYYYMMDDHH24MISS'),'안녕하세요~ 제가 두번째입니다ㅎ');
insert into diary(dID,dTITLE,dFROMID,dGROUPID,dDATE,dCONTENT)
    values(33333333,'세번째글','USER3',2,TO_DATE('20240117233530','YYYYMMDDHH24MISS'),'안녕하세요~ 제가 세번째입니다ㅎ');
insert into diary(dID,dTITLE,dFROMID,dDATE,dCONTENT)
    values(44444444,'네번째글','USER1',TO_DATE('20240117235530','YYYYMMDDHH24MISS'),'네번째글입니다.');
    

    
--DIARY SHARE 테이블(일기 전송용)
create table diary_share(
    dsCODE    NUMBER(10) primary key, -- 그냥 자동발행되는 기본키 
    dsGROUPID NUMBER(10) not null, -- 수신자들 그룹번호
    dsDID     NUMBER(10) not null, -- 일기 아이디(dID)
    dsID      VARCHAR2(20) not null,  -- 사용자 아이디(uID)
    dsDATE    DATE not null,           -- 시간
    dsREADCHECK NUMBER(1) default 0,            -- 수신자 읽음체크, DEFAULT:0 안읽음 
    dsDELETECHECK NUMBER(1) default 0           -- 수신자 삭제체크, DEFAULT:0 보유 1:삭제
);

insert into diary_share(dsCODE,dsGROUPID,dsDID,dsID,dsDATE) values(1, 1, 11111111,'USER2', TO_DATE('20240115230000','YYYYMMDDHH24MISS'));
insert into diary_share(dsCODE,dsGROUPID,dsDID,dsID,dsDATE) values(2, 1, 11111111,'USER3', TO_DATE('20240115230000','YYYYMMDDHH24MISS'));
insert into diary_share(dsCODE,dsGROUPID,dsDID,dsID,dsDATE) values(3, 2, 33333333,'USER2', TO_DATE('20240117230000','YYYYMMDDHH24MISS'));
commit;






