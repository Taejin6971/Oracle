/* DDL, DML �������� */

/*  SQL (Structured Query Language) : ����ť��, ����, ����ȭ�� ���� ���

select �÷���
from ���̺��[��]
where ����
group by �÷�[�׷���]
having ����[group by ����� ����]
order by �����÷�

SQL ������ ������ �з�

DDL (Data Definition Language) : ��ü(���̺�, ����, �Լ�, ��, Ʈ����, ������������, �ε���)�� �����ϴ� ���(����)
                               : ��Ű��(Ʋ, ��ü)�� �����ϴ� ���
    - create (����), alter (����), drop (����)
    
DML (Data Manipulation Language) : ���̺��� ���ڵ带 �����ϴ� ��� <== Ʈ������� �߻���Ŵ
    -- ����Ŭ������ Ʈ����� ������ �ڵ����� �۵���.
    -- Ʈ������� �Ϸ� �ؾ��Ѵ�. (commit, rollback) 
        <== Ʈ������� �Ϸ����� ������ LOCK�� �ɷ� �ٸ�����ڰ� ������ �Ұ��ϴ�
    - insert (�Է�), update (����), delete (����)
    
DCL (Data Control Language) : ������ ���� ���, ������ ������ �ο�,
    - grent (���Ѻο�), revoke (�������)
    
=================================================================

DQL (Data Query Language) : ����Ÿ ���� ��� (���)
    - Select
    
TCL (Transaction Control Language) : Ʈ����� ���� ��� <== DML���� �߻���
    - begin transaction : Ʈ����� �ڵ����� ���� (insert, update, delete)
    - commit [transaction] : Ʈ������� �Ϸ�, ���� DataBase�� ���������� ����
    - rollback [transaction] : Ʈ������� ���� �������� �ǵ�����.
    
    - savepoint : Ʈ������� �ӽ����� ���� ����
*/

-- ���̺� ���� : create table
create table dept(
    dno number(2) not null,
    dname varchar2(50) not null,
    loc varchar2(13) null
);

desc dept;      -- ���̺� ���� Ȯ��

-- ���̺� �� �ֱ�
-- begin transaction;
insert into dept(dno, dname, loc)
values(10, '�λ��', '����');

rollback;
commit;

select * from dept;

/*  Ʈ����� (Transaction) : �۾�(��)�� ó���ϴ� �ּ� ����
    
    - DBMS : ��Ʈ��ũ�� ���ؼ� �������� ����ڰ� ���ÿ� �۾�
    - �۾��� �Ҷ� LOCK�� �ɰ� �Ϸ�Ǹ� LOCK�� Ǯ����
    - DML ������ �۵�,
    - Ʈ������� ����(commit, rollback)�ϱ� �������� LOCK�� �ɷ��� �ٸ�������� ������ ����
    - commit : RAM�� ������ ������ DB�� ���������� �����ϵ����Ѵ�.
    - rollback : Ʈ����� ���� �������� �ǵ���
    - commit ��������  RAM������ ���� �Ǿ�����.
    - log�� ��ϵ�, "Ʈ����Ƿα�" <== ��������� �ƴ϶� ��������
    
    Ʈ������� 4���� Ư¡
        ALL or NOTHING : �Ǹ� ���� �ǰ��ϰų� �ƴϸ� ������� �ǵ����ų�
    1. ���ڼ� (Atomicity) : ���� ó���ϴ� �ּ� ����
    2. �ϰ��� (Consistency) : Ʈ����ǿ��� ó���� ����� �ϰ����� ������.
    3. ������ (Isolation : �ϳ��� Ʈ������� �ٸ� Ʈ����ǰ� �ݸ�, LOCK
    4. ���Ӽ� (Durability) : commit Ʈ������� DB�� �����
        
    A �� B ���� 100�� �Ա� �� : �� update ������ �ϳ��� Ʈ��������� �۵��Ǿ����.
    1. update ���� ����ؼ� A ���忡�� 100�� ���
    2. update ���� ����ؼ� B ���忡 100�� �Ա�
*/

-- insert ��
desc dept;
select * from dept;

insert into dept(loc, dname, dno)
values('�λ�', '������', 20);

-- �÷��� �����Ǹ� ��� �÷��� ���� �Ҵ�
insert into dept
values(30, '������', null);

insert into dept(dno, dname)
values(40, '����');

commit;

/*  update : ����      
    *���� : �ݵ�� where ����(Primary Key, Unique �÷�)�� ����ؾ��Ѵ�.
*/
update dept
set dname ='������'
where dno=40;

insert into dept(dno, dname)
values(40, '�Ǹź�');

-- dno : where �� ���, �ߺ��Ȱ��� ��������ʴ� �÷��� ���(primary Key, Unique)
update dept
set dname='HR', loc='����'
where dno=40;

