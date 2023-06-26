-- CRUD : Create, Read, Update, Delete

-- ���̺� ����
create table myTest (
    idx number not null,
    name varchar2(10) not null,
    pass varchar2(50) not null,
    addr varchar2(100) null,
    email varchar2(100) null
    );

-- ���̺��� ���� ���
select * from myTest;

-- ���̺��� �� �Է�
insert into myTest (idx, name, pass, addr, email)
values (1, 'ȫ�浿', '1234', '����', 'aaa@aaa.com');

insert into myTest (idx, name, pass, addr, email)
values (2, 'ȫ���', '1234', '�λ�', 'bbb@bbb.com');

commit;     -- Ʈ������� �Ϸ� (insert / update / delete)
-- MS-SQL, MySQL : �ڵ� Ŀ�� Ʈ�����

-- ������ ���̺� �� ���� : update �� where ������ ó��
update mytest
set addr = '����'
where idx=2;
commit;

-- ������ ���̺� �� ���� : delete
delete mytest
where idx=2;
commit;