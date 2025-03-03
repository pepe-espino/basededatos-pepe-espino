-- 1. Cuántos costes básicos hay.
SELECT COUNT(costebasico) FROM asignatura;

-- 2. Para cada titulación, número de asignaturas junto con el nombre de la titulación.
SELECT t.nombre, COUNT(a.idasignatura) 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
GROUP BY t.nombre;

-- 3. Para cada titulación, nombre de la titulación junto con el precio total de sus asignaturas.
SELECT t.nombre, SUM(a.costebasico) 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
GROUP BY t.nombre;

-- 4. Coste global de Matemáticas incrementado en un 7%.
SELECT SUM(costebasico * 1.07) 
FROM asignatura 
WHERE idtitulacion = '130110';

-- 5. Alumnos matriculados en cada asignatura junto al id.
SELECT idasignatura, COUNT(idalumno) 
FROM alumno_asignatura 
GROUP BY idasignatura;

-- 6. Igual que el anterior pero con el nombre.
SELECT a.nombre, COUNT(aa.idalumno) 
FROM asignatura a 
JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura 
GROUP BY a.nombre;

-- 7. Nombre del alumno y total a pagar con incremento del 10% por matrícula.
SELECT p.nombre, SUM(asig.costebasico * (1 + (0.1 * aa.numeromatricula))) AS total_pago
FROM persona p
JOIN alumno al ON p.dni = al.dni
JOIN alumno_asignatura aa ON al.idalumno = aa.idalumno
JOIN asignatura asig ON aa.idasignatura = asig.idasignatura
GROUP BY p.nombre;

-- 8. Coste medio de las asignaturas de titulaciones cuyo coste total supera 60€.
SELECT t.nombre, AVG(a.costebasico) 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
GROUP BY t.nombre 
HAVING SUM(a.costebasico) > 60;

-- 9. Titulaciones con más de tres alumnos.
SELECT t.nombre 
FROM titulacion t 
JOIN asignatura a ON t.idtitulacion = a.idtitulacion 
JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura 
GROUP BY t.nombre 
HAVING COUNT(DISTINCT aa.idalumno) > 3;

-- 10. Nombre de cada ciudad y número de personas.
SELECT ciudad, COUNT(*) 
FROM persona 
GROUP BY ciudad;

-- 11. Nombre de cada profesor y número de asignaturas.
SELECT p.nombre, COUNT(a.idasignatura) 
FROM profesor pr 
JOIN persona p ON pr.dni = p.dni 
LEFT JOIN asignatura a ON pr.idprofesor = a.idprofesor 
GROUP BY p.nombre;

-- 12. Nombre de cada profesor y número de alumnos (si tienen 2 o más).
SELECT p.nombre, COUNT(DISTINCT aa.idalumno) AS num_alumnos
FROM profesor pr
JOIN persona p ON pr.dni = p.dni
JOIN asignatura a ON pr.idprofesor = a.idprofesor
JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura
GROUP BY p.nombre
HAVING COUNT(DISTINCT aa.idalumno) >= 2;

-- 13. Máximo de las sumas de costes básicos por cuatrimestre.
SELECT MAX(suma_coste) 
FROM (SELECT cuatrimestre, SUM(costebasico) AS suma_coste 
FROM asignatura 
GROUP BY cuatrimestre);

-- 14. Suma del coste de las asignaturas.
SELECT SUM(costebasico) FROM asignatura;

-- 15. Número de asignaturas.
SELECT COUNT(*) FROM asignatura;

-- 16. Coste de la asignatura más cara y más barata.
SELECT MAX(costebasico), MIN(costebasico) FROM asignatura;

-- 17. Posibilidades de créditos de asignatura.
SELECT COUNT(DISTINCT creditos) FROM asignatura;

-- 18. Cuántos cursos hay.
SELECT COUNT(DISTINCT curso) FROM asignatura;

-- 19. Cuántas ciudades hay.
SELECT COUNT(DISTINCT ciudad) FROM persona;

-- 20. Nombre y créditos de asignaturas.
SELECT nombre, creditos FROM asignatura;

-- 21. Asignaturas sin titulación.
SELECT nombre FROM asignatura WHERE idtitulacion IS NULL;

-- 22. Nombre completo, teléfono y dirección de personas.
SELECT nombre || ' ' || apellido AS NombreCompleto, telefono, direccioncalle || ' ' || TO_CHAR(direccionnum) AS Direccion FROM persona;

-- 23. Día siguiente al de nacimiento.
SELECT dni, fecha_nacimiento + 1 FROM persona;

-- 24. Años de las personas.
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM fecha_nacimiento) EDAD FROM persona p;

-- 25. Personas mayores de 25 años ordenadas.
SELECT nombre, apellido FROM persona WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_nacimiento) / 12) > 25 ORDER BY apellido, nombre;

-- 26. Profesores que son alumnos.
SELECT DISTINCT p.nombre || ' ' || p.apellido AS NombreCompleto
FROM profesor pr
JOIN persona p ON pr.dni = p.dni
JOIN alumno al ON p.dni = al.dni;

-- 27. Suma de créditos de Matemáticas.
SELECT SUM(creditos) FROM asignatura WHERE idtitulacion = '130110';

-- 28. Número de asignaturas de Matemáticas.
SELECT COUNT(*) FROM asignatura WHERE idtitulacion = '130110';

-- 29. Cuánto paga cada alumno.
SELECT p.nombre, SUM(a.costebasico * (1 + (0.1 * aa.numeromatricula))) AS total_pago
FROM persona p
JOIN alumno al ON p.dni = al.dni
JOIN alumno_asignatura aa ON al.idalumno = aa.idalumno
JOIN asignatura a ON aa.idasignatura = a.idasignatura
GROUP BY p.nombre;

-- 30. Número de alumnos por asignatura.
SELECT idasignatura, COUNT(idalumno) FROM alumno_asignatura GROUP BY idasignatura;


