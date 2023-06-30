/*  ������ ���̽� ���� */
-- member table ����
create table member(
    id varchar2(20) constraint PK_member_id primary key,
    pwd varchar2(20) null,
    name varchar2(50) null,
    zipcode varchar2(7) null,
    address varchar2(20) null,
    tel varchar2(13) null,
    indate date default sysdate
);
-- foreign key ����
alter table member
add constraint FK_member_zipcode_tb_zipcode foreign key(zipcode) references tb_zipcode(zipcode);

select * from user_constraints
where table_name='MEMBER';

-- �� �Է�
insert into member(id,pwd,name,zipcode,address,tel)
--values('aa','aa','������',123,'����','123-123');
--values('bb','bb','������',456,'����','234-567');
--values('cc','cc','���¼�',789,'����','987-654');
--values('dd','dd','������',147,'����','744-558');
values('ee','ee','���»�',258,'����','681-875');

select * from member;

-- tb_zipcode table ����
create table tb_zipcode(
    zipcode varchar(7) constraint PK_tb_zipcode_zipcode primary key,
    sido varchar2(30) null,
    gugum varchar2(30) null,
    dong varchar2(30) null,
    bungi varchar2(30) null
);

select * from user_constraints
where table_name='TB_ZIPCODE';

-- �� �Է�
insert into tb_zipcode(zipcode,sido,gugum,dong,bungi)
--values('123','�����','�����','�ϰ赿','1');
--values('456','�����','������','������','2');
--values('789','�����','�����','���赿','3');
--values('147','�����','�߶���','�����','4');
values('258','�����','�����','��赿','5');

select * from tb_zipcode;

-- products table ����
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

-- �� �Է�
insert into products
values();

-- orders table ����
create table orders(
    o_seq number(10) constraint PK_orders_o_seq primary key,
    product_code varchar2(20),
    id varchar2(16),
    product_size varchar2(5),
    quantity varchar2(5),
    result char(1),
    indate date
);
-- foreign key ����
alter table orders
add constraint FK_orders_product_code_products foreign key(product_code) references products(product_code);

alter table orders
add constraint FK_orders_id_member foreign key(id) references member(id);

select * from user_constraints
where table_name='ORDERS';

-- �� �Է�
insert into orders
values();

commit;