/*  JOIN, VIEW, INDEX, ������ */

/*  ���̺� ���� */
create table dept03
as
select * from department;

select * from dept03;

create table emp03
as
select * from employee;

select * from emp03;

-- ���̺� ���� : Ư�� �÷��� ������ �־ ����
create table salesman01
as
select eno, ename, job, salary
from employee
where job='SALESMAN';

select * from salesman01;

-- �츮ȸ���� ��å�� ���� ���̺� ���� (job01)
select * from employee;
create table job01
as
select distinct job
from employee;

select * from job01;

-- ���̺� ����� ���������� ������� �ʴ´� 
    -- �÷���, �ڷ���, ���ڵ�(������)�� �����
    -- ���������� ������� �ʴ´�. (primary key, uique, foreign key, not ull, check)

-- ���� ���� Ȯ�� : user_constraints <== ������ ���� : oracle���� ���̺��� ������ ���� ���̺�
select * from  user_constraints
where table_name in('DEPARTMENT','DEPT03','EMPLOYEE','EMP03');

-- Alter Table�� ����ؼ� ���� ���̺� �������� �߰�
select * from emp03;
select * from dept03;

-- emp03 ���̺��� eno �÷��� primary key �Ҵ�. : ���̺� �ѹ��� �Ҵ� ���� �÷��� �ߺ��� �����Ͱ� ������Ѵ�. null�� ������Ѵ�.
desc emp03;

alter table emp03
add constraint PK_EMP03_ENO primary key(eno);


-- emp03 ���̺��� dno �÷��� foreign key : �θ����̺��� dept03 dno �÷��� ����
    -- foreign key�� �����ϴ� �÷��� primary key, unique �÷��� ����
    -- ���� �÷��� �ڷ����� ���ų� ��� �ؾ��Ѵ�.
    -- dno �÷��� ���� �θ����̺� �÷��� ���� ������ ���� ����־�� �Ѵ�.
    
desc dept03;

-- �θ� ���̺��� ���� �÷��� primary key, unique �̿��� �Ѵ�.
alter table dept03
add constraint PK_DEPT03_DNO primary key(dno);

alter table emp03
add constraint FK_EMP03_DNO_DEPT03 foreign key(dno) references dept03(dno);

select * from emp03;

select distinct job from emp03;

alter table emp03
add constraint CK_EMP03_SALARY check(salary>0);

-- emp03�� job �÷��� : CLERK, SALESMAN, MANAGER, ANALYST, PRESIDENT �� �ֵ��� üũ���� ���� �Ҵ�
alter table emp03
add constraint CK_EMP03_job check ( job in ('CLERK', 'SALESMAN', 'MANAGER', 'ANALYST', 'PRESIDENT'));

/*  JION : Database���� ���� ���̺��� �����մϴ�. �� ���̺��� �ٸ� ���̺�� ����(FK)�� �������ִ�.
        - RDBMS : ������ DBMS
        - DB���� ������ ���̺��� �𵨸��Ǿ��ִ�. (�ߺ�����, �������)
        - �𵨸� �����ʴ� ���̺��� �ߺ��� �����Ͱ� ��� �Էµȴ� <== �ϵ������ ����, ��������
        - employee ���̺��� dno �÷��� �μ���ȣ
        - department ���̺��� �μ���ȣ, �μ���, �μ���ġ
        - employee ���̺�� department ���̺��� �ϳ��� ���̺�� ������ �Ǿ��� ��� �μ������� ��� �ߺ��Ǿ� ����.
        - �ٸ� ���̺��� �÷��� ����ϱ� ���ؼ��� JOIN�� ����ؼ� �ٸ� ���̺��� �÷��� ����Ѵ�.
        - �� ���̺��� join �ϱ� ���ؼ��� �� ���̺��� ���� Ű �÷��� ã�ƾ� �Ѵ�. (FK > PK,UK) <== ON
        - JOIN ANSI ȣȯ JOIN : ��� DBMS���� �������� ����ϴ� JOIN ����
            - Oracle, MSSQL, MYSQL, ...
*/

select * from employee;
select * from department;

/*  EQUI JOIN : ����Ŭ������ �۵��ϴ� JOIN ���� <== ���� Ű �÷��� ���̺� �̸��� ����ؾ��Ѵ�.
        select - join�� ���̺��� �÷��� ���, �� ���̺��� ������ Ű�÷��� ��½� �ش� ���̺� ���
        from - join�� ���̺��� , �� ���, ���̺� �̸��� ��Ī���� ���
        where - �� ���̺��� ���� Ű �÷��� ã�Ƽ� = �� ó��
        and - ������ ó��
*/

-- ���̺� ��Ī(alias)�� ����ؼ� ����
select eno, ename, job, e.dno, dname, loc
from employee e, department d
where e.dno = d.dno 
and e.dno=20;

-- ���̺� ��Ī�� ������� �ʴ� ��� [��ü����]
select employee.eno, employee.ename, employee.job, employee.dno, department.dname, department.loc
from employee, department
where employee.dno = department.dno
and employee.dno=20;

