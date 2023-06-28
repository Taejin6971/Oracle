/* Select 2 */

/*  함수 사용하기
    
    오라클에서 제공해 주는 다양한 기본 제공된 함수
    1. 문자 처리 함수
    2. 숫자 처리 함수
    3. 날짜 처리 함수
    4. 변환 함수
    5. 일반 함수
*/

/* 1. 문자 함수
        UPPER   : 대문자로 변환해주는 함수
        LOWER   : 소문자로 변환해주는 함수
        INITCAP : 첫자만 대문자로 변환해주는 함수
*/

-- dual : 가상의 테이블, 단일 함수를 처리하기 위해 가장으로 만든 테이블
select upper('oracle menia') "대문자 처리"
from dual;

select lower('ORACLE MENIA') "소문자 처리"
from dual;

select initcap('oracle menia') "단어의첫글자만 대문자 처리"
from dual;

select ename "이름(원본)", lower(ename) 소문자, initcap(ename) 첫자만대문자
from employee;

select *
from employee
where ename = upper('ward');

/* 문자의 길이를 처리하는 함수
    LENGTH  : 글자수를 반환 (한글을 1byte로 처리)
    LENGTHB : 글자수를 반환 (한글을 3byte로 처리)   <== UTF-8
*/

-- 글자수를 리턴 : LENGTH
select length('oracle mania') 글자수
from dual;

-- 한글 1자는 3byte ==> length는 1byte로 처리
select length('오라클 매니아') 글자수
from dual;

select lengthb('oracle mania') 글자수
from dual;

-- lengthb : 한글 1자를 3byte로 처리
select lengthb('오라클 매니아') 글자수
from dual;

/*  char(6)     : 영문 6자, 한글 2자  <== 글자의 자릿수가 지정된 경우 
                    - 주민번호(13), 은행비밀번호(4)
    varchar2(6) : 영문 6자, 한글 2자  <== 글자의 자릿수를 알수없는 경우
                    - 주소, 메일
    nchar(6)    : 유니코드(3byte) 한글, 일본어, 중국어... 6자 입력가능 
                    아스키코드(1byte) 영문 6자 가능
    nvarchar2(6): 유니코드(3byte) 한글, 일본어, 중국어... 6자 입력가능 
                    아스키코드(1byte) 영문 6자 가능
*/
-- Test01 테이블 생성
create table test01 (
    name1 char(6) not null,
    name2 varchar2(6) null,
    name3 nchar(6) null,
    name4 nvarchar2(6) null
);

drop table test01;

desc test01;

-- test01 테이블에 값 넣기
-- name1: char(6), name2: varchar(6) : 영문 6자, 한글 2자
-- name3: nchar(6), name4: nvarchar(6) : 영문 6자, 한글 6자
insert into test01 (name1, name2, name3, name4)
values ('abcdef', 'hijklm', 'abcde6', '오라클매니아');

insert into test01 (name1, name2, name3, name4)
values ('abcdef', 'hijklm', 'abcde6', 'abcdefg');

insert into test01 (name1, name2)
values ('오늘', '날씨');

select * from test01;

-- 실제 테이블의 글자수 읽어오기
select ename, length(ename) 이름의글자수
from employee;

/*  CONCAT  : 문자열을 연결 시켜주는 함수
    SUBSTR  : 문자를 잘라내는 함수, 한글 1자를 1byte 로 처리
    SUBSTEB : 문자를 잘라내는 함수, 한글 1자를 3byte 로 처리
    INSTR   : 특정 문자의 위치값을 변환 (한글 1btye)
    INSTRB  : 특정 문자의 위치값을 변환 (한글 3btye)
    LPAD    : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (왼쪽)
    RPAD    : 글자 자릿수를 입력받고 나머지는 특정기호로 채움 (오른쪽)
    TRIM    : 공백을 제거하는 함수 (앞, 뒤)
    RTRIM   : 오른쪽의 공백 제거
    LTRIM   : 왼쪽의 공백 제거
*/

--  CONCAT
select 'oracle', 'mania', concat('oracle', 'mania')
from dual;
--  실제 테이블에 적용
select ename, job, concat(ename, job) 컬럼연결 
from employee;

