--alter session set "_oracle_script"=true;  
--create user boletin1_recuperacion_jaed identified by boletin1_recuperacion_jaed;
--GRANT CONNECT, RESOURCE, DBA TO boletin1_recuperacion_jaed;


---------------------------------------------------------------
--------------- CREACION DE TABLAS ----------------------------


CREATE TABLE TIPO_PIEZA
(
	TIPO VARCHAR2(2),
	DESCRIPCION VARCHAR2(25),
	CONSTRAINT PK_TIPO_PIEZA PRIMARY KEY(TIPO)
);

CREATE TABLE PIEZA
(
	MODELO NUMBER(2),
	TIPO VARCHAR2(2),
	PRECIO_VENTA NUMBER(11,4),
	CONSTRAINT PK_PIEZA PRIMARY KEY(MODELO, TIPO),
	CONSTRAINT FK_PIEZA FOREIGN KEY(TIPO) REFERENCES TIPO_PIEZA(TIPO)
);

CREATE TABLE EMPRESA
(
	CIF VARCHAR2(9),
	NOMBRE VARCHAR2(50),
	TELEFONO NUMBER(11,4),
	DIRECCION VARCHAR2(50),
	LOCALIDAD VARCHAR2(50),
	PROVINCIA VARCHAR2(50),
	CONSTRAINT PK_EMPRESA PRIMARY KEY(CIF)
);

CREATE TABLE SUMINISTRO
(
	CIF VARCHAR(9),
	MODELO NUMBER(2),
	TIPO VARCHAR2(2),
	PRECIO_COMPRA NUMBER(11,4),
	CONSTRAINT PK_SUMINISTRO PRIMARY KEY(CIF, MODELO, TIPO),
	CONSTRAINT FK1_SUMINISTRO FOREIGN KEY(CIF) REFERENCES EMPRESA(CIF),
	CONSTRAINT FK2_SUMINISTRO FOREIGN KEY(MODELO, TIPO) REFERENCES PIEZA(MODELO, TIPO)
);

CREATE TABLE ALMACEN
(
	N_ALMACEN NUMBER(2),
	DESCRIPCION VARCHAR2(1000),
	DIRECCION VARCHAR2(100),
	CONSTRAINT PK_ALMACEN PRIMARY KEY(N_ALMACEN)
);

CREATE TABLE EXISTENCIA
(
	MODELO NUMBER(2),
	TIPO VARCHAR2(2),
	N_ALMACEN NUMBER(2),
	CANTIDAD NUMBER(9),
	CONSTRAINT PK_EXISTENCIA PRIMARY KEY(MODELO, TIPO, N_ALMACEN),
	CONSTRAINT FK1_EXISTENCIA FOREIGN KEY(MODELO, TIPO) REFERENCES PIEZA(MODELO, TIPO),
	CONSTRAINT FK2_EXISTENCIA FOREIGN KEY(N_ALMACEN) REFERENCES ALMACEN(N_ALMACEN)
);

CREATE TABLE DEPARTAMENTO
(
	NUM_DEP NUMBER(3),
	NOMBRE VARCHAR2(50),
	CONSTRAINT PK_DEP PRIMARY KEY(NUM_DEP)
);

CREATE TABLE EMPLEADO 
(
	EMPNO NUMBER(3),
	APELLIDO VARCHAR2(50),
	SALARIO NUMBER(6,2),
	OFICIO VARCHAR2(50),
	FECHA_ALTA DATE,
	N_ALMACEN NUMBER(2),
	NUM_DEP NUMBER(3),
	CONSTRAINT PK_EMP PRIMARY KEY(EMPNO),
	CONSTRAINT FK1_EMP FOREIGN KEY(N_ALMACEN) REFERENCES ALMACEN(N_ALMACEN),
	CONSTRAINT FK2_EMP FOREIGN KEY(NUM_DEP) REFERENCES DEPARTAMENTO(NUM_DEP)
);


----------------------------------------------------------------
----------------------- INSERTS --------------------------------

DELETE FROM PIEZA p;
DELETE FROM TIPO_PIEZA tp ;
DELETE FROM EMPLEADO e ;
DELETE FROM EMPRESA e ;
DELETE FROM ALMACEN a ;
DELETE FROM SUMINISTRO ;
DELETE FROM EXISTENCIA e ;
DELETE FROM DEPARTAMENTO d ;


