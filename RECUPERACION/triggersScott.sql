/*   
    1. Nuestra empresa ha cambiado la política de sueldos y ha decidido que los suelos no llevarán céntimos, para lo cual se debe crear uno o varios triggers que garanticen que el sueldo sólo tiene un decimal, si tiene dos se redondeará el valor. (mira la función round).
    2. Crea los trigger que creas necesario para que el campo deptno se asigne de forma automática, sea dado algún valor por el usuario o no. Además hay que impedir que el usuario modifique esté valor.
    3. Crear un nuevo campo en la tabla deptno que se llame num_empleados y crear los trigger que sean necesario para mantener actualizado esos campos. Antes que nada rellenar el campo num_empleado con los valores adecuados, si es necesario crea un procedure para ello.
    4. Crea un trigger de forma que si se va a insertar a un empleado compruebe que su jefe está en el mismo departamento. Si no está lance una exception y no deje que se inserte
    5. Haz un trigger que sólo permita tener comisiones a los vendedores.
    6. Registrar todas las operaciones sobre la tabla EMP de SCOOT en una tabla llamada AUDIT_EMP donde se guarde usuario, fecha y tipo de operación.
    7. Haz un trigger que controle los sueldos de las siguientes categorías. Si se pasa de este rango poner el valor mínimo o el máximo según corresponda.
		CLERK: 800 - 1100
		ANALYST: 1200 -1600
		MANAGER: 1800 - 2000
    8. Haz un trigger que le suba un 10% el sueldo a los empleados cuando cambia la localidad donde trabajan.
    9. Haz un trigger que impidan que un departamento se quede sin empleados.
*/


------------------------------------------
----------- EJERCICIO 1 ------------------
------------------------------------------

CREATE OR REPLACE TRIGGER T_SALARIO_ROUND
BEFORE INSERT OR UPDATE ON EMP
FOR EACH ROW
BEGIN
    :NEW.SAL := ROUND(:NEW.SAL, 1);
END;

--PRUEBAS

--SE INSERTA CON MAS DECIMALES
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL)
VALUES (9991, 'REDONDEO', 'CLERK', 1234.56789);

--SE AÑADE SOLO CON 1 CUMPLIENDO EL TRIGGER
SELECT EMPNO, ENAME, SAL FROM EMP WHERE EMPNO = 9991;


------------------------------------------
----------- EJERCICIO 2 ------------------
------------------------------------------

CREATE OR REPLACE TRIGGER T_DEPTNO_POR_DEFECTO
BEFORE INSERT ON EMP
FOR EACH ROW
BEGIN
    IF :NEW.DEPTNO IS NULL THEN
        :NEW.DEPTNO := 10;
    END IF;
END;

CREATE OR REPLACE TRIGGER T_DEPTNO_NO_MODIFICACION
BEFORE UPDATE OF DEPTNO ON EMP
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001,'NO SE PUEDE MODIFICAR DEPTNO');
END;


--PRUEBAS

--INSERTAMOS SIN DEPTNO, DEBERIA PONER 10, POR DEFECTO COMO SE ESTIPULA EN EL TRIGGER
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL)
VALUES (9992, 'DEFAULTDP', 'CLERK', 1000);

SELECT EMPNO, DEPTNO FROM EMP WHERE EMPNO = 9992;

--SALTARA EXCEPTION YA QUE NO SE PUEDE MODIFICAR
UPDATE EMP SET DEPTNO = 20 WHERE EMPNO = 9992;


------------------------------------------
----------- EJERCICIO 3 ------------------
------------------------------------------

ALTER TABLE DEPT ADD (NUM_EMPLEADOS NUMBER);

CREATE OR REPLACE PROCEDURE RELLENAR_NUM_EMP
IS
BEGIN
    FOR R IN (SELECT DEPTNO FROM DEPT) LOOP
        UPDATE DEPT D
        SET NUM_EMPLEADOS = (
            SELECT COUNT(*) FROM EMP E
            WHERE E.DEPTNO = D.DEPTNO
        )
        WHERE D.DEPTNO = R.DEPTNO;
    END LOOP;
END;

CREATE OR REPLACE TRIGGER T_SUMAR_EMPLEADOS
AFTER INSERT ON EMP
FOR EACH ROW
BEGIN
    UPDATE DEPT
    SET NUM_EMPLEADOS = NUM_EMPLEADOS + 1
    WHERE DEPTNO = :NEW.DEPTNO;
