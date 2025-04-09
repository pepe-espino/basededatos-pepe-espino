--7.1. Crea un trigger que, cada vez que se inserte o elimine un empleado, registre
--una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del suceso,
--número y nombre de empleado, así como el tipo de operación realizada
--(INSERCIÓN o ELIMINACIÓN).

CREATE TABLE AUDITORIA_EMPLEADOS (descripcion VARCHAR2(200));

CREATE VIEW SEDE_DEPARTAMENTOS AS
SELECT C.NUMCE, C.NOMCE, C.DIRCE,
 	D.NUMDE, D.NOMDE, D.PRESU, D.DIREC, D.TIDIR, D.DEPDE
FROM CENTROS C JOIN DEPARTAMENTOS D ON C.NUMCE=D.NUMCE;

INSERT INTO DEPARTAMENTOS VALUES (0, 10, 260, 'F', 10, 100, 'TEMP');

CREATE OR REPLACE
TRIGGER trigger1
AFTER INSERT OR DELETE ON Empleados
BEGIN
	IF INSERTING THEN
		INSERT INTO AUDITORIA_EMPLEADOS (DESCRIPCION)
  		VALUES ('Fecha: 'SYSDATE ||', numero de empleado: ' EMPLEADO.NUMEM || ', nombre empleado: 'EMPLEADO.NOMEM || ', operación: INSERT');
	ELSIF DELETING THEN
		INSERT INTO AUDITORIA_EMPLEADOS (DESCRIPCION)
  		VALUES ('Fecha: 'SYSDATE ||', numero de empleado: ' EMPLEADO.NUMEM || ', nombre empleado: 'EMPLEADO.NOMEM || ', operación: DELETING');
END Control_Empleados;

INSERT INTO EMPLEADOS VALUES(560,900,'11/10/1970', '02/15/1985', 2000, 110, 2, 'PEPE', 121); 


--7.2. Crea un trigger que, cada vez que se modifiquen datos de un empleado,
--registre una entrada en la tabla AUDITORIA_EMPLEADOS con la fecha del
--suceso, valor antiguo y valor nuevo de cada campo, así como el tipo de operación
--realizada (en este caso MODIFICACIÓN).

CREATE OR REPLACE
TRIGGER trigger2
AFTER update ON Empleados
BEGIN
	INSERT INTO AUDITORIA_EMPLEADOS (DESCRIPCION)
  	VALUES ('Fecha: 'SYSDATE ||', antiguo datos de empleado: ' OLD.empleados.* || ', nuevos datos de empleado: ' new.empleados.* || ', operación: INSERT');
END Control_Empleados;

UPDATE INTO EMPLEADOS VALUES(900,350,'11/10/1971','02/15/1985',1850,NULL,3,'CESAR G.',121); 


--7.3. Crea un trigger para que registre en la tabla AUDITORIA_EMPLEADOS las
--subidas de salarios superiores al 5%. 

CREATE OR REPLACE
TRIGGER trigger3
AFTER update ON Empleados
BEGIN
	IF NEW.EMPLEADO.SALAR > OLD.EMPLEADO.SALAR*1.05 THEN
		INSERT INTO AUDITORIA_EMPLEADOS (DESCRIPCION)
  		VALUES ('Fecha: 'SYSDATE ||', numero de empleado: ' EMPLEADO.NUMEM || ', nombre empleado: 'EMPLEADO.NOMEM);
END Control_Empleados;




