select * from dept;

-- ���̺��� Primary Key �÷��� �����ؾ� �Ѵ�. <== �ߺ��� ���� ������ ������ ������ ����

/*  delete : ���̺��� Ư�� ���ڵ� ����  
    *���� : �ݵ�� where ����(Primary Key, Unique �÷�)�� ����ؾ��Ѵ�.
*/
delete dept
where dno=40;

commit;

/*  ���� ���� : �÷��� �ο��Ǵ� ����, Primary Key, Unique, Default, Not Null, Check, Foreign Key
        - Ư�� �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �ο�
        
    Primary Key
        - �ߺ��� ���� ���� ���ϵ��� ����
        - Not Null
        - ���̺� �ѹ��� ������ �ִ�. ���� �÷��� �ϳ��� Primary Key�� ������ �ִ�.
        - INDEX�� �ڵ����� �����ȴ�.   <== �˻��� ������ ��.
        - update, delete�� where������ ���Ǵ� �÷�
        - JION �� On ������ ���Ǵ� �÷�
        
    Unique
        - �ߺ��� ���� ������ ����.
        - null ��� <== �ѹ��� �������ִ�.
        - �ϳ��� ���̺� ������ ������ �ִ�.
        - INDEX�� �ڵ����� �����ȴ�.   <== �˻��� ������ ��.
        - JION �� On ������ ���Ǵ� �÷�
        
    Not Null
        - �ݵ�� ���� �ԷµǾ�� �Ѵ�. NULL�� ������ ������
        
    Check
        - �÷��� ����� ���� üũ�ؼ� ����, ���ǿ� �����ϴ� ���� �ֵ��� (age > 0)
        
    Foreign Key
        - �θ� ���̺��� Ư�� �÷��� �����ؼ� ���� ������ �ֵ��� ����
        - �θ� ���̺��� �����ϴ� �÷��� Primary Key, Unique Ű �÷��� ����
    
    Default : �÷��� ���� �����ʴ� ���, Default�� ������ ���� �ڵ����� ��.
        - ���������� �ƴϿ��� �������� �̸��� �ο��Ҽ� ����.
        - <<����>> nul, not null �տ� ó���ؾ��Ѵ� 
    
    ������ ���� : Oracle���� ���̺� ���� ���� ������ ������ ���̺�
        user_constraints        -- ���� ������ Ȯ���ϴ� ������ ����
        select * from user_constraints
*/

create table member1 (
    id varchar2(50) not null primary key,
    pass varchar2(50) not null,
    addr varchar2(100) null,
    phone varchar2(30) null,
    age number(3),          -- ���� 3�ڸ�
    weight number(5,2)      -- �Ǽ� : ��ü 5�ڸ�, �Ҽ��� ���� 2�ڸ�
);

-- insert
insert into member1
values('ddd', 'aaa', '����', '010-1111-1111', 20, 70.55);

select * from member1;

commit;

-- update �� where ���ǿ� primary key �÷��� �������� ó��
update  member1
set addr='�λ�', phone='010-2222-2222', age=30, weight=88.55
where id='bbb';

-- delete �� where ���ǿ� primary key �÷��� �������� ó��
delete member1
where id='ccc';

/*  Unique */
create table member2 (
    id varchar2(50) not null primary key,
    pass varchar2(50) not null Unique,
    addr varchar2(100) null,
    phone varchar2(30) null Unique,
    age number(3),
    weight number(5,2)
);

insert into member2
values('bbbb', 'bbbbb', '����', '010-2222-2222', 10, 70.55);

select * from member2;
commit;

-- ����Ŭ�� ������ ������ ����ؼ� member2 ���̺��� ���������� Ȯ��
show user;  -- ���� ������ ���� ������ ��� : C##HR
select * from user_constraints
where table_name = 'MEMBER2';

-- ���̺� ������ �������� �̸��� �ο��ϸ鼭 ���� �����Ҵ�.
-- �������� �̸��� PK_���̺��̸�_�÷���
create table member3 (
    id varchar2(50) not null constraint PK_MEMBER3_ID primary key,
    pass varchar2(50) not null constraint U_MEMBER3_PASS Unique,
    addr varchar2(100) null,
    phone varchar2(30) null constraint U_MEMBER3_PHONE Unique,
    age number(3),
    weight number(5,2)
);

-- insert
insert into member3
values('bb', 'bb', '����', '010-1111-1111', 20, 70.55);
 
select * from member3;

/* check : �÷��� ���� üũ */
create table member4 (
    id varchar2(50) not null constraint PK_MEMBER4_ID primary key,
    pass varchar2(50) not null constraint U_MEMBER4_PASS Unique,
    addr varchar2(100) null,
    phone varchar2(30) null constraint U_MEMBER4_PHONE Unique,
    age number(3) constraint CK_MEMBER4_AGE check(age>0 and age<150),
    gender char(1) constraint CK_MEMBER4_GENDER check(gender in('W','M')),
    weight number(5,2)
);