END;

CREATE OR REPLACE TRIGGER T_RESTAR_EMPLEADOS
AFTER DELETE ON EMP
FOR EACH ROW
BEGIN
    UPDATE DEPT
    SET NUM_EMPLEADOS = NUM_EMPLEADOS - 1
    WHERE DEPTNO = :OLD.DEPTNO;
END;

--PRUEBAS

--EJECUTAMOS EL PROCEDURE
BEGIN
	RELLENAR_NUM_EMP;
END;

-- COMPROBAR CANTIDAD = 4
SELECT NUM_EMPLEADOS FROM DEPT WHERE DEPTNO = 10;

-- INSERTAMOS EN DEPT 10
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
VALUES (9993, 'NUEVO10', 'CLERK', 900, 10);

-- COMRPOBAMOS QUE DEBE SER = 5:
SELECT NUM_EMPLEADOS FROM DEPT WHERE DEPTNO = 10;

-- LO ELIMINAMOS
DELETE FROM EMP WHERE EMPNO = 9993;

-- COMPROBAMOS QUE DEBE SER 4:
SELECT NUM_EMPLEADOS FROM DEPT WHERE DEPTNO = 10;


------------------------------------------
----------- EJERCICIO 4 ------------------
------------------------------------------

CREATE OR REPLACE TRIGGER T_MISMO_DEPT
BEFORE INSERT OR UPDATE ON EMP
FOR EACH ROW
DECLARE
    V_DEPT NUMBER;
BEGIN
    IF :NEW.MGR IS NOT NULL THEN
        SELECT DEPTNO INTO V_DEPT
        FROM EMP
        WHERE EMPNO = :NEW.MGR;

        IF V_DEPT != :NEW.DEPTNO THEN
            RAISE_APPLICATION_ERROR(-20002,'EL JEFE NO PERTENECE AL MISMO DEPARTAMENTO');
        END IF;
    END IF;
END;


--PRUEBAS

-- COMPROBAR AL JEFE Y SU DEPT
SELECT EMPNO,MGR, DEPTNO FROM EMP WHERE EMPNO = 7839;

-- SE INSERTA EMPLEADO CON ESE JEFE, PERO EN DEPT ERRONEO, POR LO QUE SALTA ERROR
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, MGR, DEPTNO)
VALUES (9994, 'JUAN', 'CLERK', 1000, 7839, 20);

-- SE INSERTA CORRECTAMENTE CON MISMO DEPT QUE EL JEFE
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, MGR, DEPTNO)
VALUES (9995, 'OKJEFE', 'CLERK', 1000, 7839, 10);


------------------------------------------
----------- EJERCICIO 5 ------------------
------------------------------------------

CREATE OR REPLACE TRIGGER T_COMISION_VENDEDORES
BEFORE INSERT OR UPDATE ON EMP
FOR EACH ROW
BEGIN
    IF :NEW.COMM IS NOT NULL AND :NEW.JOB != 'SALESMAN' THEN
        RAISE_APPLICATION_ERROR(-20003,'SOLO SALESMAN PUEDE TENER COMISION');
    END IF;
END;

--PRUEBAS

-- ERROR, NO ES SALESMAN
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, COMM)
VALUES (9996, 'COMERROR', 'CLERK', 1000, 300);

-- CORRECTO
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, COMM)
VALUES (9997, 'COMOK', 'SALESMAN', 1500, 400);


------------------------------------------
----------- EJERCICIO 6 ------------------
------------------------------------------

CREATE TABLE AUDIT_EMP (
    ID NUMBER(10),
    USUARIO VARCHAR2(50),
    FECHA_OPER DATE,
    TIPO_OPER VARCHAR2(50),
    CONSTRAINT PK_AUDIT PRIMARY KEY(ID)
);

CREATE SEQUENCE SQ_AUDIT
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER T_AUDIT_EMP
AFTER INSERT OR UPDATE OR DELETE ON EMP
FOR EACH ROW
BEGIN
    IF INSERTING THEN
    	INSERT INTO AUDIT_EMP VALUES(SQ_AUDIT.NEXTVAL, :NEW.ENAME, SYSDATE, 'INSERT');
    ELSIF UPDATING THEN
    	INSERT INTO AUDIT_EMP VALUES(SQ_AUDIT.NEXTVAL, :NEW.ENAME, SYSDATE, 'UPDATE');
	ELSE
		INSERT INTO AUDIT_EMP VALUES(SQ_AUDIT.NEXTVAL, :OLD.ENAME, SYSDATE, 'DELETE');
    END IF;
