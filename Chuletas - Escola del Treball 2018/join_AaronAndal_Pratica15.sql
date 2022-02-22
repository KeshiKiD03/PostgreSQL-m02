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

SELECT 'mitjana per vendedor oficina', oficina, round(avg(num_pedido),2) AS 'mitjana'
FROM repventas
LEFT JOIN pedidos
ON num_empl = rep
JOIN oficinas
ON oficina_rep = oficina
GROUP BY 2;

           ?column?           | oficina |   round   
------------------------------+---------+-----------
 mitjana per vendedor oficina |      11 | 113002.75
 mitjana per vendedor oficina |      12 | 113019.40
 mitjana per vendedor oficina |      13 | 112994.40
 mitjana per vendedor oficina |      21 | 113024.18
 mitjana per vendedor oficina |      22 | 113042.67
(5 rows)

------------ CORREGIDO

SELECT 'mitjana per vendedor oficina', oficina, count(*)/count(distinct(num_empl))::float
FROM repventas
LEFT JOIN pedidos
ON num_empl = rep
JOIN oficinas
ON oficina_rep = oficina
GROUP BY 2;

           ?column?           | oficina | ?column? 
------------------------------+---------+----------
 mitjana per vendedor oficina |      11 |        2
 mitjana per vendedor oficina |      12 |        2
 mitjana per vendedor oficina |      13 |        5
 mitjana per vendedor oficina |      21 |      5.5
 mitjana per vendedor oficina |      22 |        3
(5 rows)


SELECT 'total ventas', oficina, count(*)
FROM oficinas JOIN repventas ON oficina = oficina_rep
JOIN pedidos ON num_empl = rep
GROUP BY 2;






----------


SELECT 'ventas por vendedor', oficina, re.num_empl, count(num_pedido)
FROM repventas re
LEFT JOIN pedidos pe
ON re.num_empl = pe.rep
LEFT JOIN oficinas
ON oficina = re.oficina_rep 
GROUP BY 2,3;
      ?column?       | oficina | num_empl | count 
---------------------+---------+----------+-------
 ventas por vendedor |      11 |      106 |     2
 ventas por vendedor |      12 |      104 |     0
 ventas por vendedor |      11 |      109 |     2
 ventas por vendedor |      12 |      101 |     3
 ventas por vendedor |      13 |      105 |     5
 ventas por vendedor |         |      110 |     2
 ventas por vendedor |      21 |      102 |     4
 ventas por vendedor |      12 |      103 |     2
 ventas por vendedor |      22 |      107 |     3
 ventas por vendedor |      21 |      108 |     7
(10 rows)

-- FINAL

SELECT 'ventas por vendedor', oficina, re.num_empl, count(num_pedido)
FROM repventas re
LEFT JOIN pedidos pe
ON re.num_empl = pe.rep
LEFT JOIN oficinas
ON oficina = re.oficina_rep 
GROUP BY 2,3
UNION
SELECT 'mitjana per vendedor oficina', oficina, num_empl, count(*)/count(distinct(num_empl))::float
FROM repventas
LEFT JOIN pedidos
ON num_empl = rep
JOIN oficinas
ON oficina_rep = oficina
GROUP BY 2,3
UNION
SELECT 'total ventas', oficina, 0, count(*)
FROM oficinas JOIN repventas ON oficina = oficina_rep
JOIN pedidos ON num_empl = rep
GROUP BY 2 ORDER BY 2, 3, 1;
           ?column?           | oficina | num_empl | count 
