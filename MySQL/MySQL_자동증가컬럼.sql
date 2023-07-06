use mydb;

/*	MySQL : 자동 증가 컬럼, auto_increment
		자동증가 컬럼에는 값을 insert 하면 안된다 (default)
*/
create table dept08(
	dno int auto_increment primary key,
	dname varchar(50),
	loc varchar(50)
	);

select * from dept08;

insert into dept08 (dname, loc)
values ('HR', '서울');

insert into dept08
values (default, 'HR', '서울');