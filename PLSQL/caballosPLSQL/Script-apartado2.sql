--2. Implementa la FUNCIÓN listadocaballos que muestre en consola el siguiente listado y que
--devuelva el número de caballos mostrados en el listado. Deberás utilizar cursores e indicar en
--un comentario en el código el tipo de cursor que estás utilizando.


CREATE OR REPLACE FUNCTION listadocaballos RETURN NUMBER 
IS
    CURSOR cur_caballos IS
        SELECT c.codcaballo, c.nombre AS nombre_caballo, c.peso, c.nacionalidad,
               p.nombre AS nombre_propietario
        FROM caballos c
        JOIN personas p ON c.propietario = p.codigo
        ORDER BY c.nacionalidad DESC, p.nombre;

    CURSOR cur_carreras(p_codcaballo caballos.codcaballo%TYPE) IS
        SELECT ca.nombrecarrera, ca.fechahora, ca.importepremio,
               pa.posicionfinal, 
               (SELECT nombre FROM personas WHERE codigo = pa.jockey) AS nombre_jockey
        FROM participaciones pa
        JOIN carreras ca ON ca.codcarrera = pa.codcarrera
        WHERE pa.codcaballo = p_codcaballo
        ORDER BY ca.nombrecarrera, ca.fechahora DESC;
    
    v_total_caballos NUMBER := 0;
    v_ganadas NUMBER := 0;
    v_total_premios NUMBER := 0;

BEGIN
    DBMS_OUTPUT.PUT_LINE('INFORME DE LOS CABALLOS EXISTENTES EN LA BASE DE DATOS');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');

    FOR caballo IN cur_caballos LOOP
        v_total_caballos := v_total_caballos + 1;
        v_ganadas := 0;
        v_total_premios := 0;

        DBMS_OUTPUT.PUT_LINE('Caballo: ' || caballo.nombre_caballo);
        DBMS_OUTPUT.PUT_LINE('Peso: ' || caballo.peso);
        DBMS_OUTPUT.PUT_LINE('Nombre del Propietario: ' || caballo.nombre_propietario);

        DBMS_OUTPUT.PUT_LINE(
            RPAD('Nombre de Carrera', 25) ||
            RPAD('Nombre del jockey', 25) ||
            RPAD('Fecha', 15) ||
            RPAD('Posición Final', 17) ||
            'Importe Premio'
        );

        FOR carrera IN cur_carreras(caballo.codcaballo) LOOP
            DBMS_OUTPUT.PUT_LINE(
                RPAD(carrera.nombrecarrera, 25) ||
                RPAD(carrera.nombre_jockey, 25) ||
                RPAD(TO_CHAR(carrera.fechahora, 'DD/MM/YYYY'), 15) ||
                RPAD(carrera.posicionfinal, 17) ||
                TO_CHAR(carrera.importepremio)
            );

            IF carrera.posicionfinal = 1 THEN
                v_ganadas := v_ganadas + 1;
                v_total_premios := v_total_premios + carrera.importepremio;
            END IF;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Número de carreras ganadas: ' || v_ganadas);
        DBMS_OUTPUT.PUT_LINE('Total del importe de todos sus premios: ' || v_total_premios);
    END LOOP;

    RETURN v_total_caballos;
END;


--3. Realizar un PROCEDIMIENTO agregarcaballos que reciba como argumento el nombre, peso,
--fecha de nacimiento, nacionalidad y el dni y el nombre del dueño. El procedimiento debe
--insertar el dueño si este no existe, y luego insertar el caballo. Si hay algún fallo debe dejar la
--base de datos como estaba, es decir, no puede insertar el dueño si no puede insertar el
--caballo. Si la nacionalidad no tiene ningún valor se le pondrá “ESPAÑOL”. Debes controlar las
--posibles excepciones, por ejemplo si el caballo ya existe deberás lanzar una excepción
--personalizada indicando el mensaje “El caballo que está intentando insertar ya existe”.


CREATE OR REPLACE
PROCEDURE agregarcaballos(
    p_caballo IN caballos.nombre%TYPE,
    p_peso IN caballos.peso%TYPE,
    p_fechanac IN caballos.fechanac%TYPE,
    p_nacionalidad IN caballos.nacionalidad%TYPE,
    p_dni_dueno IN personas.dni%TYPE,
    p_nombre_dueno IN personas.nombre%TYPE
)
IS
    v_coddueno personas.codigo%TYPE;
    v_nacionalidad caballos.nacionalidad%TYPE := NVL(p_nacionalidad, 'ESPAÑOL');

    exception_caballo_existe EXCEPTION;

BEGIN

    FOR c IN (SELECT 1 FROM caballos WHERE nombre = p_caballo) LOOP
        RAISE exception_caballo_existe;
    END LOOP;

    SELECT codigo INTO v_coddueno
    FROM personas
    WHERE dni = p_dni_dueno;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO personas (codigo, nombre, dni)
        VALUES (personas_seq.NEXTVAL, p_nombre_dueno, p_dni_dueno);

    WHEN OTHERS THEN
        ROLLBACK TO SAVEPOINT inicio;
        RAISE;

BEGIN
    INSERT INTO caballos (codcaballo, nombre, peso, fechanac, nacionalidad, propietario)
    VALUES (caballos_seq.NEXTVAL, p_caballo, p_peso, p_fechanac, v_nacionalidad, v_coddueno);

    COMMIT;

EXCEPTION
    WHEN exception_caballo_existe THEN
        RAISE_APPLICATION_ERROR(-20001, 'El caballo que está intentando insertar ya existe');

    WHEN OTHERS THEN
        ROLLBACK;
END;



















