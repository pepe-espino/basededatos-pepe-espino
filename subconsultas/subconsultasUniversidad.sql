--1

SELECT DISTINCT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA NOT IN ('150212','130113');

--2

SELECT A.NOMBRE
FROM ASIGNATURA a 
WHERE A.CREDITOS > (SELECT A.CREDITOS
					FROM ASIGNATURA a
					WHERE UPPER(a.NOMBRE) LIKE 'SEGURIDAD VIAL');

--3

SELECT DISTINCT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa 
WHERE AA.IDASIGNATURA IN ('150212','130113');

--4

SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa 
WHERE  

--5

SELECT a.nombre 
FROM ASIGNATURA a
WHERE a.IDTITULACION LIKE '130110'
AND a.COSTEBASICO > (SELECT AVG(a.COSTEBASICO) FROM asignatura a WHERE a.IDTITULACION LIKE '130110');

--6

SELECT AA.IDALUMNO
FROM ALUMNO_ASIGNATURA aa 
WHERE NOT EXISTS (
					SELECT 1
					FROM ALUMNO_ASIGNATURA aas 
					WHERE AAs.IDALUMNO = aa.IDALUMNO 
					AND AAS.IDASIGNATURA IN ('150212','130113'));

--7 

SELECT aa.IDALUMNO
FROM alumno_asignatura aa
WHERE aa.idasignatura = '150212'
AND aa.idalumno NOT IN (
    SELECT idalumno FROM alumno_asignatura WHERE idasignatura = '130113'
);


--8

--9

SELECT p.dni, p.nombre
FROM persona p
LEFT JOIN profesor pr ON p.dni = pr.dni
LEFT JOIN alumno al ON p.dni = al.dni
WHERE pr.dni IS NULL AND al.dni IS NULL;


--10

SELECT a.nombre
FROM asignatura a
WHERE a.creditos = (
    SELECT MAX(a2.creditos) FROM asignatura a2
);


--11

SELECT a.nombre
FROM asignatura a
LEFT JOIN alumno_asignatura aa ON a.idasignatura = aa.idasignatura
WHERE aa.idalumno IS NULL;
















