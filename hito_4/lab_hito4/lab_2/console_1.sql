create database hito4_2023;
use hito4_2023 ;
create table numeros
(
    numero bigint primary key not null ,
    cuadrado bigint ,
    cubo bigint  ,
    raiz_cuadrada real
);
insert into numeros (numero) values ( 110);

insert into numeros (numero) values (2);


select*from  numeros;
select power(2,1);######ejecutar
#### trigger
create or replace trigger  tr_complet_dato ######or replace modificar
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
        set new.sumas_totales = valor_raiz + valor_cubo + valor_cuadrado + valor_sumas_totales; ### modificado
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



#create or replace trigger  contraseña_creadas ######or replace modificar
   # AFTER insert ### NEW
 #   on USUARIOSs
  #  for each row
#begin
 #   update USUARIOSs SET password = concat(
  #      substr(new.nombres, 1 , 2),
   #     substr(new.apellidos, 1, 2),
    #    new.edad)
     #   where  ids_usr = new.ids_usr ;


#end;
select*from USUARIOSs;
insert into USUARIOSs (nombres, apellidos, edad, correo)
values ('jjjj','wuui',20,'ajbs@sadas');
delete table usuarios;
create table usuario (
    ids_usr INT  auto_increment KEY NOT NULL,
    nombres varchar (50)not null ,
    apellidos varchar (50)not null ,
    fecha_nac date not null ,
    correo varchar (50)not null,
    password varchar (100),
    edad int
);

create or replace TRIGGER tr_calcula_pass_edades
    before insert
    on usuario
    for each row
    begin
        set new.password = LOWER(concat(
            substr(new.nombres, 1, 2),
            substr(new.apellidos, 1, 2),
            substr(new.correo, 1, 2)

            ));
        set new.edad = TIMESTAMPDIFF(year, new.fecha_nac, curdate());
    end;
select  current_date;
insert into  usuario(nombres, apellidos, fecha_nac, correo ) values
    ('mario' , 'bros' , '2000-09-21' , 'mariosamigos@gmail.com');
insert into usuario(nombres, apellidos, fecha_nac, correo, password, edad) VALUES
     ('mar' , 'bre' ,'2002-09-02' , 'marbroe@gmail.com');
insert into usuario(nombres, apellidos, fecha_nac, correo) VALUES
                                                               ('Micha', 'Brya' ,'2000-01-01' , ' michabra@gmail.com');
values ();

select*from usuario;

select TIMESTAMPDIFF("2002-01-29", curdate()) as edad from users as us;


CREATE  or replace  trigger Generar_password
BEFORE INSERT
    ON usuario
FOR EACH ROW
BEGIN
    IF LENGTH(NEW.password) <= 10 THEN
        SET NEW.password =  LOWER(concat(
                                          substr(new.nombres, 1, 2),
                                          substr(new.apellidos, 1, 2),
                                          substr(new.correo, 1, 2),
            substr(new.password,1,2)

                                      ));
        end if;
END;
insert into usuario(nombres, apellidos, fecha_nac, correo,password) VALUES
                                                               ('Micsssa', 'Brrra' ,'2000-01-01' , ' michabra@gmail.com' , '12345678911');
######
CREATE  or replace TRIGGER  tr_usuarios_manternimineto
    BEFORE INSERT
        ON usuario

           for each row
        begin
        declare  dia_de_la_semana text default '';

        set dia_de_la_semana = dayname(current_date);
        if dia_de_la_semana ='Wednesday'
            then
            signal SQLSTATE '45000'
            set message_text  = 'Base de datos en Mantenimiento ';
    end if;

end;

alter table usuario  add column  nacionalidad varchar(20);
select*from usuario;

insert into usuario(nombres, apellidos, fecha_nac, correo,password,nacionalidad) VALUES
                                                               ('Micsssa', 'Brrra' ,'2000-01-01' , ' michabra@gmail.com' , '12345678911' , 'chile');


CREATE  or replace TRIGGER  nacionalidad_no_requerida
    BEFORE INSERT
        ON usuario
           for each row
        begin
        declare  bolivia_paraguay_argentina  text default '';

        set bolivia_paraguay_argentina = nacionalidad;
        if bolivia_paraguay_argentina = true
            then
             set new= new nacionalidad  = 'bolivia -paraguay -argentina';
             false
            if
                nacionalidad = nacionalidad

    end if;

end;








