/* DDL, DML 제약조건 */

/*  SQL (Structured Query Language) : 에스큐엘, 씨퀄, 구조화된 질의 언어

select 컬럼명
from 테이블명[뷰]
where 조건
group by 컬럼[그룹핑]
having 조건[group by 결과의 조건]
order by 정렬컬럼

SQL 구문의 종류를 분류

DDL (Data Definition Language) : 객체(테이블, 계정, 함수, 뷰, 트리거, 저장프리시져, 인덱스)를 생성하는 언어(구문)
                               : 스키마(틀, 객체)를 생성하는 언어
    - create (생성), alter (수정), drop (삭제)
    
DML (Data Manipulation Language) : 테이블의 레코드를 조작하는 언어 <== 트랜잭션을 발생시킴
    -- 오라클에서는 트랜잭션 시작은 자동으로 작동됨.
    -- 트랜잭션을 완료 해야한다. (commit, rollback) 
        <== 트랜잭션을 완료하지 않으면 LOCK이 걸려 다른사용자가 접근이 불가하다
    - insert (입력), update (수정), delete (삭제)
    
DCL (Data Control Language) : 데이터 제어 언어, 계정의 권한을 부여,
    - grent (권한부여), revoke (권한취소)
    
=================================================================

DQL (Data Query Language) : 데이타 질의 언어 (출력)
    - Select
    
TCL (Transaction Control Language) : 트랜잭션 제어 언어 <== DML에서 발생됨
    - begin transaction : 트랜잭션 자동으로 시작 (insert, update, delete)
    - commit [transaction] : 트랜잭션을 완료, 실제 DataBase에 영구적으로 저장
    - rollback [transaction] : 트랜잭션을 시작 시점으로 되돌린다.
    
    - savepoint : 트랜잭션의 임시저장 시점 설정
*/

-- 테이블 생성 : create table
create table dept(
    dno number(2) not null,
    dname varchar2(50) not null,
    loc varchar2(13) null
);

desc dept;      -- 테이블 구조 확인

-- 테이블에 값 넣기
-- begin transaction;
insert into dept(dno, dname, loc)
values(10, '인사부', '서울');

rollback;
commit;

select * from dept;

/*  트랜잭션 (Transaction) : 작업(일)을 처리하는 최소 단위
    
    - DBMS : 네트워크를 통해서 여러명의 사용자가 동시에 작업
    - 작업을 할때 LOCK을 걸고 완료되면 LOCK을 풀어줌
    - DML 문에서 작동,
    - 트랜잭션을 종료(commit, rollback)하기 전까지는 LOCK이 걸려서 다른사용자의 접근을 차단
    - commit : RAM에 수정된 내용을 DB에 영구적으로 저장하도록한다.
    - rollback : 트랜잭션 시작 시점으로 되돌림
    - commit 전까지는  RAM에서만 저장 되어있음.
    - log에 기록됨, "트랜잭션로그" <== 백업시점이 아니라 오류시점
    
    트랜잭션의 4가지 특징
        ALL or NOTHING : 되면 전부 되게하거나 아니면 원래대로 되돌리거나
    1. 원자성 (Atomicity) : 일을 처리하는 최소 단위
    2. 일관성 (Consistency) : 트랜잭션에서 처리한 결과는 일관성을 가진다.
    3. 독립성 (Isolation : 하나의 트랜잭션은 다른 트랜잭션과 격리, LOCK
    4. 지속성 (Durability) : commit 트랜잭션은 DB에 저장됨
        
    A 가 B 에게 100억 입금 예 : 두 update 구문이 하나의 트랜잭션으로 작동되어야함.
    1. update 문을 사용해서 A 통장에서 100억 출금
    2. update 문을 사용해서 B 통장에 100억 입금
*/

-- insert 문
desc dept;
select * from dept;

insert into dept(loc, dname, dno)
values('부산', '관리부', 20);

-- 컬럼이 생략되면 모든 컬럼에 값을 할당
insert into dept
values(30, '영업부', null);

insert into dept(dno, dname)
values(40, '광주');

commit;

/*  update : 수정      
    *주의 : 반드시 where 조건(Primary Key, Unique 컬럼)을 사용해야한다.
*/
update dept
set dname ='제조부'
where dno=40;

insert into dept(dno, dname)
values(40, '판매부');

-- dno : where 절 사용, 중복된값이 저장되지않는 컬럼을 사용(primary Key, Unique)
update dept
set dname='HR', loc='대전'
where dno=40;

select * from dept;

