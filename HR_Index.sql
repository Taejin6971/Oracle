/*  INDEX (인덱스) : 테이블의 특정 컬럼에 검색을 빠르게 하기 위해서 부여되는 객체 
        - index 가 부여되어 있지 않는 컬럼은 검색시 테이블스캔을 한다. (검색시간이 오래걸린다)
        - 컬럼에 index 를 생성하면 index [색인] 페이지를 생성한다 (DB의 10% 공간을 사용한다.)
        - 클러스터 index     : 사전처럼 A ~ Z 순차적으로 생성된 index 페이지
        - non 클러스터 index : 책의 첫페이지 같이 내용별로 위치정보가 생성된 index 페이지
        - where , join on 절에서 자주 검색하는 컬럼에 index 부여
        - index 는 검색을 빠르게 하기 위해서 사용되는데 잘못 부여하거나 주기적으로 관리하지않으면
            오히려 검색이 느려 질수가 있다.
        - insert, update, delete 가 빈번하게 일어나는 컬럼에는 index 의 주기적인 관리가 필요
            - index 페이지가 조각 난다.
            - 주기적으로 index 페이지를 rebuild 해야 한다.
        - index 를 잘못 생성하면 오히려 더 느려질수있다.
        - primary key, unique 컬럼은 자동으로 index가 생성이 된다.
        - index 정보가 저장된 데이터 사전 : user_indexes, user_ind_columns
            select * from user_indexes;
        - index 를 생성하는 작업은 업무시간을 피해서 생성해야 한다. [야간]
*/

select * from employee;

select ename
from employee
where ename='MILLER';

-- 데이터 사전을 통해서 index 정보 확인
show user;

select * from user_indexes
where table_name in ('DEPARTMENT', 'EMPLOYEE');

-- 테이블 생성시 primary key, unique 컬럼은 자동으로 index 생성
create table emp07
as
select eno, ename, job, salary from employee;

select * from emp07;

-- 데이터 사전을 통해 제약조건 확인
select * from user_constraints
where table_name in ('EMP07');

select * from user_indexes
where table_name in ('EMP07');

select * from user_ind_columns
where table_name in ('EMP07');

select * from user_ind_columns
where table_name in ('EMPLOYEE');

-- emp07 테이블에  primary key 부여
alter table emp07
add constraint PK_EMP07_ENO primary key (eno);

-- 특정 컬럼에 index 를 생성 <== where, join on, 자주 검색하는 컬럼.
create index ind_EMP07_ENAME
on EMP07 (ENAME) ;

select * from emp07
where ename='MILLER';

create table emp08
as
select * from employee;

select * from emp08;

create index idx_EMP08_JOB
on EMP08 (JOB);

-- index 가 조각난 경우 :
    -- 1. 기존의 index 를 제거후 새로운 index 생성 (아주 심하게 조각난 경우)
    -- 2. rebuild : 조각난 index 만 새롭게 생성

-- 조각난  index 를 새롭게 rebuild : 
    -- index 가 생성된 컬럼에 빈번하게 update가 일어나는 경우 index를 새롭게 생성

-- index 삭제(index 페이지를 삭제) 후 새롭게 생성
drop index idx_EMP08_JOB;
create index ind_EMP08_JOB
on EMP08(JOB);

-- index 를 rebuild : 조각이 심하지 않는 경우, 조각난 index만 새롭게 생성
alter index ind_EMP08_JOB rebuild;

======================================================================

/*  시퀀스 (SEQUENCE) : 자동 번호 발생기, Oracle
        - 특정 컬럼에 번호를 자동으로 넘버링 한다.
        - MS-SQL : IDENTITY (1, 1)
        - MySQL  : AUTO_INCREMENT
            - 테이블 생성시 특정 컬럼에 indentity(1,1), auto_increment를 넣으면 됨
        - 정수 타입으로 지정되어야 한다.
        - 시퀀스를 확인하는 데이터 사전 : user_sequences
        
        - 시퀀스는 고유한 값을 생성, 앞으로만 전진, 한번 생성된 시퀀스는 두번다시 동일한 값으로 만들어 지지 않음.
*/

-- 시퀀스 생성 : 처음값: 10, 증가값: 10
create sequence seq1
    start with 10
    increment by 10;

select * from user_sequences;

-- 듀얼 테이블을 사용해서 sequrnce 정보 출력 : 
        -- seq.nextval (다음값을 출력)
        -- sell.currval (현재값을 확인)
