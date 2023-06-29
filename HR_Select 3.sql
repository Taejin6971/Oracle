/* Select 3 */
/*  ���� �Լ�
    SYSDATE         : ���� �ý����� ��¥�� ����ϴ� �Լ�
    MONTHS_BETWEEN  : �� ��¥ ������ ���� ���� ���
    ADD_MONTHS      : Ư�� ��¥�� �������� ���Ҷ�
    NEXT_DAY        : Ư�� ��¥���� �ʷ��ϴ� ������ ���ڷ� �޾Ƽ� ������ �����ϴ� ��¥�� ���
    LAST_DAY        : ���� ������ ��¥�� ��ȯ
    ROUND           : ��¥�� �ݿø� �ϴ� �Լ�, 15�� �̻��̸� �ݿø� �̸��̸� ����
    TRUNC           : ��¥�� �߶󳻴� �Լ�
*/

-- ���� �ý����� ��¥ ��� : yy/mm/dd
select sysdate
from dual;

select sysdate -1 ����, sysdate ����, sysdate+1 ����
from dual;

select * from employee;

-- �Ի� �Ϸκ��� ���� ��¥���� ���� �ٹ��ߴ��� ���
select ename ���, hiredate �Ի���, round(sysdate-hiredate) �ѱٹ��ϼ�
from employee;

-- �Ի��Ϸ� ���� 1000�� ���� ������ ��¥�� ���
select ename ���, hiredate �Ի���, hiredate+1000 �Ի�1000�ϳ�¥
from employee;

-- Ư�� ��¥���� ���� �������� ���
select hiredate ����, trunc(hiredate, 'month'), round(hiredate, 'month')
from employee;

-- months_btween : �� ��¥ ������ �������� ���
-- �Ի��Ϸ� ���� ��������� �ٹ��� �������� ���
select ename, hiredate, trunc(months_between(sysdate, hiredate)) �ٹ�������
from employee;

-- date (��¥Ÿ��)
-- add_months (��¥, ������) : ��¥�� �������� ���ϴ� �Լ�
-- ���ó�¥�� 100������ ���� ��¥
select sysdate ���ó�¥, add_months(sysdate, 100) "100������", sysdate+100 "100����"
from dual;

-- �Ի��� 6������ ���� ����
select ename, hiredate, add_months(hiredate, 6) "�Ի��� 6��������"
from employee;

-- next_day : Ư�� ��¥���� ������ ��ǲ���� �־ �����ϴ� ������ ��¥�� ���
select next_day(sysdate, '��')
from dual;

-- last_day (date) : date�� ������ ��¥�� ���
select sysdate ���ó�¥, last_day(sysdate)
from dual;

-- ��� ���̺��� �Ի糯�� ��������¥ ���
select hiredate �Ի���, last_day(hiredate)
from employee;

/*  ���� ��ȯ �Լ�
    TO_CHAR     : ��¥, �������� ���������� ��ȯ
    TO_DATE     : �������� ��¥������ ��ȯ
    TO_NUMBER   : �������� ���������� ��ȯ
*/

-- to_char (date, 'YYYYMMDD') : ��¥������ 'YYYYMMDD'�������� �̾Ƽ� charŸ������ ��ȯ
select to_char(sysdate, 'yyyy/mm/dd')
from dual;

/*  YYYY : ��¥ ������ �⵵�� �̾Ƴ�
    YY   : �⵵�� ������ 2�ڸ� �̾Ƴ�
    MM   : ��
    DD   : ��
    
    DAY  : ������ �̾ƿ� (������, ȭ����, ... �Ͽ���)
    DY   : ������ �̾ƿ� (��, ȭ, ... ��)
    
    HH   : �ð�
    MI   : ��
    SS   : ��
*/

select to_char(sysdate, 'yyyy/mm/dd'), to_char(sysdate, 'yyyy/mm/dd day hh:mi:ss')
from dual;

select sysdate, to_char(sysdate, 'yy/mm/dd_hh:mi:ss_dy')
from dual;

select * from employee;

desc employee;

select hiredate ����, to_char(hiredate, 'yyyy_mm_dd day hh:mi:ss')
from employee;

/*  TO_CHAR : ��¥, ���� ==> ���������� ��ȯ

    0 : �ڸ����� ó����, �ڸ����� ����������  0���� ó����
    9 : �ڸ����� ó����, �ڸ����� ����������  ���� ó����
    L : �� ������ ��ȭ($)�� ��ȣ�� ǥ��
    . : �Ҽ������� ó��
    , : õ ���� ������
*/

desc employee;

select ename, salary, to_char(salary, 'L999,999') "9", to_char(salary, 'L000,000') "0"
from employee;

/*  TO_DATE : ������ ==> ��¥Ÿ������ ��ȯ
    
    TO_DATE(��ȯ�� ����[����], 'YYYYMMDD')
*/

select to_date(20230628, 'yyyymmdd'), to_date('06282023', 'mmddyyyy')
from dual;

