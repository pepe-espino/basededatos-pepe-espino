--5.6.1. Desarrolla el paquete ARITMETICA cuyo código fuente viene en este tema.
--Crea un archivo para la especi(cación y otro para el cuerpo. Realiza varias pruebas
--para comprobar que las llamadas a funciones y procedimiento funcionan
--correctamente.


CREATE OR REPLACE
PACKAGE aritmetica IS
  version NUMBER := 1.0;

  PROCEDURE mostrar_info;
  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
END aritmetica;

CREATE OR REPLACE
PACKAGE BODY aritmetica IS

  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;

  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a+b);
  END suma;

  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a-b);
  END resta;

  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a*b);
  END multiplica;

  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a/b);
  END divide;

END aritmetica;


BEGIN
  ARITMETICA.MOSTRAR_INFO;
END;


SELECT ARITMETICA.SUMA(4,3) FROM DUAL;
SELECT ARITMETICA.RESTA(4,3) FROM DUAL;
SELECT ARITMETICA.MULTIPLICA(4,3) FROM DUAL;
SELECT ARITMETICA.DIVIDE(4,3) FROM DUAL;



--5.6.2. Al paquete anterior añade una función llamada RESTO que reciba dos
--parámetros, el dividendo y el divisor, y devuelva el resto de la división.

CREATE OR REPLACE
PACKAGE aritmetica IS
  version NUMBER := 1.0;

  PROCEDURE mostrar_info;
  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION resto      (a NUMBER, b NUMBER) RETURN NUMBER;
END aritmetica;

CREATE OR REPLACE
PACKAGE BODY aritmetica IS

  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;

  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a+b);
  END suma;

  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a-b);
  END resta;

  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a*b);
  END multiplica;

  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a/b);
  END divide;
  
  FUNCTION resto     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN MOD(a,b);
  END resto;

END aritmetica;

SELECT ARITMETICA.RESTO(4,3) FROM DUAL;
SELECT ARITMETICA.RESTO(12,6) FROM DUAL;


--5.6.3. Al paquete anterior añade un procedimiento sin parámetros llamado AYUDA
--que muestre un mensaje por pantalla de los procedimientos y funciones disponibles
--en el paquete, su utilidad y forma de uso.

CREATE OR REPLACE
PACKAGE aritmetica IS
  version NUMBER := 1.0;

  PROCEDURE mostrar_info;
  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER;
  FUNCTION resto      (a NUMBER, b NUMBER) RETURN NUMBER;
  PROCEDURE ayuda;
END aritmetica;

CREATE OR REPLACE
PACKAGE BODY aritmetica IS

  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;

  FUNCTION suma       (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a+b);
  END suma;

  FUNCTION resta      (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a-b);
  END resta;

  FUNCTION multiplica (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a*b);
  END multiplica;

  FUNCTION divide     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN (a/b);
  END divide;
  
  FUNCTION resto     (a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN MOD(a,b);
  END resto;
  
  PROCEDURE AYUDA IS
  BEGIN
	DBMS_OUTPUT.PUT_LINE('-MOSTRAR_INFO: Te muestra información acerca de la versión del programa');
    DBMS_OUTPUT.PUT_LINE('-SUMA: Realiza la suma de ambos números introducidos por parámetros.');
  	DBMS_OUTPUT.PUT_LINE('-RESTA: Realiza la resta del primer número menos el segundo.');
  	DBMS_OUTPUT.PUT_LINE('-MULTIPLICA: Realiza la multiplicación de ambos números introducidos por parámetros.');
  	DBMS_OUTPUT.PUT_LINE('-DIVIDE: Realiza la division del primer número entre el segundo.');
 	DBMS_OUTPUT.PUT_LINE('-RESTO: Devuelve el resto de la división del primer número entre el segundo.');
  END mostrar_info;

END aritmetica;

BEGIN
	ARITMETICA.MOSTRAR_INFO;
END;
















