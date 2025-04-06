CREATE OR REPLACE FUNCTION listadocaballos RETURN NUMBER IS
    CURSOR cur_caballos IS
        SELECT c.codcaballo, c.nombre AS nombre_caballo, c.peso, c.nacionalidad,
               p.nombre AS nombre_propietario
        FROM caballos c
        JOIN personas p ON c.propietario = p.codigo
        ORDER BY c.nacionalidad DESC, nombre_propietario;

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
END;

BEGIN
	DBMS_OUTPUT.PUT_LINE(listadocaballos);
END;







