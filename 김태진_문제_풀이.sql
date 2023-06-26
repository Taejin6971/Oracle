--<문제1> 컬럼 알리어스(별칭) , commission(보너스) 컬럼의 null 인 값만 출력하되 사원번호, 사원이름,입사날짜를 출력 
select eno 사원번호, ename 사원이름, hiredate 입사날짜
from employee
where commission is null;

--<문제2> dno(부서번호) 가 20이고 입사날짜가 81년 4월 이후 사원의 이름과 직책과 입사날짜를 출력
select ename 사원이름, hiredate 입사날짜
from employee
where dno=20 and hiredate like '81/04%';

--<문제3> 연봉을 계산해서 사원번호, 사원이름, 월급, 보너스, 전체 연봉을 출력
select eno 사원번호, ename 사원이름, salary 월급, commission 보너스,
        salary * 12 + nvl(commission, 0) "전체 연봉"
from employee;

--<문제4> commission이 null 이 아닌 사용자의 이름만 출력 
select ename 사원이름
from employee
where commission is not null;

--<문제5> manager (직급상사) 7698 인 사원이름과 직책을 출력.
select ename 사원이름, job 직책
from employee
where manager = 7698;

--<문제6> 월급이 1500 이상이고 부서가 20인 사원의 사원이름과 입사날짜, 부서번호, 월급을 출력
select ename 사원이름, hiredate 입사일, dno 부서번호, salary 월급
from employee
where salary>=1500 and dno=20;

--<문제7> 입사날짜가 81년 4월 1일 이상이고 81년 12월 말일까지인 사원 이름과 입사날짜을 출력
select ename 사원이름, hiredate 입사일
from employee
where hiredate between '81/04/01' and '81/12/31';

--<문제8> 직책(job) salesman 이면서 연봉이 1500 이상이면서 부서번호가 30인 사원명을 출력
select ename 사원이름
from employee
where job='SALESMAN' and dno=30 and salary>=1500;

--<문제9> 월급이 1500 이하이면서 부서번호가 20번 이 아닌 사원이름과, 월급과, 부서번호를 출력
select ename 사원이름, salary 월급, dno 부서번호
from employee
where salary <=1500 and not dno=20;

--<문제10> 사원번호(eno) 가 7788, 7782 인 부서번호와 이름과 직책을 출력
select dno 부서번호, ename 사원이름, job 직책
from employee
where eno in (7788, 7782);