/* Select 2 */

/*  �Լ� ����ϱ�
    
    ����Ŭ���� ������ �ִ� �پ��� �⺻ ������ �Լ�
    1. ���� ó�� �Լ�
    2. ���� ó�� �Լ�
    3. ��¥ ó�� �Լ�
    4. ��ȯ �Լ�
    5. �Ϲ� �Լ�
*/

/* 1. ���� �Լ�
        UPPER   : �빮�ڷ� ��ȯ���ִ� �Լ�
        LOWER   : �ҹ��ڷ� ��ȯ���ִ� �Լ�
        INITCAP : ù�ڸ� �빮�ڷ� ��ȯ���ִ� �Լ�
*/

-- dual : ������ ���̺�, ���� �Լ��� ó���ϱ� ���� �������� ���� ���̺�
select upper('oracle menia') "�빮�� ó��"
from dual;

select lower('ORACLE MENIA') "�ҹ��� ó��"
from dual;

select initcap('oracle menia') "�ܾ���ù���ڸ� �빮�� ó��"
from dual;

select ename "�̸�(����)", lower(ename) �ҹ���, initcap(ename) ù�ڸ��빮��
from employee;

select *
from employee
where ename = upper('ward');

/* ������ ���̸� ó���ϴ� �Լ�
    LENGTH  : ���ڼ��� ��ȯ (�ѱ��� 1byte�� ó��)
    LENGTHB : ���ڼ��� ��ȯ (�ѱ��� 3byte�� ó��)   <== UTF-8
*/

-- ���ڼ��� ���� : LENGTH
select length('oracle mania') ���ڼ�
from dual;

-- �ѱ� 1�ڴ� 3byte ==> length�� 1byte�� ó��
select length('����Ŭ �ŴϾ�') ���ڼ�
from dual;

select lengthb('oracle mania') ���ڼ�
from dual;

-- lengthb : �ѱ� 1�ڸ� 3byte�� ó��
select lengthb('����Ŭ �ŴϾ�') ���ڼ�
from dual;

/*  char(6)     : ���� 6��, �ѱ� 2��  <== ������ �ڸ����� ������ ��� 
                    - �ֹι�ȣ(13), �����й�ȣ(4)
    varchar2(6) : ���� 6��, �ѱ� 2��  <== ������ �ڸ����� �˼����� ���
                    - �ּ�, ����
    nchar(6)    : �����ڵ�(3byte) �ѱ�, �Ϻ���, �߱���... 6�� �Է°��� 
                    �ƽ�Ű�ڵ�(1byte) ���� 6�� ����
    nvarchar2(6): �����ڵ�(3byte) �ѱ�, �Ϻ���, �߱���... 6�� �Է°��� 
                    �ƽ�Ű�ڵ�(1byte) ���� 6�� ����
*/
-- Test01 ���̺� ����
create table test01 (
    name1 char(6) not null,
    name2 varchar2(6) null,
    name3 nchar(6) null,
    name4 nvarchar2(6) null
);

drop table test01;

desc test01;

-- test01 ���̺� �� �ֱ�
-- name1: char(6), name2: varchar(6) : ���� 6��, �ѱ� 2��
-- name3: nchar(6), name4: nvarchar(6) : ���� 6��, �ѱ� 6��
insert into test01 (name1, name2, name3, name4)
values ('abcdef', 'hijklm', 'abcde6', '����Ŭ�ŴϾ�');

insert into test01 (name1, name2, name3, name4)
values ('abcdef', 'hijklm', 'abcde6', 'abcdefg');

insert into test01 (name1, name2)
values ('����', '����');

select * from test01;

-- ���� ���̺��� ���ڼ� �о����
select ename, length(ename) �̸��Ǳ��ڼ�
from employee;

/*  CONCAT  : ���ڿ��� ���� �����ִ� �Լ�
    SUBSTR  : ���ڸ� �߶󳻴� �Լ�, �ѱ� 1�ڸ� 1byte �� ó��
    SUBSTEB : ���ڸ� �߶󳻴� �Լ�, �ѱ� 1�ڸ� 3byte �� ó��
    INSTR   : Ư�� ������ ��ġ���� ��ȯ (�ѱ� 1btye)
    INSTRB  : Ư�� ������ ��ġ���� ��ȯ (�ѱ� 3btye)
    LPAD    : ���� �ڸ����� �Է¹ް� �������� Ư����ȣ�� ä�� (����)
    RPAD    : ���� �ڸ����� �Է¹ް� �������� Ư����ȣ�� ä�� (������)
    TRIM    : ������ �����ϴ� �Լ� (��, ��)
    RTRIM   : �������� ���� ����
    LTRIM   : ������ ���� ����
*/

