CREATE DATABASE universidad;
USE universidad;
#    resoucion  ej  1
CREATE TABLE estudiantes (
    id_est Integer AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombres VARCHAR (50) NOT NULL,
    apellidos VARCHAR(50)NOT NULL,
    edad INTEGER NOT NULL,
    fono INTEGER NOT NULL,
    email VARCHAR(100),
    direccion VARCHAR(100),
    genero VARCHAR(10)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, genero)
VALUES ('Antoni','Ante Sala',23,2832115,'Antoni@gmail.com','Av.16 de Julio','masculino'),
       ('Alesandra','Magda Illca',20,2832116,'Alesandra@gmail.com','Av.16 de Julio','femenino'),
       ('Banca','Quispe Quispe',35,2832117,'Banca@gmail.com','Av.16 de Julio','masculino'),
       ('Ximena','Mollericona Miranda',28,2832118,'Ximena@gmail.com','Av.16 de Julio','femenino'),
       ('Romerio','Vaca  Sillaga',21,2832119,'Romerio@gmail.com','Av.16 de Julio','masculino');

CREATE TABLE materias(
    id_mat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre_mat varchar (100) NOT NULL ,
    cod_mat varchar (100) NOT NULL
);

INSERT INTO materias (nombre_mat, cod_mat)
VALUES ('MATE','MAT-101'),
       ('DISEÑO','DIS-102'),
       ('LENGUA','LENG'),
       ('COMPUTACION','COMP104'),
       ('Fisica ','FIS-105');


CREATE TABLE inscripcion (
    id_inscripcion INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    semestre varchar(20) NOT NULL ,
    gestion INTEGER NOT NULL,

    id_est INTEGER NOT NULL ,
    id_mat INTEGER NOT NULL ,

    FOREIGN KEY (id_est) REFERENCES estudiantes(id_est),
    FOREIGN KEY (id_mat) REFERENCES materias(id_mat)
);

INSERT INTO inscripcion (semestre, gestion, id_est, id_mat)
VALUES  ('1er Sem',2018,1,1),
        ('2do Sem',2018,1,2),
        ('1er Sem',2019,2,4),
        ('2do Sem',2019,2,3),
        ('2do Sem',2021,3,3),
        ('3er Sem',2023,3,1),
        ('4to Sem',2022,4,4),
        ('5to Sem',2023,5,5);
#    resoucion  ej  2

CREATE OR REPLACE FUNCTION fibonaci(NumerLimit INT)
RETURNS TEXT
BEGIN

  DECLARE num1 INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE num2 INT DEFAULT 1;
  DECLARE result TEXT DEFAULT '';

  SerieFigonaci: LOOP
     IF cont > NumerLimit THEN
          LEAVE SerieFigonaci;
        END IF;

    SET result = CONCAT(result, num2, ',');
    SET num2 = num1 + num2;
    SET num1 = num2 - num1;
    SET cont = cont + 1;

  END LOOP SerieFigonaci;
    RETURN result;
end;

SELECT fibonaci(8);

#    resoucion  ej  3

SET @Variable_gloval = 'HISTORIA DEL MI MUNDO';
SELECT @Variable_gloval;

CREATE OR REPLACE FUNCTION retorna_nombre()
RETURNS TEXT
BEGIN
    RETURN SUBSTR(@Variable_gloval ,-3);
END;

SELECT retorna_nombre();

SET @Limit = 10;
SELECT @Limit;


CREATE OR REPLACE FUNCTION figonaci_2()
RETURNS TEXT
BEGIN
  DECLARE num1 INT DEFAULT 0;
  DECLARE cont INT DEFAULT 1;
  DECLARE num2 INT DEFAULT 1;
  DECLARE result TEXT DEFAULT '';

  SerieFigonaci: LOOP

     IF cont > @Limit THEN
          LEAVE SerieFigonaci;
        END IF;
    SET result = CONCAT(result, num2, ',');
    SET num2 = num1 + num2;
    SET num1 = num2 - num1;
    SET cont = cont + 1;
  END LOOP SerieFigonaci;
    RETURN result;
END;

SELECT figonaci_2();

#    resoucion  ej  4




CREATE OR REPLACE FUNCTION edad_Minima()
RETURNS INT
BEGIN
    DECLARE response INTEGER;
    SELECT MIN(edad) FROM estudiantes INTO response;
RETURN response;
END;

SELECT edad_Minima();
#    DECLARE limite integer default 19;