select to_date('2001-10-30', 'yyyy-mm-dd')
from dual;

-- ���Ͽ��� ���� ��¥���� ��ĥ ��Ҵ��� ��� : 1981-04-15
select trunc(sysdate - to_date('1981-04-15', 'yyyy-mm-dd'))
from dual;

select to_date('12/06/22', 'mm/dd/yy') - to_date('1900-10-17', 'yyyy-mm-dd') �γ�¥����
from dual;

-- �ڽ��� ���Ͽ��� ������� ��ĥ/��� ��Ҵ��� ���, 
select 
trunc(sysdate - to_date('19960104','yyyymmdd')) ��ƿ³�,
trunc(months_between(sysdate, to_date('19960104','yyyymmdd'))) ��ƿ°���
from dual;

-- employee ���̺��� ������� �Ի��Ͽ��� 2030/01/01 ������ �ٹ��������� ���
select ename, hiredate, 
trunc(months_between(to_date('20300101','yyyymmdd'), hiredate)) Ư����¥�����ٹ�������
from employee;

/*  NULL ó�� �Լ� : NVL, NVL2, NULLIF

    NVL(�÷�, ��) : �÷��� NULL�� ������ ��� ������ ��ġ
    NVL2(�÷�, NULL�� �ƴҰ�� ó��, NULL�� ��� ó��)
*/

select * from employee;

-- NVL �Լ��� ����ؼ� ���� ���ϱ� (���� = ���� * 12 + ���ʽ�)
select ename, salary, commission, 
        salary * 12 + nvl(commission,0) �ѿ���
from employee;

-- NVL2 �Լ��� ����ؼ� ���� ���ϱ� (���� = ���� * 12 + ���ʽ�)
select ename, salary, commission , 
        nvl2(commission ,salary * 12 +commission , salary*12 ) as �ѿ��� 
from employee; 

-- �׷� �Լ� : group by, Ư�� �÷��� �׷����ؼ� ó����.
select �÷���
from ���̺��̸�[��]
where ����
group by �÷���[�׷������÷���]
having ���� [�׷����Ѱ��������]
order by �÷���[�������÷���]

/*  ���� �Լ� : SUM, AVG, MAX, MIN, COUNT   <== NULL�� �ڵ����� ó���ؼ� �۵�
        - NUMBER Ÿ�Կ����� ��밡��
    SUM   : �÷��� ��� ���� ���ϴ� �Լ�
    AVG   : �÷��� ��� ���� ����� ���ϴ� �Լ�
    MAX   : �÷��� ��� ���� �ִ밪�� �������� �Լ�
    MIN   : �÷��� ��� ���� �ּҰ��� �������� �Լ�
    COUNT : ���ڵ��, �׷��ε� ���� ���
    
    *���� : ���� row�� ��µ�, �ٸ� �÷��� ���� ���� ��� �����߻�
*/

select commission
from employee
order by commission asc;

select 
sum(commission) �հ�, avg(commission) ���, max(commission) �ִ밪,
min(commission) �ּҰ�, count(commission) ���ڵ��
from employee;

select * from employee;

-- �μ��� ������ �հ�, ���, �ִ밪, �ּҰ�, �׷��ε� ����
-- dno : �μ���ȣ�� ������ ���� �׷��ؼ� ó����
select sum(salary) "�μ��� ���", dno, count(dno) �׷��εȰ���
from employee
group by dno;

select ename, salary, dno
from employee
order by dno asc;

-- �μ����� ������ �հ�, ���, �ִ밪, �ּҰ�, �׷��εȼ�
select
sum(salary) �հ�, round(avg(salary)) ���, max(salary) �ִ�, min(salary) �ּ�
,dno, count(dno)
from employee
group by dno
order by dno asc;

select salary 
from employee 
where dno=20;

select ename, job, salary
from employee;

-- ���޺��� ������ �հ�, ��� �ִ밪, �ּҰ�, �׷��εȼ�
select 
sum(salary) �հ�, round(avg(salary)) ���, max(salary) �ִ�, min(salary) �ּ�
,job, count(job)
from employee
group by job
order by �հ� desc;

/*  group by ����
    
    where ��  : <����> : group by ���� ������ ó���ؼ� ���� ����� group by
    having �� : <����> : group by �� ����� ���� ����ó��, ��Ī�̸��� ����ϸ� �ȵ�.
*/

/*  ���޺��� ������ �հ�, ���, �ִ밪, �ּҰ��� ����ϵ� 
    20�� �μ��� �����ϰ� ����� 2000 �̻��ΰ͸� ���, ����� �������� ����
*/
select 
sum(salary) �հ�, round(avg(salary)) ���, max(salary) �ִ�, min(salary) �ּ�
, job, count(*)
from employee
where dno!=20
group by job
having round(avg(salary))>=2000
order by ��� desc;

-- ���÷� �̻� �׷��� �Ҽ��ִ�, ���÷���ΰ� �����Ҷ� �׷��� ����
select dno, job
from employee
order by dno, job;

