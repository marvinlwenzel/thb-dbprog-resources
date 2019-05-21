/*  Datatypes
    *unofficial* tl;dr
    https://www.w3resource.com/oracle/oracle-data-types.php

    https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/datatypes.htm


    Frequent consultation of documentation is not a sign of weakness,
    but of wisedom.

    https://docs.oracle.com/cd/B28359_01/appdev.111/b28370/triggers.htm


 */

create table Wgruppe(
    WID numeric(5) primary key,

    isTempAbh number(1)
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
);

create table Artikel(
    AIK numeric(5) primary key,
    Typ CHAR(1) CHECK(Typ IN ('Z', 'L')),
    Warengruppe numeric(5) references Wgruppe
                    on delete set null
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