BEGIN
	DBMS_OUTPUT.PUT_LINE('Hola Mundo');
END;

-- Ctrl+Shift+O -> abre output


DECLARE
  v_fecha DATE; --poner v_fecha por si hay otra fecha en la base de datos
BEGIN
  SELECT sysdate INTO v_fecha FROM dual;
  dbms_output.put_line
  (
    to_CHAR(fecha,'day", "dd" de "month" de "yyyy", a las "hh24:mi:ss')
  );
END;

DECLARE
  t_fecha  DATE;
BEGIN
  DBMS_OUTPUT.PUT_LINE ('Salida de información');
  SELECT SYSDATE INTO t_fecha FROM DUAL;
  DBMS_OUTPUT.PUT_LINE ('Fecha:  ' || t_fecha);
END;

---------------------------------------------------------------
-----------Condicionales---------------------------------------

--empieza con if, termina con end if
--las variables de establecen asi: (c := 0)
--en vez de ( { -> then )
--en vez de elif -> elsif


IF  A < B THEN
  C := 1;
ELSE
  C := 2;
END IF;

-- NO ES EQUIVALENTE A LO SIGUIENTE, si  las variables A o B
-- pueden tener valores NULL:

IF  A >= B THEN
  C := 2;
ELSE
  C := 1;
END IF;

-- LO MEJOR ES COMPROBAR PRIMERO si las variables A o B
-- tienen valores NULL

----------
--EJEMPLO


IF  A IS NULL OR B IS NULL THEN
  C := 3;
ELSIF A < B THEN
  C := 1;
ELSE
  C := 2;
END IF;


DECLARE
   A NUMBER := NULL;
   B NUMBER := 2;
   C NUMBER;

BEGIN

  IF  A IS NULL OR B IS NULL THEN
    C := 3;
  ELSIF A < B THEN
    C := 1;
  ELSE
    C := 2;
  END IF;
  DBMS_OUTPUT.PUT_LINE ('El valor de C es ' || C);

END;


------------
--EJEMPLO

DECLARE
  nota NUMBER(2);

BEGIN
  nota := 7;

  IF  nota = 10 OR nota = 9 THEN
    DBMS_OUTPUT.PUT_LINE('Sobresaliente');
  ELSIF nota = 8 OR nota = 7 THEN
    DBMS_OUTPUT.PUT_LINE('Notable');
  ELSIF nota = 6 THEN
    DBMS_OUTPUT.PUT_LINE('Bien');
  ELSIF nota = 5 THEN
    DBMS_OUTPUT. PUT_LINE('Suficiente');
  ELSIF nota < 5 AND nota >=0 THEN
    DBMS_OUTPUT.PUT_LINE('Insuficiente');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Nota no válida');
  END IF;

END;


-----------------
--EJEMPLO


DECLARE
  nota NUMBER(2);
BEGIN
  nota := 7;
  CASE nota
    WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('Sobresaliente');
    WHEN 9  THEN DBMS_OUTPUT.PUT_LINE('Sobresaliente');
    WHEN 8  THEN DBMS_OUTPUT.PUT_LINE('Notable');
    WHEN 7  THEN DBMS_OUTPUT.PUT_LINE('Notable');
    WHEN 6  THEN DBMS_OUTPUT.PUT_LINE('Bien');
    WHEN 5  THEN DBMS_OUTPUT.PUT_LINE('Suficiente');
    WHEN 4  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 3  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 2  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 1  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    WHEN 0  THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    ELSE DBMS_OUTPUT.PUT_LINE('Nota no válida');
  END CASE;
END;

-- lo mismo pero resumido

DECLARE
  nota NUMBER(2);
BEGIN
  nota := 7;
  CASE
    WHEN nota=10 OR nota=9  THEN DBMS_OUTPUT.PUT_LINE('Sobresaliente');
    WHEN nota=8  OR nota=7  THEN DBMS_OUTPUT.PUT_LINE('Notable');
    WHEN nota=6             THEN DBMS_OUTPUT.PUT_LINE('Bien');
    WHEN nota=5             THEN DBMS_OUTPUT.PUT_LINE('Suficiente');
    WHEN nota<5 AND nota>=0 THEN DBMS_OUTPUT.PUT_LINE('Insuficiente');
    ELSE DBMS_OUTPUT.PUT_LINE('Nota no válida');
  END CASE;
END;


-- ejercicio igual pero con cadenas --

DECLARE
  v_nota NUMBER(2);
  v_texto VARCHAR2(25);
BEGIN
  v_nota := 9;
  CASE 
    WHEN v_nota IN(9, 10) THEN
      v_texto := 'Sobresaliente';
    WHEN v_nota = 8 OR v_nota = 7 THEN
      v_texto := 'Notable';
    WHEN v_nota = 6 THEN
      v_texto := 'Bien';
    WHEN v_nota = 5 THEN
      v_texto := 'Suficiente';
    WHEN v_nota IN (4, 3, 2, 1, 0) THEN
      v_texto := 'Insuficiente';
    ELSE
      v_texto := 'Nota no válida';
  END CASE;
  dbms_output.put_line('Nota: ' || v_texto);
END;


-------------------------------------------------------------
-----------------BUCLES--------------------------------------

---------
--EJEMPLO

CREATE TABLE TEMP
(
	CALCULO NUMBER(6),
	CONSTRAINT PK_TEMP PRIMARY KEY(CALCULO)
);


DECLARE
  i  BINARY_INTEGER := 1;     -- La i tmb puede ser number()--
BEGIN
  LOOP
    INSERT INTO TEMP t VALUES (i*10);
    EXIT WHEN i>=10;
    i:= i+1;
  END LOOP;
END;


---------
--CON WHILE

DECLARE
  i  BINARY_INTEGER := 1;
BEGIN
  WHILE i<=10 LOOP
    INSERT INTO TEMP t VALUES (i*10);
    i:= i+1;
  END LOOP;
END;


------------
---CON FOR

BEGIN
  FOR i IN 1..10 LOOP
    INSERT INTO Tabla_Temp VALUES (i*10);
  END LOOP;
END;


--------------------------------------------------------
----------------VARIABLES-------------------------------

Nombre Tipo  [[CONSTANT|NOT NULL] := Valor_Inicial ];

CODIGO         HOTEL.ID%TYPE;        --HOTEL.ID%TYPE HACE REFERENCIA AL TIPO DE DATO DE HOTEL.ID--
HABS        HOTEL.NHABS%TYPE;
DEP       DEPARTAMENTOS%ROWTYPE;
HOTEL             HOTEL%ROWTYPE;

-----------
--EJEMPLO

CREATE TABLE HOTEL (ID NUMBER(2) PRIMARY KEY, NHABS NUMBER(3) );

INSERT INTO HOTEL VALUES (1, 10);
INSERT INTO HOTEL VALUES (2, 60);
INSERT INTO HOTEL VALUES (3, 200);
INSERT INTO HOTEL VALUES (99, NULL);


CREATE OR REPLACE
PROCEDURE TAMHOTEL (v_cod Hotel.ID%TYPE)
AS
  NumHabitaciones  Hotel.Nhabs%TYPE;
  Comentario       VARCHAR2(40);
BEGIN
  -- Número de habitaciones del Hotel cuyo ID es cod
  SELECT Nhabs INTO NumHabitaciones
  FROM Hotel WHERE ID=v_cod;

  IF NumHabitaciones IS NULL THEN
    Comentario := 'de tamaño indeterminado';
  ELSIF NumHabitaciones < 50 THEN
    Comentario := 'Pequeño';
  ELSIF NumHabitaciones < 100 THEN
    Comentario := 'Mediano';
  ELSE
    Comentario := 'Grande';
  END IF;

  DBMS_OUTPUT.PUT_LINE ('El hotel con ID '|| v_cod ||' es '|| Comentario);
END;


BEGIN
   TAMHOTEL(1);
   TAMHOTEL(2);
   TAMHOTEL(3);
   TAMHOTEL(99);
END;

