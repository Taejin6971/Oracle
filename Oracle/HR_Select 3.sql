/* Select 3 */
/*  날자 함수
    SYSDATE         : 현재 시스템의 날짜를 출력하는 함수
    MONTHS_BETWEEN  : 두 날짜 사이의 개월 수를 출력
    ADD_MONTHS      : 특정 날짜의 개월수를 더할때
    NEXT_DAY        : 특정 날짜에서 초래하는 요일을 인자로 받아서 요일이 도래하는 날짜를 출력
    LAST_DAY        : 달의 마지막 날짜를 변환
    ROUND           : 날짜를 반올림 하는 함수, 15일 이상이면 반올림 미만이면 버림
    TRUNC           : 날짜를 잘라내는 함수
*/

-- 현재 시스템의 날짜 출력 : yy/mm/dd
select sysdate
from dual;

select sysdate -1 어제, sysdate 오늘, sysdate+1 내일
from dual;

select * from employee;

-- 입사 일로부터 오늘 날짜까지 몇일 근무했는지 출력
select ename 사원, hiredate 입사일, round(sysdate-hiredate) 총근무일수
from employee;

-- 입사일로 부터 1000일 지난 시점의 날짜를 출력
select ename 사원, hiredate 입사일, hiredate+1000 입사1000일날짜
from employee;

-- 특정 날짜에서 월을 기준으로 출력
select hiredate 원본, trunc(hiredate, 'month'), round(hiredate, 'month')
from employee;

-- months_btween : 두 날짜 사이의 개월수를 출력
-- 입사일로 부터 현재까지의 근무한 개월수를 출력
select ename, hiredate, trunc(months_between(sysdate, hiredate)) 근무개월수
from employee;

-- date (날짜타입)
-- add_months (날짜, 개월수) : 날짜의 개월수를 더하는 함수
-- 오늘날짜에 100개월을 더한 날짜
select sysdate 오늘날짜, add_months(sysdate, 100) "100개월후", sysdate+100 "100일후"
from dual;

-- 입사후 6개월이 지난 시점
select ename, hiredate, add_months(hiredate, 6) "입사후 6개월시점"
from employee;

-- next_day : 특정 날짜에서 요일을 인풋으로 넣어서 도래하는 요일을 날짜를 출력
select next_day(sysdate, '토')
from dual;

-- last_day (date) : date의 마지막 날짜를 출력
select sysdate 오늘날짜, last_day(sysdate)
from dual;

-- 사원 테이블에서 입사날의 마지막날짜 출력
select hiredate 입사일, last_day(hiredate)
from employee;

/*  형식 변환 함수
    TO_CHAR     : 날짜, 숫자형을 문자형으로 변환
    TO_DATE     : 문자형을 날짜형으로 변환
    TO_NUMBER   : 문자형을 숫자형으로 변환
*/

-- to_char (date, 'YYYYMMDD') : 날짜형식을 'YYYYMMDD'형식으로 뽑아서 char타입으로 변환
select to_char(sysdate, 'yyyy/mm/dd')
from dual;

/*  YYYY : 날짜 정보의 년도를 뽑아냄
    YY   : 년도의 마지막 2자리 뽑아냄
    MM   : 월
    DD   : 일
    
    DAY  : 요일을 뽑아옴 (월요일, 화요일, ... 일요일)
    DY   : 요일을 뽑아옴 (월, 화, ... 일)
    
    HH   : 시간
    MI   : 분
    SS   : 초
*/

select to_char(sysdate, 'yyyy/mm/dd'), to_char(sysdate, 'yyyy/mm/dd day hh:mi:ss')
from dual;

select sysdate, to_char(sysdate, 'yy/mm/dd_hh:mi:ss_dy')
from dual;

select * from employee;

desc employee;

select hiredate 원본, to_char(hiredate, 'yyyy_mm_dd day hh:mi:ss')
from employee;

/*  TO_CHAR : 날짜, 숫자 ==> 문자형으로 변환

    0 : 자릿수를 처리함, 자릿수가 맞지않으면  0으로 처리됨
    9 : 자릿수를 처리함, 자릿수가 맞지않으면  공백 처리됨
    L : 각 지역의 통화($)를 기호로 표시
    . : 소수점으로 처리
    , : 천 단위 구분자
*/

desc employee;

select ename, salary, to_char(salary, 'L999,999') "9", to_char(salary, 'L000,000') "0"
from employee;

/*  TO_DATE : 문자형 ==> 날짜타입으로 변환
    
    TO_DATE(변환할 문자[숫자], 'YYYYMMDD')
*/

select to_date(20230628, 'yyyymmdd'), to_date('06282023', 'mmddyyyy')
from dual;

select to_date('2001-10-30', 'yyyy-mm-dd')
from dual;

