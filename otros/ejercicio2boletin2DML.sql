CREATE TABLE DEPARTAMENTO
(
	CODIGO NUMBER(10),
	NOMBRE VARCHAR2(100),
	PRESUPUESTO NUMBER(10,2),
	GASTOS NUMBER(10,2),
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY(CODIGO)
);

CREATE TABLE EMPLEADO
(
	CODIGO NUMBER(10),
	NIF VARCHAR2(9),
	NOMBRE VARCHAR2(100),
	APELLIDO1 VARCHAR2(100),
	APELLIDO2 VARCHAR2(100),
	CODIGO_DEPARTAMENTO NUMBER(10),
	CONSTRAINT PK_EMPLEADO PRIMARY KEY(CODIGO),
	CONSTRAINT FK_EMPLEADO FOREIGN KEY(CODIGO_DEPARTAMENTO) REFERENCES DEPARTAMENTO(CODIGO)
);



CREATE SEQUENCE SEC_COD_DEP
START WITH 1
INCREMENT BY 1;

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'DESARROLLO', 120000, 6000);

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'SISTEMAS', 150000, 21000);

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'RECURSOS HUMANOS', 280000, 25000);

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'CONTABILIDAD', 110000, 3000);

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'I+D', 375000, 380000);

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'PROYECTOS', 0, 0);

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'PUBLICIDAD', 0, 1000);

SELECT * FROM DEPARTAMENTO d ;



CREATE SEQUENCE SEC_COD_EMP
START WITH 1
INCREMENT BY 1;

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL, '32481596F','AARÓN','RIVERO','GÓMEZ',1);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL, 'Y5575632D','ADELA','SALAS','DÍAZ',2);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL, 'R6970642B','ADOLFO','RUBIO','FLORES',3);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL, '77705545E','ADRIÁN','SUÁREZ',NULL, 4);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'38382980M', 'María', 'Santana', 'Moreno', 1);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'80576669X', 'Pilar', 'Ruiz', NULL, 2);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL , '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'56399183D', 'Juan', 'Gómez', 'López', 2);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'46384486H', 'Diego','Flores', 'Salas', 5);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'67389283A', 'Marta','Herrera', 'Gil', 1);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'41234836R', 'Irene','Salas', 'Flores', NULL);

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL,'82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);

SELECT * FROM EMPLEADO e ;


----------------------------------------------------------------------------------------------------


--1. Inserta un nuevo departamento indicando su código, nombre y presupuesto.--

INSERT INTO DEPARTAMENTO d (CODIGO, NOMBRE, PRESUPUESTO)
VALUES (SEC_COD_DEP.NEXTVAL, 'MANTENIMIENTO', 75000);

SELECT * FROM DEPARTAMENTO d ;

--2. Inserta un nuevo departamento indicando su nombre y presupuesto.--

INSERT INTO DEPARTAMENTO d (NOMBRE, PRESUPUESTO)
VALUES ('SOSTENIBILIDAD', 80000);/*NO SE PUEDE AÑADIR YA QUE FALTA LA PK*/

--3. Inserta un nuevo departamento indicando su código, nombre, presupuesto y gastos.--

INSERT INTO DEPARTAMENTO d 
VALUES (SEC_COD_DEP.NEXTVAL, 'DIGITALIZACIÓN', 210000, 162400);

SELECT * FROM DEPARTAMENTO d ;

--4. Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe incluir: código, nif, nombre, apellido1, apellido2 y codigo_departamento.--

INSERT INTO EMPLEADO e 
VALUES (SEC_COD_EMP.NEXTVAL, '32453453R', 'PEDRO','ROMERO','MARTINEZ',9);

--5. Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe incluir: nif, nombre, apellido1, apellido2 y codigo_departamento.--

INSERT INTO EMPLEADO e (NIF, NOMBRE, APELLIDO1, APELLIDO2, CODIGO_DEPARTAMENTO)
VALUES ('4543534G', 'MANUEL','ARROYO','GRIMARET',8);

--6. Crea una nueva tabla con el nombre departamento_backup que tenga las mismas columnas que la tabla departamento. Una vez creada copia todos las filas de tabla departamento en departamento_backup.--

CREATE TABLE DEPARTAMENTO_BACKUP AS SELECT * FROM DEPARTAMENTO d ;

--7. Elimina el departamento Proyectos. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?--

DELETE FROM DEPARTAMENTO d 
WHERE NOMBRE LIKE 'PROYECTOS';

--8. Elimina el departamento Desarrollo. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?--
UPDATE EMPLEADO 
SET CODIGO_DEPARTAMENTO = NULL
WHERE CODIGO_DEPARTAMENTO = (SELECT CODIGO FROM DEPARTAMENTO 
WHERE CODIGO = 1);

DELETE FROM DEPARTAMENTO d 
WHERE NOMBRE LIKE 'DESARROLLO';

--9. Actualiza el código del departamento Recursos Humanos y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?--

UPDATE EMPLEADO 
SET CODIGO_DEPARTAMENTO = NULL 
WHERE CODIGO_DEPARTAMENTO = (SELECT CODIGO FROM DEPARTAMENTO d
WHERE CODIGO = 3);

UPDATE DEPARTAMENTO 
SET CODIGO = 30
WHERE NOMBRE LIKE 'RECURSOS HUMANOS';

--10.Actualiza el código del departamento Publicidad y asígnale el valor 40. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?--

UPDATE DEPARTAMENTO 
SET CODIGO = 40
WHERE NOMBRE LIKE 'PUBLICIDAD';

--11.Actualiza el presupuesto de los departamentos sumándole 50000 € al valor del presupuesto actual, solamente a aquellos departamentos que tienen un presupuesto menor que 20000 €.--

UPDATE DEPARTAMENTO 
SET PRESUPUESTO = PRESUPUESTO + 50000
WHERE PRESUPUESTO < 20000;

--12.Realiza una transacción que elimine todas los empleados que no tienen un departamento asociado.--

DELETE FROM EMPLEADO e 
WHERE CODIGO_DEPARTAMENTO = NULL;






















