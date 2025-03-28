--------------------------------------------------------------------
---------BOLETÍN 1 PL/SQL - JOSE ANTONIO ESPINO DAZA ---------------

--1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el
--mensaje HOLA MUNDO.

CREATE OR REPLACE PROCEDURE ESCRIBE
AS 
	COMENTARIO VARCHAR2(50);
BEGIN
	DBMS_OUTPUT.PUT_LINE('HOLA MUNDO');
END;

BEGIN
	ESCRIBE;
END;

-----------------------------------------------------------------------

--2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
--parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
--La forma del procedimiento ser. la siguiente:
--ESCRIBE_MENSAJE (mensaje VARCHAR2)


CREATE OR REPLACE PROCEDURE ESCRIBE_MENSAJE (MENSAJE VARCHAR2)
AS 
	COMENTARIO VARCHAR2(50);
BEGIN
	COMENTARIO:=MENSAJE;
	DBMS_OUTPUT.PUT_LINE(COMENTARIO);
END;

BEGIN
	ESCRIBE_MENSAJE('Hola buenas tardes');
	ESCRIBE_MENSAJE('Hola buenas noches');
END;

------------------------------------------------------------------------

--3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
--números desde un mínimo hasta un máximo con un determinado paso. La
--forma del procedimiento ser. la siguiente:
--SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER)


CREATE OR REPLACE PROCEDURE INTRODUCCION_PLSQL.SERIE (V_MINIMO NUMBER, V_MAXIMO NUMBER, PASO NUMBER)
AS
	i NUMBER := V_MINIMO;
	V_NUMEROS NUMBER;
BEGIN
	WHILE i <= V_MAXIMO LOOP
		V_NUMEROS:=I;
		DBMS_OUTPUT.PUT_LINE(V_NUMEROS);
		i := i+PASO;
	END LOOP;
END;

BEGIN
	SERIE(1,5,1);   -- de 1 en 1
	DBMS_OUTPUT.PUT_LINE('--');
	SERIE(2,20,2);  -- de 2 en 2
	DBMS_OUTPUT.PUT_LINE('--');
	SERIE(0,35,5);  -- de 5 en 5
END;

------------------------------------------------------------------------------

--4. Crea una función AZAR que reciba dos parámetros y genere un número al
--azar entre un mínimo y máximo indicado. La forma de la función será la
--siguiente:
--AZAR (minimo NUMBER, maximo NUMBER) RETURN NUMBER





-----------------------------------------------------------------------------------

--5. Crea una función NOTA que reciba un parámetro que será una nota numérica
--entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
--Bien, Notable, ...). La forma de la función será la siguiente:
--NOTA (nota NUMBER) RETURN VARCHAR2


CREATE OR REPLACE FUNCTION NOTA (V_NOTA NUMBER) RETURN VARCHAR2
IS 
	COMENTARIO VARCHAR2(50);
BEGIN
	CASE
		WHEN V_NOTA IN(9,10) THEN 
			COMENTARIO := 'SOBRESALIENTE';
		WHEN V_NOTA IN (7,8) THEN 
			COMENTARIO := 'NOTABLE';
		WHEN V_NOTA = 6 THEN
			COMENTARIO := 'BIEN';
		WHEN V_NOTA = 5 THEN
			COMENTARIO := 'SUFICIENTE';
		WHEN V_NOTA IN (0,1,2,3,4) THEN
			COMENTARIO := 'INSUFICIENTE';
		ELSE
			COMENTARIO := 'NOTA NO VALIDA';
		END CASE;
	RETURN COMENTARIO;
END;

SELECT NOTA(5) FROM DUAL;
SELECT NOTA(10) FROM DUAL;
SELECT NOTA(7) FROM DUAL;
SELECT NOTA(3) FROM DUAL;
SELECT NOTA(0) FROM DUAL;
SELECT NOTA(500) FROM DUAL;


























