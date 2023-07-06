/*  INDEX (�ε���) : ���̺��� Ư�� �÷��� �˻��� ������ �ϱ� ���ؼ� �ο��Ǵ� ��ü 
        - index �� �ο��Ǿ� ���� �ʴ� �÷��� �˻��� ���̺�ĵ�� �Ѵ�. (�˻��ð��� �����ɸ���)
        - �÷��� index �� �����ϸ� index [����] �������� �����Ѵ� (DB�� 10% ������ ����Ѵ�.)
        - Ŭ������ index     : ����ó�� A ~ Z ���������� ������ index ������
        - non Ŭ������ index : å�� ù������ ���� ���뺰�� ��ġ������ ������ index ������
        - where , join on ������ ���� �˻��ϴ� �÷��� index �ο�
        - index �� �˻��� ������ �ϱ� ���ؼ� ���Ǵµ� �߸� �ο��ϰų� �ֱ������� ��������������
            ������ �˻��� ���� ������ �ִ�.
        - insert, update, delete �� ����ϰ� �Ͼ�� �÷����� index �� �ֱ����� ������ �ʿ�
            - index �������� ���� ����.
            - �ֱ������� index �������� rebuild �ؾ� �Ѵ�.
        - index �� �߸� �����ϸ� ������ �� ���������ִ�.
        - primary key, unique �÷��� �ڵ����� index�� ������ �ȴ�.
        - index ������ ����� ������ ���� : user_indexes, user_ind_columns
            select * from user_indexes;
        - index �� �����ϴ� �۾��� �����ð��� ���ؼ� �����ؾ� �Ѵ�. [�߰�]
*/

select * from employee;

select ename
from employee
where ename='MILLER';

-- ������ ������ ���ؼ� index ���� Ȯ��
show user;

select * from user_indexes
where table_name in ('DEPARTMENT', 'EMPLOYEE');

-- ���̺� ������ primary key, unique �÷��� �ڵ����� index ����
create table emp07
as
select eno, ename, job, salary from employee;

select * from emp07;

-- ������ ������ ���� �������� Ȯ��
select * from user_constraints
where table_name in ('EMP07');

select * from user_indexes
where table_name in ('EMP07');

select * from user_ind_columns
where table_name in ('EMP07');

select * from user_ind_columns
where table_name in ('EMPLOYEE');

-- emp07 ���̺�  primary key �ο�
alter table emp07
add constraint PK_EMP07_ENO primary key (eno);

-- Ư�� �÷��� index �� ���� <== where, join on, ���� �˻��ϴ� �÷�.
create index ind_EMP07_ENAME
on EMP07 (ENAME) ;

select * from emp07
where ename='MILLER';

create table emp08
as
select * from employee;

select * from emp08;

create index idx_EMP08_JOB
on EMP08 (JOB);

-- index �� ������ ��� :
    -- 1. ������ index �� ������ ���ο� index ���� (���� ���ϰ� ������ ���)
    -- 2. rebuild : ������ index �� ���Ӱ� ����

-- ������  index �� ���Ӱ� rebuild : 
    -- index �� ������ �÷��� ����ϰ� update�� �Ͼ�� ��� index�� ���Ӱ� ����

-- index ����(index �������� ����) �� ���Ӱ� ����
drop index idx_EMP08_JOB;
create index ind_EMP08_JOB
on EMP08(JOB);

-- index �� rebuild : ������ ������ �ʴ� ���, ������ index�� ���Ӱ� ����
alter index ind_EMP08_JOB rebuild;

======================================================================

/*  ������ (SEQUENCE) : �ڵ� ��ȣ �߻���, Oracle
        - Ư�� �÷��� ��ȣ�� �ڵ����� �ѹ��� �Ѵ�.
        - MS-SQL : IDENTITY (1, 1)
        - MySQL  : AUTO_INCREMENT
            - ���̺� ������ Ư�� �÷��� indentity(1,1), auto_increment�� ������ ��
        - ���� Ÿ������ �����Ǿ�� �Ѵ�.
        - �������� Ȯ���ϴ� ������ ���� : user_sequences
        
        - �������� ������ ���� ����, �����θ� ����, �ѹ� ������ �������� �ι��ٽ� ������ ������ ����� ���� ����.
*/

-- ������ ���� : ó����: 10, ������: 10
create sequence seq1
    start with 10
    increment by 10;

select * from user_sequences;

-- ��� ���̺��� ����ؼ� sequrnce ���� ��� : 
        -- seq.nextval (�������� ���)
        -- sell.currval (���簪�� Ȯ��)
