create database defensa_hito4_2023 ;

use defensa_hito4_2023

create table departamento(
    id_dep int primary key not null,
    nombre varchar(50)
);

create table provincia(
    id_prov int primary key not null,

    nombre varchar(50),
    id_dep int,
    foreign key (id_dep) references departamento(id_dep)
);

create table proyecto(
    id_proy int primary key,
    nombreProy varchar(100),
    tipoProy varchar(30)
);

create table persona(
    id_per int primary key not null,
    nombre varchar(20),
    apellidos varchar(50),
    fecha_nac date,
    edad int,
    email varchar(50),

    id_dep int,
    id_prov int,
    foreign key (id_dep) references departamento (id_dep),
    foreign key (id_prov) references provincia (id_prov),
    sexo char(1)
);

create table detalle_proyecto(
    id_dp int primary key not null,

    id_proy int,
    id_per int,
    foreign key (id_proy) references  proyecto (id_proy),
    foreign key (id_per) references  persona (id_per)
);

insert into departamento values (1,'El alto');
insert into departamento values (2,'La paz');
insert  into provincia values (1,'provincia1',1);
insert into provincia values (2,'provincia2',2);
insert into proyecto values (1,'proyecto1','tipo1');
insert into proyecto values (2,'proyecto2','tipo2');
insert into persona values(2,'Mario','Guso', '2000-10-10', 30, 'mario@gmail.com', 1, 1, 'F');
insert into persona values(1,'Pedrote','Alvarez', '2000-10-10', 40, 'pedro@gmail.com', 2, 2, 'M');
insert into detalle_proyecto values(1,1,1);
insert into detalle_proyecto values(2,2,2);

drop database defensa_hito4_2023;
create table audit_proyectos (
    nombre_proy_anterior varchar(30),
    nombre_proy_posterior varchar(30),
    tipo_proy_anterior varchar(30),
    tipo_proy_posterior varchar(30),
    operation varchar(30),
    userId varchar(30),
    hostName varchar(30)
);

create trigger audit_proyectos_update
    before update on proyecto
    for each row
begin
insert into audit_proyectos values (old.nombreProy,new.nombreProy,old.tipoProy,new.tipoProy,'update',user(),@hostname);
end;

update proyecto set nombreProy='proyecto3' where id_proy=1;


create or replace trigger audit_proyectos_update
    before insert on proyecto
    for each row
    begin
        insert into audit_proyectos(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior,
                                    operation, userId, hostName) select user(),user(),now(),now(),'insert',userId,userId,@hostname;
    end;
create or replace trigger  audit_proyectos_update
    before delete on proyecto
    for each row
    begin
        declare nombre_proy_anterior text;
        declare nombre_proy_posterior text;
        declare tipo_proy_posterior text;
        declare tipo_proy_anterior text;

        INSERT INTO audit_proyectos(nombre_proy_anterior, nombre_proy_posterior, tipo_proy_anterior,
                                    tipo_proy_posterior, operation, userId, hostName) select user(),user(),now(),now(),'insert',userId,userId,@hostname;
    end;

#####
create or replace view vista_proyecto as
    select per.nombre, per.apellidos, pr.nombreProy, pr.tipoProy,
       concat(per.nombre, ' ', per.apellidos) as fullName,
       concat(pr.nombreProy, ' : ', pr.tipoProy) as desc_proyecto,
       dep.nombre as departamento,
       dep.id_dep, pr.id_proy,
       case
            when dep.nombre = 'El alto' then 'EA'
            when dep.nombre = 'La Paz' then 'LP'
        end as codigo_dep
from persona per
inner join detalle_proyecto dp on per.id_per = dp.id_per
inner join proyecto pr on dp.id_proy = pr.id_proy
inner join departamento dep on per.id_dep = dep.id_dep
inner join provincia prov on per.id_prov = prov.id_prov;
drop view  vista_proyecto;

select * from vista_proyecto;


####
CREATE  or replace TRIGGER  mantenimineto
    BEFORE INSERT
        ON proyecto

           for each row
        begin
        declare  dia_de_la_semana text default '';


        set dia_de_la_semana = dayname(current_date);
        if dia_de_la_semana ='Wednesday'
            then
            signal SQLSTATE '45000'
            set message_text  = 'No se admite inserciones del tipo FORESTACION ';


    end if;

end;
select *from proyecto;

CREATE  or replace TRIGGER  mantenimineto
    BEFORE INSERT
        ON proyecto

           for each row
        begin
        declare  mes_del_año text default '';

        set mes_del_año = monthname(current_date);
        if  mes_del_año ='June'
            then
            signal SQLSTATE '45000'
            set message_text  = 'No se admite inserciones del tipo FORESTACION ';

    end if;
end;

SELECT *from proyecto;

CREATE FUNCTION dicc(par_dia TEXT)
    RETURNS TEXT
    BEGIN
        DECLARE var_dia TEXT;

        IF par_dia = 'monday' THEN
            SET var_dia = 'Lunes';
            ELSEIF par_dia = 'tuesday' THEN
            SET var_dia = 'Martes';
            ELSEIF par_dia = 'wednesday' THEN
            SET var_dia = 'Miercoles';
            ELSEIF par_dia = 'thursday' THEN
            SET var_dia = 'Jueves';
            ELSEIF par_dia = 'friday' THEN
            SET var_dia = 'Viernes';
            ELSEIF par_dia = 'saturday' THEN
            SET var_dia = 'Sabado';
            ELSEIF par_dia = 'sunday' THEN
            SET var_dia = 'Domingo';
        end if;

RETURN var_dia;

        END;
SELECT dicc('sunday');













