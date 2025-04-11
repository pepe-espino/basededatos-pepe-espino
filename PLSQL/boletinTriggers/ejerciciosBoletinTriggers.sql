--7.1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre
--una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
--número y nombre de empleado, así como el tipo de operación realizada
--(INSERCIÓN o ELIMINACIÓN).

CREATE TABLE AUDITORIA_EMPLEADOS (descripcion VARCHAR2(200));


CREATE OR REPLACE TRIGGER BOLETINTRIGGERS.trigger1
AFTER INSERT OR DELETE ON Empleados
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		INSERT INTO AUDITORIA_EMPLEADOS (descripcion)
  		VALUES ('Fecha: '|| TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:mm:ss') ||', numero de empleado: ' || :NEW.NUMEM || ', nombre empleado: '|| :NEW.NOMEM || ', operación: INSERT');
	ELSIF DELETING THEN
		INSERT INTO AUDITORIA_EMPLEADOS (descripcion)
  		VALUES ('Fecha: '|| TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:mm:ss') ||', numero de empleado: ' || :OLD.NUMEM || ', nombre empleado: '|| :OLD.NOMEM || ', operación: DELETING');
  	END IF;
END trigger1;

INSERT INTO EMPLEADOS VALUES(1,1, SYSDATE,SYSDATE, 1, 1, 1, 'prueba', 100); 

SELECT * FROM EMPLEADOS e ;

SELECT * FROM AUDITORIA_EMPLEADOS ae ;

--7.2. Crea un trigger que, cada vez que se modifiquen datos de un empleado,
--registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del
--suceso, valor antiguo y valor nuevo de cada campo, así como el tipo de operación
--realizada (en este caso MODIFICACIÓN).

CREATE OR REPLACE
TRIGGER trigger2
AFTER update ON Empleados
FOR EACH ROW
BEGIN
	INSERT INTO AUDITORIA_EMPLEADOS (descripcion)
  	VALUES ('Fecha: ' || SYSDATE ||', antiguo datos de empleado: '|| :OLD.empleados.* || ', nuevos datos de empleado: '|| :new.empleados.* || ', operación: INSERT');
END;

-- PONER CADA DATO PARA QUE FUNCIONE, NO FUNCIONA EL * --


UPDATE INTO EMPLEADOS VALUES(1,1,SYSDATE,SYSDATE,1,NULL,3,'CESAR',1); 


--7.3. Crea un trigger para que registre en la tabla AUDITORIA_EMPLEADOS las
--subidas de salarios superiores al 5%. 

CREATE OR REPLACE
TRIGGER trigger3
AFTER update ON Empleados
FOR EACH ROW
BEGIN
	IF NEW.EMPLEADO.SALAR > OLD.EMPLEADO.SALAR*1.05 THEN
		INSERT INTO AUDITORIA_EMPLEADOS (DESCRIPCION)
  		VALUES ('Fecha: 'SYSDATE ||', numero de empleado: ' EMPLEADO.NUMEM || ', nombre empleado: 'EMPLEADO.NOMEM);
END;



--7.4. Deseamos operar sobre los datos de los departamentos y los centros donde
--se hallan. Para ello haremos uso de la vista SEDE_DEPARTAMENTOS creada
--anteriormente. Al tratarse de una vista que involucra más de una tabla,
--necesitaremos crear un trigger de sustitución para gestionar las operaciones de
--actualización de la información. Crea el trigger necesario para realizar inserciones,
--eliminaciones y modi(caciones en la vista anterior.


CREATE VIEW SEDE_DEPARTAMENTOS AS
SELECT C.NUMCE, C.NOMCE, C.DIRCE,
 	D.NUMDE, D.NOMDE, D.PRESU, D.DIREC, D.TIDIR, D.DEPDE
FROM CENTROS C JOIN DEPARTAMENTOS D ON C.NUMCE=D.NUMCE;



CREATE OR REPLACE
TRIGGER trigger_sede_dep
INSTEAD OF INSERT OR UPDATE OR DELETE ON SEDE_DEPARTAMENTOS
FOR EACH ROW
BEGIN
	INSERT INTO CENTROS c 
	VALUES(:NEW.NUMCE, :NEW.NOMCE, :NEW.DIRCE);

	INSERT INTO DEPARTAMENTOS d (NUMDE,NUMCE, NOMDE, PRESU, DIREC, TIDIR, DEPDE)
	VALUES (:NEW.NUMDE,:NEW.NUMCE, :NEW.NOMDE, :NEW.PRESU, :NEW.DIREC, :NEW.TIDIR, :NEW.DEPDE);
END;


-- Inserción de datos
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (30, 310, 'NUEVO1');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (31, 320, 'NUEVO2');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (32, 330, 'NUEVO3');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (20, 340, 'NUEVO4');


INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (50, 500, 'NUEVO5');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (51, 501, 'NUEVO6');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (52, 502, 'NUEVO7');
INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (53, 503, 'NUEVO8');


INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (58, 603, 'NUEVO45546');

INSERT INTO SEDE_DEPARTAMENTOS (NUMCE, NUMDE, NOMDE)
VALUES (59, 604, 'NUEVO455467');


SELECT * FROM CENTROS;
SELECT * FROM DEPARTAMENTOS;
-- Borrado de datos
DELETE FROM SEDE_DEPARTAMENTOS WHERE NUMDE=310;
SELECT * FROM SEDE_DEPARTAMENTOS;
DELETE FROM SEDE_DEPARTAMENTOS WHERE NUMCE=30;
SELECT * FROM SEDE_DEPARTAMENTOS;
-- Modificación de datos
UPDATE SEDE_DEPARTAMENTOS
SET NOMDE='CUENTAS', TIDIR='F', NUMCE=20 WHERE NOMDE='FINANZAS';
SELECT * FROM DEPARTAMENTOS;
UPDATE SEDE_DEPARTAMENTOS
SET NOMDE='FINANZAS', TIDIR='P', NUMCE=10 WHERE NOMDE='CUENTAS';
SELECT * FROM DEPARTAMENTOS;


UPDATE SEDE_DEPARTAMENTOS 
SET NUMDE=504, DIREC=480, TIDIR='F', PRESU=80, DEPDE=105 WHERE NUMDE=501;




