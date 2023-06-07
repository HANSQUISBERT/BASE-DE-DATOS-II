create database procesual_hito4;
use procesual_hito4;

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


insert into departamento values(1,'El alto');
insert into departamento values(2,'Santa Cruz');
insert into departamento values(3,'Cochabamba');

insert into provincia values(1,'provincia 1',1);
insert into provincia values(2,'provincia 2',2);
insert into provincia values(3,'provincia 3',3);

insert into persona values(2,'Mario','Guso', '2000-10-10', 30, 'mario@gmail.com', 1, 1, 'F');
insert into persona values(4,'Maria','Frans', '2000-10-10', 30, 'mario@gmail.com', 4, 4, 'F');
insert into persona values(1,'Joao','Salazar', '2000-10-10', 20, 'joao@gmail.com', 1, 1, 'M');
insert into persona values(3,'Pedrote','Alvarez', '2000-10-10', 40, 'pedro@gmail.com', 3, 3, 'M');

insert into proyecto values(1,'proyecto1','tipo1');
insert into proyecto values(2,'proyecto2','tipo2');
insert into proyecto values(3,'proyecto3','tipo3');

insert into detalle_proyecto values(1,1,1);
insert into detalle_proyecto values(2,2,2);
insert into detalle_proyecto values(3,3,3);


# 10.Crear una función que sume los valores de la serie Fibonacci.


CREATE FUNCTION serie_Fibonacci (n INT)
RETURNS VARCHAR(255)
BEGIN
DECLARE serie VARCHAR(255);
DECLARE n1 INT;
DECLARE n2 INT;
DECLARE n3 INT;

SET n1 = 0;
SET n2 = 1;
SET serie = CONCAT(n1, ',', n2);

WHILE n > 2 DO
  SET n3 = n1 + n2;
  SET serie = CONCAT(serie, ',', n3);
  SET n1 = n2;
  SET n2 = n3;
  SET n = n - 1;
END WHILE;

RETURN serie;
END;

select serie_Fibonacci(10);

#suma de la serie fibonnaci
CREATE FUNCTION suma_serie_fibonacci (serie VARCHAR(255))
RETURNS INT
BEGIN
DECLARE total INT DEFAULT 0;
DECLARE n INT DEFAULT 0;

WHILE LENGTH(serie) > 0 DO
  SET n = SUBSTRING_INDEX(serie, ',', 1);
  SET serie = SUBSTRING(serie, LENGTH(n) + 2);
  SET total = total + n;
END WHILE;

RETURN total;
END;
select serie_Fibonacci(10);
select suma_serie_fibonacci(serie_Fibonacci(10)) as 'suma de la serie fibonacci';

# 11. Manejo de vistas


create or replace view persona_view as
SELECT CONCAT(pe.nombre,' ',pe.apellidos) as nombres_completo,pe.edad,pe.fecha_nac,proy.nombreProy
from persona as pe
inner join detalle_proyecto dp on pe.id_per = dp.id_per
inner join proyecto proy on dp.id_proy = proy.id_proy
inner join departamento d on pe.id_dep = d.id_dep
where pe.sexo = 'F' and d.nombre = 'El Alto' and pe.fecha_nac = '2000-10-10';

select * from persona_view;

# 12.Manejo de TRIGGERS I.


#estado es un nuevo campo de la tabla proyecto
alter table proyecto add estado varchar(10);

CREATE or replace TRIGGER estado_proyecto
BEFORE INSERT ON proyecto
FOR EACH ROW
BEGIN
IF NEW.tipoProy = 'EDUCACION' or NEW.tipoProy = 'FORESTACION' or NEW.tipoProy = 'CULTURA' THEN
  SET NEW.estado = 'ACTIVO';
ELSE
  SET NEW.estado = 'INACTIVO';
END IF;
END;

INSERT INTO proyecto (id_proy,nombreProy,tipoProy) VALUES (5,'proyecto5','Learning');
INSERT INTO proyecto (id_proy,nombreProy,tipoProy) VALUES (6,'proyecto6','EDUCACION');
INSERT INTO proyecto (id_proy,nombreProy,tipoProy) VALUES (7,'proyecto7','CASAS');
SELECT * FROM proyecto;

# 13.Manejo de Triggers II.


CREATE or replace TRIGGER calculaEdad
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
SET NEW.edad = YEAR(CURDATE()) - YEAR(NEW.fecha_nac);
END;

INSERT INTO persona (id_per,nombre,apellidos,sexo,fecha_nac,id_dep) VALUES (4,'persona4','persona4','M','1990-10-10',1);

INSERT INTO persona (id_per,nombre,apellidos,sexo,fecha_nac,id_dep) VALUES (5,'persona5','persona5','F','1950-10-10',1);
    SELECT * FROM persona;

# 14.Manejo de TRIGGERS III.


CREATE TABLE copia_persona (

    nombre varchar(20),
    apellidos varchar(50),
    fecha_nac date,
    edad int,
    email varchar(50),
    id_dep int,
    id_prov int,
    sexo char(1),
    foreign key (id_dep) references departamento(id_dep),
    foreign key (id_prov) references provincia(id_prov)
);

CREATE or replace TRIGGER copia_persona
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
INSERT INTO copia_persona (nombre,apellidos,fecha_nac,edad,email,id_dep,id_prov,sexo)
VALUES (NEW.nombre,NEW.apellidos,NEW.fecha_nac,NEW.edad,NEW.email,NEW.id_dep,NEW.id_prov,NEW.sexo);
END;

INSERT INTO persona (id_per,nombre,apellidos,sexo,fecha_nac,id_dep) VALUES (5,'persona5','persona5','M','1990-10-10',2);
INSERT INTO persona (id_per,nombre,apellidos,sexo,fecha_nac,id_dep) VALUES (8,'persona8','persona8','F','1960-10-10',1);
INSERT INTO persona (id_per,nombre,apellidos,sexo,fecha_nac,id_dep) VALUES (9,'persona9','persona9','F','1960-10-10',1);
SELECT * FROM copia_persona;
SELECT*FROM persona ;


#crear una consulta con todas las tablas en una vista

create or replace view persona_view_example as
SELECT CONCAT(pe.nombre,' ',pe.apellidos) as nombres_completo,pe.edad,pe.fecha_nac,proy.nombreProy
from persona as pe
inner join detalle_proyecto dp on pe.id_per = dp.id_per
inner join proyecto proy on dp.id_proy = proy.id_proy
inner join departamento d on pe.id_dep = d.id_dep
inner join provincia p on pe.id_prov = p.id_prov;

select * from persona_view_example;


