CREATE OR REPLACE PROCEDURE empleados_por_dep
IS 

	CURSOR C_NUM_DEP IS
	SELECT D.NUMDE FROM DEPARTAMENTOS d;
	
	CURSOR C_MOSTRAR_EMPLEADOS (C_NUM_DEP NUMBER) IS
	SELECT e.numem AS numero_empleado, e.nomem AS nombre_empleado, e.salar AS salario_empleado FROM EMPLEADOS e
	WHERE C_NUM_DEP = E.NUMDE;

BEGIN
	FOR filadept IN C_NUM_DEP LOOP
		DBMS_OUTPUT.PUT_LINE(filadept.numde);
		FOR filaemp IN C_MOSTRAR_EMPLEADOS(filadept.NUMDE) LOOP
			DBMS_OUTPUT.PUT_LINE('-- Empleado: ' || filaemp.nombre_empleado || ' número de empleado: '|| filaemp.numero_empleado || ' salario: '|| filaemp.salario_empleado);
		END LOOP;
	END LOOP;
END;

BEGIN
	empleados_por_dep;
END;
