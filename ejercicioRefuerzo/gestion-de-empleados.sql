--1

SELECT e.apellido1
from empleado e ;

--2

select DISTINCT  e.apellido1
from empleado e; 

--3

select *
from empleado e; 

--4

SELECT e.nombre, e.apellido1, e.apellido2
from empleado e ;

--5

----------------------------------------------------------------
CONSULTAS MULTITABLAS

--1

select e.nombre, e.apellido1, e.apellido2, d.*
FROM empleado e 
join departamento d on d.id = e.id_departamento;

--2

select e.nombre, e.apellido1, e.apellido2, d.*
FROM empleado e 
join departamento d on d.id = e.id_departamento
order by d.nombre, e.apellido1, e.apellido2, e.nombre;

--3

select d.id, d.nombre
from departamento d
join empleado e on e.id_departamento = d.id;

--4

select d.id, d.nombre, d.presupuesto-d.gastos as presupuesto_actual
from departamento d
join empleado e on e.id_departamento = d.id;

--5

select d.nombre, e.nif, e.id_departamento, e.apellido1
from departamento d 
join empleado e on e.id_departamento = d.id
where UPPER(e.nif) like '38382980M';

--6

select d.nombre
from departamento d
join empleado e on e.id_departamento = d.id
where upper(e.nombre ) like 'PEPE' AND UPPER(e.apellido1) like 'RUIZ' AND UPPER(e.apellido2) LIKE 'SANTANA';

------------------------------------------------------------------------

--1

select e.nombre, e.apellido1, e.apellido2
from empleado e 
where e.id_departamento = (select d.id
						   from departamento d
						   where UPPER(d.nombre) like 'SISTEMAS');

--2

select d.nombre, d.presupuesto
from departamento d
where d.presupuesto = (select MAX(d2.presupuesto)
					   from departamento d2);

--3

select d.nombre, d.presupuesto
from departamento d
where d.presupuesto = (select MIN(d2.presupuesto)
					   from departamento d2);

----------------------------------
/*SUBCONSULTAS CON IN Y NOT IN   */

--8

SELECT d.nombre
FROM departamento d
where d.id IN (select e.id_departamento
				from empleado e);

--9

SELECT d.nombre
FROM departamento d
where d.id NOT IN (select e.id_departamento
				from empleado e);

/* EXIST Y NOT EXIST  */


--10

SELECT d.nombre
from departamento d 
where 






















