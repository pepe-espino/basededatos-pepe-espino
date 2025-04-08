--------------------------------------------------------------------
---------BOLETÍN 2 PL/SQL - JOSE ANTONIO ESPINO DAZA ---------------

--1. Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO.

<<<<<<< HEAD
CREATE OR REPLACE PROCEDURE finanzas IS
    v_num_empleados NUMBER;
    v_sal_min NUMBER;
    v_sal_max NUMBER;
    v_sal_avg NUMBER;
BEGIN
    SELECT COUNT(*), MIN(SALAR), MAX(SALAR), AVG(SALAR)
    INTO v_num_empleados, v_sal_min, v_sal_max, v_sal_avg
    FROM EMPLEADOS e, departamentos d
    WHERE e.NUMDE = d.numde;
				

    DBMS_OUTPUT.PUT_LINE('Num empleados: ' || v_num_empleados);
    DBMS_OUTPUT.PUT_LINE('Salario min: ' || v_sal_min);
    DBMS_OUTPUT.PUT_LINE('Salario max: ' || v_sal_max);
   	DBMS_OUTPUT.PUT_LINE('Salario med: ' || ROUND(v_sal_avg, 2));
END;

BEGIN finanzas;
END;

----
=======
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










>>>>>>> 14553e4163c77181d93ff6be31cbc015036cabae

