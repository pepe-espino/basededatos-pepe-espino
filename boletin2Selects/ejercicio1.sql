-- 1
SELECT Nombre, Creditos FROM asignatura;

-- 2
SELECT DISTINCT Creditos FROM asignatura;

-- 3
SELECT * FROM persona;

-- 4
SELECT Nombre, Creditos FROM asignatura WHERE Cuatrimestre = 1;

-- 5
SELECT Nombre, Apellido FROM persona WHERE EXTRACT(YEAR FROM Fecha_nacimiento) < '1975';

-- 6
SELECT Nombre, Costebasico FROM asignatura WHERE Creditos > 4.5;

-- 7
SELECT Nombre FROM asignatura WHERE Costebasico BETWEEN 25 AND 35;

-- 8
SELECT DISTINCT Idalumno FROM alumno_asignatura WHERE Idasignatura IN ('150212', '130113');

-- 9
SELECT Nombre FROM asignatura WHERE Cuatrimestre = 2 AND Creditos != 6;

-- 10
SELECT Nombre, Apellido FROM persona WHERE Apellido LIKE 'G%';

-- 11
SELECT Nombre FROM asignatura WHERE Idtitulacion IS NULL;

-- 12
SELECT Nombre FROM asignatura WHERE Idtitulacion IS NOT NULL;

-- 13
SELECT Nombre FROM asignatura WHERE Costebasico / Creditos > 8;

-- 14
SELECT Nombre, Creditos * 10 Horas FROM asignatura;

-- 15
SELECT * FROM asignatura WHERE Cuatrimestre = 2 ORDER BY Idasignatura;

-- 16
SELECT Nombre FROM persona WHERE Ciudad = 'Madrid' AND Varon = 0;

-- 17
SELECT Nombre, Telefono FROM persona WHERE Telefono LIKE '91%';

-- 18
SELECT Nombre FROM asignatura WHERE lower(Nombre) LIKE '%pro%';

-- 19
SELECT Nombre FROM asignatura WHERE Curso = 1 AND Idprofesor = 'P101';

-- 20
SELECT DISTINCT aa.Idalumno, aa.Idasignatura FROM ALUMNO_ASIGNATURA aa
WHERE NUMEROMATRICULA >= 3;

--Aqui se puede utilizar el decode: SELECT cod_book, decode (cod_book, 4, 'Pepito Grillo', 5, 'Peter Pan', 'Other cases') translation FROM books;
-- 21
SELECT Nombre, Costebasico, Costebasico * 1.1 Primera_Repeticion, Costebasico * 1.3 Segunda_Repeticion, Costebasico * 1.6 Tercera_Repeticion FROM asignatura;

SELECT A.NOMBRE ,AA.NUMEROMATRICULA, DECODE (AA.NUMEROMATRICULA, 1, A.COSTEBASICO, 2, A.COSTEBASICO * 1.1, 3, A.COSTEBASICO * 1.3, A.COSTEBASICO * 1.6) COSTE_ULTIMA_MATRICULA FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa
WHERE A.IDASIGNATURA = AA.IDASIGNATURA;

-- 22
SELECT * FROM persona WHERE EXTRACT(FROM Fecha_nacimiento) < '1970';

SELECT * FROM PERSONA p WHERE FECHA_NACIMIENTO < TO_DATE('1970','YYYY');

-- 23
SELECT DISTINCT DNI FROM profesor;

-- 24
SELECT Idalumno FROM alumno_asignatura WHERE Idasignatura = '130122';

-- 25
SELECT DISTINCT Idasignatura FROM alumno_asignatura;

-- 26
SELECT Nombre FROM asignatura WHERE Creditos > 4 AND (Cuatrimestre = 1 OR Curso = 1);

-- 27
SELECT DISTINCT a.Idtitulacion FROM asignatura a
JOIN TITULACION t ON T.IDTITULACION = a.IDTITULACION;

-- 28
SELECT Dni FROM persona WHERE Apellido LIKE '%g%' OR Apellido LIKE '%G%';

-- 29
SELECT * FROM persona WHERE Varon = 1 AND Fecha_nacimiento > TO_DATE('1970-01-01', 'YYYY-MM-DD') AND Ciudad LIKE 'M%';
