------------------------------+---------+----------+-------
 total ventas                 |      11 |        0 |     4
 mitjana per vendedor oficina |      11 |      106 |     2
 ventas por vendedor          |      11 |      106 |     2
 mitjana per vendedor oficina |      11 |      109 |     2
 ventas por vendedor          |      11 |      109 |     2
 total ventas                 |      12 |        0 |     5
 mitjana per vendedor oficina |      12 |      101 |     3
 ventas por vendedor          |      12 |      101 |     3
 mitjana per vendedor oficina |      12 |      103 |     2
 ventas por vendedor          |      12 |      103 |     2
 mitjana per vendedor oficina |      12 |      104 |     1
 ventas por vendedor          |      12 |      104 |     0
 total ventas                 |      13 |        0 |     5
 mitjana per vendedor oficina |      13 |      105 |     5
 ventas por vendedor          |      13 |      105 |     5
 total ventas                 |      21 |        0 |    11
 mitjana per vendedor oficina |      21 |      102 |     4
 ventas por vendedor          |      21 |      102 |     4
 mitjana per vendedor oficina |      21 |      108 |     7
 ventas por vendedor          |      21 |      108 |     7
 total ventas                 |      22 |        0 |     3
 mitjana per vendedor oficina |      22 |      107 |     3
 ventas por vendedor          |      22 |      107 |     3
 ventas por vendedor          |         |      110 |     2
(24 rows)



-- 4. Mostrar les compres de productes de la fabrica 'aci' que han fet els clients del Bill Adams i el Dan Roberts. Mostrar també l'import total per cada client.

SELECT pe.producto, pr.descripcion, pe.fab
FROM pedidos pe
JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
WHERE pe.fab = 'aci'; 

SELECT pe.producto, pr.descripcion, pe.fab
FROM pedidos pe
JOIN productos pr
ON pe.producto = pr.id_producto AND pe.fab = pr.id_fab
JOIN clientes cl
ON pe.clie = cl.num_clie
JOIN repventas re
ON pe.rep = re.num_empl
WHERE pe.fab = 'aci' AND (re.nombre = 'Bill Adams' OR re.nombre = 'Dan Roberts'); 


-- 5. Mostrar el total de ventes de cada oficina i el total de ventes de cada regió
	training=# SELECT 'Total ventes oficina' , oficina , region , sum(importe) 
	FROM oficinas 
	JOIN repventas ON oficina = oficina_rep 
	JOIN pedidos ON num_empl = rep 
	GROUP BY oficina 
	UNION 
	SELECT 'Total ventes regio' , null , region , sum(importe) 
	FROM oficinas 
	JOIN repventas ON oficina = oficina_rep 
	JOIN pedidos ON num_empl = rep 
	GROUP BY region
	ORDER BY 2,3;
       ?column?       | oficina | region |    sum    
----------------------+---------+--------+-----------
 Total ventes oficina |      11 | Este   |  40063.00
 Total ventes oficina |      12 | Este   |  29328.00
 Total ventes oficina |      13 | Este   |  39327.00
 Total ventes oficina |      21 | Oeste  |  81409.00
 Total ventes oficina |      22 | Oeste  |  34432.00
 Total ventes regio   |         | Este   | 108718.00
 Total ventes regio   |         | Oeste  | 115841.00
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

-- 6. Mostrar els noms dels venedors de cada ciutat i el numero total de venedors per ciutat
	training=# SELECT 'Venedors: ' , nombre , ciudad , null 
	FROM repventas 
	LEFT JOIN oficinas ON oficina_rep = oficina 
	UNION 
	SELECT 'Total: ' , null , ciudad , count(*) 
	FROM repventas 
	LEFT JOIN oficinas ON oficina_rep = oficina 
	GROUP BY ciudad 
	ORDER BY ciudad,1 DESC;
  ?column?  |    nombre     |   ciudad    | ?column? 
------------+---------------+-------------+----------
 Venedors:  | Bill Adams    | Atlanta     |         
 Total:     |               | Atlanta     |        1
 Venedors:  | Bob Smith     | Chicago     |         
 Venedors:  | Dan Roberts   | Chicago     |         
 Venedors:  | Paul Cruz     | Chicago     |         
 Total:     |               | Chicago     |        3
 Venedors:  | Nancy Angelli | Denver      |         
 Total:     |               | Denver      |        1
 Venedors:  | Larry Fitch   | Los Angeles |         
 Venedors:  | Sue Smith     | Los Angeles |         
 Total:     |               | Los Angeles |        2
 Venedors:  | Mary Jones    | New York    |         
 Venedors:  | Sam Clark     | New York    |         
 Total:     |               | New York    |        2
 Venedors:  | Tom Snyder    |             |         
 Total:     |               |             |        1