INSERT INTO TIPO_PIEZA VALUES ('MO', 'Motor');
INSERT INTO TIPO_PIEZA VALUES ('RU', 'Rueda');
INSERT INTO TIPO_PIEZA VALUES ('FR', 'Freno');

INSERT INTO PIEZA VALUES (10, 'MO', 1200.50);
INSERT INTO PIEZA VALUES (20, 'RU', 150.00);
INSERT INTO PIEZA VALUES (30, 'FR', 85.75);

INSERT INTO EMPRESA VALUES ('A12345678', 'MotoRecambios S.A.', 9541234, 'Calle Moto 1', 'Sevilla', 'Sevilla');
INSERT INTO EMPRESA VALUES ('B87654321', 'Ruedas y Más S.L.', 9116543, 'Av. Neumáticos 22', 'Madrid', 'Madrid');

INSERT INTO SUMINISTRO VALUES ('A12345678', 10, 'MO', 1000.00);
INSERT INTO SUMINISTRO VALUES ('B87654321', 20, 'RU', 120.00);
INSERT INTO SUMINISTRO VALUES ('A12345678', 30, 'FR', 60.00);

INSERT INTO ALMACEN VALUES (1, 'Almacén central', 'Polígono Industrial 12, Sevilla');
INSERT INTO ALMACEN VALUES (2, 'Almacén secundario', 'Calle Logística 45, Madrid');

INSERT INTO EXISTENCIA VALUES (10, 'MO', 1, 50);
INSERT INTO EXISTENCIA VALUES (20, 'RU', 1, 100);
INSERT INTO EXISTENCIA VALUES (30, 'FR', 2, 75);

INSERT INTO DEPARTAMENTO VALUES (20, 'Logística');
INSERT INTO DEPARTAMENTO VALUES (40, 'Mantenimiento');

INSERT INTO EMPLEADO VALUES (127, 'García', 1800.50, 'Mecánico', TO_DATE('2022-04-15', 'YYYY-MM-DD'), 1, 20);
INSERT INTO EMPLEADO VALUES (128, 'López', 1950.00, 'Encargado', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 1, 20);
INSERT INTO EMPLEADO VALUES (129, 'Pérez', 1700.00, 'Repartidor', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 2, 40);
INSERT INTO EMPLEADO VALUES (130, 'Morales', 1150.00, 'Repartidor', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 2, 40);


----------------------------------------------------------------
----------------------- EJERCICIO 1 ----------------------------
----------------------------------------------------------------

/*
 
 1.Realiza los siguientes cursores (implícitos o explícitos)
a) Realiza un bloque de programa en PL-SQL que visualice el apellido y el oficio del
empleado decódigo 127.
b) Crea un bloque de programa que visualice los apellidos de los empleados
pertenecientes al departamento 20.
 
*/


-- a)


DECLARE

V_APELLIDO VARCHAR2(50);
V_OFICIO VARCHAR2(50);

BEGIN
	
	SELECT E.APELLIDO, E.OFICIO INTO V_APELLIDO , V_OFICIO
	FROM EMPLEADO e WHERE E.EMPNO = 127;

	DBMS_OUTPUT.PUT_LINE('EL EMPLEADO CON CÓDIGO 127 SE APELLIDA '|| V_APELLIDO || ' Y ES ' || V_OFICIO);
	
END;


-- b)

DECLARE

	CURSOR C_EMPLEADOS IS
	SELECT * FROM EMPLEADO e 
	WHERE E.NUM_DEP = 20;

BEGIN
	
	FOR E IN C_EMPLEADOS LOOP 
		DBMS_OUTPUT.PUT_LINE(E.APELLIDO|| ' TRABAJA EN EL DEPARTAMENTO 20.');
	END LOOP;
	
END;

----------------------------------------------------------------
----------------------- EJERCICIO 2 ----------------------------
----------------------------------------------------------------


/*
 
2. Usando un cursor escribe un bloque PL/SQL que visualice el apellido y la fecha de alta de
todos los empleados ordenados por fecha de alta
 
*/


DECLARE

	CURSOR C_EMP_ALTA IS
	SELECT * FROM EMPLEADO e
	ORDER BY E.FECHA_ALTA;

