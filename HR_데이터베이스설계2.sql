/*  单捞磐海捞胶汲拌2 */

-- sale table 积己
create table sale(
    sale_date date constraint PK_sale_sale_date primary key,
    wine_code varchar2(6) not null,
    mem_id varchar2(30) not null,
    sale_amount varchar2(5) default 0 not null,
    sale_price varchar2(6) default 0 not null,
    sale_tot_price varchar2(15) default 0 not null
);
-- FK 汲沥
alter table sale
--add constraint FK_sale_wine_code_wine foreign key(wine_code) references wine(wine_code);
add constraint FK_sale_mem_id_member01 foreign key(mem_id) references member01(mem_id);

select * from user_constraints
where table_name='SALE';

-- member table 积己
create table member01(
    mem_id varchar2(6) constraint PK_member01_mem_id primary key,
    mem_grade varchar2(20) null,
    mem_pw varchar2(20) not null,
    mem_birth date default sysdate not null,
    mem_tel varchar2(20) null,
    mem_pt varchar2(10) default 0 not null
);
-- FK 汲沥
alter table member01
add constraint FK_member01_mem_grade_grade_pt_rade foreign key(mem_grade) references grade_pt_rade(mem_grade);

select * from user_constraints
where table_name='MEMBER01';

-- grade_pt_rade table 积己
create table grade_pt_rade(
    mem_grade varchar2(20) constraint PK_grade_pt_rade_mem_grade primary key,
    grade_pt_rate number (3,2) null
);

-- today table 积己
create table today(
    today_code varchar2(6) constraint PK_today_today_code primary key,
    today_sens_value number (3) null,
    today_intell_value number (3) null,
    today_phy_value number (3) null
);
-- nation table 积己
create table nation(
    nation_code varchar2(26) constraint PK_nation_nation_code primary key,
    nation_name varchar2 (50) not null
);

-- wine table 积己
create table wine(
    wine_code varchar2(26) constraint PK_wine_wine_code primary key,
    wine_name varchar2(100) not null,
    wine_url blob null,
    nation_code varchar2(6),
    wine_type_code varchar2(6),
    wine_sugar_code number(2) null,
    wine_price number(15) default 0 not null,
    wine_vintage date null,
    theme_code varchar2(6),
    today_code varchar2(6)
);
-- FK 汲沥
alter table wine
--add constraint FK_wine_nation_code_nation foreign key(nation_code) references nation(nation_code);
--add constraint FK_wine_wine_type_code_wine_type foreign key(wine_type_code) references wine_type(wine_type_code);
--add constraint FK_wine_theme_code_theme foreign key(theme_code) references theme(theme_code);
add constraint FK_wine_today_code_today foreign key(today_code) references today(today_code);

select * from user_constraints
where table_name='WINE';

-- theme table 积己
create table theme(
    theme_code varchar2(6) constraint PK_theme_theme_code primary key,
    theme_name varchar2(50) not null
);

-- stock_mamagement table 积己
create table stock_mamagement(
    stock_code varchar2(6) constraint PK_stock_mamagement_stock_code primary key,
    wine_code varchar2(6) null,
    manager_id varchar2(30) null,
    ware_date date default sysdate not null,
    stock_amount number(5) default 0 not null
);
-- FK 汲沥
alter table stock_mamagement
--add constraint FK_stock_mamagement_wine_code_wine foreign key(wine_code) references wine(wine_code);
add constraint FK_stock_mamagement_manager_id_manager foreign key(manager_id) references manager(manager_id);

select * from user_constraints
where table_name='STOCK_MAMAGEMENT';

-- manager table 积己
create table manager(
    manager_id varchar2(30) constraint PK_manager_manager_id primary key,
    manager_pwd varchar2(20) not null,
    manager_tel varchar2(20) null
);

-- wine_type table 积己
create table wine_type(
    wine_type_code varchar2(6) constraint PK_wine_type_wine_type_code primary key,
    wine_type_name varchar2(50) null
);
