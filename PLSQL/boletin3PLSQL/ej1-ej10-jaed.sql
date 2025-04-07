--1. Realiza un procedimiento que reciba un número de departamento y muestre por pantalla su nombre y localidad.


CREATE OR REPLACE PROCEDURE NOM_LOC_DPT (P_DEPTNO NUMBER(2,0)) 
IS
	V_NOMBRE_DEP DEPT.DNAME%TYPE;
	V_LOCALIDAD_DEP DEPT.LOC%TYPE;
BEGIN
	
	SELECT D.DNAME, D.LOC 
	INTO V_NOMBRE_DEP, V_LOCALIDAD_DEP
	FROM DEPT D
	WHERE D.DEPTNO = DEPTNO;
	
	DBMS_OUTPUT.PUT_LINE('Nombre del departamento: ' || V_NOMBRE_DEP);
    DBMS_OUTPUT.PUT_LINE('Localidad: ' || V_LOCALIDAD_DEP);

EXCEPTION
	WHEN OTHERS THEN
	 DMBS_OUTPUT.PUT_LINE("Error.");
	
END;

BEGIN
	NOM_LOC_DPT(10);
	DBMS_OUTPUT.PUT_LINE('-------');
	NOM_LOC_DPT(5);
END;


--2. Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma de sus salarios.

CREATE OR REPLACE FUNCTION devolverSalario (p_nombre_dep IN DEPT.DNAME%TYPE) RETURN NUMBER
IS
    v_total_salario NUMBER;
BEGIN
    SELECT SUM(E.SAL)
    INTO v_total_salario
    FROM EMP E
    JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    WHERE D.DNAME = p_nombre_dep;

    IF v_total_salario IS NULL THEN
        RETURN 0;
    ELSE
        RETURN v_total_salario;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error.');
END;

BEGIN
	DBMS_OUTPUT.PUT_LINE(devolverSalario('ACCOUNTING'));
END;


--3. Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del nombre de cada empleado.

CREATE OR REPLACE PROCEDURE mostrarAbreviaturas
IS
    CURSOR c_empleados IS
        SELECT ENAME FROM EMP;
    	v_nombre EMP.ENAME%TYPE;
BEGIN
    FOR i IN c_empleados LOOP
        v_nombre := SUBSTR(i.ENAME, 1, 3);
        DBMS_OUTPUT.PUT_LINE('Abreviatura: ' || v_nombre);
    END LOOP;
END;

BEGIN
	mostrarAbreviaturas;
END;

--4. Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus empleados.

CREATE OR REPLACE PROCEDURE mostrarEmpleados (p_deptno IN NUMBER)
IS
    CURSOR c_empleados IS
        SELECT ENAME FROM EMP WHERE DEPTNO = p_deptno;
   	 	v_nombre EMP.ENAME%TYPE;
BEGIN
    FOR i IN c_empleados LOOP
        DBMS_OUTPUT.PUT_LINE('Empleado: ' || i.ENAME);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error.');
END;



--5. Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre los nombres de los empleados de ese departamento que son jefes de otros empleados.Trata las excepciones que consideres necesarias.


CREATE OR REPLACE PROCEDURE mostrarJefes (p_nombre_dep IN DEPT.DNAME%TYPE)
IS
    CURSOR c_jefes IS
        SELECT E.ENAME
        FROM EMP E
        JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        WHERE D.DNAME = p_nombre_dep AND E.EMPNO IN (SELECT MGR FROM EMP WHERE MGR IS NOT NULL);
    v_nombre EMP.ENAME%TYPE;
BEGIN
    FOR i IN c_jefes LOOP
        DBMS_OUTPUT.PUT_LINE('Jefe: ' || i.ENAME);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error.');
END;



--6. Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es 7082

CREATE OR REPLACE PROCEDURE mostrarEmpleado
IS
    v_nombre EMP.ENAME%TYPE;
    v_salario EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, SAL
    INTO v_nombre, v_salario
    FROM EMP
    WHERE EMPNO = 7082;

    DBMS_OUTPUT.PUT_LINE('Empleado: ' || v_nombre || ' , Salario: ' || v_salario);
EXCEPTION
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error.');
END;

--7. Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de departamento, muestre en pantalla el número de empleados de dicho departamento Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. Si el departamento no existe se tratará la excepción correspondiente.

CREATE OR REPLACE PROCEDURE hallarNumEmp (p_nombre_dep IN DEPT.DNAME%TYPE)
IS
    v_num_emp NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_num_emp
    FROM EMP E
    JOIN DEPT D ON E.DEPTNO = D.DEPTNO
    WHERE D.DNAME = p_nombre_dep;

    IF v_num_emp = 0 THEN
        DBMS_OUTPUT.PUT_LINE('En el departamento no hay empleados.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Número de empleados: ' || v_num_emp);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error.');
END;


--8. Hacer un procedimiento que reciba como parámetro un código de empleado y devuelva su nombre.

CREATE OR REPLACE PROCEDURE devolverNombreEmpleado (p_empno IN NUMBER)
IS
    v_nombre EMP.ENAME%TYPE;
BEGIN
    SELECT ENAME INTO v_nombre
    FROM EMP
    WHERE EMPNO = p_empno;

    DBMS_OUTPUT.PUT_LINE('Empleado: ' || v_nombre);
EXCEPTION
    WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error.');
END;


--9. Codificar un procedimiento que reciba una cadena y la visualice al revés.

CREATE OR REPLACE PROCEDURE mostrarCadenaAlReves (p_cadena IN VARCHAR2)
IS
    v_cadena_reves VARCHAR2(50);
BEGIN
    v_reves := REVERSE(p_cadena);
    DBMS_OUTPUT.PUT_LINE('Cadena al revés: ' || v_cadena_reves);
END;


--10. Escribir un procedimiento que reciba una fecha y escriba el año, en número, correspondiente a esa fecha. 

CREATE OR REPLACE PROCEDURE mostrarAnio (p_fecha IN DATE)
IS
    v_anio NUMBER;
BEGIN
    v_anio := EXTRACT(YEAR FROM p_fecha);
    DBMS_OUTPUT.PUT_LINE('Año: ' || v_anio);
END;





















