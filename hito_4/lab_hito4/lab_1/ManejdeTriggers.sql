create database hito4_2023;
use hito4_2023 ;
create table numeros
(
    numero bigint primary key not null ,
    cuadrado bigint ,
    cubo bigint  ,
    raiz_cuadrada real
);

insert into numeros (numero) values (2);


select*from  numeros;
select power(2,1);######ejecutar
#### trigger
create or replace trigger  tr_completa_datos ######or replace modificar
    before insert ### NEW
    on numeros
    for each row
    begin
        declare valor_cuadrado bigint;
        declare valor_cubo bigint;
        declare valor_raiz real;
        declare valor_sumas_totales bigint default new.numero;### modificado

        set valor_cuadrado = power (NEW.numero,2);
        set valor_cubo = power (NEW.numero,3);
        set valor_raiz = sqrt (NEW.numero);
        ##### inecesario set valor_sumas_totales = power(NEW.numero);   ##### no se usa el set

        set new.cuadrado = valor_cuadrado;
        set new.cubo = valor_cubo;
        SET new.raiz_cuadrada = valor_raiz;
        set new.sumas_totales = valor_raiz + valor_cubo + valor_cuadrado + valor_sumas_totales;### modificado
    end;
##### insertar valores en la tabla
insert into numeros (numero) values (4);
select*from numeros;
insert into numeros (numero) values (10);


show triggers ;##### correr trigers o buscar cuantos triggers tenemos

######
truncate numeros ;##### eliminar datos de la tabla
alter table numeros add sumas_totales real;##### insertar nueva tabla enla database
#######tabla corta
create or replace trigger  tr_completa_datos
    before insert ### NEW
    on numeros
    for each row
begin

    set new.cuadrado = power (NEW.numero,2);
    set new.cubo = power (NEW.numero,3);
    set new.raiz_cuadrada = sqrt (NEW.numero);
    set new.sumas_totales = new.raiz_cuadrada + new.cuadrado + new.numero + new.cubo ;
end;


###################
create table USUARIOSs (
    ids_usr INT  auto_increment KEY NOT NULL,
    nombres varchar (50)not null ,
    apellidos varchar (50)not null ,
    edad int not null ,
    correo varchar (50)not null,
    password varchar (100)
);
select*from USUARIOSs;

create or replace trigger  contraseña_creadas ######or replace modificar
    before insert ### NEW
    on USUARIOSs
    for each row
begin
    declare nombres varchar(50) default  substring(new.nombres,1,2) ;
    declare apellidos varchar(50) default  substring(new.apellidos,1,2) ;
    set new.password = concat (nombres,apellidos,new.edad);

end;
select*from USUARIOSs;
insert into USUARIOSs (nombres, apellidos, edad, correo)
values ('jjjj','wuui',20,'ajbs@sadas');
#####
###hacelower

#######







