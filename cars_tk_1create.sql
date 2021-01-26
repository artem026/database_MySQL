/*

1.	Составить общее текстовое описание БД и решаемых ею задач;
2.	минимальное количество таблиц - 10;
3.	скрипты создания структуры БД (с первичными ключами, индексами, внешними ключами);
4.	создать ERDiagram для БД;
5.	скрипты наполнения БД данными;
6.	скрипты характерных выборок (включающие группировки, JOIN'ы, вложенные таблицы);
7.	представления (минимум 2);
8.	хранимые процедуры / триггеры;

*/


-- База данных Cars_tk. Хранение данных автомобилей компании, водителей и клиентах
-- Возможность получать выборки по необходимым данным


DROP DATABASE IF EXISTS cars_tk_db;
CREATE DATABASE cars_tk_db;
USE cars_tk_db;

/* ------- Table: Reserv ------- */

drop table if exists Reserv;
create table Reserv
(
    cars_id int not null,
    login varchar(20) not null
);


/* ------- Table: Category -------- */

drop table if exists Category;
create table Category
(
    category_id int not null,
    name varchar(50) not null,
    primary key (category_id)
);

alter table Category
    comment 'Тип кузова';

   
/* ------- Table: Optional ------- */

drop table if exists Optional;
create table Optional
(
    optional_id int not null,
    name      varchar(50),
    primary key (optional_id)
);


/* ------- Table: Photos ------- */

drop table if exists Photos;
create table Photos
(
    cars_id int not null,
    name  varchar(50)
);


/* ------- Table: Cars ------- */

drop table if exists Cars;
create table Cars
(
    Cars_id  int not null,
    category_id int not null,
    driver_id int not null,
    code  int not null,
    numbers varchar(10) not null,
    color varchar(10) not null,
    brand varchar(50),
    model varchar(50) not null,
    price int not null,
    primary key (cars_id)
);

alter table Cars
    comment 'АВТО';



/* ------- Table: TotalCars ------- */

drop table if exists TotalCars;
create table TotalCars
(
    count int,
    type  int not null,
    primary key (type)
);


/* ------- Table: CarsMeta ------- */

drop table if exists CarsMeta;
create table CarsMeta
(
    meta_id  int not null,
    cars_id int not null,
    engine  float,
    manufacture_year int,
    km_distance  int,
    primary key (meta_id)
);



/* ------- Table: Region ------- */

drop table if exists Region;
create table Region
(
    code int  not null,   
    name varchar(50) not null,
    primary key (code)
);


/* ------- Table: Driver ------- */

drop table if exists Driver;
create table Driver
(    
    driver_id int  not null,
    name varchar(50) not null,
    surname varchar(50) not null,
    phone varchar(10),
    primary key (driver_id)
);


/* ------- Table: Users ------- */

drop table if exists Users;
create table Users
(
    login varchar(20) not null,
    primary key (login)
);


/* ------- Table: Orders ------- */

drop table if exists Orders;
create table Orders
(
    cars_id int not null,
    count     int
);

alter table Orders
    comment 'Счетчик заказов';


/* ------- Table: cars2optional -------*/

drop table if exists cars2optional;
create table cars2optional
(
    cars_id int not null,
    optional_id int not null,
    primary key (cars_id, optional_id)
);

alter table Reserv
    add constraint FK_reserv2cars foreign key (cars_id)
        references Cars (cars_id) on delete restrict on update restrict;

alter table Reserv
    add constraint FK_reserv2users foreign key (login)
        references Users (login) on delete restrict on update restrict;

alter table Photos
    add constraint FK_cars2photo foreign key (cars_id)
        references Cars (cars_id) on delete restrict on update restrict;

alter table Cars
    add constraint FK_cars2category foreign key (category_id)
        references Category (category_id) on delete restrict on update restrict;

alter table Cars
    add constraint FK_cars2region foreign key (code)
        references Region (code) on delete restrict on update restrict;

alter table Cars
    add constraint FK_driver2cars foreign key (driver_id)
        references Driver (driver_id) on delete restrict on update restrict;

alter table CarsMeta
    add constraint FK_cars2meta foreign key (cars_id)
        references Cars (cars_id) on delete restrict on update restrict;

alter table Orders
    add constraint FK_orders foreign key (cars_id)
        references Cars (cars_id) on delete restrict on update restrict;

alter table cars2optional
    add constraint FK_cars2optional foreign key (cars_id)
        references Cars (cars_id) on delete restrict on update restrict;

alter table cars2optional
    add constraint FK_cars2optional2 foreign key (optional_id)
        references Optional (optional_id) on delete restrict on update restrict;
        
       