-- 생일에서 오늘 날짜까지 며칠 살았는지 출력 : 1981-04-15
select trunc(sysdate - to_date('1981-04-15', 'yyyy-mm-dd'))
from dual;

select to_date('12/06/22', 'mm/dd/yy') - to_date('1900-10-17', 'yyyy-mm-dd') 두날짜의차
from dual;

-- 자신의 생일에서 현재까지 며칠/몇개월 살았는지 출력, 
select 
trunc(sysdate - to_date('19960104','yyyymmdd')) 살아온날,
trunc(months_between(sysdate, to_date('19960104','yyyymmdd'))) 살아온개월
from dual;

-- employee 테이블에서 각사원의 입사일에서 2030/01/01 까지의 근무개월수를 출력
select ename, hiredate, 
trunc(months_between(to_date('20300101','yyyymmdd'), hiredate)) 특정날짜까지근무개월수
from employee;

/*  NULL 처리 함수 : NVL, NVL2, NULLIF

    NVL(컬럼, 값) : 컬럼의 NULL이 존재할 경우 값으로 대치
    NVL2(컬럼, NULL이 아닐경우 처리, NULL인 경우 처리)
*/

select * from employee;

-- NVL 함수를 사용해서 연봉 구하기 (연봉 = 월급 * 12 + 보너스)
select ename, salary, commission, 
        salary * 12 + nvl(commission,0) 총연봉
from employee;

-- NVL2 함수를 사용해서 연봉 구하기 (연봉 = 월급 * 12 + 보너스)
select ename, salary, commission , 
        nvl2(commission ,salary * 12 +commission , salary*12 ) as 총연봉 
from employee; 

-- 그룹 함수 : group by, 특정 컬럼을 그룹핑해서 처리함.
select 컬럼명
from 테이블이름[뷰]
where 조건
group by 컬럼명[그룹핑할컬럼명]
having 조건 [그룹핑한결과의조건]
order by 컬럼명[정렬할컬럼명]

/*  집계 함수 : SUM, AVG, MAX, MIN, COUNT   <== NULL을 자동으로 처리해서 작동
        - NUMBER 타입에서만 사용가능
    SUM   : 컬럼의 모든 값을 더하는 함수
    AVG   : 컬럼의 모든 값의 평균을 구하는 함수
    MAX   : 컬럼의 모든 값의 최대값을 가져오는 함수
    MIN   : 컬럼의 모든 값의 최소값을 가져오는 함수
    COUNT : 레코드수, 그룹핑된 갯수 출력
    
    *주의 : 단일 row로 출력됨, 다른 컬럼을 같이 사용될 경우 오류발생
*/

select commission
from employee
order by commission asc;

select 
sum(commission) 합계, avg(commission) 평균, max(commission) 최대값,
min(commission) 최소값, count(commission) 레코드수
from employee;

select * from employee;

-- 부서별 월급의 합계, 평규, 최대값, 최소값, 그룹핑된 갯수
-- dno : 부서번호가 동일한 값을 그룹해서 처리함
select sum(salary) "부서별 평균", dno, count(dno) 그룹핑된갯수
from employee
group by dno;

select ename, salary, dno
from employee
order by dno asc;

-- 부서별로 월급의 합계, 평균, 최대값, 최소값, 그룸핑된수
select
sum(salary) 합계, round(avg(salary)) 평균, max(salary) 최대, min(salary) 최소
,dno, count(dno)
from employee
group by dno
order by dno asc;

select salary 
from employee 
where dno=20;

select ename, job, salary
from employee;

-- 직급별로 월급의 합계, 평균 최대값, 최소값, 그룹핑된수
select 
sum(salary) 합계, round(avg(salary)) 평균, max(salary) 최대, min(salary) 최소
,job, count(job)
from employee
group by job
order by 합계 desc;

/*  group by 에서
    
    where 절  : <조건> : group by 전에 조건을 처리해서 나온 결과만 group by
    having 절 : <조건> : group by 한 결과에 대한 조건처리, 별칭이름을 사용하면 안됨.
*/

/*  직급별로 월급의 합계, 평균, 최대값, 최소값을 출력하되 
    20번 부서는 제외하고 평균이 2000 이상인것만 출력, 평균을 내림차순 정렬
*/
select 
sum(salary) 합계, round(avg(salary)) 평균, max(salary) 최대, min(salary) 최소
, job, count(*)
from employee
where dno!=20
group by job
having round(avg(salary))>=2000
order by 평균 desc;

-- 두컬럼 이상 그룹핑 할수있다, 두컬럼모두가 동일할때 그룹핑 가능
select dno, job
from employee
order by dno, job;

-- 부서번호,직책 컬럼 모두 그룹핑해서 월급의 합계, 평균, 최대값, 최소값, count
select
sum(salary), round(avg(salary)), max(salary), min(salary), count(*), dno, job
from employee
group by dno, job
order by count(*) desc;