BEGIN
	
	FOR E IN C_EMP_ALTA LOOP
		DBMS_OUTPUT.PUT_LINE('EL EMPLEADO '|| UPPER(E.APELLIDO) || ' SE DIO DE ALTA EL '|| E.FECHA_ALTA);
	END LOOP;
	
END;


----------------------------------------------------------------
----------------------- EJERCICIO 3 ----------------------------
----------------------------------------------------------------


/*
 
3. Crea un trigger que impida que se agregue o modifique un empleado con el sueldo mayor o
menor que los valores máximo y mínimo respectivamente para su cargo. Se agrega la
restricción de que el trigger no se disparará si el oficio es PRESIDENTE.
 
*/


CREATE OR REPLACE TRIGGER T_EMPSUELDO 
BEFORE INSERT ON EMPLEADO
FOR EACH ROW
DECLARE 
	V_SALARIOMIN NUMBER(6,2);
	V_SALARIOMAX NUMBER(6,2);
BEGIN 
	
	SELECT MAX(EM.SALARIO), MIN(EM.SALARIO) 
	INTO V_SALARIOMAX, V_SALARIOMIN
	FROM EMPLEADO em
	WHERE EM.OFICIO = :NEW.OFICIO;	

	IF (:NEW.SALARIO < V_SALARIOMIN OR :NEW.SALARIO > V_SALARIOMAX) AND :NEW.OFICIO != 'PRESIDENTE' THEN
		
		RAISE_APPLICATION_ERROR(-20001, 'EL SALARIO NO PUEDE SUPERAR EL VALOR MÁXIMO NI EL VALOR MÍNIMO.');
	
	END IF;
	
END;


------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

--MAXIMOS Y MINIMOS

SELECT MAX(E.SALARIO), MIN(E.SALARIO) 
FROM EMPLEADO e
WHERE UPPER(E.OFICIO) = 'REPARTIDOR'; 

SELECT *
FROM EMPLEADO e
WHERE UPPER(E.OFICIO) = 'REPARTIDOR'; 

-- UNA VEZ COMPROBAMOS LOS VALORES MÁXIMOS Y MÍNIMOS QUEDA ESTABLECIDO QUE 
-- PARA REPARTIDOR EL MAX ES 1700 Y MIN 1150

--CASO VALIDO
INSERT INTO EMPLEADO VALUES (131, 'Flores', 1300.00, 'Repartidor', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 2, 40);

--CASO ERRÓNEO LIMITE SUPERIOR, SALTA ERROR
INSERT INTO EMPLEADO VALUES (132, 'Espino', 9000.00, 'Repartidor', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 2, 40);

--CASO ERRÓNEO LIMITE INFERIOR, SALTA ERROR
INSERT INTO EMPLEADO VALUES (133, 'Cabeza', 1000.00, 'Repartidor', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 2, 40);



----------------------------------------------------------------
----------------------- EJERCICIO 4 ----------------------------
----------------------------------------------------------------

	
/*
 
4. Crea triggers que permitan actualizar en cascada el campo tipo de la tabla tipos_pieza en
caso de que sea modificado con una instrucción UPDATE.
Propaga esa actualización por las tablas piezas, existencias y suministros (harán falta
varios triggers).
 
*/


CREATE OR REPLACE TRIGGER T_UPDATE_TIPO
AFTER UPDATE OF TIPO ON TIPO_PIEZA
FOR EACH ROW
BEGIN
	
    UPDATE PIEZA
    SET TIPO = :NEW.TIPO
    WHERE TIPO = :OLD.TIPO;

    UPDATE EXISTENCIA
    SET TIPO = :NEW.TIPO
    WHERE TIPO = :OLD.TIPO;

    UPDATE SUMINISTRO
    SET TIPO = :NEW.TIPO
    WHERE TIPO = :OLD.TIPO;

    
END;

------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

-- PRIMERO DEBEMOS ELIMINAR TEMPORALMENTE LAS CONSTRAINTS YA QUE NO SE PUEDEN MODIFICAR LAS PK QUE SON FK EN OTRA TABLA

ALTER TABLE PIEZA DROP CONSTRAINT FK_PIEZA;
ALTER TABLE SUMINISTRO DROP CONSTRAINT FK2_SUMINISTRO;
ALTER TABLE EXISTENCIA DROP CONSTRAINT FK1_EXISTENCIA;

