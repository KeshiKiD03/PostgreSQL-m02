-- 1. Mostar les ventes individuals dels productes dels fabricants 'aci' i 'rei' que comencin per 'Bisagra' o 'Articulo'. Mostrar també el total venut d'aquests productes.

SELECT 'Compra : ', empresa, fecha_pedido as data, importe from pedidos JOIN clientes on clie=num_clie 
 UNION 
SELECT 'Total :', empresa, current_date as data, sum(importe) FROM pedidos JOIN clientes ON clie=num_clie GROUP BY empresa 
UNION 
SELECT 'Total General :', '--------', current_date as data, sum(importe) FROM pedidos ORDER BY empresa, data;






SELECT 'Venta individual : ', pe.fab, pr.descripcion, pe.producto, pe.importe
FROM pedidos pe
JOIN productos pr
ON pe.fab = pr.id_fab AND pe.producto = pr.id_producto
WHERE pe.fab = 'aci' OR pe.fab = 'rei' AND (pr.descripcion LIKE 'Bisagra%' OR pr.descripcion LIKE 'Articulo%')
UNION
SELECT 'Total : ', pe.fab, pr.descripcion, pe.producto, sum(pe.importe)
FROM pedidos pe
JOIN productos pr
ON pe.fab = pr.id_fab AND pe.producto = pr.id_producto
WHERE pe.fab = 'aci' OR (pe.fab = 'rei' AND (pr.descripcion LIKE 'Bisagra%' OR pr.descripcion LIKE 'Articulo%'))
GROUP BY pe.producto, pe.fab, pr.id_producto, pr.id_fab
ORDER BY 2, 3;

      ?column?       | fab |   descripcion   | producto | importe  
---------------------+-----+-----------------+----------+----------
 Venta individual :  | aci | Ajustador       | 4100x    |   600.00
 Venta individual :  | aci | Ajustador       | 4100x    |   150.00
 Total :             | aci | Ajustador       | 4100x    |   750.00
 Venta individual :  | aci | Articulo Tipo 2 | 41002    |  4104.00
 Total :             | aci | Articulo Tipo 2 | 41002    |  4864.00
 Venta individual :  | aci | Articulo Tipo 2 | 41002    |   760.00
 Venta individual :  | aci | Articulo Tipo 3 | 41003    |  3745.00
 Total :             | aci | Articulo Tipo 3 | 41003    |  3745.00
 Venta individual :  | aci | Articulo Tipo 4 | 41004    |  3978.00
 Venta individual :  | aci | Articulo Tipo 4 | 41004    |  3276.00
 Total :             | aci | Articulo Tipo 4 | 41004    |  7956.00
 Venta individual :  | aci | Articulo Tipo 4 | 41004    |   702.00
 Total :             | rei | Bisagra Dcha.   | 2a44r    | 67500.00
 Venta individual :  | rei | Bisagra Dcha.   | 2a44r    | 22500.00
 Venta individual :  | rei | Bisagra Dcha.   | 2a44r    | 45000.00
 Venta individual :  | rei | Bisagra Izqda.  | 2a44l    | 31500.00
 Total :             | rei | Bisagra Izqda.  | 2a44l    | 31500.00
 Venta individual :  | aci | Extractor       | 4100y    | 27500.00
 Total :             | aci | Extractor       | 4100y    | 27500.00
 Venta individual :  | aci | Montador        | 4100z    | 22500.00
 Venta individual :  | aci | Montador        | 4100z    | 15000.00
 Total :             | aci | Montador        | 4100z    | 37500.00
(22 rows)


-- 2. Mostrar les ventes individuals fetes pels venedors de New York i de Chicago que superin els 2500€. Mostrar també el total de ventes de cada oficina.

SELECT 'Venta Individual', num_empl, ciudad, importe 
FROM repventas 
JOIN oficinas 
ON oficina_rep = oficina 
JOIN pedidos 
ON num_empl = rep 
WHERE (ciudad = 'New York' OR ciudad = 'Chicago') AND importe > 2500 
UNION 
SELECT 'Total Ventas', null, ciudad, sum(importe) 
FROM repventas 
JOIN oficinas 
ON oficina_rep = oficina 
JOIN pedidos ON num_empl = rep 
WHERE (ciudad LIKE 'New York' OR ciudad LIKE 'Chicago') AND importe > 2500 
GROUP BY 3 
ORDER BY 2, 3, 4;

     ?column?     | num_empl |  ciudad  | importe  
------------------+----------+----------+----------
 Venta Individual |      101 | Chicago  |  3978.00
 Venta Individual |      101 | Chicago  | 22500.00
 Venta Individual |      106 | New York | 31500.00
 Venta Individual |      109 | New York |  5625.00
 Total Ventas     |          | Chicago  | 26478.00
 Total Ventas     |          | New York | 37125.00
(6 rows)


-- 3. Mostrar quantes ventes ha fet cada venedor, la mitjana de numero de ventes dels venedors de cada oficina i el numero de ventes total.

-- 4. Mostrar les compres de productes de la fabrica 'aci' que han fet els clients del Bill Adams i el Dan Roberts. Mostrar també l'import total per cada client.

-- 5. Mostrar el total de ventes de cada oficina i el total de ventes de cada regió

-- 6. Mostrar els noms dels venedors de cada ciutat i el numero total de venedors per ciutat

-- 7. Mostrat els noms dels clients de cada ciutat i el numero total de clients per ciutat.

-- 8. Mostrat els noms dels treballadors que son -caps- d'algú, els noms dels seus -subordinats- i el numero de treballadors que té assignat cada cap.

