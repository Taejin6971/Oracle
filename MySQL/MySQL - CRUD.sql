-- CRUD : Create, Read, Update, Delete

-- 한줄 주석
/*
	여러줄 주석
*/

-- 데이터 베이스 생성
create database myDB;

-- 데이터 베이스 접속 하기
use myDB;

-- 테이블 생성
create table myTest (
    idx int not null,
    name varchar(10) not null,
    pass varchar(50) not null,
    addr varchar(100) null,
    email varchar(100) null
    );

-- 테이블의 내용 출력
select * from myTest;

-- 테이블의 값 입력
insert into myTest (idx, name, pass, addr, email)
values (1, '홍길동', '1234', '서울', 'aaa@aaa.com');

insert into myTest (idx, name, pass, addr, email)
values (2, '홍길순', '1234', '부산', 'bbb@bbb.com');

-- MS-SQL, MySQL : 자동 커밋 트랜잭션

-- 기존의 테이블 값 수정 : update 는 where 조건을 처리
update mytest
set addr = '광주'
where idx=2;

-- 기존의 테이블 값 삭제 : delete
delete from mytest
where idx=2;