CREATE OR REPLACE FUNCTION Edad_Minima_bucle()
RETURNS TEXT
BEGIN

    DECLARE response TEXT DEFAULT '';
    DECLARE limite integer default 19;
    DECLARE num INTEGER;

    SELECT MIN(edad) FROM estudiantes INTO limite;

    IF limite%2<=0
    THEN
        SET num = 0;
            WHILE num <= limite DO
                SET response =  CONCAT(response,num,',');
                SET num = num +2;
            end while;
    ELSE
        SET num = 1;
             WHILE num <= limite DO
                SET response =  CONCAT(num,',',response);
                SET num = num + 2;
            end while;
    END IF;
RETURN response;
END;

Select Edad_Minima_bucle();

#    resoucion  ej  5

CREATE OR REPLACE FUNCTION cuenta_vocales(Cadena TEXT)
    RETURNS TEXT
BEGIN

    DECLARE puntero CHAR;
    DECLARE x Int DEFAULT 1;
    DECLARE cont Int DEFAULT 0;
    DECLARE cont2 Int DEFAULT 0;
    DECLARE cont3 Int DEFAULT 0;
    DECLARE cont4 Int DEFAULT 0;
    DECLARE cont5 Int DEFAULT 0;


    WHILE x <= CHAR_LENGTH(Cadena) DO

        SET puntero = SUBSTR(Cadena, x, 1);
            IF puntero = 'a' THEN
                SET cont = cont + 1;
            end if;

            IF puntero = 'e' THEN
                SET cont2 = cont2 + 1;
            END IF;

            IF puntero = 'i' THEN
                SET cont3 = cont3 + 1;
            END IF;

            IF puntero = 'o' THEN
                SET cont4 = cont4 + 1;
            END IF;

            IF puntero = 'u' THEN
                SET cont5 = cont5 + 1;
            END IF;

            SET X = X + 1;
        end while;

    RETURN CONCAT('a:', cont , ' e:', cont2 , ' i:', cont3 , ' o:', cont4 , ' u:',cont5);
end;

select cuenta_vocales('COLEGIATURA DE LA UNIVERSIDAD');

#    resoucion  ej  6

CREATE OR REPLACE FUNCTION Categoria_clienT(credit_number INT)
RETURNS TEXT
BEGIN

    declare response text default '';
        CASE
        WHEN credit_number > 50000
            THEN SET response = 'PLATINIUM';
        WHEN credit_number >= 10000 AND credit_number <= 50000
            THEN SET response = 'GOLD';
        WHEN credit_number < 10000 AND credit_number >=0
            THEN SET response = 'SILVER';
        END CASE;
    RETURN response;
END;

SELECT Categoria_clienT(100000);

#    resoucion  ej  7

CREATE OR REPLACE FUNCTION new_Cad_sinvocales(cadena1 VARCHAR(200), cadena2 VARCHAR(200))
RETURNS TEXT
BEGIN

    DECLARE response TEXT DEFAULT '';
    DECLARE cadena_concatenada TEXT DEFAULT CONCAT(cadena1, '-', cadena2);
    DECLARE puntero CHAR;
    DECLARE contador INTEGER DEFAULT 1;


        WHILE contador <=CHAR_LENGTH(cadena_concatenada) DO
            SET puntero = SUBSTRING(cadena_concatenada,contador,1);


                IF FIND_IN_SET(puntero, 'a,e,i,o,u') > 0  THEN
                    SET contador = contador + 1;
                ELSE
                    IF puntero = ' ' THEN
                        SET contador = contador +1;
                        SET response = CONCAT(response,puntero,' ');
                    ELSE
                        SET contador  = contador +1;
                        SET response = CONCAT(response,puntero);
                    END IF;
                END IF;
        END WHILE;

    RETURN response;
END;

SELECT new_Cad_sinvocales('TALLER DBA II','GESTION 2023');

#    resoucion  ej  8

CREATE OR REPLACE FUNCTION reduccion_cad(Cadena TEXT)
RETURNS TEXT
BEGIN
   DECLARE response TEXT DEFAULT '';
   DECLARE contador INTEGER DEFAULT 0;
   DECLARE puntero TEXT DEFAULT '';

   REPEAT
       SET puntero = substr(Cadena,contador);
       SET response = CONCAT(response,puntero,',');
       SET contador = contador + 1;
   until contador > CHAR_LENGTH(Cadena) end repeat;
  RETURN response;
END;

SELECT reduccion_cad('ARQ IIII');