select eno, ename, job, e.dno, dname, loc
from employee e, department d
where e.dno = d.dno
and e.dno=20;

-- employee ���̺�, department ���̺��� ��ü �÷� ���
desc employee;
desc department;

create table emp_dept
as
select eno, job, manager, hiredate, salary, commission, e.dno, dname, loc
from employee e, department d
where e.dno = d.dno;

select * from emp_dept;
select * from department;

/*  ANSI JOIN : ��� DBMS���� �������� ����ϴ� JOIN ����
        
        INNER JOIN : �� ���̺� ��� ���� Ű �÷��� ���� ��ġ �ϴ� �͸� ��� <== 90% �̻� ���
        select - �� ���̺��� �÷��� ���, �� ���̺��� ���� Ű �÷��� ��½� ���̺� �̸� ���
        from   - ���̺�1 [INNER]JOIN ���̺�2
        on     - �� ���̺��� ���� Ű �÷��� ���
        where  - ���� ó��
*/

select eno, ename, job, salary, e.dno, dname, loc
from employee e join department d
on e.dno=d.dno
where e.dno=20;

/*  OUTER JOIN : ���� ���̺��� �ÿ��� ��� ��� �ϵ��� ��
        LEFT OUTER JOIN  : ���� ���̺��� ������ ��� ���
        RIGHT OUTER JOIN : ������ ���̺��� ������ ��� ���
        FULL OUTER JOIN  : �� ���̺� ��� ��ü ������ ���
*/

/*  ANSI ȣȯ�� Outer JOIN */
-- ���� �ǽ� ���̺� ����
create table emp05
as
select * from employee;

create table dept05
as
select * from department;

select * from emp05;
select * from dept05;
insert into dept05
values(50, 'HR', 'SEOUL');
commit;

-- ANSI ȣȯ INNER JOIN : �� ���̺��� ���� Ű �÷��� ��ġ�ϴ� �����͸� ��� (������)
select ename, job, e.dno, dname, loc
from dept05 d inner join emp05 e
on d.dno=e.dno;

-- ANSI ȣȯ LEFT OUTER JOIN : �� ���̺��� ���� Ű Ű�÷��� ��ġ�ϴ� ���� ���̺��� ���� ��� ���
select ename, job, e.dno, d.dno, dname, loc
from dept05 d left outer join emp05 e
on d.dno=e.dno;

-- Oracle equi JOIN
-- īŸ���þ� �� (�� ���̺��� ��� ���ڵ尡 �� ���̺��� ���ڵ�� ���� ��Ī)
-- where ���ǿ��� �� ���� Ű �÷��� ���� �׸� ���.
select *
from employee e, department d
where e.dno = d.dno
and salary>2000;

/*  NATURAL JOIN : Oracle ������ ���Ǵ� JOIN
        - �� ���̺��� ���� Ű �÷��� Oracle�� �ڵ����� ã�Ƽ� JOIN
        - select ������ ���� Ű �÷��� ���̺��� ����ϸ� �����߻�
        - from ���� NATURAL JOIN Ű���带 �����
        - where ���� ���� Ű �÷��� ������� �ʴ´�. (Oracle���� �� ���̺��� ���� Ű �÷��� �ڵ����� ã�� ó��)
        - where ���� ���� ó��
*/

-- NATURAL JOIN <== �� ���̺��� ���� Ű �÷��� �ڵ����� ã�Ƽ� JOIN, 
        -- select ���� ���� Ű �÷��� ����Ҷ� ���̺� �̸��� ����ϸ� �����߻�
select eno, ename, salary, dno, dname, loc
from emp05 e natural join dept05 d
where salary>2000;

-- EQUI JOIN
select eno, ename, salary, e.dno, dname, loc
from emp05 e, dept05 d
where e.dno=d.dno
and salary>2000;

-- ANSI JOIN : ��� DBMS���� ���Ǵ� ���� : Oracle, MS-SQL, MYSQL, postgre, MariaDB, ...
select eno, ename, salary, e.dno, dname, loc
from emp05 e join dept05 d
on e.dno=d.dno
where salary>2000;

/*  SELF JOIN : �ڱ� �ڽ��� ���̺��� �ٽ��ѹ� JOIN
        - �ݵ�� ���̺� ��Ī�� ����ؼ� JOIN �ؾ���
        - select ���� �÷��� ����Ҷ� �ݵ�� ��Ī�� ����ؾ� �Ѵ�.
        - ������, ��� ������ �ڽ��� ���̺��� ��ȸ�Ҷ� �����.
*/

select * from emp05;

-- SELF JOIN �� ����ؼ� ����� ���� �������(�̸�)�� ���
select eno �����ȣ, ename �����, manager ���ӻ��
from employee
where manager=7788
order by ename;

select eno �����ȣ, ename �����, manager ���ӻ��
from employee
where eno=7788
order by ename;

-- SELF JOIN �� ����ؼ� ���� ��� ������ �ѹ��� ��� (EQUI JOIN)
select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.ename ���ӻ���̸�
from emp05 e, emp05 m
where e.manager = m.eno
order by e.ename;