(16 rows)


-- 7. Mostrat els noms dels clients de cada ciutat i el numero total de clients per ciutat.
	training=# SELECT 'Clients: ' , empresa , ciudad , null 
	FROM clientes 
	JOIN repventas ON rep_clie = num_empl 
	LEFT JOIN oficinas ON oficina_rep = oficina 
	UNION 
	SELECT 'Total: ' , null , ciudad , count(*) 
	FROM clientes 
	JOIN repventas ON rep_clie = num_empl 
	LEFT JOIN oficinas ON oficina_rep = oficina 
	GROUP BY ciudad 
	ORDER BY ciudad,1 ;
 ?column?  |      empresa      |   ciudad    | ?column? 
-----------+-------------------+-------------+----------
 Clients:  | Acme Mfg.         | Atlanta     |         
 Clients:  | Three-Way Lines   | Atlanta     |         
 Total:    |                   | Atlanta     |        2
 Clients:  | First Corp.       | Chicago     |         
 Clients:  | Ian & Schmidt     | Chicago     |         
 Clients:  | Smithson Corp.    | Chicago     |         
 Clients:  | Chen Associates   | Chicago     |         
 Clients:  | QMA Assoc.        | Chicago     |         
 Clients:  | AAA Investments   | Chicago     |         
 Total:    |                   | Chicago     |        6
 Clients:  | Peter Brothers    | Denver      |         
 Total:    |                   | Denver      |        1
 Clients:  | Zetacorp          | Los Angeles |         
 Clients:  | Rico Enterprises  | Los Angeles |         
 Clients:  | Orion Corp        | Los Angeles |         
 Clients:  | Fred Lewis Corp.  | Los Angeles |         
 Clients:  | Carter & Sons     | Los Angeles |         
 Clients:  | Midwest Systems   | Los Angeles |         
 Total:    |                   | Los Angeles |        6
 Clients:  | Solomon Inc.      | New York    |         
 Clients:  | Jones Mfg.        | New York    |         
 Clients:  | J.P. Sinclair     | New York    |         
 Clients:  | Holm & Landis     | New York    |         
 Total:    |                   | New York    |        4

-- 8. Mostrat els noms dels treballadors que son -caps- d'algú, els noms dels seus -subordinats- i el numero de treballadors que té assignat cada cap.

SELECT DISTINCT 'caps', dir.num_empl, 0, dir.nombre FROM repventas JOIN repventas dir ON repventas.director=dir.num_empl
UNION
SELECT 'subordinats', director, num_empl, nombre FROM repventas
UNION
SELECT 'numero subordinats', director, count(*), '-' FROM repventas GROUP BY 2 ORDER BY 2,1;
      ?column?      | num_empl | ?column? |    nombre     
--------------------+----------+----------+---------------
 caps               |      101 |        0 | Dan Roberts
 numero subordinats |      101 |        1 | -
 subordinats        |      101 |      110 | Tom Snyder
 caps               |      104 |        0 | Bob Smith
 numero subordinats |      104 |        3 | -
 subordinats        |      104 |      101 | Dan Roberts
 subordinats        |      104 |      105 | Bill Adams
 subordinats        |      104 |      103 | Paul Cruz
 caps               |      106 |        0 | Sam Clark
 numero subordinats |      106 |        3 | -
 subordinats        |      106 |      104 | Bob Smith
 subordinats        |      106 |      108 | Larry Fitch
 subordinats        |      106 |      109 | Mary Jones
 caps               |      108 |        0 | Larry Fitch
 numero subordinats |      108 |        2 | -
 subordinats        |      108 |      102 | Sue Smith
 subordinats        |      108 |      107 | Nancy Angelli
 numero subordinats |          |        1 | -
 subordinats        |          |      106 | Sam Clark
(19 rows)