-- A CONTINUACION EJECUTAMOS EL UPDATE PARA VER SI FUNCIONA EL TRIGGER

UPDATE TIPO_PIEZA
SET TIPO = 'MT'
WHERE TIPO = 'MO';

-- VOLVEMOS A CREAR LAS CONSTRAINTS PARA UNIR LAS TABLAS
	    
ALTER TABLE PIEZA
ADD CONSTRAINT FK_PIEZA FOREIGN KEY (TIPO) REFERENCES TIPO_PIEZA(TIPO);

ALTER TABLE SUMINISTRO
ADD CONSTRAINT FK2_SUMINISTRO FOREIGN KEY (MODELO, TIPO) REFERENCES PIEZA(MODELO, TIPO);
	
ALTER TABLE EXISTENCIA
ADD CONSTRAINT FK1_EXISTENCIA FOREIGN KEY (MODELO, TIPO) REFERENCES PIEZA(MODELO, TIPO);

-- COMPROBAMOS QUE SE HAN ACTUALIZADO TODOS LOS DATOS

SELECT TIPO FROM PIEZA p ;
SELECT TIPO FROM SUMINISTRO s ;
SELECT TIPO FROM EXISTENCIA e ;



----------------------------------------------------------------
----------------------- EJERCICIO 5 ----------------------------
----------------------------------------------------------------


/*

5. Crea una tabla llamada suministros_audit con los campos tipo de pieza, modelo de pieza, cif,
precio viejo, precio nuevo y fecha (todos con los mismos tipos de datos que los equivalentes en
la tabla suministros).
Consigue que cada vez que se modifica un precio en la tabla suministros se almacene un
registros en la tabla suministros_audit con el precio viejo, el nuevo y la fecha del cambio.

*/

CREATE TABLE SUMINISTRO_AUDIT
(
	CIF VARCHAR(9),
	MODELO NUMBER(2),
	TIPO VARCHAR2(2),
	PRECIO_COMPRA_ANTIGUO NUMBER(11,4),
	PRECIO_COMPRA_NUEVO NUMBER(11,4),
	FECHA_CAMBIO DATE,
	CONSTRAINT PK_SUMINISTRO_AUDIT PRIMARY KEY(CIF, MODELO, TIPO)
);


CREATE OR REPLACE TRIGGER T_SUMIN_AUDIT
AFTER UPDATE OF PRECIO_COMPRA ON SUMINISTRO
FOR EACH ROW 
BEGIN 
	
	INSERT INTO SUMINISTRO_AUDIT sa (CIF ,MODELO,TIPO,PRECIO_COMPRA_ANTIGUO,PRECIO_COMPRA_NUEVO ,FECHA_CAMBIO)
	VALUES (:OLD.CIF, :OLD.MODELO, :OLD.TIPO, :OLD.PRECIO_COMPRA, :NEW.PRECIO_COMPRA, SYSDATE);
	
END;

------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

SELECT * FROM SUMINISTRO s ;

SELECT * FROM SUMINISTRO_AUDIT sa ;

--COMPROBAMOS PRIMERO LAS TABLAS, Y EJECUTAMOS EL UPDATE

UPDATE SUMINISTRO s SET PRECIO_COMPRA = 2000
WHERE s.MODELO = 10 AND S.CIF = 'A12345678' AND S.TIPO = 'MT';

-- UNA VEZ ACTUALIZADO COMPROBAMOS SI SE HAN INSERTADO LOS CAMBIOS

SELECT * FROM SUMINISTRO_AUDIT sa ;



----------------------------------------------------------------
----------------------- EJERCICIO 6 ----------------------------
----------------------------------------------------------------


/*

6. Crear un trigger para la tabla de piezas que prohíba modificar el precio de venta de una pieza
a un precio más pequeño que el del menor precio de compra para esa pieza (debe provocar un
error si se produce esa situación, la modificación del precio no se realizará)

*/


CREATE OR REPLACE TRIGGER T_PRECIO_PIEZA
BEFORE UPDATE OF PRECIO_VENTA ON PIEZA
FOR EACH ROW
DECLARE
	V_PRECIOMIN NUMBER(11,4);
	V_PRECIOMAX NUMBER(11,4);