select eno, ename, manager, eno, ename, manager
from emp05;

-- SELF JOIN �� ����ؼ� ���� ��� ������ �ѹ��� ��� (ANSI JOIN)
select e.eno �����ȣ, e.ename ����̸�, e.manager ���ӻ����ȣ, m.ename ���ӻ���̸�
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename;

select * from emp05;

-- select ������ || ���� ���ڿ��� �����Ҽ� ����
select '����� : ' ||ename|| ' �� ������ '||salary|| ' ���� �Դϴ�.' ����޿�����
from emp05;

-- ������� ���ӻ�� �̸��� self JOIN���� �ٷ� ���
select e.ename ����̸�, m.ename ���ӻ���̸�
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename;

-- 
select e.ename ||'�� ���ӻ�� �̸���'|| m.ename ||'�Դϴ�.' "����� ���� ���ӻ�� ��"
from emp05 e join emp05 m
on e.manager = m.eno
order by e.ename;

/*  CROSS JOIN : īŸ���þ� ��, �� ���̺��� �ϳ��� ���ڵ忡�� �� ���̺��� ��� ���ڵ�� ����
        - ��,�� ���̺��� ��� ������ ���ؼ� ���� üũ�� ���.
*/

-- ANSI JOIN ���� ��� (14 * 5 = 70�� ���ڵ� ���)
select * 
from emp05 e cross join dept05 d;

-- EQUI JOIN ���� ��� (14 * 5 = 70�� ���ڵ� ���)
select * 
from emp05 e, dept05 d;

-- VIEW ���� �Ҽ��մ� ���� ���� (System �輺���� �����ؼ� ����)
GRANT CREATE ANY VIEW TO "C##HR" WITH ADMIN OPTION;
GRANT DROP ANY VIEW TO "C##HR" WITH ADMIN OPTION;

/*  VIEW : ������ ���̺�, �ڵ尡 ����� �������̺�
        - VIEW �� �����͸� ������ ���� �ʴ´�. select �ڵ尡 ���ִ�.
        - ��ġ ���̺� ó�� ����.
        - VIEW �� select ������ �� ����.
        - ������ ���ؼ� ���� (���� ���̺��� Ư�� �÷��� ���)
        - ������ ������ ������ ȣ���ؼ� ��� (JOIN)
*/

-- VIEW ���� (������ ���� ������ view)
create view v_emp
as
select ename, salary from emp05;

select * from emp05;

-- VIEW ����
select * from v_emp;

-- VIEW ������ Ȯ���ϴ� ������ ���� : user_views
-- ���� �α׿��� �������� ������ ��� view�� Ȯ��
select * from user_views;

-- VIEW ���� : emp05 ���̺�� dept05 ���̺��� JOIN �ϴ� ����
create view v_emp_dept
as
select eno, ename, job, salary, e.dno, dname, loc
from emp05 e, dept05 d
where e.dno=d.dno;

-- VIEW
select * from v_emp_dept;

drop view v_emp_dept;

-- �ڽ��� ���� ��縦 ����ϴ� VIEW ����
select * from emp05;

select eno, ename, manager, eno, ename, manager
from emp05;

create view v_manager_info
as
select e.eno, e.ename ����̸�, e.manager, m.ename ���ӻ��
from emp05 e join emp05 m 
on e.manager=m.eno
order by e.ename;

select * from v_manager_info;

-- VIEW�� ����� �ڵ� ������ Ȯ�� : ������ ������ ����ؼ� Ȯ��
select * from user_views;

-- OUTER JOIN : ANSI
alter table dept05
add constraint PK_DEPT05_DNO primary key(dno);

alter table emp05
add constraint FK_EMP05_DNO_DEPT05 foreign key(dno) references dept05(dno);

-- INNER JOIN : �� ���̺���  ���� Ű �÷��� ��ġ�ϴ� �͸� ���
select eno, ename, salary, e.dno, d.dno, dname, loc
from emp05 e inner join dept05 d
on e.dno=d.dno;

select * from dept05;

select distinct dno from emp05;

-- RIGHT OUTER JOIN : ������ ���̺��� ��� ������ ��� <== ANSI JOIN
select eno, ename, salary, e.dno, d.dno, dname, loc
from emp05 e right outer join dept05 d
on e.dno=d.dno;

-- RIGHT OUTER JOIN : ������ ���̺��� ��� ������ ��� <== EQUI JOIN
select eno, ename, salary, e.dno, d.dno, dname, loc
from emp05 e, dept05 d
where e.dno(+)=d.dno;

-- NATURAL JOIN : �� ���̺��� ���� Ű �÷��� �ڵ����� �ĺ�
select eno, ename, salary, dno, dname, loc
from emp05 e natural join dept05 d;

-- SELF JOIN : �ڽ��� ���̺��� �ѹ��� JOIN
select e.eno, e.ename, e.manager, m.eno, m.ename, m.manager
from emp05 e, emp05 m
where e.manager=m.eno
order by e.eno;