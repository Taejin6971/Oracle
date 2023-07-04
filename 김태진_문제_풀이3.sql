--1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select ename, substr(hiredate,1,5)
from employee;

--2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename, hiredate
from employee
where substr(hiredate,4,2)=04;

--3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename, manager
from employee
where mod(manager,2)!=0;

--4. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select ename, salary
from employee
where mod(salary,3)=0;

--5. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select hiredate, to_char(hiredate, 'yy/mon dy')
from employee;

/*6. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
   데이터 형식을 일치 시키시오.*/
select trunc(sysdate-to_date(20230101,'yyyymmdd'))
from dual;

--7. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc(sysdate-to_date(19960104,'yyyymmdd'))
from dual;

--8. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc(months_between(sysdate, to_date(19960104,'yyyymmdd')))
from dual;

--9. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename, nvl(manager,0)
from employee;

/*10.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"*/
select eno, rpad(substr(eno,1,2),length(eno),'*') 가린번호,
        ename, rpad(substr(ename,1,1),length(ename),'*') 가린이름
from employee;

/*11.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	dual 테이블 사용*/
select rpad(substr('801210-12345667',1,8),length('801210-12345667'),'*') 주민번호,
        rpad(substr('010-1234-5678',1,6),length('010-1234-5678'),'*') 전화번호
from dual;

--======================================================================================
--모든 평균은 소숫점 2자리까지 출력하되 반올림 해서 출력 하시오.  
--1.  10 번 부서를 제외하고 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum(salary),round(avg(salary),2),max(salary),min(salary),dno
from employee
group by dno;

--2.  직책의 SALSMAN, PRESIDENT, CLERK 을 제외한 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오.   	
select sum(salary),round(avg(salary),2),max(salary),min(salary),dno
from employee
where job not in('SALESMAN','PRESIDENT','CLERK')
group by dno;

--3. SMITH 과 동일한 부서에 근무하는 사원들 의 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee
where dno=(
    select dno
    from employee
    where ename='SMITH'
    );

--4. 부서별 최소월급을 가져오되 최소월급이 1000 이상인 것만 출력하세요. 
select min(salary),dno
from employee
group by dno
having min(salary)>1000;

--5.  부서별 월급의 합계가 9000 이상것만 출력
select sum(salary),dno
from employee
group by dno
having sum(salary)>9000;

--6.  부서별 월급의 평균이 2000 이상만 출력
select round(avg(salary),2),dno
from employee
group by dno
having avg(salary)>2000;

--7. 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 
select round(avg(salary),2),dno
from employee
where salary>1500
group by dno
having avg(salary)>=2500;

--8. sub query - 부서별로 최소 급여를 받는 사용자의 이름과 급여와 직책과 부서번호를 출력하세요. 
select ename, salary, job, dno
from employee
where salary in (
    select min(salary) 
    from employee 
    group by dno
    );

--9. sub query - 전체 평균 급여보다 많이 받는 사용자의  이름과 급여와 직책과 부서번호를 출력하세요. 
select ename, salary, job, dno
from employee
where salary > (
    select avg(salary)
    from employee
    );

--10. sub query - 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순 정렬하시오.
select eno, ename, salary
from employee
where salary > (
    select avg(salary)
    from employee
    )
order by salary;

======== 해답지 ==============================================================================

1. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력 하시오. 
select * from employee; 
select substr ( hiredate, 1,5 ) as 년월 
from employee; 

2. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력 하시오.
select ename, hiredate 
from employee
where  substr (hiredate, 4, 2)  = 04; 

3. MOD 함수를 사용하여 직속상관이 홀수인 사원만 출력하시오. 
select ename, manager 
from employee
where MOD (manager , 2) = 1; 

4. MOD 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.

select ename, salary 
from employee
where MOD ( salary , 3) = 0 ; 