--  SUBSTR : 문자열을 잘라오는 함수: substr(컬럼, 4,3) >> 컬럼의 4번째 자리에서 3자를 잘라와 출력
select substr('oracle mania', 4,3)
from dual;

select substr('오라클 매니아', 3,3)
from dual;

select substrb('oracle mania', 4,3)
from dual;

select substrb('오라클 매니아', 4,3)
from dual;
--  실제 테이블에 적용
select hiredate,
substr(hiredate, 1,2) 연도만출력,
substr(hiredate, 4,2) 월만출력,
substr(hiredate, 7,2) 일만출력
from employee;

--  INSTR : 특정 문자의 위치를 출력
--  oracle mania 에서 a라는 단어가 들어간 자릿수 : 3
select instr('oracle mania', 'a')
from dual;
--  4번째 자리 이후부터 'a'라는 단어가 들어간 자릿수 : 9
select instr('oracle mania', 'a', 4)
from dual;
--  사원 이름 컬럼에 'K'글자가 들어간 자릿수 검색, 검색이 되지 않을경우: 0
select ename, instr(ename, 'K')
from employee;

--  LPAD : LPAD(컬럼, 자릿수를 늘림, '*')   : 특수문자를 왼쪽에 출력
--  RPAD : RPAD(컬럼, 자릿수를 늘림, '*')   : 특수문자를 오른쪽에 출력
select salary, 
LPAD(salary, 10,'*'), 
RPAD(salary, 10,'*')
from employee;
--  주민번호(13) : 230627-1234567 >> 전체(14, - 포함), 230627-1******
    -- SUBSTR을 사용해서 잘라내고, RPAD를 사용해 오른쪽은 *로 처리, lengrh 함수 사용
select '230627-1234567' "주민번호(원본)",
RPAD(substr('230627-1234567', 1, 8), length('230627-1234567'), '*') "주민번호(보안)"
from dual;

select * from employee;

--  이름, 입사일을 출력시 연도/월/**
select ename 사원이름, rpad(substr(hiredate, 1, 6), length(hiredate), '*')
from employee;

--  TRIM 을 사용해서 공백 제거 : DataBase에 저장하기전 client에서 문자열의 앞,뒤 공백을 제거후 저장
select '    oracle mania    ' 원본,
RTRIM('    oracle mania    ') "오른쪽 공백제거",
LTRIM('    oracle mania    ') "왼쪽 공백제거",
TRIM('    oracle mania    ') "앞뒤 공백제거"
from dual;

/*  2. 숫자 함수
    ROUND : 특정 자릿수에서 반올림 처리하는 함수 << 연산시 소수점자리를 반올림해서 처리
            5이상 반올림, 5이하 버림
    ROUND(대상) : 소수점 뒷자리에서 반올림
    ROUND(대상, 소숫점자릿수) :
        - 양수 일때 : 소숫점 기준으로 오른쪽으로 이동해서 반올림, 해당 자릿수 뒤에서 반올림
        - 음수 일때 : 소숫점 기준으로 왼쪽으로 이동해서 반올림, 해당 자릿수에서 반올림
        
    TRUNC : 특정 자릿수에서 잘라서 버림
    MOD : 나머지 값만 반환
*/
select 98.7654 원본,
round(98.7654),     -- 99
round(98.7654, 2),  -- 98.77
round(98.7654, 3),  -- 98.765
round(98.7654, -1), -- 100
round(98.7654, -2), -- 100
round(98.7654, -3)  -- 0
from dual;

SELECT round(1234/34)
FROM dual;

-- 월 근로소득세를 출력 : 월급 * 0.033
SELECT salary, salary* 0.033
FROM employee;

-- TRUNC : 특정 자리에서 버림
SELECT
trunc(98.7654),     -- 98 소수점 뒤는 모두 버림
trunc(98.7654, 1),  -- 98.7
trunc(98.7654, 2),  -- 98.76
trunc(98.7654, -1)  -- 90
FROM dual;

-- MOD(대상, 나누는수) : 대상을 나누는 수로 나누어서 나머지만 출력
-- 31을 나누어서 몫만 출력, 나머지 출력
SELECT
trunc(31/2) "몫 만 출력",
mod(31, 2) "나머지만 출력"
from dual;