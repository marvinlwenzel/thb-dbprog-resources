-- ORACLE Beispiel

drop table bsp_person;
drop view bsp_adult;
drop view bsp_child;

-- Eine simple Tabelle zum Speicher von Personen, die Adults oder Children sein können
-- Children benötigen einen erwachsenen Vormund (guardian)
create table bsp_person
(
    name   varchar(10) not null primary key,
    type   char        not null check ( type in ('a', 'c') ),
    guardian varchar(10) null references bsp_person (name)
);

-- Simple views, die noch vereinfacht werden koennten.
create view bsp_adult as select * from bsp_person where type = 'a';
create view bsp_child as select * from bsp_person where type = 'c';

-- Ein einfacher Grunddatenbestand.
insert into bsp_person values ('Alice', 'a', null);
insert into bsp_person values ('Bob', 'a', null);
insert into bsp_person values ('Charlie', 'a', null);
insert into bsp_person values ('Donald', 'a', null);
insert into bsp_person values ('Huey', 'c', 'Alice');
insert into bsp_person values ('Dewey', 'c', 'Alice');
insert into bsp_person values ('Louie', 'c', 'Bob');

-- Der Trigger zur Sicherung der Vormundschaft
create or replace trigger bsp_child_guardian
    before insert OR update
    on bsp_person
    FOR EACH ROW
    when ( new.type = 'c')
    declare
        guardian_type bsp_person.type%TYPE;
        guardian_name bsp_person.guardian%TYPE;
    begin
        guardian_name := :new.guardian;
        if (:new.guardian is null) then
            raise_application_error(-20001, 'Ein Kind braucht einen Vormund.');
        end if;
        select type into guardian_type from bsp_person p where p.name = guardian_name;
        if (guardian_type != 'a') then
            raise_application_error(-20002, 'Der Vormund darf selbst kein Kind sein.');
        end if;
    end;
/

-- Das Kind braucht einen guardian
insert into bsp_person values ('Louie2', 'c', null);
/*
insert into bsp_person values ('Louie2', 'c', null)
[2019-05-15 11:12:39] [72000][20000] ORA-20000: Der braucht nen Vormund
[2019-05-15 11:12:39] ORA-06512: at "DUMMY.BSP_CHILD_GUARDIAN", line 7
[2019-05-15 11:12:39] ORA-04088: error during execution of trigger 'DUMMY.BSP_CHILD_GUARDIAN'
*/


-- Der guardian inst selbst noch ein Kind.
insert into bsp_person values ('Louie3', 'c', 'Louie');
/*
[2019-05-15 11:12:44] [72000][20000] ORA-20000: Das ist pointless...
[2019-05-15 11:12:44] ORA-06512: at "DUMMY.BSP_CHILD_GUARDIAN", line 11
[2019-05-15 11:12:44] ORA-04088: error during execution of trigger 'DUMMY.BSP_CHILD_GUARDIAN'
*/
