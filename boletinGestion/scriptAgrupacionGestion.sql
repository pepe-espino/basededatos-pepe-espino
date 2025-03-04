--1 
SELECT AVG(dto) FROM facturas;

--2
SELECT AVG(dto) FROM facturas WHERE dto IS NOT NULL;

--3.
SELECT AVG(NVL(dto, 0)) FROM facturas;

--4.
SELECT COUNT(*) FROM facturas;

--5. 
SELECT COUNT(*) FROM pueblos WHERE codpro IN ('12', '03', '46');

--6. 
SELECT SUM(stock * precio) FROM articulos;

--7. 
SELECT COUNT(DISTINCT codpue) 
FROM clientes 
WHERE codpostal LIKE '12%';

--8. 
SELECT MAX(stock), MIN(stock), MAX(stock) - MIN(stock) 
FROM articulos 
WHERE precio BETWEEN 9 AND 12;

--9. 
SELECT AVG(precio) 
FROM articulos 
WHERE stock > 10;

--10. 
SELECT MIN(fecha), MAX(fecha) 
FROM facturas 
WHERE codcli = 210;

--11. 
SELECT COUNT(*) 
FROM articulos 
WHERE stock IS NULL;

--12. 
SELECT COUNT() FROM lineas_fac) * 100, 1) 
FROM lineas_fac 
WHERE dto IS NULL;

--13. 
SELECT codcli, COUNT(*) 
FROM facturas 
GROUP BY codcli;

--14. 
SELECT codcli, COUNT(*) 
FROM facturas 
GROUP BY codcli 
HAVING COUNT(*) >= 2;

--15. 
SELECT SUM(cant * precio) 
FROM lineas_fac;

--16. 
SELECT SUM(cant * precio) 
FROM lineas_fac 
WHERE LOWER(codart) LIKE '%a%';

--17. 
SELECT fecha, COUNT(*) 
FROM facturas 
GROUP BY fecha;

--18. 
SELECT p.nombre, COUNT(*) AS num_clientes 
FROM clientes c 
JOIN pueblos p ON c.codpue = p.codpue 
GROUP BY p.nombre 
ORDER BY num_clientes DESC;

---19. 
SELECT p.nombre, COUNT(*) AS num_clientes 
FROM clientes 
JOIN pueblos p ON clientes.codpue = p.codpue 
GROUP BY p.nombre 
HAVING COUNT(clientes.CODCLI) > 2 
ORDER BY num_clientes DESC;

--20. 
SELECT articulos.descrip, SUM(cant) 
FROM lineas_fac 
JOIN articulos ON lineas_fac.codart = articulos.codart 
WHERE articulos.codart LIKE 'P%' 
GROUP BY articulos.codart, articulos.descrip;

--21. 
SELECT MAX(precio) AS precioMaximo, MIN(precio) precioMinimo
FROM lineas_fac 
WHERE LOWER(codart) LIKE 'c%' 
GROUP BY codart;

--22
SELECT MAX(precio) AS precioMaximo, MIN(precio) precioMinimo, MAX(PRECIO)-MIN(PRECIO) AS diferencia 
FROM lineas_fac 
WHERE LOWER(codart) LIKE 'c%' 
GROUP BY codart;

--23. 
SELECT a.descrip FROM articulos a 
JOIN lineas_fac l ON a.codart = l.codart 
GROUP BY a.descrip 
HAVING SUM(l.cant * l.precio) > 10000;

--24. 
SELECT DISTINCT codcli, iva, COUNT(CODFAC)  
FROM facturas 
WHERE codcli BETWEEN 150 AND 300
GROUP BY CODCLI , iva;

--25. 
SELECT AVG(SUM(lf.PRECIO*lf.CANT)) AS mediaImporte FROM LINEAS_FAC lf
GROUP BY LF.CODFAC;












