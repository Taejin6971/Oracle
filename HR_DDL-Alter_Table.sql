/*  DDL : Alter Table: 기존의 생성된 테이블을 수정
        - 기존 테이블의 컬럼을 추가, 컬럼이름변경, 컬럼삭제, 컬럼의 자료형 수정
        - 컬럼의 부여된 제약조건을 생성, 수정, 삭제
*/

-- 샘플 테이블 생성
-- 테이블 복사 : 원본 테이블 - department, 복사 - dept01
    -- 원본의 컬럼명, 자료형, 데이터(레코드) 복사
    -- 원본 테이블의 제약 조건은 복사되어 오지않는다.
create table dept01
as
select * from department;

create table emp01
as
select * from employee;

select * from dept01;
desc dept01;
desc department;

-- 제약 조건을 확인하는 데이터 사전
show user;
select * from user_constraints      -- 현재 접속한 계정의 모든 테이블의 제약조건을 확인
-- where table_name='DEPARTMENT';
where table_name='DEPT01';

select * from user_constraints      -- 현재 접속한 계정의 모든 테이블의 제약조건을 확인
where table_name='EMPLOYEE';
-- where table_name='EMP01';

-- DEPT01 테이블에 새로운 컬럼 추가, null
select * from dept01;

-- birth 컬럼 추가
alter table dept01
add (birth date);

alter table dept01
add (email varchar2(100), addr varchar2(200), jumin char(14));

-- 테이블에 컬럼을 추가할때 null이 기본, update 구문을 사용해서 값을 넣음
update dept01
set birth=sysdate, email='aaa@aaa.com', addr='서울', jumin='880520-1111111'
where dno=10;
commit;

-- 컬럼의 자료형 수정 : char varchar 글자수를 늘림
alter table dept01
modify email varchar2(200);

desc dept01;

-- 특정 컬럼 삭제     <== 야간에 작업해야한다. (부하가 많이 걸리는 작업)
select * from dept01;

alter table dept01
drop column jumin;

alter table dept01
drop column addr;

-- 컬럼명 변경 :
select * from dept01;

alter table dept01
rename column dno to d_dno;

alter table dept01
rename column birth_day to birthday;

-- 테이블 이름 변경
rename dept01 to dept001;

rename dept001 to dept01;

-- 데이터 사전에서 현재로그온한 사용자의 모든 테이블 출력
select * from user_tables;
select table_name from user_tables
order by table_name;

/*  alter table을 사용해서 제약조건 생성, 수정, 삭제
        - primary key
        - unique
        - foreign key
        - check
        - not null
        
        - default
*/

-- 데이터 사전을 통해서 여러 테이블의 제약 조건을 한번에 확인
select * from user_constraints
where table_name in ('DEPT01', 'DEPARTMENT', 'EMP01', 'EMPLOYEE')
order by table_name;

/*  기존 테이블에 primary key 제약조건 넣기
    - 컬럼에 중복된 값이 없어어야 한다.
    - 컬럼에 null이 들어있으면 안된다.
    - 테이블에 primary key 컬럼이 존재하면 안된다. (테이블에 PK는 한번만 들어갈수있다)
*/
select * from dept01;

desc dept01;

-- dept01 테이블에 d_dno 컬럽에 primary key 할당
alter table dept01
add constraint PK_DEPT01_D_DNO primary key(d_dno);

/*  foreign key 할당
    - 부모 테이블의 primary key, unique 컬럼을 참조함.
    - FK가 적용된 컬럼과, 부모테이블의 참조컬림의 자료형이 비슷하거나 같아야한다.
    - FK가 적용된 컬럼의 값은 부모테이블의 참조값이 들어가있어야한다.
*/
-- emp01 테이블의
select * from dept01;   -- 부모 테이블(dept01) : d_dno
select * from emp01;    -- 자식 테이블(emp01)  : dno (FK)

-- emp01 의 dno 컬럼에 FK 할당. (부모 테이블 : d_dno)
alter table emp01
add constraint FK_EMP01_DNO foreign key(dno) references dept01(d_dno);

/*  unique 제약조건 추가
    - 컬럼에 중복된 값이 없어야한다.
    - null은 한번만 들어가 있어야한다.
    - null, not null이 적용된곳에 부여할수 있다.
*/

-- emp01 table에 ename 컬럼에 unique 제약조건 추가
select * from emp01;

alter table emp01
add constraint U_EMP01_ENAME unique(ename);

-- emp01 테이블의 eno 컬럼에 PK 제약조건 넣기
alter table emp01
add constraint PF_EMO01_ENO primary key(eno);

/*  check 제약조건 추가
    - 특정 컬럼에 조건에 맞는 값만 저장하도록 설정
    - salary 컬럼에 조건 : salary>0
*/
alter table emp01
add constraint CK_EMP01_SALARY check(salary>0);

/*  not null 제약조건 추가 
    - 컬럼에 null 값이 존재하지 않아야 한다.    
*/
-- job 컬럼에 not null 제약조건 추가
desc emp01;

alter table emp01
modify job constraint NN_EMP01_JOB not null;

/*  기존 테이블의 default
    - default는 제약 조건이 아니다. 제약조건 이름이 가질수없다.
*/
select * from emp01;

-- cummission 컬럼의 값을 넣지않을 경우 기본값(default) : 0
alter table emp01
modify commission default 0;

-- default, null에 값을 넣을때 : default, null
insert into emp01
values (8000,'홍길동','사무원','7369',sysdate,6000,default,40);

-- 컬럼이 지정되지 않았을때 default, null
insert into emp01(eno,ename,job,manager,hiredate,salary,dno)
values (8001,'이길동','사무원','7369',sysdate,4000,40);

/*  기존 테입블의 제약 조건 제거 :
    - 제약조건 이름으로 제거 가능
*/
select * from user_constraints
where table_name='EMP01';

select constraint_name from user_constraints
where table_name='EMP01';

-- primary key 제약조건 제거 : PF_EMO01_ENO
alter table emp01
drop constraint PF_EMO01_ENO;

-- unique 제약조건 제거 : U_EMP01_ENAME
alter table emp01
drop constraint U_EMP01_ENAME;

-- check 제약조건 제거 : CK_EMP01_SALARY
alter table emp01
drop constraint CK_EMP01_SALARY;

-- not null 제약조건 제거 : NN_EMP01_JOB
alter table emp01
drop constraint NN_EMP01_JOB;

-- foreign key 제약조건 제거 : FK_EMP01_DNO
alter table emp01
drop constraint FK_EMP01_DNO;

-- default 제거 : 제약조건이 아니기때문에 drop 불가 (기본값으로 null 설정)
alter table emp01
modify commission default null;

commit;