5. 입사한 년도는 2자리 (YY), 월은 (MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력 하시오. 
select hiredate , to_char ( hiredate, 'YY MON DD DY') as 출력결과 
from employee; 

6. 올해 몇 일이 지났는지 출력 하시오. 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 TO_DATE 함수를 사용하여
   데이터 형식을 일치 시키시오.
  select trunc (sysdate - to_date ( 20220101 , 'YYYYMMDD')) as 올해날짜수 from dual;  
   

7. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
 select trunc (sysdate - to_date ( 19800101 , 'YYYYMMDD')) as 총날짜수 from dual;  

8. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요.
select trunc( months_between (sysdate , to_date ( 19800101 , 'YYYYMMDD'))) as 총개월수 from dual;

9. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오.
select ename, manager , nvl (manager, 0), nvl2 (manager, manager,0)
from employee; 

10.   사원번호,
      [사원번호 2자리만출력 나머지는 *가림 ] as "가린번호", 
      이름, 
       [이름의 첫자만 출력 총 네자리, 세자리는 * 가림] as "가린이름"
       
    select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as 가린번호 ,  
    ename, rpad ( substr (ename, 1,1), 4,'*')
    from employee;
    
        select eno, rpad (substr (eno , 1 ,2) , length(eno), '*')  as 가린번호 ,  
    ename, rpad ( substr (ename, 1,1), length (ename),'*')
    from employee;
      
    select ename, length(ename)
    from employee; 
       
11.  주민번호:   를 출력하되 801210-1*******   출력 하도록 , 전화 번호 : 010-12*******
	dual 테이블 사용
    
    select  RPAD (substr ('801210-1234578', 1,8) , length ('801210-1234578'), '*') as 주민번호,
            RPAD ( substr ('010-1234-5678', 1,6), length ('010-1234-5678'), '*') as 전화번호
    from dual; 
    
    모든 평균은 소숫점 2자리까지 출력하되 반올림 해서 출력 하시오.  
1.  10 번 부서를 제외하고 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum (salary), round (avg(salary),2), max(salary), min(salary), dno, count(*)
from employee
where dno not in (20)
group by dno
order by dno;

2.  직책의 SALSMAN, PRESIDENT, CLERK 을 제외한 각 부서별 월급의 합계와 평균과 최대값, 최소값을 구하시오.  
select sum (salary), round (avg(salary),2), max(salary), min(salary), dno, count(*)
from employee
where job not in ('SALESMAN', 'PRESIDENT', 'CLERK')
group by dno
order by dno;

3. SMITH 과 동일한 부서에 근무하는 사원들 의 월급의 합계와 평균과 최대값, 최소값을 구하시오. 
select sum(salary), round( avg(salary),2), max(salary), min(salary), dno, count(*)
from employee
where dno = (select dno from employee where ename = 'SMITH')
group by dno;

4. 부서별 최소월급을 가져오되 최소월급이 1000 이상인 것만 출력하세요. 
select min (salary), dno, count(*)
from employee
group by dno
having min(salary) > 1000;

5.  부서별 월급의 합계가 9000 이상것만 출력

select dno , count(*), sum (salary) as 부서별합계 , round (avg(salary) , 2) as 부서별평균
from employee 
group by dno
having sum (salary) >9000 ; 


6. 부서별 월급의 평균이 2000 이상만 출력

select dno , count(*), sum (salary) as 부서별합계 , round (avg(salary) , 2) as 부서별평균
from employee 
group by dno
having round (avg(salary) , 2) > 2000.00 ; 

7. 월급이 1500 이하는 제외하고 각 부서별로 월급의 평균을 구하되 월급의 평균이 2500이상인 것만 출력 하라. 
select dno, count(*) , round (avg (salary)) as 부서별평균
from employee
where salary > 1500
group by dno
having round (avg (salary)) > 2500; 

8. sub query - 부서별로 최소 급여를 받는 사용자의 이름과 급여와 직책과 부서번호를 출력하세요. 

select eno, ename, salary, dno
from employee
where salary in (select  min(salary)
                from employee
                group by dno );
                
9. sub query - 전체 평균 급여보다 많이 받는 사용자의  이름과 급여와 직책과 부서번호를 출력하세요. 
select ename, salary, job, dno 
from employee
where salary > ( select avg(salary) from employee); 


10. sub query - 급여가 평균 급여보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해 오름차순 정렬하시오. 

select eno, ename,salary from employee
where salary > (select avg(salary) as 평균급여 from employee)
order by salary asc;