BEGIN
	
	SELECT MAX(P.PRECIO_VENTA), MIN(P.PRECIO_VENTA)
	INTO V_PRECIOMAX, V_PRECIOMIN
	FROM PIEZA p 
	WHERE P.MODELO = :NEW.MODELO AND p.TIPO = :NEW.TIPO;
	
	IF :NEW.PRECIO_VENTA > V_PRECIOMAX OR :NEW.PRECIO_VENTA < V_PRECIOMIN THEN
		RAISE_APPLICATION_ERROR(-20002, 'EL PRECIO DE VENTA NO PUEDE SER MAYOR NI MENOR A LOS LIMITES ESTABLECIDOS');
	END IF;
	
	
END;

------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

SELECT * FROM PIEZA;

--HACEMOS EL INSERT DENTRO DE LOS LÍMITES PARA LUEGO MODIFICARLO
INSERT INTO PIEZA VALUES(40, 'RU', 500);

--EJECUTAMOS EL UPDATE

UPDATE PIEZA p SET PRECIO_venta = 1300
WHERE p.MODELO = 40 AND p.TIPO = 'RU';

--UNA VEZ ACTUALIZADO VEMOS QUE SI NO HA SALTADO LA EXCEPCION EL PRECIO ESTÁ ACTUALIZADO

SELECT * FROM PIEZA;



----------------------------------------------------------------
----------------------- EJERCICIO 7 ----------------------------
----------------------------------------------------------------


/*

7. Visualiza mediante un procedimiento los apellidos de los empleados de un departamento
cualquiera. Usa un cursor con variables de acoplamiento.

*/

CREATE OR REPLACE PROCEDURE APELLIDOS_EN_DEPT (P_NUM_DEP IN NUMBER) 
IS 
	CURSOR C_EMPLEADOS IS
	SELECT * FROM EMPLEADO e
	WHERE E.NUM_DEP = P_NUM_DEP;
	
BEGIN 
	
	DBMS_OUTPUT.PUT_LINE('Empleados en el departamento '||P_NUM_DEP|| ':');
	
	FOR C IN C_EMPLEADOS LOOP
		
		DBMS_OUTPUT.PUT_LINE(C.APELLIDO);
		
	END LOOP;
	
END;

BEGIN
	APELLIDOS_EN_DEPT(40);
END;


----------------------------------------------------------------
----------------------- EJERCICIO 8 ----------------------------
----------------------------------------------------------------


/*

8. Visualiza utilizando un WHILE un bloque PL/SQL que visualice el apellido y la fecha de alta de
todos los empleados ordenados por fecha de alta.
Crea posteriormente un bloque PL/SQL que realice lo mismo, pero usando un cursor
“FOR..LOOP”. Usa la tabla EMPLEADOS (emp_no, apellido, salario, num_dep, fecha_alta)

*/

DECLARE

	CURSOR C_EMP IS
	SELECT * FROM EMPLEADO e;
	
	V_EMPNO  EMPLEADO.EMPNO%TYPE;
  	V_APELLIDO  EMPLEADO.APELLIDO%TYPE;
  	V_SALARIO EMPLEADO.SALARIO%TYPE;
  	V_OFICIO EMPLEADO.OFICIO%TYPE;
  	V_FECHA_ALTA EMPLEADO.FECHA_ALTA%TYPE;
   	V_N_ALMACEN EMPLEADO.N_ALMACEN%TYPE;
    V_NUM_DEP EMPLEADO.NUM_DEP%TYPE;

BEGIN
  OPEN C_EMP;

  FETCH C_EMP INTO V_EMPNO, V_APELLIDO, V_SALARIO, V_OFICIO, V_FECHA_ALTA, V_N_ALMACEN, V_NUM_DEP;

  WHILE C_EMP%FOUND 
  LOOP
    DBMS_OUTPUT.PUT_LINE('EMPNO: ' || V_EMPNO ||
                         ', APELLIDO: ' || V_APELLIDO ||
                         ', SALARIO: ' || V_SALARIO ||
                         ', OFICIO: ' || V_OFICIO ||
                         ', FECHA_ALTA: ' || V_FECHA_ALTA||
                         ', N_ALMACEN: ' || V_N_ALMACEN ||
                         ', NUM_DEP: ' || V_NUM_DEP);

  FETCH C_EMP INTO V_EMPNO, V_APELLIDO, V_SALARIO, V_OFICIO, V_FECHA_ALTA, V_N_ALMACEN, V_NUM_DEP;
  END LOOP;

  CLOSE C_EMP;