-- ���� ���� ���
select * from user_constraints
where table_name='MEMBER4';

-- insert
insert into member4
values('b', 'b', '����', '010-1111-2222', 70, 'M', 70.55);
 
select * from member4;
commit;

/*  Default : ���� ���� ������ Default�� ������ ���� �ڵ����� ��*/
create table member5 (
    id varchar2(50) not null constraint PK_MEMBER5_ID primary key,
    pass varchar2(50) not null constraint U_MEMBER5_PASS Unique,
    addr varchar2(100) default '����' null,
    phone varchar2(30) null constraint U_MEMBER5_PHONE Unique,
    age number(3) null constraint CK_MEMBER5_AGE check(age>0 and age<150),
    gender char(1) null constraint CK_MEMBER5_GENDER check(gender in('W','M')),
    weight number(5,2) default 10.00 null,
    hiredate date default sysdate
);

drop table member5;

-- insert : default�� �� �Ҵ� : defaultŰ�� ����ϴ� ���
insert into member5
values('b', 'b', default, '010-1111-2222', 70, 'M', default, default);

-- insert : default�� �� �Ҵ� : �÷��� ��� ���� �ʴ� ���
insert into member5 (id, pass, phone, age, gender)
values('c', 'c', '010-1111-3333', 70, 'M');
 
select * from member5;
commit;

/*  Foreign Key : �θ� ���̺��� Ư�� �÷��� �����ؼ� ���� �ֵ��� ���� 
        - �θ� ���̺��� Primary Key, Unique Ű �÷��� ����
        - Foreign Key�� �ڽ� ���̺��� Ư�� �÷��� �ִ´�.
*/

-- employee ���̺��� dno �÷��� Foreign Key ==> Department ���̺��� dno �÷��� ����
-- employee ���̺��� dno �÷��� ���� �Ҵ��Ҷ� Department ���̺��� dno �÷��� ���� ������ �Ҵ�
select * from department;       -- �μ� ������ �����ϴ� ���̺� (�θ� ���̺�)
select * from employee;         -- ��� ������ �����ϴ� ���̺� (�ڽ� ���̺� : Foreign Key (dno))

desc employee;

-- employee�� dno �÷��� Department�� dno �÷��� ������.
insert into employee(eno, ename, job, manager, hiredate, salary, commission, dno)
values (8000,'KTJ','MANAGER',7369,sysdate,3000,300,40);

rollback;

/*  Foreign Key �ǽ� ���̺� ����*/

-- �θ� ���̺� ���� (PK, UK)
create table ParentTbl(
    info number constraint PK_ParentTbl_info Primary Key,
    name varchar2(20),
    age number(3), check(age>0 and age<200),
    gender char(1) check(gender in ('W','M'))
);

-- �θ� ���̺� ����(Dumy) ������ �Է�
insert into ParentTbl(info,name,age,gender)
values(10,'ȫ�浿',20,'M');

insert into ParentTbl(info,name,age,gender)
values(20,'�̱浿',32,'M');

insert into ParentTbl(info,name,age,gender)
values(30,'��浿',43,'M');

insert into ParentTbl(info,name,age,gender)
values(40,'�۱浿',52,'M');

select*from parenttbl;
commit;

-- �ڽ� ���̺� ���� (FK)
create table ChildTbl(
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    info number, 
        constraint FK_ChildTbl_info Foreign Key(info) references ParentTbl(info)
);

-- �ڽ� ���̺� ���� ������ �Է�
insert into childtbl(id,pw,info)
values ('aaa','aaa',10);

insert into childtbl(id,pw,info)
values ('bbb','aaa',20);

insert into childtbl(id,pw,info)
values ('ccc','aaa',30);

insert into childtbl(id,pw,info)
values ('ddd','aaa',40);

select * from childtbl;
commit;

-- FK�� �����ϴ� �θ� ���̺��� drop���� �ʴ´�.
    -- 1. �ڽ� ���̺��� ���� ������ �θ� ���̺� ����
    -- 2. �θ� ���̺��� �����ϸ鼭 cascade constraints �ɼ��� ����ϸ� ���� ��������
    
-- �θ� ���̺� ���� �Ұ�
drop table parenttbl;

-- 1. �ڽ� ���̺��� ���� ������ �θ� ���̺� ����
drop table childtbl;
drop table parenttbl;

-- 2. �θ� ���̺��� �����ϸ鼭 cascade constraints �ɼ��� ����ϸ� ���� ��������
drop table parenttbl cascade constraints;
drop table childtbl;