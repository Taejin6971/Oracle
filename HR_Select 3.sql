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
select to_char(sysdate, 'yyyymmdd')
from dual;