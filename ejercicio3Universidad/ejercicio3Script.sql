-- 1
SELECT COUNT(costebasico) FROM asignatura;

-- 2
SELECT t.nombre, COUNT(a.idasignatura) 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
GROUP BY t.nombre;

-- 3
SELECT t.nombre, SUM(a.costebasico) AS precioTotal
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
GROUP BY t.nombre;

-- 4
SELECT SUM(costebasico * CREDITOS * 1.07) 
FROM asignatura 
WHERE idtitulacion = '130110';

-- 5
SELECT idasignatura, COUNT(idalumno) 
FROM alumno_asignatura 
GROUP BY idasignatura;

-- 6
SELECT a.nombre, COUNT(aa.idalumno) 
FROM asignatura a 
JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura 
GROUP BY a.nombre;

-- 7
SELECT P.NOMBRE, SUM(A.COSTEBASICO * CREDITOS * (1 + (AA.NUMEROMATRICULA - 1) * 0.1)) AS TOTAL_A_PAGAR
FROM PERSONA P
JOIN ALUMNO AL ON P.DNI = AL.DNI
JOIN ALUMNO_ASIGNATURA AA ON AL.IDALUMNO = AA.IDALUMNO
JOIN ASIGNATURA A ON AA.IDASIGNATURA = A.IDASIGNATURA
GROUP BY P.NOMBRE;

-- 8
SELECT t.nombre, AVG(a.costebasico * a.CREDITOS) 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
GROUP BY t.nombre 
HAVING SUM(a.costebasico) > 60;

-- 9
SELECT t.nombre 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura 
GROUP BY t.nombre 
HAVING COUNT(aa.idalumno) > 3;

-- 10
SELECT ciudad, COUNT(*)AS numeroPersonas 
FROM persona 
GROUP BY ciudad;

-- 11
SELECT p.nombre, COUNT(a.idasignatura) 
FROM profesor pr 
JOIN persona p ON pr.dni = p.dni 
LEFT JOIN asignatura a ON pr.idprofesor = a.idprofesor
GROUP BY p.nombre
HAVING COUNT(A.IDASIGNATURA) >= 2;

-- 12
SELECT p.nombre, COUNT(DISTINCT aa.idalumno) AS num_alumnos
FROM profesor pr
JOIN persona p ON pr.dni = p.dni
JOIN asignatura a ON pr.idprofesor = a.idprofesor
JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura
GROUP BY p.nombre
HAVING COUNT(DISTINCT aa.idalumno) >= 2;

-- 13
SELECT MAX(suma_coste) 
FROM (SELECT cuatrimestre, SUM(costebasico) AS suma_coste 
FROM asignatura 
GROUP BY cuatrimestre);

-- 14
SELECT SUM(costebasico) FROM asignatura;

-- 15
SELECT COUNT(*) FROM asignatura;

-- 16
SELECT MAX(costebasico), MIN(costebasico) FROM asignatura;

-- 17
SELECT COUNT(DISTINCT creditos) FROM asignatura;

-- 18
SELECT COUNT(DISTINCT curso) FROM asignatura;

-- 19
SELECT COUNT(DISTINCT ciudad) FROM persona;

-- 20
SELECT nombre, creditos FROM asignatura;

-- 21
SELECT nombre FROM asignatura WHERE idtitulacion IS NULL;

-- 22
SELECT nombre || ' ' || apellido AS NombreCompleto, telefono, direccioncalle || ' ' || TO_CHAR(direccionnum) AS Direccion FROM persona;

-- 23
SELECT dni, fecha_nacimiento + 1 FROM persona;

-- 24
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM fecha_nacimiento) EDAD FROM persona p;

-- 25
SELECT nombre, apellido FROM persona WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_nacimiento) / 12) > 25 ORDER BY apellido, nombre;

-- 26
SELECT DISTINCT p.nombre || ' ' || p.apellido AS NombreCompleto
FROM profesor pr
JOIN persona p ON pr.dni = p.dni
JOIN alumno al ON p.dni = al.dni;

-- 27
SELECT SUM(creditos) FROM asignatura WHERE idtitulacion = '130110';

-- 28
SELECT COUNT(*) FROM asignatura WHERE idtitulacion = '130110';

-- 29
SELECT p.nombre, SUM(a.costebasico * (1 + (0.1 * aa.numeromatricula))) AS total_pago
FROM persona p
JOIN alumno al ON p.dni = al.dni
JOIN alumno_asignatura aa ON al.idalumno = aa.idalumno
JOIN asignatura a ON aa.idasignatura = a.idasignatura
GROUP BY p.nombre;

-- 30
SELECT idasignatura, COUNT(idalumno) FROM alumno_asignatura GROUP BY idasignatura;


