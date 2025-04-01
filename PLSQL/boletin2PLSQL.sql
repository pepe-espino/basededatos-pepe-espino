--------------------------------------------------------------------
---------BOLETÍN 2 PL/SQL - JOSE ANTONIO ESPINO DAZA ---------------

--1. Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO.

DECLARE
	E_CURSOR EMPLEADOS%ROWTYPE;
BEGIN
	SELECT COUNT(E.NUMEM), MIN(E.SALAR), MAX(E.SALAR), AVG(E.SALAR) FROM EMPLEADOS e
	JOIN DEPARTAMENTOS d ON D.NUMDE = E.NUMDE
	WHERE UPPER(D.NOMDE) LIKE 'FINANZAS';	
	
	
	
END
