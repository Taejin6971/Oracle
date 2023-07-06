/*  JOIN 실습*/
 drop table member10 cascade constraints;
 drop table zipcode10 cascade constraints;
 drop table product10 cascade constraints;
 drop table orders10 cascade constraints;

create table zipcode10 (
    zipcode number(6) not null constraint PK_ZIPCODE_ZIPCODE Primary key, 
    si_do varchar2(200) not null, 
    gu_gun varchar2(200) not null, 
    bungi varchar2(200) not null
);

create table member10 (
    m_id number(4) not null constraint PK_MEMBER10_M_ID Primary key, 
    pass varchar2(200) not null , 
    name  varchar2(200) not null, 
    email varchar2(200) not null, 
    zipcode number(6) null , 
    constraint FK_MEMBER10_ZIPCODE10 foreign key (zipcode) references zipcode10(zipcode)
);

create table product10 ( 
    pro_id number(6) not null constraint PK_PRODUCT10_PRO_ID primary key, 
    pro_name varchar2(200) not null, 
    pro_price number(7,2) not null , 
    pro_cnt number(4) default 0 not null 
);

create table orders10 (
    ord_id number(6) not null constraint PK_ORDER10_ORD_ID Primary key, 
    m_id number(4) not null , 
    pro_id number(6) not null , 
    orderdate date,
        constraint FK_ORDER10_M_ID foreign key (m_id) references member10(m_id), 
        constraint FK_ORDER10_PRO_ID foreign key (pro_id) references product10(pro_id)
);

-- 각 각의 테이블에 레코드 5개씩 저장후 join 실습 : equi join, ansi join
-- 구매 정보에 대해서 회원이름, 메일주소, 시도, 제품이름, 제품가격, 제품수량(ctn), 구매날짜 출력

-- insert
insert into zipcode10(zipcode, si_do, gu_gun, bungi)
values (555, '대전광역시', '중구', '338');
insert into zipcode10(zipcode, si_do, gu_gun, bungi)
values (111, '서울특별시', '노원구', '119');
insert into zipcode10(zipcode, si_do, gu_gun, bungi)
values (333, '대구광역시', '달서구', '773');
insert into zipcode10(zipcode, si_do, gu_gun, bungi)
values (222, '인천광역시', '부평구', '557');
insert into zipcode10(zipcode, si_do, gu_gun, bungi)
values (444, '부산광역시', '남구', '662');

insert into member10(m_id, pass, name, email, zipcode)
values (147, '666', '문재준', 'ddd@ddd.com', 444);
insert into member10(m_id, pass, name, email, zipcode)
values (258, '555', '장태석', 'eee@eee.com', 555);
insert into member10(m_id, pass, name, email, zipcode)
values (456, '888', '방철중', 'bbb@bbb.com', 222);
insert into member10(m_id, pass, name, email, zipcode)
values (789, '777', '한주호', 'ccc@ccc.com', 333);
insert into member10(m_id, pass, name, email, zipcode)
values (123, '999', '김태진', 'aaa@aaa.com', 111);

insert into product10(pro_id, pro_name, pro_price, pro_cnt)
values (12, 'HELMET', 99.99, 100);
insert into product10(pro_id, pro_name, pro_price, pro_cnt)
values (56, 'PANTS', 55.99, 46);
insert into product10(pro_id, pro_name, pro_price, pro_cnt)
values (34, 'JACKET', 78.99, 84);
insert into product10(pro_id, pro_name, pro_price, pro_cnt)
values (90, 'BOOTS', 38.99, 35);
insert into product10(pro_id, pro_name, pro_price, pro_cnt)
values (78, 'GLOVES', 24.99, 66);

insert into orders10(ord_id, m_id, pro_id, orderdate)
values (1, 123, 34, '22/04/19');
insert into orders10(ord_id, m_id, pro_id, orderdate)
values (2, 789, 12, '23/02/14');
insert into orders10(ord_id, m_id, pro_id, orderdate)
values (3, 456, 12, '22/10/24');
insert into orders10(ord_id, m_id, pro_id, orderdate)
values (4, 123, 78, '23/01/04');
insert into orders10(ord_id, m_id, pro_id, orderdate)
values (5, 258, 90, '22/12/08');

commit;

select * from zipcode10;
select * from member10;
select * from product10;
select * from orders10;

구매 정보에 대해서 회원이름, 메일주소, 시도, 제품이름, 제품가격, 제품수량(ctn), 구매날짜 출력
-- equi join
select name, email, si_do, pro_name, pro_price, pro_cnt, orderdate
from zipcode10 z, member10 m, product10 p, orders10 o
where z.zipcode = m.zipcode
    and m.m_id = o.m_id
    and p.pro_id = o.pro_id;
    
-- ansi join
select name, email, si_do, pro_name, pro_price, pro_cnt, orderdate
from orders10 o join member10 m 
        on o.m_id = m.m_id
    join zipcode10 z
        on z.zipcode = m.zipcode
    join product10 p
        on p.pro_id = o.pro_id;