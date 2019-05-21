## Datentypen in MySQL
## *unofficial* tl;dr
## https://www.techonthenet.com/mysql/datatypes.php
##
## https://dev.mysql.com/doc/refman/5.5/en/data-types.html
## https://dev.mysql.com/doc/refman/8.0/en/data-types.html

## Frequent consultation of documentation is not a sign of weakness,
## but of wisedom.

## https://dev.mysql.com/doc/refman/5.5/en/create-table-foreign-keys.html


create table Wgruppe(
    WID numeric(5) primary key,

    isTempAbh TINYINT(1)
);

create table Artikel(
    AIK numeric(5) primary key,
    Typ CHAR(1) CHECK(Typ IN ('Z', 'L')),
    Warengruppe numeric(5) references Wgruppe
);

create table Artikel(
    AIK numeric(5) primary key,
    Typ CHAR(1) CHECK(Typ IN ('Z', 'L')),
    Warengruppe numeric(5) references Wgruppe
                    on delete cascade
                    on update cascade
);

create table Artikel(
    AIK numeric(5) primary key,
    Typ CHAR(1) CHECK(Typ IN ('Z', 'L')),
    Warengruppe numeric(5) references Wgruppe
                    on delete set null
                    on update restrict
);

insert into Wgruppe VALUES (10001, 1);
insert into Wgruppe VALUES (10002, 1);
insert into Wgruppe VALUES (10003, 0);


drop table Artikel;
insert into Artikel VALUES (20001, 'Z', 10001);
insert into Artikel VALUES (20002, 'Z', 10002);
insert into Artikel VALUES (20003, 'L', 10003);


select * from Artikel;

delete from Wgruppe where WID = 10001;