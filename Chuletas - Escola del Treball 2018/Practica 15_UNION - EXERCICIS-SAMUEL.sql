-- 1. Mostar les ventes individuals dels productes dels fabricants 'aci' i 'rei' que comencin per 'Bisagra' o 'Articulo'. Mostrar també el total venut d'aquests productes.
	training=# SELECT 'Ventes individuals: ' , fab , producto , importe 
	FROM pedidos 
	LEFT JOIN productos ON fab = id_fab and producto = id_producto 
	WHERE (fab = 'aci' or fab = 'rei') and (descripcion like 'Bisagra%' or descripcion like 'Articulo%')
	UNION
	SELECT 'Total ventes: ' , fab , producto , sum(importe) 
	FROM pedidos 
	LEFT JOIN productos ON fab = id_fab and producto = id_producto 
	WHERE (fab = 'aci' or fab = 'rei') and (descripcion like 'Bisagra%' or descripcion like 'Articulo%')
	GROUP BY fab , producto 
	ORDER BY fab , producto , 1 DESC;
       ?column?       | fab | producto | importe  
----------------------+-----+----------+----------
 Ventes individuals:  | aci | 41002    |   760.00
 Ventes individuals:  | aci | 41002    |  4104.00
 Total ventes:        | aci | 41002    |  4864.00
 Ventes individuals:  | aci | 41003    |  3745.00
 Total ventes:        | aci | 41003    |  3745.00
 Ventes individuals:  | aci | 41004    |   702.00
 Ventes individuals:  | aci | 41004    |  3276.00
 Ventes individuals:  | aci | 41004    |  3978.00
 Total ventes:        | aci | 41004    |  7956.00
 Ventes individuals:  | rei | 2a44l    | 31500.00
 Total ventes:        | rei | 2a44l    | 31500.00
 Ventes individuals:  | rei | 2a44r    | 45000.00
 Ventes individuals:  | rei | 2a44r    | 22500.00
 Total ventes:        | rei | 2a44r    | 67500.00
(14 rows)


-- 2. Mostrar les ventes individuals fetes pels venedors de New York i de Chicago que superin els 2500€. Mostrar també el total de ventes de cada oficina.
	training=# 
	SELECT 'Ventes individuals: ' , num_pedido , rep, ciudad , importe 
	FROM pedidos 
	JOIN repventas ON rep = num_empl 
	LEFT JOIN oficinas ON oficina_rep = oficina 
	WHERE importe > 2500 and (ciudad = 'New York' or ciudad = 'Chicago')
	UNION
	SELECT 'Total ventes: ' , 0,0, ciudad, sum(importe) 
	FROM pedidos 
	JOIN repventas ON rep = num_empl 
	LEFT JOIN oficinas ON oficina_rep = oficina 
	WHERE (ciudad = 'New York' or ciudad = 'Chicago') 
	GROUP BY ciudad ORDER BY ciudad , 1 DESC;
       ?column?       | num_pedido | rep |  ciudad  | importe  
----------------------+------------+-----+----------+----------
 Ventes individuals:  |     112968 | 101 | Chicago  |  3978.00
 Ventes individuals:  |     113042 | 101 | Chicago  | 22500.00
 Total ventes:        |          0 |   0 | Chicago  | 29328.00
 Ventes individuals:  |     113003 | 109 | New York |  5625.00
 Ventes individuals:  |     112961 | 106 | New York | 31500.00
 Total ventes:        |          0 |   0 | New York | 40063.00
(6 rows)

-- 3. Mostrar quantes ventes ha fet cada venedor, la mitjana de numero de ventes dels venedors de cada oficina i el numero de ventes total.
	
-- 4. Mostrar les compres de productes de la fabrica 'aci' que han fet els clients del Bill Adams i el Dan Roberts. Mostrar també l'import total per cada client.
	training=# SELECT 'Compres per producte' , clie , fab , producto , importe 
	FROM pedidos 
	JOIN clientes ON clie = num_clie 
	JOIN repventas ON rep_clie = num_empl 
	WHERE fab = 'aci' and (nombre = 'Bill Adams' or nombre = 'Dan Roberts') 
	UNION 
	SELECT 'Total per producte' , clie , '---' , '---' , sum(importe) 
	FROM pedidos 
	JOIN clientes ON clie = num_clie 
	JOIN repventas ON rep_clie = num_empl 
	WHERE fab = 'aci' and (nombre = 'Bill Adams' or nombre = 'Dan Roberts') 
	GROUP BY clie 
	ORDER BY clie , 1;
       ?column?       | clie | fab | producto | importe  
----------------------+------+-----+----------+----------
 Compres per producte | 2102 | aci | 41004    |  3978.00
 Total per producte   | 2102 | --- | ---      |  3978.00
 Compres per producte | 2103 | aci | 41004    |   702.00
 Compres per producte | 2103 | aci | 4100y    | 27500.00
 Compres per producte | 2103 | aci | 41004    |  3276.00
 Compres per producte | 2103 | aci | 41002    |  4104.00
 Total per producte   | 2103 | --- | ---      | 35582.00
(7 rows)

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
 Clients:  | Ace International |             |         
 Total:    |                   |             |        1
(26 rows)

-- 8. Mostrat els noms dels treballadors que son -caps- d'algú, els noms dels seus -subordinats- i el numero de treballadors que té assignat cada cap.
	
