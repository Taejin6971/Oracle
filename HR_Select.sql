/* Select �� */

-- ���̺��� ��ū �÷��� ���
select * from employee;     -- ��������� ����� ���̺�

select * from department;   -- ����� ���� �μ� ������ ����

select * from salgrade;     -- ���޿� ���� ����� ����

/*  EMPLOYEE ���̺��� �÷�(�ʵ�) ����
    ENO         : �����ȣ
    ENAME       : �����
    JOB         : ��å
    MANAGER     : ���� ��� (���)
    HIREDATE    : �Ի���
    SALARY      : ����
    COMMISSION  : ���ʽ�
    DNO         : �μ���ȣ
*/

/*  DEPARTMENT ���̺��� �÷�(�ʵ�) ����
    DNO     : �μ���ȣ
    DNAME   : �μ���
    LOC     : �μ���ġ
*/

/*  SALGRADE ���̺��� �÷�(�ʵ�) ����
    GRADE : ���
    LOSAL : �ּ� ����
    HISAL : �ִ� ����
*/

-- SELECT ���� : ����϶�
SELECT      : �÷���
FROM        : ���̺��[��]
WHERE       : ����
GROUP BY    : �׷������÷�
HAVING      : ���� (�׷����� ����� ����)
ORDER BY    : �÷��� (������ �÷���)

/* �⺻ Select */
-- ��� �÷� ����ϱ�
select * from employee;

-- Ư�� �÷��� ����ϱ�
select eno, ename, salary
from employee;

-- �÷��� ������ ����Ҽ� �ִ�. �÷��� ������ �����Ҽ� �ִ�.
select ename, salary, salary+100, hiredate, salary*2
from employee;

-- �÷��� ��Ī �����ϱ� : �����̸� as ��Ī�̸�
select ename as �̸�, salary as ����, salary+100 as "����+100", salary*2 as "������ �ι�"
from employee;

-- �÷��� ��Ī �����ϱ� : as ���� ����
select ename �̸�, salary ����, salary+100 "����+100", salary*2 "������ �ι�"
from employee;

/* WHERE ���� ����ϱ� */
select * from employee;
-- �̸��� JAMES�� ����� �̸��� ��å, �Ի���, �μ���ȣ ����ϱ�
-- SELECT, select, FROM, from, WHERE, where
-- �÷��� ����� �� (���ڵ�)�� �����ö� ��ҹ��ڸ� ������.
select ename �̸�, job ��å, hiredate �Ի���, dno �μ���ȣ
from employee
where ename='JAMES';

-- where ������ or, and ������ ���
select *
from employee
where ename='JAMES' or ename='SMITH';

-- where ������ in ������ ���
select *
from employee
where ename in ('JAMES', 'SMITH');

-- where ������ �� ������ ��� : >, <, >=, <=
-- ������ 1500 �̻��� ����ڸ� ���
select *
from employee
where salary>=1500;

-- ������ 1500�̻� �̰� �μ��� 30�� ����� ������ ���
select *
from employee
where salary>=1500 and dno=30;

-- ���̺��� �÷��� �ڷ����� �� ���̺� ���� Ȯ��
-- NUMBER : Oracle���� ����, �Ǽ�
/*
    NUMBER(4)   : ���� 4�ڸ������� ������ �ִ�.
    NUMBER(7,2) : �Ǽ� (��ü 7�ڸ�, ������ ���� 2�ڸ�)
    CHAR(10)    : ���� 10byte     <== �ڸ����� �˼��ִ� ���
        - VARCHAR2 ���� ������ ������, �ϵ���� ���� �ִ�
        - �ֹι�ȣ(13), ��й�ȣ 4�ڸ��� ����.
    VARCHAR2(10): ���� 10byte     <== VARCHAR2�� ���, �ڸ����� �˼����� ��� 
        - CHAR ���� ������ ���������� �ϵ������ �������� �ʴ´�.
    DATE        : ��¥�� �����ϴ� ������ Ÿ��
*/

-- ���̺� ���� Ȯ��
desc employee;

-- NUMBER : ����, �Ǽ� ���� �����ö� ''�� ���̸� �ȵ�.
-- CHAR, VARCHAR2, DATE ���� �����ö� ''�� �ٿ�����.

-- ��å�� �������(SALESMAN) �̰� ������ 1500 �̻� 3000 �̸��� ����� �̸��� ����� ����
select ename �̸�
from employee
where job='SALESMAN' and (salary>=1500 and salary<3000);

-- null �� �˻� : 
    -- *����: =�� ����ϸ� �ȵ�, is null
    -- null : 0�� �ƴϰ� ����ִ� ����
    
-- ���ʽ�(COMMISSION)�� ���� ��� ���� ���
select *
from employee
where commission is null;

-- ���ʽ�(COMMISSION)�� �ִ� ��� ���� ��� : null�� �ƴѰ͸� �˻�
select *
from employee
where commission is not null;

-- ���,���(MANAGER)�� ���� ��� ���� ���
select *
from employee
where manager is null;

