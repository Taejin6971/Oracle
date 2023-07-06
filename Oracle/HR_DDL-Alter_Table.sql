/*  DDL : Alter Table: ������ ������ ���̺��� ����
        - ���� ���̺��� �÷��� �߰�, �÷��̸�����, �÷�����, �÷��� �ڷ��� ����
        - �÷��� �ο��� ���������� ����, ����, ����
*/

-- ���� ���̺� ����
-- ���̺� ���� : ���� ���̺� - department, ���� - dept01
    -- ������ �÷���, �ڷ���, ������(���ڵ�) ����
    -- ���� ���̺��� ���� ������ ����Ǿ� �����ʴ´�.
create table dept01
as
select * from department;

create table emp01
as
select * from employee;

select * from dept01;
desc dept01;
desc department;

-- ���� ������ Ȯ���ϴ� ������ ����
show user;
select * from user_constraints      -- ���� ������ ������ ��� ���̺��� ���������� Ȯ��
-- where table_name='DEPARTMENT';
where table_name='DEPT01';

select * from user_constraints      -- ���� ������ ������ ��� ���̺��� ���������� Ȯ��
where table_name='EMPLOYEE';
-- where table_name='EMP01';

-- DEPT01 ���̺� ���ο� �÷� �߰�, null
select * from dept01;

-- birth �÷� �߰�
alter table dept01
add (birth date);

alter table dept01
add (email varchar2(100), addr varchar2(200), jumin char(14));

-- ���̺� �÷��� �߰��Ҷ� null�� �⺻, update ������ ����ؼ� ���� ����
update dept01
set birth=sysdate, email='aaa@aaa.com', addr='����', jumin='880520-1111111'
where dno=10;
commit;

-- �÷��� �ڷ��� ���� : char varchar ���ڼ��� �ø�
alter table dept01
modify email varchar2(200);

desc dept01;

-- Ư�� �÷� ����     <== �߰��� �۾��ؾ��Ѵ�. (���ϰ� ���� �ɸ��� �۾�)
select * from dept01;

alter table dept01
drop column jumin;

alter table dept01
drop column addr;

-- �÷��� ���� :
select * from dept01;

alter table dept01
rename column dno to d_dno;

alter table dept01
rename column birth_day to birthday;

-- ���̺� �̸� ����
rename dept01 to dept001;

rename dept001 to dept01;

-- ������ �������� ����α׿��� ������� ��� ���̺� ���
select * from user_tables;
select table_name from user_tables
order by table_name;

/*  alter table�� ����ؼ� �������� ����, ����, ����
        - primary key
        - unique
        - foreign key
        - check
        - not null
        
        - default
*/

-- ������ ������ ���ؼ� ���� ���̺��� ���� ������ �ѹ��� Ȯ��
select * from user_constraints
where table_name in ('DEPT01', 'DEPARTMENT', 'EMP01', 'EMPLOYEE')
order by table_name;

/*  ���� ���̺� primary key �������� �ֱ�
    - �÷��� �ߺ��� ���� ������ �Ѵ�.
    - �÷��� null�� ��������� �ȵȴ�.
    - ���̺� primary key �÷��� �����ϸ� �ȵȴ�. (���̺� PK�� �ѹ��� �����ִ�)
*/
select * from dept01;

desc dept01;

-- dept01 ���̺� d_dno �÷��� primary key �Ҵ�
alter table dept01
add constraint PK_DEPT01_D_DNO primary key(d_dno);

/*  foreign key �Ҵ�
    - �θ� ���̺��� primary key, unique �÷��� ������.
    - FK�� ����� �÷���, �θ����̺��� �����ø��� �ڷ����� ����ϰų� ���ƾ��Ѵ�.
    - FK�� ����� �÷��� ���� �θ����̺��� �������� ���־���Ѵ�.
*/
-- emp01 ���̺���
select * from dept01;   -- �θ� ���̺�(dept01) : d_dno
select * from emp01;    -- �ڽ� ���̺�(emp01)  : dno (FK)

-- emp01 �� dno �÷��� FK �Ҵ�. (�θ� ���̺� : d_dno)
alter table emp01
add constraint FK_EMP01_DNO foreign key(dno) references dept01(d_dno);

/*  unique �������� �߰�
    - �÷��� �ߺ��� ���� ������Ѵ�.
    - null�� �ѹ��� �� �־���Ѵ�.
    - null, not null�� ����Ȱ��� �ο��Ҽ� �ִ�.
*/

-- emp01 table�� ename �÷��� unique �������� �߰�
select * from emp01;

alter table emp01
add constraint U_EMP01_ENAME unique(ename);

-- emp01 ���̺��� eno �÷��� PK �������� �ֱ�
alter table emp01
add constraint PF_EMO01_ENO primary key(eno);

/*  check �������� �߰�
    - Ư�� �÷��� ���ǿ� �´� ���� �����ϵ��� ����
    - salary �÷��� ���� : salary>0
*/
alter table emp01
add constraint CK_EMP01_SALARY check(salary>0);

/*  not null �������� �߰� 
    - �÷��� null ���� �������� �ʾƾ� �Ѵ�.    
*/
-- job �÷��� not null �������� �߰�
desc emp01;

alter table emp01
modify job constraint NN_EMP01_JOB not null;

/*  ���� ���̺��� default
    - default�� ���� ������ �ƴϴ�. �������� �̸��� ����������.
*/
select * from emp01;

-- cummission �÷��� ���� �������� ��� �⺻��(default) : 0
alter table emp01
modify commission default 0;

-- default, null�� ���� ������ : default, null
insert into emp01
values (8000,'ȫ�浿','�繫��','7369',sysdate,6000,default,40);

-- �÷��� �������� �ʾ����� default, null
insert into emp01(eno,ename,job,manager,hiredate,salary,dno)
values (8001,'�̱浿','�繫��','7369',sysdate,4000,40);

/*  ���� ���Ժ��� ���� ���� ���� :
    - �������� �̸����� ���� ����
*/
select * from user_constraints
where table_name='EMP01';

select constraint_name from user_constraints
where table_name='EMP01';

-- primary key �������� ���� : PF_EMO01_ENO
alter table emp01
drop constraint PF_EMO01_ENO;

-- unique �������� ���� : U_EMP01_ENAME
alter table emp01
drop constraint U_EMP01_ENAME;

-- check �������� ���� : CK_EMP01_SALARY
alter table emp01
drop constraint CK_EMP01_SALARY;

-- not null �������� ���� : NN_EMP01_JOB
alter table emp01
drop constraint NN_EMP01_JOB;

-- foreign key �������� ���� : FK_EMP01_DNO
alter table emp01
drop constraint FK_EMP01_DNO;

-- default ���� : ���������� �ƴϱ⶧���� drop �Ұ� (�⺻������ null ����)
alter table emp01
modify commission default null;

commit;