select seq1.nextval from dual;
select seq1.currval from dual;

-- 테이블의 특정 컬럼에 값을 넣을때, 시퀀스에서 발생된 값을 넣는다
-- 테이블 복사시 where를 false로 처리하면 테이블만  복사, 레코드(값)은 가져오지 않음
create table dept08
as
select * from department
where 0=1;

select * from dept08;

-- DEPT08 테이블의  DNO 컬럼에 sequenec 할당 : seq1.nextval

select seq1.currval from dual;

desc dept08;

insert into dept08 (dno, dname, loc)
values (seq1.nextval, 'HR', 'Seoul');


-- 시퀀스 생성
-- 초기값: 1, 증가값:1    <== seq2
create sequence seq2
start with 1
increment by 1
nocache;

select * from user_sequences;

-- insert 시 테이블의 컬럼에 부착 : 정수형
create table dept09
as
select * from department
where 0=1;

select * from dept09;

select seq2.currval from dual;

insert into dept09 (dno, dname, loc)
values (seq2.nextval, 'HR', 'Seoul');

commit;

/*  view : 가상 테이블, select 쿼리가 들어가있다.
        - 1. 실제 테이블의 중요 컬럼을 숨실 경우 (보안)
        - 2. 복잡한 쿼리를 저장후 사용할때 join 쿼리
        
        - view를 사용해서 insert, update, deletef를 할수도있다. (특징에따라 안될수도있다.)
            - 실제 테이블에 저장됨
            - 실제 테이블의 제약조건에 따라 달라진다
*/

-- 1. 원본 테이블 복사
create table dept10
as
select * from department;

select * from dept10;

-- 2. view 생성 
create view v_dept10
as
select dno, dname
from dept10;

-- 3. view를 사용
select * from v_dept10;

-- 4. view에 값 insert : 실제 테이블에 값이 insert됨 (실제 테이블의 제약조건에 따라 값이 insert될수도, 안될수도 있다.)
insert into v_dept10 (dno, dname)
values (50, 'HR');

commit;

-- 5. view를 사용해서 update / delete
update v_dept10
set dname='관리부'
where dno=50;

delete v_dept10
where dno=50;

-- view에서 insert / update / delete 시 실제 테이블의 제약 조건에 따라 달라집
select * from dept10;

alter table dept10
modify loc constraint NN_DEPT10_LOC not null;

desc dept10;

-- view에 값을 insert 할때 오류발생, 실제 테이블의 제약조건 위해 (원본 dept10 테이블의 loc컬럼 not null)
select * from v_dept10;

insert into v_dept10
values (60, 'HR');      -- 오류 발생

================================================================================

/*  view 내부에 distinct, 집계함수(sum,avg,max,min) 를 사용할시 반드시 별칭 이름을 사용해야한다. 
    
    - view 생성시 group by 절에서 별칭을 사용하지 않는 경우 오류 발생
    - view 내부에 집계함수 사용시 별칭이름 사용하지 않으면 오류 발생
*/

create view v_emp10
as
select min(salary) 최소월급, max(salary) 최대월급, round(avg(salary)) 평균월급, 
        sum(salary) 월급합계, count(*) 사원명수, dno 부서번호
from employee
group by dno;

select * from v_emp10;

================================================================================

/*  ERD(Entity Relationship Diagram) : 데이터 베이스 모델링 설계도
        - ER Win : 유료, 기업, Oracle, MS-SQL, MySQL, ...
        - https://www.erdcloud.com/ <== 무료, 팀별로 공유
        
    모델링
    ==================================================================
    1. 요구사항 분석 >> 2. 논리 모델링 >> 3. 물리적 모델링 >> 구현
    
    1. 요구사항 분석 : 업무파악, 고객협의, 프로잭트 범위(비용, 기간, 구현범위)
    2. 논리적 모델링 : 한글로 정의 (고객, 주소, 주문, 제품)
        엔티티 (논리적 모델링) 명     :        테이블 명 (물리적 모델링)
        속성 (논리적 모델링) 명       :        컬럼 명 (물리적 모델링)
        관계 :    1:1,    1:다,    다:다
    3. 물리적 모델링 : 테이블 이름, 컬럼명, 자료형   << 영문으로 지정
    4. 구현 : Oracle, MySQL, MS-SQL, ...
*/