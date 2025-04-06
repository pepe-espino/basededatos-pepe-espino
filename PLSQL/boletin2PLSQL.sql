--------------------------------------------------------------------
---------BOLETÍN 2 PL/SQL - JOSE ANTONIO ESPINO DAZA ---------------

--1. Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO.

CREATE OR REPLACE PROCEDURE BOLETIN2_PLSQL.OBTENER_ESTADISTICAS_FINANZAS IS
	V_NUM_EMPLEADOS NUMBER;
	V_SALARIO_MIN NUMBER;
	V_SALARIO_MAX NUMBER;
	V_SALARIO_MEDIO NUMBER;
BEGIN
	SELECT COUNT(E.NUMEM), MIN(E.SALAR), MAX(E.SALAR), AVG(E.SALAR) 
	INTO V_NUM_EMPLEADOS , V_SALARIO_MIN , V_SALARIO_MAX , V_SALARIO_MEDIO 
	FROM EMPLEADOS e
	JOIN DEPARTAMENTOS d ON D.NUMDE = E.NUMDE
	WHERE UPPER(D.NOMDE) LIKE 'FINANZAS';	
	
	DBMS_OUTPUT.PUT_LINE('Números de empleados: '|| v_num_empleados);
	DBMS_OUTPUT.PUT_LINE('Salario mínimo: '|| V_SALARIO_MIN);
	DBMS_OUTPUT.PUT_LINE('Salario mínimo: '|| V_SALARIO_MAX);
	DBMS_OUTPUT.PUT_LINE('Salario medio: '|| V_SALARIO_MEDIO);
END;

BEGIN
	OBTENER_ESTADISTICAS_FINANZAS;
END;


--2. Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
--con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
--mostrar por pantalla el código de empleado, nombre, salario anterior y final.
--Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
--por cualquier razón no es posible actualizar todos estos salarios, debe
--deshacerse el trabajo a la situación inicial.


CREATE OR REPLACE PROCEDURE SUBIR_SALARIO IS
	CURSOR SUBIR_SAL_EMP IS
		SELECT e. FROM EMPLEADOS e