--  CONCAT
select 'oracle', 'mania', concat('oracle', 'mania')
from dual;
--  ���� ���̺� ����
select ename, job, concat(ename, job) �÷����� 
from employee;

--  SUBSTR : ���ڿ��� �߶���� �Լ�: substr(�÷�, 4,3) >> �÷��� 4��° �ڸ����� 3�ڸ� �߶�� ���
select substr('oracle mania', 4,3)
from dual;

select substr('����Ŭ �ŴϾ�', 3,3)
from dual;

select substrb('oracle mania', 4,3)
from dual;

select substrb('����Ŭ �ŴϾ�', 4,3)
from dual;
--  ���� ���̺� ����
select hiredate,
substr(hiredate, 1,2) ���������,
substr(hiredate, 4,2) �������,
substr(hiredate, 7,2) �ϸ����
from employee;

--  INSTR : Ư�� ������ ��ġ�� ���
--  oracle mania ���� a��� �ܾ �� �ڸ��� : 3
select instr('oracle mania', 'a')
from dual;
--  4��° �ڸ� ���ĺ��� 'a'��� �ܾ �� �ڸ��� : 9
select instr('oracle mania', 'a', 4)
from dual;
--  ��� �̸� �÷��� 'K'���ڰ� �� �ڸ��� �˻�, �˻��� ���� �������: 0
select ename, instr(ename, 'K')
from employee;

--  LPAD : LPAD(�÷�, �ڸ����� �ø�, '*')   : Ư�����ڸ� ���ʿ� ���
--  RPAD : RPAD(�÷�, �ڸ����� �ø�, '*')   : Ư�����ڸ� �����ʿ� ���
select salary, 
LPAD(salary, 10,'*'), 
RPAD(salary, 10,'*')
from employee;
--  �ֹι�ȣ(13) : 230627-1234567 >> ��ü(14, - ����), 230627-1******
    -- SUBSTR�� ����ؼ� �߶󳻰�, RPAD�� ����� �������� *�� ó��, lengrh �Լ� ���
select '230627-1234567' "�ֹι�ȣ(����)",
RPAD(substr('230627-1234567', 1, 8), length('230627-1234567'), '*') "�ֹι�ȣ(����)"
from dual;

select * from employee;

--  �̸�, �Ի����� ��½� ����/��/**
select ename ����̸�, rpad(substr(hiredate, 1, 6), length(hiredate), '*')
from employee;

--  TRIM �� ����ؼ� ���� ���� : DataBase�� �����ϱ��� client���� ���ڿ��� ��,�� ������ ������ ����
select '    oracle mania    ' ����,
RTRIM('    oracle mania    ') "������ ��������",
LTRIM('    oracle mania    ') "���� ��������",
TRIM('    oracle mania    ') "�յ� ��������"
from dual;

/*  2. ���� �Լ�
    ROUND : Ư�� �ڸ������� �ݿø� ó���ϴ� �Լ� << ����� �Ҽ����ڸ��� �ݿø��ؼ� ó��
            5�̻� �ݿø�, 5���� ����
    ROUND(���) : �Ҽ��� ���ڸ����� �ݿø�
    ROUND(���, �Ҽ����ڸ���) :
        - ��� �϶� : �Ҽ��� �������� ���������� �̵��ؼ� �ݿø�, �ش� �ڸ��� �ڿ��� �ݿø�
        - ���� �϶� : �Ҽ��� �������� �������� �̵��ؼ� �ݿø�, �ش� �ڸ������� �ݿø�
        
    TRUNC : Ư�� �ڸ������� �߶� ����
    MOD : ������ ���� ��ȯ
*/
select 98.7654 ����,
round(98.7654),     -- 99
round(98.7654, 2),  -- 98.77
round(98.7654, 3),  -- 98.765
round(98.7654, -1), -- 100
round(98.7654, -2), -- 100
round(98.7654, -3)  -- 0
from dual;

SELECT round(1234/34)
FROM dual;

-- �� �ٷμҵ漼�� ��� : ���� * 0.033
SELECT salary, salary* 0.033
FROM employee;

-- TRUNC : Ư�� �ڸ����� ����
SELECT
trunc(98.7654),     -- 98 �Ҽ��� �ڴ� ��� ����
trunc(98.7654, 1),  -- 98.7
trunc(98.7654, 2),  -- 98.76
trunc(98.7654, -1)  -- 90
FROM dual;

-- MOD(���, �����¼�) : ����� ������ ���� ����� �������� ���
-- 31�� ����� �� ���, ������ ���
SELECT
trunc(31/2) "�� �� ���",
mod(31, 2) "�������� ���"
from dual;