-- 테이블에는 Primary Key 컬럼이 존재해야 한다. <== 중복된 값을 넣을수 없도록 제약을 설정

/*  delete : 테이블의 특정 레코드 삭제  
    *주의 : 반드시 where 조건(Primary Key, Unique 컬럼)을 사용해야한다.
*/
delete dept
where dno=40;

commit;

/*  제약 조건 : 컬럼에 부여되는 제약, Primary Key, Unique, Default, Not Null, Check, Foreign Key
        - 특정 컬럼에 무결성을 확보하기 위해서 부여
        
    Primary Key
        - 중복된 값을 넣지 못하도록 설정
        - Not Null
        - 테이블에 한번만 넣을수 있다. 여러 컬럼에 하나의 Primary Key를 넣을수 있다.
        - INDEX가 자동으로 생성된다.   <== 검색을 빠르게 함.
        - update, delete시 where절에서 사용되는 컬럼
        - JION 시 On 절에서 사용되는 컬럼
        
    Unique
        - 중복된 값을 넣을수 없다.
        - null 허용 <== 한번만 넣을수있다.
        - 하나의 테이블에 여러번 넣을수 있다.
        - INDEX가 자동으로 생성된다.   <== 검색을 빠르게 함.
        - JION 시 On 절에서 사용되는 컬럼
        
    Not Null
        - 반드시 값이 입력되어야 한다. NULL을 넣을수 없도록
        
    Check
        - 컬럼에 들오는 값을 체크해서 저장, 조건에 만족하는 값만 넣도록 (age > 0)
        
    Foreign Key
        - 부모 테이블의 특정 컬럼을 참조해서 값을 넣을수 있도록 설정
        - 부모 테이블의 참조하는 컬럼은 Primary Key, Unique 키 컬럼을 참조
    
    Default : 컬럼에 값을 넣지않는 경우, Default로 설정된 값이 자동으로 들어감.
        - 제약조건이 아니여서 제약조건 이름을 부여할수 없다.
        - <<주의>> nul, not null 앞에 처리해야한다 
    
    데이터 사전 : Oracle에서 테이블에 대한 각종 정보를 저장한 테이블
        user_constraints        -- 제약 조건을 확인하는 데이터 사전
        select * from user_constraints
*/

create table member1 (
    id varchar2(50) not null primary key,
    pass varchar2(50) not null,
    addr varchar2(100) null,
    phone varchar2(30) null,
    age number(3),          -- 정수 3자리
    weight number(5,2)      -- 실수 : 전체 5자리, 소숫점 이하 2자리
);

-- insert
insert into member1
values('ddd', 'aaa', '서울', '010-1111-1111', 20, 70.55);

select * from member1;

commit;

-- update 시 where 조건에 primary key 컬럼을 조건으로 처리
update  member1
set addr='부산', phone='010-2222-2222', age=30, weight=88.55
where id='bbb';

-- delete 시 where 조건에 primary key 컬럼을 조건으로 처리
delete member1
where id='ccc';

/*  Unique */
create table member2 (
    id varchar2(50) not null primary key,
    pass varchar2(50) not null Unique,
    addr varchar2(100) null,
    phone varchar2(30) null Unique,
    age number(3),
    weight number(5,2)
);

insert into member2
values('bbbb', 'bbbbb', '서울', '010-2222-2222', 10, 70.55);

select * from member2;
commit;

-- 오라클의 데이터 사전을 사용해서 member2 테이블의 제약조건을 확인
show user;  -- 현재 접속한 계정 정보를 출력 : C##HR
select * from user_constraints
where table_name = 'MEMBER2';

-- 테이블 생성시 제약조건 이름을 부여하면서 제약 조건할당.
-- 제약조건 이름은 PK_테이블이름_컬럼명
create table member3 (
    id varchar2(50) not null constraint PK_MEMBER3_ID primary key,
    pass varchar2(50) not null constraint U_MEMBER3_PASS Unique,
    addr varchar2(100) null,
    phone varchar2(30) null constraint U_MEMBER3_PHONE Unique,
    age number(3),
    weight number(5,2)
);

-- insert
insert into member3
values('bb', 'bb', '서울', '010-1111-1111', 20, 70.55);
 
select * from member3;

/* check : 컬럼의 값을 체크 */
create table member4 (
    id varchar2(50) not null constraint PK_MEMBER4_ID primary key,
    pass varchar2(50) not null constraint U_MEMBER4_PASS Unique,
    addr varchar2(100) null,
    phone varchar2(30) null constraint U_MEMBER4_PHONE Unique,
    age number(3) constraint CK_MEMBER4_AGE check(age>0 and age<150),
    gender char(1) constraint CK_MEMBER4_GENDER check(gender in('W','M')),
    weight number(5,2)
);