-- ���� �˻��ϱ�
-- �Ի� ��¥�� 81/02/20 �ϳ� �Ի��� ����� �̸��� ��å�� ������ ���
select ename �̸�, job ��å, salary ����, hiredate �Ի���
from employee
where hiredate='81/02/20';

-- 81�⵵�� �Ի��� ����鸸 ���
select *
from employee
where hiredate>='81/01/01' and hiredate<='81/12/31';    -- ��¥ �÷� : date

-- where ���� Like ������ ����ϱ� <== �÷��� Ư�� �ܾ �˻��Ҷ� ��� : �Խ���, �̸�, �۳���, ��¥ �˻�
    -- ���ڿ��� �ܾ �˻��Ҷ� ���
    -- ���ϵ� ī�� �ĺ��� ��� : % ����ڰ� �͵� ��� ����.
-- �̸��� A�� ���۵Ǵ� ����� �˻�
select *
from employee
where ename like 'A%';

select *
from employee
where hiredate like '81%';

-- ��å(job) �÷����� AG ��� �ܾ �� ��� ������ ���
select *
from employee
where job like '%AG%';

-- �ߺ��� �����ؼ� ����ϱ� : DISTINCT, �ٸ� �÷��� �����Ǹ� �����߻�, ���� �÷����� ���
-- �츮ȸ�翡 �����ϴ� ��å�� ���
select distinct job
from employee

-- �츮ȸ�翡 �����ϴ� �μ��� ���
select distinct dno
from employee

/* �����ؼ� ��� : order by �÷��� asc[desc]
    asc     : �������� ����, A => Z, 1 => 9     <== �⺻��
    desc    : �������� ����, Z => A, 9 => 1
*/

-- ��� ���̺��� �̸� �÷��� �������� �������� ����
select *
from employee
order by ename desc;

-- ��� ��ȣ�� �������� �������� ����
select *
from employee
order by eno;

-- �ֱ� �Ի� ������� ���
select *
from employee
order by hiredate desc;

-- �޿��� ���� ������� ����ϵ� ������ 1000�̻��� �����, ��å, �޿� ,�μ���ȣ�� ���
select ename �����, job ��å, salary �޿�, dno �μ���ȣ
from employee
where salary >= 1000
order by salary desc;

-- NVL �Լ� ����ϱ� : NULL�� 0���� ó���ϴ� �Լ�
    -- +, -, *, / NULL�� ������ �����ϸ� NULL�� ó����
    -- NULL�� ����ִ� ����. 0�� �ƴ�
    -- NVL (commission, 0) : commission �÷��� null�� ������ ��� 0���� �ٲپ��
    -- *���� : ��Ģ ����� null �÷��� �����ϴ��� Ȯ���ؾ��Ѵ�.
    
-- NVL �Լ��� ������� �ʰ� ��ü ������ ���ϴ� �÷��� ���
select * from employee

-- �� ���� = ����(salary) * 12 + ���ʽ�(commission)
-- ��ü ������ ����ؼ� �̸�, ��å, ����, ���ʽ�, �ѿ���
select ename �̸�, job ��å, salary ����, commission ���ʽ�,
        salary * 12 + commission "�� ����"
from employee;

-- NVL �Լ��� ����ؼ� commission �÷��� null�� 0���� ��ä�� ��� (������ ���������� ���)
select ename �̸�, job ��å, salary ����, commission ���ʽ�,
        salary * 12 + nvl (commission, 0)  "�� ����"
from employee
order by "�� ����" desc;

-- null�� �˻�
select *
from employee
where commission is null;

-- where �÷��� between A and B : A �̻� B ����
-- ������ 1500 �̻� 3000 ������ �����, ��å, ����, �Ի����� ����ϵ� �ֱ� �Ի��� ��������� ����
select ename �����, job ��å, salary ����, hiredate �Ի���
from employee
where salary>=1500 and salary<=3000
order by hiredate desc;

select ename �����, job ��å, salary ����, hiredate �Ի���
from employee
where salary between 1500 and 3000
order by hiredate desc;

-- ���ڵ� ���� ��� : count    <== �Խ��ǿ��� DB�� ��ü ���ڵ� ���� �����ͼ� ����¡ ó���� �ϱ����� ���
    -- count �Լ��� null�� ī��Ʈ �����ʴ´�.
    -- Ư�� �÷��� ����� ���Ҷ� null ���� ī��Ʈ ���������� �����ؾ��Ѵ�.
    
-- count(*) : ��ü ���ڵ��
select count(*) "��ü ���ڵ��"
from employee;

-- Ư�� �÷��� ī��Ʈ �Ҷ� null ���� �÷��� ��� null�� ī��Ʈ ���� ����.
select count(commission) "��ü ���ڵ��"
from employee;

-- employee ���̺��� �÷��� null ��뿩��, �ڷ��� (number(n), char(n), varchar2(n), date)
desc employee;

-- not null �÷��� count �ؾ� ��ü ���ڵ带 ����� ����Ҽ� �ִ�.
select count(eno)
from employee;