select seq1.nextval from dual;
select seq1.currval from dual;

-- ���̺��� Ư�� �÷��� ���� ������, ���������� �߻��� ���� �ִ´�
-- ���̺� ����� where�� false�� ó���ϸ� ���̺�  ����, ���ڵ�(��)�� �������� ����
create table dept08
as
select * from department
where 0=1;

select * from dept08;

-- DEPT08 ���̺���  DNO �÷��� sequenec �Ҵ� : seq1.nextval

select seq1.currval from dual;

desc dept08;

insert into dept08 (dno, dname, loc)
values (seq1.nextval, 'HR', 'Seoul');


-- ������ ����
-- �ʱⰪ: 1, ������:1    <== seq2
create sequence seq2
start with 1
increment by 1
nocache;

select * from user_sequences;

-- insert �� ���̺��� �÷��� ���� : ������
create table dept09
as
select * from department
where 0=1;

select * from dept09;

select seq2.currval from dual;

insert into dept09 (dno, dname, loc)
values (seq2.nextval, 'HR', 'Seoul');

commit;

/*  view : ���� ���̺�, select ������ ���ִ�.
        - 1. ���� ���̺��� �߿� �÷��� ���� ��� (����)
        - 2. ������ ������ ������ ����Ҷ� join ����
        
        - view�� ����ؼ� insert, update, deletef�� �Ҽ����ִ�. (Ư¡������ �ȵɼ����ִ�.)
            - ���� ���̺� �����
            - ���� ���̺��� �������ǿ� ���� �޶�����
*/

-- 1. ���� ���̺� ����
create table dept10
as
select * from department;

select * from dept10;

-- 2. view ���� 
create view v_dept10
as
select dno, dname
from dept10;

-- 3. view�� ���
select * from v_dept10;

-- 4. view�� �� insert : ���� ���̺� ���� insert�� (���� ���̺��� �������ǿ� ���� ���� insert�ɼ���, �ȵɼ��� �ִ�.)
insert into v_dept10 (dno, dname)
values (50, 'HR');

commit;

-- 5. view�� ����ؼ� update / delete
update v_dept10
set dname='������'
where dno=50;

delete v_dept10
where dno=50;

-- view���� insert / update / delete �� ���� ���̺��� ���� ���ǿ� ���� �޶���
select * from dept10;

alter table dept10
modify loc constraint NN_DEPT10_LOC not null;

desc dept10;

-- view�� ���� insert �Ҷ� �����߻�, ���� ���̺��� �������� ���� (���� dept10 ���̺��� loc�÷� not null)
select * from v_dept10;

insert into v_dept10
values (60, 'HR');      -- ���� �߻�

================================================================================

/*  view ���ο� distinct, �����Լ�(sum,avg,max,min) �� ����ҽ� �ݵ�� ��Ī �̸��� ����ؾ��Ѵ�. 
    
    - view ������ group by ������ ��Ī�� ������� �ʴ� ��� ���� �߻�
    - view ���ο� �����Լ� ���� ��Ī�̸� ������� ������ ���� �߻�
*/

create view v_emp10
as
select min(salary) �ּҿ���, max(salary) �ִ����, round(avg(salary)) ��տ���, 
        sum(salary) �����հ�, count(*) ������, dno �μ���ȣ
from employee
group by dno;

select * from v_emp10;

================================================================================

/*  ERD(Entity Relationship Diagram) : ������ ���̽� �𵨸� ���赵
        - ER Win : ����, ���, Oracle, MS-SQL, MySQL, ...
        - https://www.erdcloud.com/ <== ����, ������ ����
        
    �𵨸�
    ==================================================================
    1. �䱸���� �м� >> 2. �� �𵨸� >> 3. ������ �𵨸� >> ����
    
    1. �䱸���� �м� : �����ľ�, ������, ������Ʈ ����(���, �Ⱓ, ��������)
    2. ���� �𵨸� : �ѱ۷� ���� (��, �ּ�, �ֹ�, ��ǰ)
        ��ƼƼ (���� �𵨸�) ��     :        ���̺� �� (������ �𵨸�)
        �Ӽ� (���� �𵨸�) ��       :        �÷� �� (������ �𵨸�)
        ���� :    1:1,    1:��,    ��:��
    3. ������ �𵨸� : ���̺� �̸�, �÷���, �ڷ���   << �������� ����
    4. ���� : Oracle, MySQL, MS-SQL, ...
*/