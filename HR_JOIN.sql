/*  JOIN, VIEW, INDEX, 시퀀스 */

/*  테이블 복사 */
create table dept03
as
select * from department;

select * from dept03;

create table emp03
as
select * from employee;

select * from emp03;

-- 테이블 복사 : 특정 컬럼과 조건을 주어서 복사
create table salesman01
as
select eno, ename, job, salary
from employee
where job='SALESMAN';

select * from salesman01;

-- 우리회사의 직책만 담은 테이블 생성 (job01)
select * from employee;
create table job01
as
select distinct job
from employee;

select * from job01;

-- 테이블 복사시 제약조건은 복사되지 않는다 
    -- 컬럼명, 자료형, 레코드(데이터)만 복사됨
    -- 제약조건은 복사되지 않는다. (primary key, uique, foreign key, not ull, check)

-- 제약 조건 확인 : user_constraints <== 데이터 사전 : oracle에서 테이블의 정보를 담은 테이블
select * from  user_constraints
where table_name in('DEPARTMENT','DEPT03','EMPLOYEE','EMP03');

-- Alter Table을 사용해서 기존 테이블에 제약조건 추가
select * from emp03;
select * from dept03;

-- emp03 테이블의 eno 컬럼에 primary key 할당. : 테이블에 한번만 할당 가능 컬럼에 중복된 데이터가 없어야한다. null이 없어야한다.
desc emp03;

alter table emp03
add constraint PK_EMP03_ENO primary key(eno);


-- emp03 테이블의 dno 컬럼에 foreign key : 부모테이블의 dept03 dno 컬럼을 참조
    -- foreign key가 참조하는 컬럼은 primary key, unique 컬럼을 참조
    -- 참조 컬럼의 자료형이 같거나 비슷 해야한다.
    -- dno 컬럼의 값이 부모테이블 컬럼의 값이 참조된 값에 들어있어야 한다.
    
desc dept03;

-- 부모 테이블의 참조 컬럼은 primary key, unique 이여야 한다.
alter table dept03
add constraint PK_DEPT03_DNO primary key(dno);

alter table emp03
add constraint FK_EMP03_DNO_DEPT03 foreign key(dno) references dept03(dno);

select * from emp03;

select distinct job from emp03;

alter table emp03
add constraint CK_EMP03_SALARY check(salary>0);

-- emp03의 job 컬럼은 : CLERK, SALESMAN, MANAGER, ANALYST, PRESIDENT 만 넣도록 체크제약 조건 할당
alter table emp03
add constraint CK_EMP03_job check ( job in ('CLERK', 'SALESMAN', 'MANAGER', 'ANALYST', 'PRESIDENT'));

/*  JION : Database에는 많은 테이블이 존재합니다. 각 테이블은 다른 테이블과 관계(FK)를 가지고있다.
        - RDBMS : 관계형 DBMS
        - DB내의 각각의 테이블은 모델링되어있다. (중복제거, 성능향상)
        - 모델링 되지않는 데이블은 중복된 데이터가 계속 입력된다 <== 하드공간을 낭비, 성능저하
        - employee 테이블의 dno 컬럼은 부서번호
        - department 테이블은 부서번호, 부서명, 부서위치
        - employee 테이블과 department 테이블을 하나의 테이블로 디자인 되었을 경우 부서정보가 계속 중복되어 들어간다.
        - 다른 테이블의 컬럼을 출력하기 위해서는 JOIN을 사용해서 다른 테이블의 컬럼을 출력한다.
        - 두 테이블을 join 하기 위해서는 두 테이블의 공통 키 컬럼을 찾아야 한다. (FK > PK,UK) <== ON
        - JOIN ANSI 호환 JOIN : 모든 DBMS에서 공통으로 사용하는 JOIN 구문
            - Oracle, MSSQL, MYSQL, ...
*/

select * from employee;
select * from department;

/*  EQUI JOIN : 오라클에서만 작동하는 JOIN 구문 <== 공통 키 컬럼은 테이블 이름을 명시해야한다.
        select - join할 테이블의 컬럼을 명시, 두 테이블의 공통의 키컬럼을 출력시 해당 테이블 명시
        from - join할 테이블을 , 로 명시, 테이블 이름을 별칭으로 사용
        where - 두 테이블의 공통 키 컬럼을 찾아서 = 로 처리
        and - 조건을 처리
*/

-- 테이블 별칭(alias)을 사용해서 조인
select eno, ename, job, e.dno, dname, loc
from employee e, department d
where e.dno = d.dno 
and e.dno=20;

-- 테이블 별칭을 상용하지 않는 경우 [전체구문]
select employee.eno, employee.ename, employee.job, employee.dno, department.dname, department.loc
from employee, department
where employee.dno = department.dno
and employee.dno=20;

