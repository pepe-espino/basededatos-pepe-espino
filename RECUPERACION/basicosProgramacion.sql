/*

1. Realizar un procedure que muestre los números múltiplos de 5 de 0 a 100.
2. Procedure que muestre por pantalla todos los números comprendidos entre 1 y 100 que son
múltiplos de 7 o de 13.
3. Realizar un procedure que muestre los número múltiplos del primer parámetro que van desde el
segundo parámetro hasta el tercero.
4. Procedure que reciba un número entero por parámetro y visualice su tabla de multiplicar
5. Realizar un procedure que muestre los número comprendidos desde el primer parámetro hasta
el segundo.
6. Realizar un procedure que cuente de 20 en 20, desde el primer parámetro hasta el segundo.
7. Realizar un procedure que reciba dos números como parámetro, y muestre el resultado de
elevar el primero parámetro al segundo.
8. Realizar un procedure que reciba dos números como parámetro y muestre el resultado de elevar
el primero número a 1, a 2... hasta el segundo número.
9. Procedure que tome un número N que se le pasa por parámetro y muestre la suma de los N
primeros números.
10. Función que tome como parámetros dos números enteros A y B, y calcule el producto de A y B
mediante sumas, mostrando el resultado y devolviéndolo.
11. Procedure que tome como parámetros dos números B y E enteros positivos, y calcule la potencia
(B elevado a E) a través de productos.
12. Realizar un procedure que reciba como parámetro un número entero positivo N y calcule el
factorial.
Factorial (0)= 1
Factorial (1)= 1
Factorial (N) = N * Factorial(N – 1)
13. Realizar un procedure que reciba como parámetros número N entero positivo y calcule la suma
de los inversos de N es decir
1/1 + 1/2 + 1/3 + 1/4 + ...... 1/N

*/


----------------------------------------------------
---------------- ejercicio 1 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE MULTIPLOS_DE_5
IS
BEGIN
    FOR I IN 0 .. 100 LOOP
        IF MOD(I, 5) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(I);
        END IF;
    END LOOP;
END;


----------------------------------------------------
---------------- ejercicio 2 -----------------------
----------------------------------------------------

CREATE OR REPLACE PROCEDURE MULTIPLOS_DE_7_O_13
IS
BEGIN
    FOR I IN 1 .. 100 LOOP
        IF MOD(I, 7) = 0 OR MOD(I, 13) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(I);
        END IF;
    END LOOP;
END;


----------------------------------------------------
---------------- ejercicio 3 -----------------------
----------------------------------------------------

CREATE OR REPLACE PROCEDURE MULTIPLOS_PERSONALIZADOS (P_MULTIPLO IN NUMBER,P_INICIO IN NUMBER,P_FIN IN NUMBER)
IS
BEGIN
    FOR I IN P_INICIO .. P_FIN LOOP
        IF MOD(I, P_MULTIPLO) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(I);
        END IF;
    END LOOP;
END;


----------------------------------------------------
---------------- ejercicio 4 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE TABLA_MULTIPLICAR (P_NUM IN NUMBER)
IS
BEGIN
    FOR I IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(P_NUM || ' x ' || I || ' = ' || (P_NUM * I));
    END LOOP;
END;



----------------------------------------------------
---------------- ejercicio 5 -----------------------
----------------------------------------------------

CREATE OR REPLACE PROCEDURE MOSTRAR_RANGO (P_INICIO IN NUMBER,P_FIN IN NUMBER)
IS
BEGIN
    FOR I IN P_INICIO .. P_FIN LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;


----------------------------------------------------
---------------- ejercicio 6 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE CONTAR_DE_20_EN_20 (P_INICIO IN NUMBER,P_FIN IN NUMBER)
IS
    I NUMBER := P_INICIO;
BEGIN
    WHILE I <= P_FIN LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 20;
    END LOOP;
END;


----------------------------------------------------
---------------- ejercicio 7 -----------------------
----------------------------------------------------

CREATE OR REPLACE PROCEDURE ELEVAR_NUMERO (P_BASE IN NUMBER,P_EXPONENTE IN NUMBER
)
IS
    V_RESULTADO NUMBER := 1;
BEGIN
    FOR I IN 1 .. P_EXPONENTE LOOP
        V_RESULTADO := V_RESULTADO * P_BASE;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('RESULTADO: ' || V_RESULTADO);
END;


----------------------------------------------------
---------------- ejercicio 8 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE POTENCIAS_SUCECIVAS (P_BASE IN NUMBER,P_MAXEXP IN NUMBER)
IS
    V_RESULTADO NUMBER;
BEGIN
    FOR I IN 1 .. P_MAXEXP LOOP
        V_RESULTADO := 1;
        FOR J IN 1 .. I LOOP
            V_RESULTADO := V_RESULTADO * P_BASE;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(P_BASE || ' ^ ' || I || ' = ' || V_RESULTADO);
    END LOOP;
END;



----------------------------------------------------
---------------- ejercicio 9 -----------------------
----------------------------------------------------

CREATE OR REPLACE PROCEDURE SUMA_PRIMEROS_N (P_N IN NUMBER)
IS
    V_SUMA NUMBER := 0;
BEGIN
    FOR I IN 1 .. P_N LOOP
        V_SUMA := V_SUMA + I;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('SUMA = ' || V_SUMA);
END;



----------------------------------------------------
---------------- ejercicio 10 -----------------------
----------------------------------------------------


CREATE OR REPLACE FUNCTION PRODUCTO_CON_SUMAS (P_A IN NUMBER,P_B IN NUMBER)
RETURN NUMBER
IS
    V_RESULTADO NUMBER := 0;
BEGIN
    FOR I IN 1 .. P_B LOOP
        V_RESULTADO := V_RESULTADO + P_A;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('RESULTADO = ' || V_RESULTADO);
    RETURN V_RESULTADO;
END;



----------------------------------------------------
---------------- ejercicio 11 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE POTENCIA_CON_PRODUCTOS (P_BASE IN NUMBER,P_EXPONENTE IN NUMBER)
IS
    V_RESULTADO NUMBER := 1;
BEGIN
    FOR I IN 1 .. P_EXPONENTE LOOP
        V_RESULTADO := V_RESULTADO * P_BASE;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('RESULTADO = ' || V_RESULTADO);
END;


----------------------------------------------------
---------------- ejercicio 12 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE FACTORIAL (P_N IN NUMBER)
IS
    V_RESULTADO NUMBER := 1;
BEGIN
    IF P_N < 0 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: EL NÚMERO DEBE SER POSITIVO.');
        RETURN;
    END IF;

    FOR I IN 2 .. P_N LOOP
        V_RESULTADO := V_RESULTADO * I;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('FACTORIAL = ' || V_RESULTADO);
END;


----------------------------------------------------
---------------- ejercicio 13 -----------------------
----------------------------------------------------


CREATE OR REPLACE PROCEDURE SUMA_INVERSOS (P_N IN NUMBER)
IS
    V_SUMA NUMBER := 0;
BEGIN
    IF P_N < 1 THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: EL NÚMERO DEBE SER MAYOR O IGUAL A 1.');
        RETURN;
    END IF;

    FOR I IN 1 .. P_N LOOP
        V_SUMA := V_SUMA + (1 / I);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('SUMA DE INVERSOS = ' || V_SUMA);
END;