END;


DECLARE
	CURSOR C_EMP IS
	SELECT * FROM EMPLEADO e ;
BEGIN
	
	FOR C IN C_EMP LOOP
		DBMS_OUTPUT.PUT_LINE(C.APELLIDO);
	END LOOP;
	
END;


----------------------------------------------------------------
----------------------- EJERCICIO 9 ----------------------------
----------------------------------------------------------------


/*

9. Realizar una función que reciba como parámetro el nombre y el apellido de un empleado,
también debe recibir un parámetro que podrá ser un uno (debe insertarlo un empleado) o un
dos (debe borrar al empleado cuyo nombre y apellido coincidan). La función deberá devolver un
1 si se ha podido realizar la inserción, y un cero si ha ocurrido algún error. Pon el bloque anónimo
donde pruebes la ejecución de la función para las distintas casuísticas y muestra por consola los
valores

*/

-- EN VEZ DEL NOMBRE DEL EMPLEADO, VOY A INTRODUCIR POR PARAMETRO EL NUMERO DE EMPLEADO Y EL APELLIDO
-- YA QUE NO EXISTE EL CAMPO NOMBRE DE EMPLEADO

CREATE OR REPLACE FUNCTION INSERT_OR_DELETE_EMP (
    P_EMPNO IN NUMBER,
    P_APELLIDO IN VARCHAR,
    P_NUM IN NUMBER
) RETURN NUMBER
IS
    V_EXISTE NUMBER(1);
    P_RESULTADO NUMBER(1) := 0; 
BEGIN 
    SELECT COUNT(*) INTO V_EXISTE
    FROM EMPLEADO e 
    WHERE E.APELLIDO = P_APELLIDO AND E.EMPNO = P_EMPNO;

    IF P_NUM = 1 THEN 
        IF V_EXISTE = 0 THEN
            INSERT INTO EMPLEADO VALUES(P_EMPNO, P_APELLIDO, NULL, NULL, NULL, NULL, NULL);
            P_RESULTADO := 1;
        END IF;

    ELSIF P_NUM = 2 THEN 
        IF V_EXISTE = 1 THEN
            DELETE FROM EMPLEADO e
            WHERE E.EMPNO = P_EMPNO AND E.APELLIDO = P_APELLIDO;
            P_RESULTADO := 1;
        END IF;

    END IF;

    RETURN P_RESULTADO;

EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;

------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

DECLARE
    RESULTADO NUMBER;
BEGIN
    -- INSERT DE LOS DATOS
    RESULTADO := INSERT_OR_DELETE_EMP(9999, 'PEPE', 1);
    DBMS_OUTPUT.PUT_LINE('Resultado de inserción: ' || RESULTADO);

    -- BORRAR LOS DATOS
    RESULTADO := INSERT_OR_DELETE_EMP(9999, 'PEPE', 2);
    DBMS_OUTPUT.PUT_LINE('Resultado de borrado: ' || RESULTADO);

    -- INTENTO DE BORRAR SIN QUE EXISTAN LOS DATOS
    RESULTADO := INSERT_OR_DELETE_EMP(9999, 'PEPE', 2);
    DBMS_OUTPUT.PUT_LINE('Intento de borrado inexistente: ' || RESULTADO);

    -- NUMERO INTRODUCIDO 3 PARA QUE SALTE ERROR
    RESULTADO := INSERT_OR_DELETE_EMP(9999, 'PEPE', 3);
    DBMS_OUTPUT.PUT_LINE('Resultado con número inválido: ' || RESULTADO);
END;



----------------------------------------------------------------
----------------------- EJERCICIO 10 ----------------------------
----------------------------------------------------------------


/*

10. Añade una columna a la tabla Departamentos llamada totalempleados. Rellénala a partir de
los datos de la tabla empleados y haz el trigger que creas conveniente para mantener
actualizada posteriormente la nueva columna.

*/

ALTER TABLE DEPARTAMENTO ADD TOTALEMPLEADOS NUMBER;

UPDATE DEPARTAMENTO D
SET TOTALEMPLEADOS = (
    SELECT COUNT(*)
    FROM EMPLEADO E
    WHERE E.NUM_DEP = D.NUM_DEP);


