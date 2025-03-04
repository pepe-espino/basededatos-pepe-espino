-- 1. Lista el primer apellido de todos los empleados.

SELECT primer_apellido FROM empleado;

-- 2. Lista el primer apellido de los empleados eliminando los apellidos repetidos.

SELECT DISTINCT primer_apellido FROM empleado;

-- 3. Lista todas las columnas de la tabla empleado.

SELECT * FROM empleado;

-- 4. Lista el nombre y los apellidos de todos los empleados.

SELECT nombre, primer_apellido, segundo_apellido FROM empleado;

-- 5. Lista el identificador de los departamentos de los empleados.

SELECT codigo FROM empleado;

-- 6. Lista los identificadores de los departamentos eliminando repetidos.

SELECT DISTINCT codigo FROM empleado;

-- 7. Lista el nombre y apellidos en una única columna.

SELECT CONCAT(nombre, ' ', primer_apellido, ' ', segundo_apellido) nombre_completo FROM empleado;

-- 8. Lista el nombre y apellidos en una única columna en mayúscula.

SELECT UPPER(CONCAT(nombre, ' ', primer_apellido, ' ', segundo_apellido))  nombre_completo FROM empleado;

-- 9. Lista el nombre y apellidos en una única columna en minúscula.

SELECT LOWER(CONCAT(nombre, ' ', primer_apellido, ' ', segundo_apellido ))  nombre_completo FROM empleado;

-- 10. Lista el identificador de los empleados junto con su NIF dividido en dos columnas.

SELECT codigo, nif FROM empleado;

-- 11. Lista el nombre de cada departamento y su presupuesto actual.

SELECT nombre, (presupuesto - gastos) presupuesto_actual FROM departamento;

-- 12. Lista el nombre de los departamentos con el presupuesto actual ordenado de forma ascendente.

SELECT nombre, (presupuesto - gastos)  presupuesto_actual FROM departamento ORDER BY presupuesto_actual ASC;

---------------------------------------------------------------------

-- 1. Lista empleados con datos de los departamentos donde trabajan.

SELECT e.NOMBRE, e.primer_apellido , e.segundo_apellido , d.codigo, d.NOMBRE, d.presupuesto , d.gastos 
FROM empleado e 
LEFT JOIN departamento d ON e.codigo = d.codigo ;

-- 2. Igual que la anterior, pero ordenado por departamento y apellidos.

SELECT * FROM empleado e 
WHERE e.cod_departamento IS NULL;

-- 3. Lista identificador y nombre de los departamentos con empleados.

SELECT DISTINCT d.codigo, d.nombre 
FROM departamento d JOIN empleado e ON d.codigo = e.codigo;

-- 4. Lista identificador, nombre y presupuesto actual solo de departamentos con empleados.

SELECT d.codigo, d.nombre, (d.presupuesto - d.gastos) presupuesto_actual 
FROM departamento d JOIN empleado e ON d.codigo = e.codigo;

-- 5. Devuelve el nombre del departamento donde trabaja el empleado con NIF 38382980M.

SELECT d.nombre FROM departamento d 
JOIN empleado e ON d.codigo = e.codigo 
WHERE e.nif = '38382980M';

-- 6. Devuelve el nombre del departamento donde trabaja Pepe Ruiz Santana.

SELECT d.nombre FROM departamento d 
JOIN empleado e ON d.codigo = e.codigo 
WHERE UPPER(e.nombre) = 'PEPE' AND UPPER(e.primer_apellido) = 'RUIZ' AND UPPER(e.segundo_apellido) = 'SANTANA';

-- 7. Lista empleados que trabajan en I+D, ordenados alfabéticamente.

SELECT * FROM empleado WHERE codigo = (SELECT codigo FROM departamento WHERE nombre = 'I+D') ORDER BY nombre;

-- 8. Lista empleados que trabajan en Sistemas, Contabilidad o I+D.

SELECT * FROM empleado 
WHERE codigo IN (SELECT codigo FROM departamento WHERE nombre IN ('Sistemas', 'Contabilidad', 'I+D'))
ORDER BY nombre;

-- 9. Lista empleados cuyos departamentos no tienen un presupuesto entre 100000 y 200000 euros.

SELECT e.* FROM empleado e 
JOIN departamento d ON e.codigo = d.codigo 
WHERE d.presupuesto NOT BETWEEN 100000 AND 200000;

-- 10. Lista nombres de departamentos con empleados cuyo segundo apellido es NULL.

SELECT DISTINCT d.nombre FROM departamento d 
JOIN empleado e ON d.codigo = e.codigo 
WHERE e.segundo_apellido IS NULL;

-- 11. Lista empleados con los departamentos donde trabajan, incluyendo los que no tienen departamento.

SELECT e.*, d.* FROM empleado e 
LEFT JOIN departamento d ON e.codigo = d.codigo;

-- 12. Lista solo empleados sin departamento.

SELECT * FROM empleado WHERE codigo IS NULL;

-- 13. Lista solo departamentos sin empleados.

SELECT * FROM departamento d 
LEFT JOIN empleado e ON e.cod_departamento = d.codigo 
WHERE e.codigo IS NULL;

-- 14. Lista todos los empleados y departamentos, incluyendo los que no tienen relación entre sí.

SELECT * FROM empleado e 
LEFT JOIN departamento d ON e.codigo = d.codigo UNION 
SELECT * FROM departamento d
LEFT JOIN empleado e ON e.codigo = d.codigo
ORDER BY d.nombre ;

-- 15. Lista empleados sin departamento y departamentos sin empleados.

SELECT d.codigo, d.nombre NOMBREDEP FROM empleado e 
LEFT JOIN departamento d ON e.codigo = d.codigo 
WHERE d.codigo IS NULL
UNION 
SELECT d.codigo, d.nombre NOMBREDEP FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.cod_departamento 
WHERE e.cod_departamento IS NULL
ORDER BY NOMBREDEP ASC;

-- dEBES PONER UN ALIAS PARA QUE DETECTE QUE SON LO MISMO--