/* 각 직책에 대해서 월급의 합계, 평균, 최대값, 최소값을 출력하는데
    입사일이 81년도에 입사한 사람들만 출력하되 월급의 평균이 1500 이상인것만 출력하고
    평균을 내림차순 정렬
*/
select 
sum(salary) 합계, round(avg(salary)) 평균, max(salary) 최대값, min(salary) 최소값
, job, count(*)
from employee
where hiredate like'81%'
group by job
having avg(salary)>=1500
order by 평균 desc;

select count(*)
from employee
where hiredate like'81%';

-- rollup : 그룹한 결과 마지막 라인에 전체 결과를 출력,
-- cube   : 각 그룹핑의 마지막 라인에 결과출력, 제일 마지막 라인에 전체 결과도 함께 출력

-- rollup, cube 를 사용하지 않는 그룹핑 쿼리

-- group by 절에서 컬럼 2개가 그룹필 될때 두 컬럼에 걸쳐서 중복을 그룹핑
select
sum(salary), round(avg(salary)) 평균, max(salary), min(salary), dno, job, count(*)
from employee
group by dno, job
order by dno asc;

select dno, job
from employee
order by dno, job;

-- rollup 사용
select
sum(salary), round(avg(salary)) 평균, max(salary), min(salary), dno, job, count(*)
from employee
group by rollup(dno, job)
order by dno asc;

-- cube 사용
select
sum(salary), round(avg(salary)) 평균, max(salary), min(salary), dno, job, count(*)
from employee
group by cube(dno, job)
order by dno asc;

/*  SubQuery (서브쿼리) : select 내부의 select 구문, 여러벙 작업을 하나의 쿼리에서 실행
        where 절에서 많이 사용
*/

/*  ename 이 SCOTT인 사원과 동일한 직책의 사원들을 출력
    1. ename이 SCOTT인 사원의 직책을 가져오는 쿼리
    2. 직책을 조건으로 해서 사원을 알아와야하는 쿼리
*/
select * from employee;

select job 
from employee 
where ename='SCOTT';

select ename 
from employee 
where job='ANALYST';

-- SubQuery 사용
select ename, salary, job
from employee 
where job=(
    select job 
    from employee 
    where ename='SCOTT'
    );

-- SMITH 와 동일한 부서를 가진 사원들을 출력
select ename, dno
from employee
where dno=(
    select dno 
    from employee 
    where ename='SMITH'
    );

-- SCOTT의 월급보다 많은 사원정보 출력
select ename, salary
from employee
where salary>(
    select salary 
    from employee 
    where ename='SCOTT'
    );

-- 최소 급여를 받는 사원의 이름과 담당업무, 급여 출력
select ename, job, salary
from employee
where salary=(
    select min(salary) 
    from employee
    );

-- 단일 값이 아니라 여러개의 값이 출력될 경우 IN 키워드 사용

-- 부서별로 최소급여를 받는 사원의 이름, 직책, 월급 출력, group by, min, in 키워드 사용
select ename, job, salary, dno
from employee
where salary in (
    select min(salary) 
    from employee 
    group by dno
    );
    
-- 각 부서의 최소 급여가 30번 부서의 최소 급여보다 큰 부서를 출력
select min(salary), dno, count(*)
from employee
group by dno
having min(salary)>(
    select min(salary)
    from employee
    where dno=30
    );
    
/*  ANY 연산자 : 서브쿼리가 반환하는 각각의 값과 비교함
        < any : 최대값 보다 작음을 나타낸다.
        > any : 최소값 보다 큰것을 나타낸다.
        = any : in 과 동일한 키워드
        
    ALL 연산자 : 서브쿼리에서 반환되는 모든값을 비교함
        < all : 최소값 보다 작음을 나타낸다.
        > all : 최대값 보다 큰것을 나타낸다.
*/

-- 직급이 SALESMAN이 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력
select *
from employee
order by job, salary;

-- all 사용
select ename, job, salary
from employee
where salary < all(
    select salary
    from employee
    where job='SALESMAN'
    )
    and job != 'SALESMAN';
    
-- min 사용
select ename, job, salary
from employee
where salary < (
    select min(salary)
    from employee
    where job='SALESMAN'
    )
    and job != 'SALESMAN';
    
-- 담당 업무가 분석가(ANALYST)인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 출력
-- all 사용
select ename, job, salary
from employee
where salary < all(
    select salary
    from employee
    where job='ANALYST'
    )
    and job != 'ANALYST';
    
-- min 사용
select ename, job, salary
from employee
where salary < (
    select min(salary)
    from employee
    where job='ANALYST'
    )
    and job != 'ANALYST';