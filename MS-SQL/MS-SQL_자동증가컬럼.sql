/*	MS-SQL : �ڵ� ���� �÷�, IDENTITY(1,1)
		�ڵ����� �÷����� ���� insert �ϸ� �ȵȴ�
*/
create table dept08(
	dno int identity(1,1) primary key,
	dname varchar(50),
	loc varchar(50)
	);

select * from dept08;

insert into dept08 (dname, loc)
values ('�λ��', '����');

insert into dept08
values ('������', '�λ�');