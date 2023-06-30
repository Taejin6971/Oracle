/*  데이터 베이스 설계 */
-- member table 생성
create table member(
    id varchar2(20) constraint PK_member_id primary key,
    pwd varchar2(20) null,
    name varchar2(50) null,
    zipcode varchar2(7) null,
    address varchar2(20) null,
    tel varchar2(13) null,
    indate date default sysdate
);
-- foreign key 설정
alter table member
add constraint FK_member_zipcode_tb_zipcode foreign key(zipcode) references tb_zipcode(zipcode);

select * from user_constraints
where table_name='MEMBER';

-- 값 입력
insert into member(id,pwd,name,zipcode,address,tel)
--values('aa','aa','김태진',123,'서울','123-123');
--values('bb','bb','이태준',456,'서울','234-567');
--values('cc','cc','한태성',789,'서울','987-654');
--values('dd','dd','박태주',147,'서울','744-558');
values('ee','ee','장태상',258,'서울','681-875');

select * from member;

-- tb_zipcode table 생성
create table tb_zipcode(
    zipcode varchar(7) constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30) null,
    gugum varchar2(30) null,
    dong varchar2(30) null,
    bungi varchar2(30) null
);

select * from user_constraints
where table_name='TB_ZIPCODE';

-- 값 입력
insert into tb_zipcode(zipcode,sido,gugum,dong,bungi)
--values('123','서울시','노원구','하계동','1');
--values('456','서울시','도봉구','수유동','2');
--values('789','서울시','노원구','월계동','3');
--values('147','서울시','중랑구','상봉동','4');
values('258','서울시','노원구','상계동','5');

select * from tb_zipcode;

-- products table 생성
create table products(
    product_code varchar2(20) constraint PK_products_product_code primary key,
    product_name varchar2(100) null,
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date    
);

select * from user_constraints
where table_name='PRODUCTS';

-- 값 입력
insert into products
values();

-- orders table 생성
create table orders(
    o_seq number(10) constraint PK_orders_o_seq primary key,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
);
-- foreign key 설정
alter table orders
add constraint FK_orders_product_code_products foreign key(product_code) references products(product_code);

alter table orders
add constraint FK_orders_id_member foreign key(id) references member(id);

select * from user_constraints
where table_name='ORDERS';

-- 값 입력
insert into orders
values();

commit;