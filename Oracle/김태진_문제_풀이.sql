--<����1> �÷� �˸��(��Ī) , commission(���ʽ�) �÷��� null �� ���� ����ϵ� �����ȣ, ����̸�,�Ի糯¥�� ��� 
select eno �����ȣ, ename ����̸�, hiredate �Ի糯¥, commission ���ʽ�
from employee
where commission is null;

--<����2> dno(�μ���ȣ) �� 20�̰� �Ի糯¥�� 81�� 4�� ���� ����� �̸��� ��å�� �Ի糯¥�� ���
select ename ����̸�, job ��å, hiredate �Ի糯¥, dno �μ���ȣ
from employee
where dno=20 and hiredate>='81/04/01';

--<����3> ������ ����ؼ� �����ȣ, ����̸�, ����, ���ʽ�, ��ü ������ ���
select eno �����ȣ, ename ����̸�, salary ����, commission ���ʽ�,
        salary * 12 + nvl(commission, 0) "��ü ����"
from employee;

--<����4> commission�� null �� �ƴ� ������� �̸��� ��� 
select ename ����̸�, commission ���ʽ�
from employee
where commission is not null;

--<����5> manager (���޻��) 7698 �� ����̸��� ��å�� ���.
select ename ����̸�, job ��å, manager ���޻��
from employee
where manager=7698;

--<����6> ������ 1500 �̻��̰� �μ��� 20�� ����� ����̸��� �Ի糯¥, �μ���ȣ, ������ ���
select ename ����̸�, hiredate �Ի���, dno �μ���ȣ, salary ����
from employee
where salary>=1500 and dno=20;

--<����7> �Ի糯¥�� 81�� 4�� 1�� �̻��̰� 81�� 12�� ���ϱ����� ��� �̸��� �Ի糯¥�� ���
select ename ����̸�, hiredate �Ի���
from employee
where hiredate between '81/04/01' and '81/12/31';

--<����8> ��å(job) salesman �̸鼭 ������ 1500 �̻��̸鼭 �μ���ȣ�� 30�� ������� ���
select ename ����̸�, job ��å, salary * 12 + nvl(commission, 0) ����, dno �μ���ȣ
from employee
where job=upper('salesman') and dno=30 and salary * 12 + nvl(commission, 0)>=1500;

--<����9> ������ 1500 �����̸鼭 �μ���ȣ�� 20�� �� �ƴ� ����̸���, ���ް�, �μ���ȣ�� ���
select ename ����̸�, salary ����, dno �μ���ȣ
from employee
where salary<=1500 and dno!=20;

--<����10> �����ȣ(eno) �� 7788, 7782 �� �μ���ȣ�� �̸��� ��å�� ���
select dno �μ���ȣ, ename ����̸�, job ��å, eno �����ȣ
from employee
where eno in (7788, 7782);