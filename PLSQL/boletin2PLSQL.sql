--------------------------------------------------------------------
---------BOLETÍN 2 PL/SQL - JOSE ANTONIO ESPINO DAZA ---------------

--1. Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO.

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