select eno, ename, job, e.dno, dname, loc
from employee e, department d
where e.dno = d.dno
and e.dno=20;

-- employee 테이블, department 테이블의 전체 컬럼 출력
desc employee;
desc department;

create table emp_dept
as
select eno, job, manager, hiredate, salary, commission, e.dno, dname, loc
from employee e, department d
where e.dno = d.dno;

select * from emp_dept;
select * from department;

/*  ANSI JOIN : 모든 DBMS에서 공통으로 사용하는 JOIN 구문
        
        INNER JOIN : 두 테이블 모두 공통 키 컬럼의 값이 일치 하는 것만 출력 <== 90% 이상 사용
        select - 두 테이블의 컬럼을 명시, 두 테이블의 공통 키 컬럼을 출력시 테이블 이름 명시
        from   - 테이블1 [INNER]JOIN 테이블2
        on     - 두 테이블의 공통 키 컬럼을 명시
        where  - 조건 처리
*/

select eno, ename, job, salary, e.dno, dname, loc
from employee e join department d
on e.dno=d.dno
where e.dno=20;

/*  OUTER JOIN : 한쪽 테이블의 냉용은 모두 출력 하도록 함
        LEFT OUTER JOIN  : 왼쪽 테이블은 무조건 모두 출력
        RIGHT OUTER JOIN : 오른쪽 테이블은 무조건 모두 출력
        FULL OUTER JOIN  : 두 테이블 모두 전체 내용을 출력
*/

/*  ANSI 호환의 Outer JOIN */
-- 조인 실습 테이블 생성
create table emp05
as
select * from employee;

create table dept05
as
select * from department;

select * from emp05;
select * from dept05;
insert into dept05
values(50, 'HR', 'SEOUL');
commit;

-- ANSI 호환 INNER JOIN : 두 테이블의 공통 키 컬럼이 일치하는 데이터만 출력 (교집합)
select ename, job, e.dno, dname, loc
from dept05 d inner join emp05 e
on d.dno=e.dno;

-- ANSI 호환 LEFT OUTER JOIN : 두 테이블의 공통 키 키컬럼이 일치하는 왼쪽 테이블의 값을 모두 출력
select ename, job, e.dno, d.dno, dname, loc
from dept05 d left outer join emp05 e
on d.dno=e.dno;

-- Oracle equi JOIN
-- 카타르시안 곱 (앞 테이블의 모든 레코드가 뒷 테이블의 레코드와 각각 매칭)
-- where 조건에서 두 공통 키 컬럼이 같은 항목만 출력.
select *
from employee e, department d
where e.dno = d.dno
and salary>2000;

/*  NATURAL JOIN : Oracle 에서만 사용되는 JOIN
        - 두 테이블의 공통 키 컬럼을 Oracle이 자동으로 찾아서 JOIN
        - select 구문에 공통 키 컬럼에 테이블을 명시하면 오류발생
        - from 절에 NATURAL JOIN 키워드를 사용함
        - where 절에 공통 키 컬럼을 명시하지 않는다. (Oracle에서 두 테이블의 공통 키 컬럼을 자동으로 찾아 처리)
        - where 절에 조건 처리
*/

-- NATURAL JOIN <== 두 테이블의 공통 키 컬럼을 자동으로 찾아서 JOIN, 
        -- select 절에 공통 키 컬럼을 출력할때 테이블 이름을 명시하면 오류발생
select eno, ename, salary, dno, dname, loc
from emp05 e natural join dept05 d
where salary>2000;

-- EQUI JOIN
select eno, ename, salary, e.dno, dname, loc
from emp05 e, dept05 d
where e.dno=d.dno
and salary>2000;

-- ANSI JOIN : 모든 DBMS에서 사용되는 구문 : Oracle, MS-SQL, MYSQL, postgre, MariaDB, ...
select eno, ename, salary, e.dno, dname, loc
from emp05 e join dept05 d
on e.dno=d.dno
where salary>2000;

/*  SELF JOIN : 자기 자신의 테이블을 다시한번 JOIN
        - 반드시 테이블 별칭을 사용해서 JOIN 해야함
        - select 절에 컬럼을 명시할때 반드시 별칭을 사용해야 한다.
        - 조직도, 상사 정보를 자신의 테이블에서 조회할때 사용함.
*/

select * from emp05;

-- SELF JOIN 을 사용해서 사원의 직속 상관정보(이름)를 출력
select eno 사원번호, ename 사원명, manager 직속상관
from employee
where manager=7788
order by ename;

select eno 사원번호, ename 사원명, manager 직속상관
from employee
where eno=7788
order by ename;

-- SELF JOIN 을 사용해서 직속 상관 정보를 한번에 출력 (EQUI JOIN)
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.ename 직속상관이름
from emp05 e, emp05 m
where e.manager = m.eno
order by e.ename;

