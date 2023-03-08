CREATE DATABASE hito2;
use hito2 ;
CREATE TABLE usuarios(
    id_usuario integer auto_increment primary key,
    nombre varchar (50) not null,
    apellido varchar (50) not null,
    edad integer not null,
    email varchar (100) not null
);
insert into usuarios(nombre, apellido, edad, email) values ('nombre1', 'apellido','21', 'nombres1@gmail.com'),
                                                           ('nombre2', 'apellido','30', 'nombres2@gmail.com'),
                                                           ('nombre3', 'apellido','40', 'nombres3@gmail.com');
create view mayores_a_30 as
    select us.nombre, us.edad
    from usuarios as  us
    where us.edad >30;

select *
from mayores_a_30



alter view mayores_a_30 as
    select concat(us.nombre,'',us.apellido) as FULLNAME, us.edad AS EDAD_USUARIO,us.email AS EMAIL_USUARIO
from usuarios as us
    where us.edad >30;

SELECT MA.*
FROM mayores_a_30 AS MA
WHERE ma.FULLNAME LIKE '%3%';

DROP VIEW mayores_a_30 ;


































