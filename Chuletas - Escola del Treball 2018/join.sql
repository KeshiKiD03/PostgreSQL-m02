-- 3. Mostrar quantes ventes ha fet cada venedor, la mitjana de numero de ventes dels venedors de cada oficina i el numero de ventes total.

 SELECT count(*), re.nombre, re.num_empl
FROM pedidos pe
RIGHT JOIN repventas re
ON pe.rep = re.num_empl
GROUP BY re.num_empl;
 count |    nombre     | num_empl 
-------+---------------+----------
     2 | Sam Clark     |      106
     3 | Dan Roberts   |      101
     2 | Mary Jones    |      109
     1 | Bob Smith     |      104
     4 | Sue Smith     |      102
     3 | Nancy Angelli |      107
     7 | Larry Fitch   |      108
     2 | Tom Snyder    |      110
     2 | Paul Cruz     |      103
     5 | Bill Adams    |      105
(10 rows)


 SELECT count(*), re.nombre, re.num_empl
FROM pedidos pe
RIGHT JOIN repventas re
ON pe.rep = re.num_empl
GROUP BY re.num_empl;

-- 4. Mostrar les compres de productes de la fabrica 'aci' que han fet els clients del Bill Adams i el Dan Roberts. Mostrar també l'import total per cada client.

SELECT pe.producto, pr.descripcion, pe.fab
FROM pedidos pe
JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
WHERE pe.fab = 'aci'; 

-- 5. Mostrar el total de ventes de cada oficina i el total de ventes de cada regió

SELECT 'oficinas' AS total, ventas
FROM oficinas
UNION
SELECT 'region' AS total, sum(ventas)
FROM oficinas
GROUP BY region
ORDER BY 2;

  total   |   ventas   
----------+------------
 oficinas |  186042.00
 oficinas |  367911.00
 oficinas |  692637.00
 oficinas |  735042.00
 oficinas |  835915.00
 region   | 1021957.00
 region   | 1795590.00
(7 rows)


-- 6. Mostrar els noms dels venedors de cada ciutat i el numero total de venedors per ciutat

SELECT re.nombre, o.ciudad
FROM repventas re
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina

    nombre     |   ciudad    
---------------+-------------
 Bill Adams    | Atlanta
 Mary Jones    | New York
 Sue Smith     | Los Angeles
 Sam Clark     | New York
 Bob Smith     | Chicago
 Dan Roberts   | Chicago
 Tom Snyder    | 
 Larry Fitch   | Los Angeles
 Paul Cruz     | Chicago
 Nancy Angelli | Denver
(10 rows)

SELECT count(re.nombre), o.ciudad
FROM repventas re
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
GROUP BY o.ciudad
ORDER BY 2;
 count |   ciudad    
-------+-------------
     1 | Atlanta
     3 | Chicago
     1 | Denver
     2 | Los Angeles
     2 | New York
     1 | 
(6 rows)


SELECT 'Noms' AS nombre, re.nombre, o.ciudad
FROM repventas re
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
UNION
SELECT 'Total' AS nombre, count(re.nombre), o.ciudad
FROM repventas re
LEFT JOIN oficinas o
ON re.oficina_rep = o.oficina
GROUP BY o.ciudad
ORDER BY 2;


-- 7. Mostrat els noms dels clients de cada ciutat i el numero total de clients per ciutat.
-- 8. Mostrat els noms dels treballadors que son -caps- d'algú, els noms dels seus -subordinats- i el numero de treballadors que té assignat cada cap.
