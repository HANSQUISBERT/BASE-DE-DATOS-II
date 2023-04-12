create database hito3_2023;

use hito3_2023;

set @usuario = 'ADMIN';

create or replace function variable()
    returns TEXT
begin

    return @usuario;
end;


select variable();

set @HITO_3 = 'ADMIN';

create OR REPLACE FUNCTION verificar()
    returns VARCHAR(50)
begin
    declare respuesta varchar(50);

    CASE
        WHEN @HITO_3 = 'ADMIN' THEN SET respuesta = 'Usuario ADMIN';
        ELSE
            SET respuesta = 'Usuario INVITADO';
        END CASE ;

    RETURN respuesta;

end;


SELECT verificar();

CREATE  FUNCTION numeros_naturales (Limite int)
returns  TEXT
BEGIN
    DECLARE cont INT DEFAULT 1;
    DECLARE respuesta TEXT Default '';

    WHILE CONT <= limite DO
        SET respuesta = CONCAT (respuesta, cont , ',');
        SET cont = cont +1 ;

     END WHILE;
        RETURN respuesta ;

END;
select numeros_naturales(9999);

CREATE  FUNCTION numeros_naturales1 (Limite int)
    returns  TEXT
BEGIN
    DECLARE cont INT DEFAULT 2;
    DECLARE respuesta TEXT Default '';

    WHILE CONT <= limite DO
            SET respuesta = CONCAT (respuesta, cont , ',');
            SET cont = cont +2 ;

        END WHILE;
    RETURN respuesta ;

END;
select numeros_naturales1(3333);
CREATE  FUNCTION numeros_naturalesv3 (Limite int)
    returns  TEXT
BEGIN
    DECLARE pares INT DEFAULT 2;
    DECLARE impares TEXT Default 1;
    DECLARE cont INT DEFAULT 1;
    DECLARE respuesta TEXT DEFAULT '';

    WHILE CONT <= limite DO
            if cont % 2 = 1 then
                set respuesta =  concat(respuesta, pares, ',');
                set  pares = pares +2 ;
                ELSE
                SET respuesta = concat (respuesta,impares, ',');
                SET impares = impares +2;
            end if;
            SET cont = cont +1;

        END WHILE;
    RETURN respuesta  ;
END;
select numeros_naturalesv3(3333);
