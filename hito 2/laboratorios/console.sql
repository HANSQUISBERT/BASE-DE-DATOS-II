CREATE DATABASE hito2 ;
DROP DATABASE ejemplo ;
Use hito2 ;
CREATE TABLE ejemplo (
    NOMBRE VARCHAR (20) NOT NULL,
    APELLIDO VARCHAR (20) NOT NULL,
    EDAD INTEGER NOT NULL,
    CI INTEGER PRIMARY KEY NOT NULL
) ;
INSERT INTO ejemplo (NOMBRE,APELLIDO,EDAD,CI)VALUES ('JOSE','COPE',20,2929292);
INSERT INTO ejemplo (NOMBRE,APELLIDO,EDAD,CI)VALUES ('JOSEPE','COPA',20,2929202);
SELECT *
FROM ejemplo
DELETE FROM ejemplo where CI = 2929202 ;
DROP DATABASE IF EXISTS hito2 ;
DROP TABLE IF EXISTS ejemplo ;

CREATE DATABASE insertar ;}
CREATE DATABASE universidad ;
USE universidad ;
CREATE TABLE estudiantes (
    id_est integer auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar (100) not null,
        edad integer not null,
        fono integer not null,
        email varchar (50) not null
) ;

DESCRIBE estudiantes ;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email) values ('nombre1','apellido1' ,10 ,11111,'user1@gmail.com'),
                                                                       ('nombre2','apellido2' ,20 ,11111,'user2@gmail.com'),
                                                                       ('nombre2','apellido3' ,10 ,11111,'user3@gmail.com');
 select*
from estudiantes
ALTER TABLE estudiantes ADD COLUMN direccion VARCHAR(200) default 'EL ALTO';
ALTER TABLE estudiantes
DROP COLUMN direccion ;