END;

--PRUEBAS

-- INSERTAR EMPLEADO NUEVO
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
VALUES (9998, 'AUDITINS', 'CLERK', 1200, 10);

-- MODIFICAR DEPTNO, APARECERA UPDATE EN TIPO DE OPERACION
UPDATE EMP SET ENAME = 'AUDMODIF' WHERE EMPNO = 9998;

-- BORRAMOS EMPLEADO Y APARECERA DELETE
DELETE FROM EMP WHERE EMPNO = 9998;

-- AQUI COMPROBAMOS TODO
SELECT * FROM AUDIT_EMP;


------------------------------------------
----------- EJERCICIO 7 ------------------
------------------------------------------

CREATE OR REPLACE TRIGGER T_CONTROL_SALARIO
BEFORE INSERT OR UPDATE ON EMP
FOR EACH ROW
BEGIN
    IF :NEW.JOB = 'CLERK' THEN
    
        IF :NEW.SAL < 800 THEN
        	:NEW.SAL := 800;
        ELSIF :NEW.SAL > 1100 THEN
        	:NEW.SAL := 1100;
        END IF;
        
    ELSIF :NEW.JOB = 'ANALYST' THEN
    
    	IF :NEW.SAL < 1200 THEN
        	:NEW.SAL := 1200;
        ELSIF :NEW.SAL > 1600 THEN
        	:NEW.SAL := 1600;
        END IF;
    
    ELSIF :NEW.JOB = 'MANAGER' THEN
    	
        IF :NEW.SAL < 1800 THEN
        	:NEW.SAL := 1800;
        ELSIF :NEW.SAL > 2000 THEN
        	:NEW.SAL := 2000;
        END IF;
    
    END IF;
END;

--PRUEBAS

-- INSERTAMOS ANALYST FUERA DE RANGO POR DEBAJO
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL)
VALUES (9999, 'ANASAL', 'ANALYST', 1000);

-- COMPROBAMOS QUE AL PASARNOS DEL LIMITE POR DEBAJO SE PONE EL SAL MINIMO:
SELECT SAL FROM EMP WHERE EMPNO = 9999;

-- INSERTAMOS MANAGER EXCEDIENDO POR ARRIBA
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL)
VALUES (9990, 'MGRSAL', 'MANAGER', 2500);

-- COMPROBAMOS QUE SE AJUSTA AL LIMITE SUPERIOR, EN ESTE CASO 2000:
SELECT SAL FROM EMP WHERE EMPNO = 9990;


------------------------------------------
----------- EJERCICIO 8 ------------------
------------------------------------------

CREATE OR REPLACE TRIGGER T_AUMENTO_SAL
AFTER UPDATE OF LOC ON DEPT
FOR EACH ROW
BEGIN
    UPDATE EMP
    SET SAL = SAL * 1.10
    WHERE DEPTNO = :NEW.DEPTNO;
END;


--PRUEBAS

-- COMPROBAR SALARIO ANTES DE CAMBIAR
SELECT EMPNO, SAL FROM EMP WHERE DEPTNO = 10;

-- CAMBIAMOS LOCALIDAD EN DEPTNO 10
-- UPDATE DEPT SET LOC = 'SEVILLA' WHERE DEPTNO = 10;




------------------------------------------
----------- EJERCICIO 9 ------------------
------------------------------------------


CREATE OR REPLACE TRIGGER T_NO_DEPT_VACIO
BEFORE DELETE ON EMP
FOR EACH ROW
DECLARE
    V_CANT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_CANT
    FROM EMP
    WHERE DEPTNO = :OLD.DEPTNO
      AND EMPNO != :OLD.EMPNO;

    IF V_CANT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004,'NO SE PUEDE DEJAR DEPARTAMENTO SIN EMPLEADOS');
    END IF;
END;


--PRUEBAS

-- COMPROBAR EMPLEADOS 10
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 10;

-- SE INTENTA BORRAR TODOS LOS DATOS DE EMP
DELETE FROM EMP;






