select eno, ename, manager, eno, ename, manager
from emp05;

-- SELF JOIN 을 사용해서 직속 상관 정보를 한번에 출력 (ANSI JOIN)
select e.eno 사원번호, e.ename 사원이름, e.manager 직속상관번호, m.ename 직속상관이름
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename;

select * from emp05;

-- select 문에서 || 사용시 문자열과 연력할수 있음
select '사원명 : ' ||ename|| ' 은 월급이 '||salary|| ' 만원 입니다.' 사원급여정보
from emp05;

-- 사원명의 직속상관 이름을 self JOIN으로 바로 출력
select e.ename 사원이름, m.ename 직속상관이름
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename;

-- 
select e.ename ||'의 직속상관 이름은'|| m.ename ||'입니다.' "사원에 대한 직속상관 명"
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename;

/*  CROSS JOIN : 카타르시안 곱, 앞 테이블의 하나의 레코드에서 뒤 테이블의 모든 레코드와 연결
        - 앞,뒤 테이블의 모든 내용을 곱해서 성능 체크시 사용.
*/

-- ANSI JOIN 으로 출력 (14 * 5 = 70개 레코드 출력)
select * 
from emp05 e cross join dept05 d;

-- EQUI JOIN 으로 출력 (14 * 5 = 70개 레코드 출력)
select * 
from emp05 e, dept05 d;

-- VIEW 생성 할수잇는 권한 설정 (System 계성으로 접속해서 실행)
GRANT CREATE ANY VIEW TO "C##HR" WITH ADMIN OPTION;
GRANT DROP ANY VIEW TO "C##HR" WITH ADMIN OPTION;

/*  VIEW : 가상의 테이블, 코드가 저장된 가상테이블
        - VIEW 는 데이터를 가지고 있지 않는다. select 코드가 들어가있다.
        - 마치 테이블 처럼 사용됨.
        - VIEW 는 select 구문이 들어가 있음.
        - 보안을 위해서 사용됨 (실제 테이블의 특정 컬럼만 출력)
        - 복잡한 쿼리를 저장후 호출해서 사용 (JOIN)
*/

-- VIEW 생성 (보안을 위해 생성한 view)
create view v_emp
as
select ename, salary from emp05;

select * from emp05;

-- VIEW 실행
select * from v_emp;

-- VIEW 정보를 확인하는 데이터 사전 : user_views
-- 현재 로그온한 계정에서 생성된 모든 view를 확인
select * from user_views;

-- VIEW 생성 : emp05 테이블과 dept05 테이블을 JOIN 하는 구문
create view v_emp_dept
as
select eno, ename, job, salary, e.dno, dname, loc
from emp05 e, dept05 d
where e.dno=d.dno;

-- VIEW
select * from v_emp_dept;

drop view v_emp_dept;

-- 자신의 직속 상사를 출력하는 VIEW 생성
select * from emp05;

select eno, ename, manager, eno, ename, manager
from emp05;

create view v_manager_info
as
select e.eno, e.ename 사원이름, e.manager, m.ename 직속상관
from emp05 e join emp05 m 
on e.manager=m.eno
order by e.ename;

select * from v_manager_info;

-- VIEW에 저장된 코드 정보를 확인 : 데이터 사전을 사용해서 확인
select * from user_views;

-- OUTER JOIN : ANSI
alter table dept05
add constraint PK_DEPT05_DNO primary key(dno);

alter table emp05
add constraint FK_EMP05_DNO_DEPT05 foreign key(dno) references dept05(dno);

-- INNER JOIN : 두 테이블의  공통 키 컬럼이 일치하는 것만 출력
select eno, ename, salary, e.dno, d.dno, dname, loc
from emp05 e inner join dept05 d
on e.dno=d.dno;

select * from dept05;

select distinct dno from emp05;

-- RIGHT OUTER JOIN : 오른쪽 테이블의 모든 내용을 출력 <== ANSI JOIN
select eno, ename, salary, e.dno, d.dno, dname, loc
from emp05 e right outer join dept05 d
on e.dno=d.dno;

-- RIGHT OUTER JOIN : 오른쪽 테이블의 모든 내용을 출력 <== EQUI JOIN
select eno, ename, salary, e.dno, d.dno, dname, loc
from emp05 e, dept05 d
where e.dno(+)=d.dno;

-- NATURAL JOIN : 두 테이블의 공통 키 컬럼을 자동으로 식별
select eno, ename, salary, dno, dname, loc
from emp05 e natural join dept05 d;

-- SELF JOIN : 자신의 테이블을 한번더 JOIN
select e.eno, e.ename, e.manager, m.eno, m.ename, m.manager
from emp05 e, emp05 m
where e.manager=m.eno
order by e.eno;