-- 제약 조건 출력
select * from user_constraints
where table_name='MEMBER4';

-- insert
insert into member4
values('b', 'b', '서울', '010-1111-2222', 70, 'M', 70.55);
 
select * from member4;
commit;

/*  Default : 값을 넣지 않으면 Default로 설정된 값이 자동으로 들어감*/
create table member5 (
    id varchar2(50) not null constraint PK_MEMBER5_ID primary key,
    pass varchar2(50) not null constraint U_MEMBER5_PASS Unique,
    addr varchar2(100) default '서울' null,
    phone varchar2(30) null constraint U_MEMBER5_PHONE Unique,
    age number(3) null constraint CK_MEMBER5_AGE check(age>0 and age<150),
    gender char(1) null constraint CK_MEMBER5_GENDER check(gender in('W','M')),
    weight number(5,2) default 10.00 null,
    hiredate date default sysdate
);

drop table member5;

-- insert : default에 값 할당 : default키를 사용하는 경우
insert into member5
values('b', 'b', default, '010-1111-2222', 70, 'M', default, default);

-- insert : default에 값 할당 : 컬럼이 명시 되지 않는 경우
insert into member5 (id, pass, phone, age, gender)
values('c', 'c', '010-1111-3333', 70, 'M');
 
select * from member5;
commit;

/*  Foreign Key : 부모 테이블의 특정 컬럼을 참조해서 값을 넣도록 설정 
        - 부모 테이블의 Primary Key, Unique 키 컬럼을 참조
        - Foreign Key는 자식 테이블의 특정 컬럼에 넣는다.
*/

-- employee 테이블의 dno 컬럼은 Foreign Key ==> Department 테이블의 dno 컬럼을 참조
-- employee 테이블의 dno 컬럼의 값을 할당할때 Department 테이블의 dno 컬럼의 값을 참조후 할당
select * from department;       -- 부서 정보를 저장하는 테이블 (부모 테이블)
select * from employee;         -- 사원 정보를 저장하는 테이블 (자식 테이블 : Foreign Key (dno))

desc employee;

-- employee의 dno 컬럼은 Department의 dno 컬럼을 참조함.
insert into employee(eno, ename, job, manager, hiredate, salary, commission, dno)
values (8000,'KTJ','MANAGER',7369,sysdate,3000,300,40);

rollback;

/*  Foreign Key 실습 테이블 생성*/

-- 부모 테이블 생성 (PK, UK)
create table ParentTbl(
    info number constraint PK_ParentTbl_info Primary Key,
    name varchar2(20),
    age number(3), check(age>0 and age<200),
    gender char(1) check(gender in ('W','M'))
);

-- 부모 테이블에 더미(Dumy) 데이터 입력
insert into ParentTbl(info,name,age,gender)
values(10,'홍길동',20,'M');

insert into ParentTbl(info,name,age,gender)
values(20,'이길동',32,'M');

insert into ParentTbl(info,name,age,gender)
values(30,'김길동',43,'M');

insert into ParentTbl(info,name,age,gender)
values(40,'송길동',52,'M');

select*from parenttbl;
commit;

-- 자식 테이블 생성 (FK)
create table ChildTbl(
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    info number, 
        constraint FK_ChildTbl_info Foreign Key(info) references ParentTbl(info)
);

-- 자식 테이블에 더미 데이터 입력
insert into childtbl(id,pw,info)
values ('aaa','aaa',10);

insert into childtbl(id,pw,info)
values ('bbb','aaa',20);

insert into childtbl(id,pw,info)
values ('ccc','aaa',30);

insert into childtbl(id,pw,info)
values ('ddd','aaa',40);

select * from childtbl;
commit;

-- FK가 참조하는 부모 테이블은 drop되지 않는다.
    -- 1. 자식 테이블을 먼저 삭제후 부모 테이블 삭제
    -- 2. 부모 테이블을 삭제하면서 cascade constraints 옵션을 사용하면 강제 삭제가능
    
-- 부모 테이블 삭제 불가
drop table parenttbl;

-- 1. 자식 테이블을 먼저 제거후 부모 테이블 삭제
drop table childtbl;
drop table parenttbl;

-- 2. 부모 테이블을 삭제하면서 cascade constraints 옵션을 사용하면 강제 삭제가능
drop table parenttbl cascade constraints;
drop table childtbl;