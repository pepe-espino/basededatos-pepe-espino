--7.1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre
--una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
--número y nombre de empleado, así como el tipo de operación realizada
--(INSERCIÓN o ELIMINACIÓN).

CREATE TABLE AUDITORIA_EMPLEADOS (descripcion VARCHAR2(200));

CREATE VIEW SEDE_DEPARTAMENTOS AS
SELECT C.NUMCE, C.NOMCE, C.DIRCE,
 	D.NUMDE, D.NOMDE, D.PRESU, D.DIREC, D.TIDIR, D.DEPDE
FROM CENTROS C JOIN DEPARTAMENTOS D ON C.NUMCE=D.NUMCE;


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




























