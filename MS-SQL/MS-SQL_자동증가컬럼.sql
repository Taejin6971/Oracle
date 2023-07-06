/*	MS-SQL : 자동 증가 컬럼, IDENTITY(1,1)
		자동증가 컬럼에는 값을 insert 하면 안된다
*/
create table dept08(
	dno int identity(1,1) primary key,
	dname varchar(50),
	loc varchar(50)
	);

select * from dept08;

insert into dept08 (dname, loc)
values ('인사부', '서울');

insert into dept08
values ('관리부', '부산');