CREATE OR REPLACE TRIGGER ACTUALIZAR_TOTALEMPLEADOS
AFTER INSERT OR DELETE ON EMPLEADO
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE DEPARTAMENTO
        SET TOTALEMPLEADOS = TOTALEMPLEADOS + 1
        WHERE NUM_DEP = :NEW.NUM_DEP;

    ELSIF DELETING THEN
        UPDATE DEPARTAMENTO
        SET TOTALEMPLEADOS = TOTALEMPLEADOS - 1
        WHERE NUM_DEP = :OLD.NUM_DEP;
    END IF;
END;


------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

-- COMPROBAR VALOR ACTUAL
SELECT TOTALEMPLEADOS FROM DEPARTAMENTO WHERE NUM_DEP = 20;

-- INSERTAR UN EMPLEADO EN EL DEPARTAMENTO 10
INSERT INTO EMPLEADO (EMPNO, APELLIDO,SALARIO, OFICIO, FECHA_ALTA, N_ALMACEN, NUM_DEP)
VALUES (150, 'Marquez',1500, 'ANALISTA', SYSDATE, NULL , 20);

-- COMPROBAR ACTUALIZACIÓN
SELECT TOTALEMPLEADOS FROM DEPARTAMENTO WHERE NUM_DEP = 20;

-- ELIMINAR EL EMPLEADO
DELETE FROM EMPLEADO WHERE EMPNO = 150;

-- COMPROBAR QUE SE HA RESTADO
SELECT TOTALEMPLEADOS FROM DEPARTAMENTO WHERE NUM_DEP = 20;


----------------------------------------------------------------
----------------------- EJERCICIO 11 ----------------------------
----------------------------------------------------------------


/*

11. Realizar un procedimiento que reciba un número entero y positivo (si no es así mostrar un
mensaje de error y salir), y dos letras distintas (si no son distintas mostrar mensaje de error y
salir) y muestre por consola n veces la primera letra, luego otra fila con n veces la segunda letra,
otra fila con n veces la primera fila, y así hasta completar n filas.

Por ejemplo, si llamo a la función con el número 6 y la letra A y B deberá aparecer algo
como esto
AAAAAA
BBBBBB
AAAAAA
BBBBBB
AAAAAA
BBBBBB
Si la llamo con el número 5 y la letra A y B deberá aparecer algo como esto
AAAAA
BBBBB
AAAAA
BBBBB
AAAAA

*/


CREATE OR REPLACE PROCEDURE MOSTRAR_LETRAS (
    P_NUM IN NUMBER,
    P_LETRA1 IN CHAR,
    P_LETRA2 IN CHAR
)
IS
    V_LINEA VARCHAR2(100);
BEGIN

	IF P_NUM <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: EL NÚMERO DEBE SER ENTERO Y POSITIVO.');
        RETURN;
    END IF;


	IF P_LETRA1 = P_LETRA2 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: LAS LETRAS DEBEN SER DISTINTAS.');
        RETURN;
    END IF;


	FOR I IN 1 .. P_NUM LOOP
        IF MOD(I, 2) = 1 THEN
            V_LINEA := RPAD(P_LETRA1, P_NUM, P_LETRA1);
        ELSE
            V_LINEA := RPAD(P_LETRA2, P_NUM, P_LETRA2);
        END IF;

        DBMS_OUTPUT.PUT_LINE(V_LINEA);
    END LOOP;
END;


-- CON MOD COMPRUEBO EL MODULO DE I PARA LAS FILAS PARES O IMPARES Y LUEGO CON RPAD HAGO QUE SE AÑADAN A LA DERECHA


------------------------------------------------------------
------------------ PRUEBAS ---------------------------------

--LAS MUESTRA CORRECTAMENTE 6 FILAS

BEGIN
    MOSTRAR_LETRAS(6, 'A', 'B');
END;

-- LAS MUESTRA CORRECTAMENTE CON 5 FILAS

BEGIN
	MOSTRAR_LETRAS(5, 'A', 'B');
END;

-- ERROR, YA QUE EL NUMERO NO PUEDE SER NEGATIVO

BEGIN
	MOSTRAR_LETRAS(-3, 'A', 'B');
END;

-- ERROR, YA QUE LAS LETRAS SON LA MISMA

BEGIN
	MOSTRAR_LETRAS(4, 'A', 'A');
END;










