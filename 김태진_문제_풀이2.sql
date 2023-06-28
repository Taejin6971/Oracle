--1. 덧셈 연산자를 사용하여 모든 사원에 대해서 $300의 급여 인상을 계산한후 사원이름, 급여, 인상된 급여를 출력하세요. 
select ename 사원, salary 급여, salary+300 "인상된 급여"
from employee;

--2. 사원의 이름, 급여, 연간 총 수입이 많은것 부터 작은순으로 출력 하시오. 
    -- 연간 총 수입은 월급에 12를 곱한후 $100의 상여금을 더해서 계산 하시오. 
select ename 사원, salary 급여, salary*12+nvl(commission, 0)+100 "연간 총 수입", commission
from employee
order by "연간 총 수입" desc;

--3. 급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은것 부터 작은순으로 출력하세요. 
select ename 사원, salary 급여
from employee
where salary>=2000
order by salary desc;

--4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하세요. 
select ename 사원, dno 부서번호, eno 사원번호
from employee
where eno=7788;

--5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력 하세요. 
select ename 사원, salary 급여
from employee
where salary not between 2000 and 3000;

--6. 1981년 2월 20일부터 81년 5월 1일 사이의 입사한 사원의 이름 담당업무, 입사일을 출력하시오
select ename 사원, job 담당업무, hiredate 입사일
from employee
where hiredate between '81/02/20' and '81/05/01';

--7. 부서번호가 20및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 기준(내림차순)으로 출력하시오.
select ename 사원, dno 부서번호
from employee
where dno in (20, 30)
order by ename desc;

--8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력하되 이름을 오름차순으로 출력하세요. 
select ename 사원, salary 급여, dno 부서번호
from employee
where dno in(20,30) and salary between 2000 and 3000
order by ename;

--9. 1981년도 입사한 사원의 이름과 입사일을 출력 하시오 ( like 연산자와 와일드 카드 사용 : _ , % )
select ename 사원, hiredate 입사일
from employee
where hiredate like'81%';

--10. 관리자가 없는 사원의 이름과 담당업무를 출력하세요.
select ename 사원, job 담당업무, manager
from employee
where manager is null;

--11. 커밋션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여및 커밋션을 기준으로 내림차순 정렬하여 표시하시오.
select ename 사원, salary 급여, commission 커미션
from employee
where commission is not null
order by 급여 desc, 커미션 desc;

--12. 이름이 세번째 문자인 R인 사원의 이름을 표시하시오.
select ename 사원
from employee
where instr(ename, 'R', 3)=3;

select ename 사원
from employee
where ename like'__R%';

--13. 이름에 A 와 E 를 모두 포함하고 있는 사원의 이름을 표시하시오.
select ename 사원
from employee
where instr(ename, 'A')!=0 and instr(ename, 'E')!=0;

select ename 사원
from employee
where ename like'%A%' and ename like'%E%';

--14. 담당 업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이며서 
    -- 급여가 $1600, $950, 또는 $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
select ename 사원, job 담당업무, salary 급여
from employee
where job in ('CLERK', 'SALESMAN') and salary not in (1600,950,1300);

--15. 커미션이 $500이상인 사원의 이름과 급여 및 커미션을 출력하시오.
select ename 사원, salary 급여, commission 커미션
from employee
where commission>=500;