1. Lista el nombre de todos los productos que hay en la tabla producto.

SELECT p.nombre 
FROM producto p;

2. Lista los nombres y los precios de todos los productos de la tabla producto.

SELECT p.nombre , p.precio 
FROM producto p;

3. Lista todas las columnas de la tabla producto.

SELECT *
FROM producto p;

4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).

SELECT p.nombre, p.precio as precio_en_euros, p.precio*1.09 as precio_en_dolares 
FROM producto p;

5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza
los siguientes alias para las columnas: nombre de producto, euros, dólares.

SELECT p.nombre as nombre_de_producto, p.precio as euros, p.precio*1.09 as dolares 
FROM producto p;

6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres
a mayúscula.

SELECT UPPER(p.nombre) as nombre , p.precio 
FROM producto p;

7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres
a minúscula.

SELECT LOWER(p.nombre) as nombre , p.precio 
FROM producto p ;

8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los
dos primeros caracteres del nombre del fabricante.

SELECT f.nombre as nombre, UPPER(SUBSTRING(f.nombre, 1, 2)) 
FROM fabricante f ;

9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del
precio.

SELECT p.nombre , ROUND(p.precio) 
FROM producto p ;

10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del
precio para mostrarlo sin ninguna cifra decimal.

SELECT p.nombre , TRUNCATE(p.precio, 0) 
FROM producto p ;

11. Lista el identificador de los fabricantes que tienen productos en la tabla producto.

SELECT f.id 
FROM fabricante f
WHERE f.id IN (SELECT p.id_fabricante FROM producto p);

12. Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los iden‑
tificadores que aparecen repetidos.

SELECT DISTINCT f.id 
FROM fabricante f
WHERE f.id IN (SELECT p.id_fabricante FROM producto p);

13. Lista los nombres de los fabricantes ordenados de forma ascendente.

SELECT f.nombre 
FROM fabricante f 
order by f.nombre asc; 

14. Lista los nombres de los fabricantes ordenados de forma descendente.

SELECT f.nombre 
FROM fabricante f 
order by f.nombre DESC; 