-- �μ���ȣ,��å �÷� ��� �׷����ؼ� ������ �հ�, ���, �ִ밪, �ּҰ�, count
select
sum(salary), round(avg(salary)), max(salary), min(salary), count(*), dno, job
from employee
group by dno, job
order by count(*) desc;

/* �� ��å�� ���ؼ� ������ �հ�, ���, �ִ밪, �ּҰ��� ����ϴµ�
    �Ի����� 81�⵵�� �Ի��� ����鸸 ����ϵ� ������ ����� 1500 �̻��ΰ͸� ����ϰ�
    ����� �������� ����
*/
select 
sum(salary) �հ�, round(avg(salary)) ���, max(salary) �ִ밪, min(salary) �ּҰ�
, job, count(*)
from employee
where hiredate like'81%'
group by job
having avg(salary)>=1500
order by ��� desc;

select count(*)
from employee
where hiredate like'81%';

-- rollup : �׷��� ��� ������ ���ο� ��ü ����� ���,
-- cube   : �� �׷����� ������ ���ο� ������, ���� ������ ���ο� ��ü ����� �Բ� ���

-- rollup, cube �� ������� �ʴ� �׷��� ����

-- group by ������ �÷� 2���� �׷��� �ɶ� �� �÷��� ���ļ� �ߺ��� �׷���
select
sum(salary), round(avg(salary)) ���, max(salary), min(salary), dno, job, count(*)
from employee
group by dno, job
order by dno asc;

select dno, job
from employee
order by dno, job;

-- rollup ���
select
sum(salary), round(avg(salary)) ���, max(salary), min(salary), dno, job, count(*)
from employee
group by rollup(dno, job)
order by dno asc;

-- cube ���
select
sum(salary), round(avg(salary)) ���, max(salary), min(salary), dno, job, count(*)
from employee
group by cube(dno, job)
order by dno asc;

/*  SubQuery (��������) : select ������ select ����, ������ �۾��� �ϳ��� �������� ����
        where ������ ���� ���
*/

/*  ename �� SCOTT�� ����� ������ ��å�� ������� ���
    1. ename�� SCOTT�� ����� ��å�� �������� ����
    2. ��å�� �������� �ؼ� ����� �˾ƿ;��ϴ� ����
*/
select * from employee;

select job 
from employee 
where ename='SCOTT';

select ename 
from employee 
where job='ANALYST';

-- SubQuery ���
select ename, salary, job
from employee 
where job=(
    select job 
    from employee 
    where ename='SCOTT'
    );

-- SMITH �� ������ �μ��� ���� ������� ���
select ename, dno
from employee
where dno=(
    select dno 
    from employee 
    where ename='SMITH'
    );

-- SCOTT�� ���޺��� ���� ������� ���
select ename, salary
from employee
where salary>(
    select salary 
    from employee 
    where ename='SCOTT'
    );

-- �ּ� �޿��� �޴� ����� �̸��� ������, �޿� ���
select ename, job, salary
from employee
where salary=(
    select min(salary) 
    from employee
    );

-- ���� ���� �ƴ϶� �������� ���� ��µ� ��� IN Ű���� ���

-- �μ����� �ּұ޿��� �޴� ����� �̸�, ��å, ���� ���, group by, min, in Ű���� ���
select ename, job, salary, dno
from employee
where salary in (
    select min(salary) 
    from employee 
    group by dno
    );
    
-- �� �μ��� �ּ� �޿��� 30�� �μ��� �ּ� �޿����� ū �μ��� ���
select min(salary), dno, count(*)
from employee
group by dno
having min(salary)>(
    select min(salary)
    from employee
    where dno=30
    );
    
/*  ANY ������ : ���������� ��ȯ�ϴ� ������ ���� ����
        < any : �ִ밪 ���� ������ ��Ÿ����.
        > any : �ּҰ� ���� ū���� ��Ÿ����.
        = any : in �� ������ Ű����
        
    ALL ������ : ������������ ��ȯ�Ǵ� ��簪�� ����
        < all : �ּҰ� ���� ������ ��Ÿ����.
        > all : �ִ밪 ���� ū���� ��Ÿ����.
*/

-- ������ SALESMAN�� �ƴϸ鼭 ������ SALESMAN�� ������� �޿��� ���� ����� ��� ���
select *
from employee
order by job, salary;

-- all ���
select ename, job, salary
from employee
where salary < all(
    select salary
    from employee
    where job='SALESMAN'
    )
    and job != 'SALESMAN';
    
-- min ���
select ename, job, salary
from employee
where salary < (
    select min(salary)
    from employee
    where job='SALESMAN'
    )
    and job != 'SALESMAN';
    
-- ��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ���
-- all ���
select ename, job, salary
from employee
where salary < all(
    select salary
    from employee
    where job='ANALYST'
    )
    and job != 'ANALYST';
    
-- min ���
select ename, job, salary
from employee
where salary < (
    select min(salary)
    from employee
    where job='ANALYST'
    )
    and job != 'ANALYST';