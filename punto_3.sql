Nota: 

Para el ejercicio, se asumió que las variables que tienen el simbolo
# son los ID por tablas y que se encuentran disponibles entre tablas 
para realizar conexiones entre ellas. Por ejemplo: asumo que la variable #cedula se encuentra en la tabla pedido. 


Muestre el nombre de cada cliente y el nombre
de cada producto que ha comprado

SELECT DISTINCT
cli.nombre AS nombre_cliente,
prod.nombre AS nombre_producto
FROM pedido pe
INNER JOIN cliente cli
ON (pe.cedula = cli.cedula)
INNER JOIN producto prod
ON (prod.codigo_producto = pe.codigo_producto); 

¿Cuáles son los productos que no han sido vendidos? s

SELECT prod.nombre AS nombre_producto
FROM producto prod
WHERE prod.codigo_producto NOT IN (SELECT pe.codigo_producto
FROM pedido pe);


Muestre el nombre del último o los últimos 
productos que se hayan vendido. 

SELECT
prod.nombre AS nombre_producto
FROM pedido pe
INNER JOIN producto prod
ON (prod.codigo_producto = pe.codigo_producto) 
ORDER  BY pe.fecha DESC
LIMIT 1;


Muestre el nombre del cliente y el número total de productos 
que ha comprado ordenados por el total de productos 
de manera descendente.

SELECT
cli.nombre as nombre_cliente,
SUM(prod.cantidad) AS total
FROM pedido pe
INNER JOIN cliente cli
ON (pe.cedule = cli.cedula)
INNER JOIN producto prod
ON (prod.codigo_producto = pe.codigo_producto)
GROUP BY nombre_cliente
ORDER BY total;



Muestre cada uno de los días de la tabla pedido y 
cuanto se vendió en ese día
organizado de menor a mayor fecha.

SELECT 
pe.fecha,
SUM(pe.cantidad*prod.precio) AS total_vendido
FROM pedido pe
INNER JOIN producto prod
ON (prod.codigo_producto = pe.codigo_producto)
GROUP BY pe.fecha
ORDER BY pe.fecha ASC


Muestre todos los datos de las personas que son de ‘Cali’ 
y han hecho compras superiores a 1 millón de pesos. 

SELECT DISTINCT
cli.cedula,
cli.nombre,
cli.ciudad,
cli.telefono
FROM cliente cli
INNER JOIN pedido pe
ON (cli.cedula = pe.cedula)
INNER JOIN producto prod
ON (pe.codigo_producto = prod.codigo)
WHERE cli.ciudad = 'Cali'
GROUP BY cli.cedula, cli.nombre
HAVING sum(prod.precio*pe.cantidad) > 1000000


Muestre todos los datos de los productos que son más 
baratos que un ‘Portátil’ y
más caros que un ‘Lapicero’.


SELECT 
prod.nombre AS nombre_producto,
prod.precio
FROM producto prod
WHERE prod.precio > (SELECT precio FROM producto WHERE nombre = 'Lapicero')
AND prod.precio < (SELECT precio FROM producto WHERE nombre = 'Pórtatil')


Muestre todos los datos de los clientes que no han comprado ningún producto.

SELECT 
cli.cedula, 
cli.nombre AS nombre cliente
FROM cliente cli
WHERE cli.cedula NOT IN (SELECT ped.cedula FROM pedido ped);
