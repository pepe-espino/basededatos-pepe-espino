CREATE TABLE DEPT
(
 DEPTNO NUMBER(2),
 DNAME VARCHAR2(14),
 LOC VARCHAR2(13),
 CONSTRAINT PK_DEPT PRIMARY KEY (DEPTNO)
);

CREATE TABLE EMP
(
 EMPNO NUMBER(4),
 ENAME VARCHAR2(10),
 JOB VARCHAR2(9),
 MGR NUMBER(4),
 HIREDATE DATE,
 SAL NUMBER(7, 2),
 COMM NUMBER(7, 2),
 DEPTNO NUMBER(2),
 CONSTRAINT FK_DEPTNO FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
 CONSTRAINT PK_EMP PRIMARY KEY (EMPNO)
);

---------------inserts

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO EMP VALUES(7369, 'SMITH', 'CLERK', 7902,TO_DATE('17-DEC-1980', 'DD-MON-YYYY'), 800, NULL, 20);
INSERT INTO EMP VALUES(7499, 'ALLEN', 'SALESMAN', 7698,TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600, 300, 30);
INSERT INTO EMP VALUES(7521, 'WARD', 'SALESMAN', 7698,TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250, 500, 30);
INSERT INTO EMP VALUES(7566, 'JONES', 'MANAGER', 7839,TO_DATE('2-APR-1981', 'DD-MON-YYYY'), 2975, NULL, 20);
INSERT INTO EMP VALUES(7654, 'MARTIN', 'SALESMAN', 7698,TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO EMP VALUES(7698, 'BLAKE', 'MANAGER', 7839,TO_DATE('1-MAY-1981', 'DD-MON-YYYY'), 2850, NULL, 30);
INSERT INTO EMP VALUES(7782, 'CLARK', 'MANAGER', 7839,TO_DATE('9-JUN-1981', 'DD-MON-YYYY'), 2450, NULL, 10);
INSERT INTO EMP VALUES(7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES(7839, 'KING', 'PRESIDENT', NULL,TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO EMP VALUES(7844, 'TURNER', 'SALESMAN', 7698,TO_DATE('8-SEP-1981', 'DD-MON-YYYY'), 1500, 0, 30);
INSERT INTO EMP VALUES(7876, 'ADAMS', 'CLERK', 7788,TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO EMP VALUES(7900, 'JAMES', 'CLERK', 7698,TO_DATE('3-DEC-1981', 'DD-MON-YYYY'), 950, NULL, 30);
INSERT INTO EMP VALUES(7902, 'FORD', 'ANALYST', 7566,TO_DATE('3-DEC-1981', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES(7934, 'MILLER', 'CLERK', 7782,TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);


------------------------------------------


----------------------------------------------------------------
----------------------- EJERCICIO 1 ----------------------------
----------------------------------------------------------------

/*
 
    1. Nuestra empresa ha cambiado la política de sueldos y ha decidido que los suelos no 
    llevarán céntimos, para lo cual se debe crear uno o varios triggers que garanticen que 
    el sueldo sólo tiene un decimal, si tiene dos se redondeará el valor. (mira la función round).

*/


CREATE OR REPLACE TRIGGER T_QUITARCENTIMOS
AFTER INSERT OR UPDATE ON EMP
FOR EACH ROW 
BEGIN 
	
	IF INSERTING THEN
	
		UPDATE EMP SET SAL = ROUND(SAL, 1)
		WHERE EMPNO = :NEW.EMPNO;
	
	ELSIF UPDATING THEN
	
	 	UPDATE EMP SET SAL = ROUND(SAL, 1)
		WHERE EMPNO = :NEW.EMPNO;
	
	END IF;
	
END;


------------------ PRUEBAS ---------------------------------

SELECT * FROM EMP;


----------------------------------------------------------------
----------------------- EJERCICIO 2 ----------------------------
----------------------------------------------------------------

/*
 
     2. Crea los trigger que creas necesario para que el campo deptno se asigne de forma automática,
    sea dado algún valor por el usuario o no. Además hay que impedir que el usuario modifique esté valor.

*/

----------------------------------------------------------------
----------------------- EJERCICIO 3 ----------------------------
----------------------------------------------------------------

/*
 
    3. Crear un nuevo campo en la tabla deptno que se llame num_empleados y crear los trigger 
    que sean necesario para mantener actualizado esos campos. Antes que nada rellenar el campo
    num_empleado con los valores adecuados, si es necesario crea un procedure para ello.


*/

ALTER TABLE DEPT 
ADD NUM_EMPLEADOS NUMBER(6);

CREATE OR REPLACE TRIGGER T_NUMEMP
BEFORE INSERT ON EMP
FOR EACH ROW 
DECLARE 
	CURSOR C_DEPT IS 
	SELECT * FROM DEPT d ; 

	V_NUM_EMPLEADOS NUMBER(10);
BEGIN 

	FOR C IN C_DEPT LOOP
		
		SELECT COUNT(*) INTO V_NUM_EMPLEADOS
		FROM EMP e
		WHERE E.DEPTNO = C.DEPTNO;
	
		UPDATE DEPT SET NUM_EMPLEADOS = V_NUM_EMPLEADOS
		WHERE DEPTNO = C.DEPTNO;
		
	END LOOP;
	
END;

SELECT * FROM EMP e ;

INSERT INTO EMP e (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7935, 'PEPE', 'CLERK', 7839, SYSDATE, 2300, NULL, 20);


----------------------------------------------------------------
----------------------- EJERCICIO 4 ----------------------------
----------------------------------------------------------------

/*
 
	4. Crea un trigger de forma que si se va a insertar a un empleado compruebe que su jefe 
	está en el mismo departamento. Si no está lance una exception y no deje que se inserte


*/

----------------------------------------------------------------
----------------------- EJERCICIO 5 ----------------------------
----------------------------------------------------------------

/*
 
	5. Haz un trigger que sólo permita tener comisiones a los vendedores.


*/

----------------------------------------------------------------
----------------------- EJERCICIO 6 ----------------------------
----------------------------------------------------------------

/*
 
	6. Registrar todas las operaciones sobre la tabla EMP de SCOOT en una 
	tabla llamada AUDIT_EMP donde se guarde usuario, fecha y tipo de operación.


*/

----------------------------------------------------------------
----------------------- EJERCICIO 7 ----------------------------
----------------------------------------------------------------

/*
 
	7. Haz un trigger que controle los sueldos de las siguientes categorías. 
	Si se pasa de este rango poner el valor mínimo o el máximo según corresponda.
	CLERK: 800 - 1100
	ANALYST: 1200 -1600
	MANAGER: 1800 - 2000


*/

----------------------------------------------------------------
----------------------- EJERCICIO 8 ----------------------------
----------------------------------------------------------------

/*
 
	8. Haz un trigger que le suba un 10% el sueldo a los empleados cuando cambia la localidad donde trabajan.


*/
    

















