-- 21.- Es desitja un llistat d'identificadors de fabricants de productes. 
-- Només volem tenir en compte els productes de preu superior a 54. 
-- Només volem que apareguin els fabricants amb un nombre total d'unitats superior a 300.

SELECT id_fab, sum(existencias) AS "Numero total de unitats"
FROM productos
WHERE precio > 54
GROUP BY id_fab
HAVING sum(existencias) > 300;

 id_fab | Numero total de unitats 
--------+-------------------------
 aci    |                     843
(1 row)


-- 22.Es desitja un llistat dels productes amb les seves descripcions, 
-- ordenat per la suma total d'imports facturats (pedidos) de cada producte de l'any 1989.

SELECT pr.descripcion, sum(pe.importe), TO_CHAR(pe.fecha_pedido, 'fmDD Month YYYY')
FROM productos pr JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
WHERE pe.fecha_pedido >= '1989-01-01' AND pe.fecha_pedido <= '1989-12-31'
GROUP BY pr.descripcion, pe.fecha_pedido;

    descripcion    |   sum    |      to_char      
-------------------+----------+-------------------
 Articulo Tipo 4   |  3978.00 | 12 October   1989
 Bisagra Izqda.    | 31500.00 | 17 December  1989
 Articulo Tipo 4   |  3276.00 | 17 December  1989
 Articulo Tipo 2   |   760.00 | 4 November  1989
 Montador          | 15000.00 | 12 October   1989
 Extractor         | 27500.00 | 31 December  1989
 Articulo Tipo 4   |   702.00 | 27 December  1989
 V Stago Trinquete |  1896.00 | 4 January   1989
 Pasador Bisagra   |  2100.00 | 12 December  1989
(9 rows)

SELECT pr.descripcion, sum(pe.importe), pe.fecha_pedido
FROM productos pr JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
WHERE pe.fecha_pedido >= '1989-01-01' AND pe.fecha_pedido <= '1989-12-31'
GROUP BY pr.descripcion, pe.fecha_pedido
ORDER BY 2 DESC;

    descripcion    |   sum    | fecha_pedido 
-------------------+----------+--------------
 Articulo Tipo 4   |  3978.00 | 1989-10-12
 Bisagra Izqda.    | 31500.00 | 1989-12-17
 Articulo Tipo 4   |  3276.00 | 1989-12-17
 Articulo Tipo 2   |   760.00 | 1989-11-04
 Montador          | 15000.00 | 1989-10-12
 Extractor         | 27500.00 | 1989-12-31
 Articulo Tipo 4   |   702.00 | 1989-12-27
 V Stago Trinquete |  1896.00 | 1989-01-04
 Pasador Bisagra   |  2100.00 | 1989-12-12
(9 rows)


-- CORREGIDO

SELECT pr.id_fab, pr.id_producto, pr.descripcion, sum(pe.importe)
FROM productos pr JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
WHERE pe.fecha_pedido >= '1989-01-01' AND pe.fecha_pedido <= '1989-12-31'
GROUP BY pr.id_fab, pr.id_producto
ORDER BY sum(pe.importe);

 id_fab | id_producto |    descripcion    |   sum    
--------+-------------+-------------------+----------
 aci    | 41002       | Articulo Tipo 2   |   760.00
 rei    | 2a45c       | V Stago Trinquete |  1896.00
 rei    | 2a44g       | Pasador Bisagra   |  2100.00
 aci    | 41004       | Articulo Tipo 4   |  7956.00
 aci    | 4100z       | Montador          | 15000.00
 aci    | 4100y       | Extractor         | 27500.00
 rei    | 2a44l       | Bisagra Izqda.    | 31500.00
(7 rows)

SELECT pr.id_fab, pr.id_producto, pr.descripcion, sum(pe.importe)
FROM productos pr JOIN pedidos pe
ON pr.id_producto = pe.producto AND pr.id_fab = pe.fab
WHERE pe.fecha_pedido >= '1989-01-01' AND pe.fecha_pedido <= '1989-12-31'
GROUP BY pr.id_fab, pr.id_producto
ORDER BY 4;



-- 23. Per a cada director (de personal, no d'oficina) excepte per al gerent (el venedor que no té director), vull saber el total de vendes dels seus subordinats. 
-- Mostreu codi i nom dels directors.

SELECT jefe.num_empl, jefe.nombre, sum(importe)
FROM repventas jefe JOIN repventas venedors
ON venedors.director = jefe.num_empl
JOIN pedidos
ON venedors.num_empl = rep
GROUP BY jefe.num_empl;

 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(4 rows)

SELECT jefe.num_empl, jefe.nombre, sum(importe)
FROM repventas jefe JOIN repventas venedors
ON jefe.num_empl = venedors.director
JOIN pedidos
ON venedors.num_empl = rep
GROUP BY jefe.num_empl;

 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(4 rows)

SELECT jefe.num_empl, jefe.nombre, sum(importe)
FROM repventas jefe RIGHT JOIN repventas venedors
ON jefe.num_empl = venedors.director
JOIN pedidos
ON venedors.num_empl = rep
GROUP BY jefe.num_empl;

 num_empl |   nombre    |   sum    
----------+-------------+----------
          |             | 32958.00
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(5 rows)

SELECT jefe.num_empl, jefe.nombre, sum(importe)
FROM repventas jefe LEFT JOIN repventas venedors
ON jefe.num_empl = venedors.director
JOIN pedidos
ON venedors.num_empl = rep
GROUP BY jefe.num_empl;

 num_empl |   nombre    |   sum    
----------+-------------+----------
      106 | Sam Clark   | 65738.00
      101 | Dan Roberts | 23132.00
      104 | Bob Smith   | 68655.00
      108 | Larry Fitch | 57208.00
(4 rows)


-- 24. Quins són els 5 productes que han estat venuts a més clients diferents? 
-- Mostreu el número de clients per cada producte. 
-- A igualtat de nombre de clients es volen ordenats per ordre decreixent d'existències i, a igualtat d'existències, per descripció. 
-- Mostreu tots els camps pels quals s'ordena.

SELECT pe.clie , pe.fab , count(*) , pr.existencias , pr.descripcion 
FROM pedidos pe JOIN productos pr 
ON pe.fab = pr.id_fab AND pe.producto = pr.id_producto
GROUP BY pe.clie , pe.fab , pr.existencias , pr.descripcion 
ORDER BY count(*) DESC, pr.existencias DESC , pr.descripcion LIMIT 5;
 rep | fab | count | existencias |    descripcion    
-----+-----+-------+-------------+-------------------
 105 | aci |     2 |         139 | Articulo Tipo 4
 108 | qsa |     2 |          38 | Reductor
 110 | rei |     1 |         210 | V Stago Trinquete
 102 | rei |     1 |         210 | V Stago Trinquete
 105 | aci |     1 |         207 | Articulo Tipo 3
(5 rows)



--------- LA QUE ESTÁ BIEN ----------

SELECT id_fab, id_producto, descripcion, existencias, count(distinct clie) AS "Clients diferents"
FROM productos JOIN pedidos
ON id_fab = fab AND id_producto = producto
GROUP BY id_fab, id_producto
ORDER BY 5 DESC, 4 DESC, 3;
 id_fab | id_producto |    descripcion    | existencias | Clients diferents 
--------+-------------+-------------------+-------------+-------------------
 qsa    | xk47        | Reductor          |          38 |                 3
 rei    | 2a45c       | V Stago Trinquete |         210 |                 2
 aci    | 41002       | Articulo Tipo 2   |         167 |                 2
 aci    | 41004       | Articulo Tipo 4   |         139 |                 2
 aci    | 4100x       | Ajustador         |          37 |                 2
 aci    | 4100z       | Montador          |          28 |                 2
 fea    | 114         | Bancada Motor     |          15 |                 2
 rei    | 2a44r       | Bisagra Dcha.     |          12 |                 2
 imm    | 779c        | Riostra 2-Tm      |           9 |                 2
 bic    | 41003       | Manivela          |           3 |                 2
 aci    | 41003       | Articulo Tipo 3   |         207 |                 1
 fea    | 112         | Cubierta          |         115 |                 1
 imm    | 773c        | Riostra 1/2-Tm    |          28 |                 1
 aci    | 4100y       | Extractor         |          25 |                 1
 rei    | 2a44g       | Pasador Bisagra   |          14 |                 1
 rei    | 2a44l       | Bisagra Izqda.    |          12 |                 1
 imm    | 775c        | Riostra 1-Tm      |           5 |                 1
(17 rows)

----------- LA ULTIMA

SELECT id_fab, id_producto, descripcion, existencias, COUNT(DISTINCT clie) AS "Clients diferents" 
FROM productos JOIN pedidos 
ON id_fab = fab AND id_producto = producto
GROUP BY id_fab, id_producto
ORDER BY 5 DESC, 4 DESC, 3 LIMIT 5;
 id_fab | id_producto |    descripcion    | existencias | Clients diferents 
--------+-------------+-------------------+-------------+-------------------
 qsa    | xk47        | Reductor          |          38 |                 3
 rei    | 2a45c       | V Stago Trinquete |         210 |                 2
 aci    | 41002       | Articulo Tipo 2   |         167 |                 2
 aci    | 41004       | Articulo Tipo 4   |         139 |                 2
 aci    | 4100x       | Ajustador         |          37 |                 2
(5 rows)


-- 25. Es vol llistar el clients (codi i empresa) tals que no hagin comprat cap tipus de frontissa 
-- ("bisagra" en castellà, figura a la descripció) i hagin comprat articles de més d'un fabricant diferent.

SELECT cl.num_clie, cl.empresa, count(pe.fab), pe.producto
FROM clientes cl JOIN pedidos pe
ON cl.num_clie = pe.clie
JOIN productos pr
ON pr.id_fab = pe.fab AND pr.id_producto = pe.producto
WHERE NOT (pr.descripcion LIKE '*Bisagra*') 
GROUP BY cl.num_clie, pe.producto
HAVING count(pe.fab) > 1;
 num_clie |  empresa  | count | producto 
----------+-----------+-------+----------
     2103 | Acme Mfg. |     2 | 41004
(1 row)

----- SAMUEL

	training=# SELECT cl.num_clie , cl.empresa , count(DISTINCT pe.fab) 
	FROM clientes cl JOIN pedidos pe ON cl.num_clie = pe.clie 
	JOIN productos pr ON pe.fab = pr.id_fab and pe.producto = pr.id_producto 
	WHERE pr.descripcion NOT ILIKE '%bisagra%' 
	GROUP BY cl.num_clie , cl.empresa 
	HAVING count(DISTINCT pe.fab) > 1;
 num_clie |      empresa      | count 
----------+-------------------+-------
     2106 | Fred Lewis Corp.  |     2
     2107 | Ace International |     2
     2108 | Holm & Landis     |     3
     2114 | Orion Corp        |     2
     2118 | Midwest Systems   |     3
     2124 | Peter Brothers    |     2
(6 rows)

------ CORREGIDO

SELECT empresa,rep_clie,count(fab) FROM clientes JOIN pedidos ON (rep_clie=rep) JOIN productos ON id_fab=fab and
id_producto=producto WHERE descripcion NOT like 'bisagra' GROUP BY empresa,rep_clie HAVING count(fab)>1;
      empresa      | rep_clie | count 
-------------------+----------+-------
 Three-Way Lines   |      105 |     5
 Jones Mfg.        |      106 |     2
 Ace International |      110 |     2
 Carter & Sons     |      102 |     4
 Holm & Landis     |      109 |     2
 JCP Inc.          |      103 |     2
 Zetacorp          |      108 |     6
 Rico Enterprises  |      102 |     4
 Peter Brothers    |      107 |     3
 Orion Corp        |      102 |     4
 Smithson Corp.    |      101 |     3
 Solomon Inc.      |      109 |     2
 AAA Investments   |      101 |     3
 Acme Mfg.         |      105 |     5
 Chen Associates   |      103 |     2
 Fred Lewis Corp.  |      102 |     4
 First Corp.       |      101 |     3
 QMA Assoc.        |      103 |     2
 J.P. Sinclair     |      106 |     2
 Midwest Systems   |      108 |     6
(20 rows)



-- 26. Llisteu les oficines per ordre descendent de nombre total de clients 
-- diferents amb comandes (pedidos) realizades pels venedors 
-- d'aquella oficina, i, a igualtat de clients, ordenat per ordre ascendent 
-- del nom del director de l'oficina. 
-- Només s'ha de mostrar el codi i la ciutat de l'oficina.

SELECT ciudad, num_pedido 
FROM oficinas JOIN repventas
ON oficina = oficina_rep
JOIN pedidos 
ON num_empl = rep;
   ciudad    | num_pedido 
-------------+------------
 New York    |     112961
 Atlanta     |     113012
 New York    |     112989
 Los Angeles |     113051
 Chicago     |     112968
 Los Angeles |     113045
 Atlanta     |     112963
 Los Angeles |     113013
 New York    |     113058
 Denver      |     112997
 Atlanta     |     112983
 Los Angeles |     113024
 Denver      |     113062
 Los Angeles |     112979
 Atlanta     |     113027
 Los Angeles |     113007
 Denver      |     113069
 Los Angeles |     112992
 Chicago     |     112975
 Chicago     |     113055
 Los Angeles |     113048
 Los Angeles |     112993
 Los Angeles |     113065
 New York    |     113003
 Los Angeles |     113049
 Atlanta     |     112987
 Chicago     |     113057
 Chicago     |     113042
(28 rows)

--- POR CADA PEDIDO, EN QUE CIUDAD TRABAJA CADA REPVENTAS

SELECT ciudad, num_pedido
FROM oficinas RIGHT JOIN repventas
ON oficina = oficina_rep
JOIN pedidos 
ON num_empl = rep;
   ciudad    | num_pedido 
-------------+------------
 New York    |     112961
 Atlanta     |     113012
 New York    |     112989
 Los Angeles |     113051
 Chicago     |     112968
             |     110036
 Los Angeles |     113045
 Atlanta     |     112963
 Los Angeles |     113013
 New York    |     113058
 Denver      |     112997
 Atlanta     |     112983
 Los Angeles |     113024
 Denver      |     113062
 Los Angeles |     112979
 Atlanta     |     113027
 Los Angeles |     113007
 Denver      |     113069
             |     113034
 Los Angeles |     112992
 Chicago     |     112975
 Chicago     |     113055
 Los Angeles |     113048
 Los Angeles |     112993
 Los Angeles |     113065
 New York    |     113003
 Los Angeles |     113049
 Atlanta     |     112987
 Chicago     |     113057
 Chicago     |     113042
(30 rows)

----------

SELECT ciudad, num_pedido, clie
FROM oficinas RIGHT JOIN repventas
ON oficina = oficina_rep
JOIN pedidos 
ON num_empl = rep
training-# ORDER BY ciudad;
   ciudad    | num_pedido | clie 
-------------+------------+------
 Atlanta     |     112983 | 2103
 Atlanta     |     112963 | 2103
 Atlanta     |     112987 | 2103
 Atlanta     |     113027 | 2103
 Atlanta     |     113012 | 2111
 Chicago     |     113042 | 2113
 Chicago     |     112968 | 2102
 Chicago     |     112975 | 2111
 Chicago     |     113055 | 2108
 Chicago     |     113057 | 2111
 Denver      |     113062 | 2124
 Denver      |     113069 | 2109
 Denver      |     112997 | 2124
 Los Angeles |     112979 | 2114
 Los Angeles |     113051 | 2118
 Los Angeles |     113007 | 2112
 Los Angeles |     113013 | 2118
 Los Angeles |     112992 | 2118
 Los Angeles |     113024 | 2114
 Los Angeles |     113048 | 2120
 Los Angeles |     113065 | 2106
 Los Angeles |     112993 | 2106
 Los Angeles |     113049 | 2118
 Los Angeles |     113045 | 2112
 New York    |     113058 | 2108
 New York    |     112989 | 2101
 New York    |     112961 | 2117
 New York    |     113003 | 2108
             |     113034 | 2107
             |     110036 | 2107
(30 rows)

-----------------

SELECT ciudad, count(clie), count(DISTINCT clie)
FROM oficinas RIGHT JOIN repventas
ON oficina = oficina_rep
JOIN pedidos 
ON num_empl = rep
GROUP BY oficina
ORDER BY ciudad;
   ciudad    | count | count 
-------------+-------+-------
 Atlanta     |     5 |     2
 Chicago     |     5 |     4
 Denver      |     3 |     2
 Los Angeles |    11 |     5
 New York    |     4 |     3
             |     2 |     1
(6 rows)


---------

SELECT ciudad, dir AS "Director", count(clie), count(DISTINCT clie)
FROM oficinas RIGHT JOIN repventas
ON oficina = oficina_rep
JOIN pedidos 
ON num_empl = rep
GROUP BY oficina
ORDER BY ciudad;
   ciudad    | Director | count | count 
-------------+----------+-------+-------
 Atlanta     |      105 |     5 |     2
 Chicago     |      104 |     5 |     4
 Denver      |      108 |     3 |     2
 Los Angeles |      108 |    11 |     5
 New York    |      106 |     4 |     3
             |          |     2 |     1
(6 rows)

----------- FINAL

SELECT ciudad, dir AS "Director", director.nombre, count(clie), count(DISTINCT clie)
FROM oficinas RIGHT JOIN repventas director
ON oficina = oficina_rep
JOIN pedidos 
ON num_empl = rep
GROUP BY oficina, director.num_empl
ORDER BY ciudad;
   ciudad    | Director |    nombre     | count | count 
-------------+----------+---------------+-------+-------
 Atlanta     |      105 | Bill Adams    |     5 |     2
 Chicago     |      104 | Dan Roberts   |     3 |     3
 Chicago     |      104 | Paul Cruz     |     2 |     1
 Denver      |      108 | Nancy Angelli |     3 |     2
 Los Angeles |      108 | Larry Fitch   |     7 |     3
 Los Angeles |      108 | Sue Smith     |     4 |     3
 New York    |      106 | Sam Clark     |     2 |     2
 New York    |      106 | Mary Jones    |     2 |     1
             |          | Tom Snyder    |     2 |     1
(9 rows)

---------- finaaaaaaaaaaaaaaaaaaaaal  

SELECT ciudad, dir AS "Director", director.nombre, count (clie), count(DISTINCT clie) 
FROM oficinas RIGHT JOIN repventas 
ON oficina = oficina_rep 
JOIN pedidos 
ON rep = num_empl 
JOIN repventas director 
ON dir = director.num_empl 
GROUP BY oficina, director.num_empl 
ORDER BY 3 ASC;
   ciudad    | Director |   nombre    | count | count 
-------------+----------+-------------+-------+-------
 Atlanta     |      105 | Bill Adams  |     5 |     2
 Chicago     |      104 | Bob Smith   |     5 |     4
 Los Angeles |      108 | Larry Fitch |    11 |     5
 Denver      |      108 | Larry Fitch |     3 |     2
 New York    |      106 | Sam Clark   |     4 |     3
(5 rows)


-- 27.Llista totes les comandes mostrant el seu número, 
-- import, nom de client i límit de crèdit. 

SELECT pe.num_pedido, pe.importe, cl.empresa, cl.limite_credito
FROM pedidos pe JOIN clientes cl
ON pe.clie = cl.num_clie;
 num_pedido | importe  |      empresa      | limite_credito 
------------+----------+-------------------+----------------
     112961 | 31500.00 | J.P. Sinclair     |       35000.00
     113012 |  3745.00 | JCP Inc.          |       50000.00
     112989 |  1458.00 | Jones Mfg.        |       65000.00
     113051 |  1420.00 | Midwest Systems   |       60000.00
     112968 |  3978.00 | First Corp.       |       65000.00
     110036 | 22500.00 | Ace International |       35000.00
     113045 | 45000.00 | Zetacorp          |       50000.00
     112963 |  3276.00 | Acme Mfg.         |       50000.00
     113013 |   652.00 | Midwest Systems   |       60000.00
     113058 |  1480.00 | Holm & Landis     |       55000.00
     112997 |   652.00 | Peter Brothers    |       40000.00
     112983 |   702.00 | Acme Mfg.         |       50000.00
     113024 |  7100.00 | Orion Corp        |       20000.00
     113062 |  2430.00 | Peter Brothers    |       40000.00
     112979 | 15000.00 | Orion Corp        |       20000.00
     113027 |  4104.00 | Acme Mfg.         |       50000.00
     113007 |  2925.00 | Zetacorp          |       50000.00
     113069 | 31350.00 | Chen Associates   |       25000.00
     113034 |   632.00 | Ace International |       35000.00
     112992 |   760.00 | Midwest Systems   |       60000.00
     112975 |  2100.00 | JCP Inc.          |       50000.00
     113055 |   150.00 | Holm & Landis     |       55000.00
     113048 |  3750.00 | Rico Enterprises  |       50000.00
     112993 |  1896.00 | Fred Lewis Corp.  |       65000.00
     113065 |  2130.00 | Fred Lewis Corp.  |       65000.00
     113003 |  5625.00 | Holm & Landis     |       55000.00
     113049 |   776.00 | Midwest Systems   |       60000.00
     112987 | 27500.00 | Acme Mfg.         |       50000.00
     113057 |   600.00 | JCP Inc.          |       50000.00
     113042 | 22500.00 | Ian & Schmidt     |       20000.00
(30 rows)

SELECT pe.num_pedido, pe.importe, cl.empresa, cl.limite_credito
FROM pedidos pe LEFT JOIN clientes cl
ON pe.clie = cl.num_clie;
 num_pedido | importe  |      empresa      | limite_credito 
------------+----------+-------------------+----------------
     112961 | 31500.00 | J.P. Sinclair     |       35000.00
     113012 |  3745.00 | JCP Inc.          |       50000.00
     112989 |  1458.00 | Jones Mfg.        |       65000.00
     113051 |  1420.00 | Midwest Systems   |       60000.00
     112968 |  3978.00 | First Corp.       |       65000.00
     110036 | 22500.00 | Ace International |       35000.00
     113045 | 45000.00 | Zetacorp          |       50000.00
     112963 |  3276.00 | Acme Mfg.         |       50000.00
     113013 |   652.00 | Midwest Systems   |       60000.00
     113058 |  1480.00 | Holm & Landis     |       55000.00
     112997 |   652.00 | Peter Brothers    |       40000.00
     112983 |   702.00 | Acme Mfg.         |       50000.00
     113024 |  7100.00 | Orion Corp        |       20000.00
     113062 |  2430.00 | Peter Brothers    |       40000.00
     112979 | 15000.00 | Orion Corp        |       20000.00
     113027 |  4104.00 | Acme Mfg.         |       50000.00
     113007 |  2925.00 | Zetacorp          |       50000.00
     113069 | 31350.00 | Chen Associates   |       25000.00
     113034 |   632.00 | Ace International |       35000.00
     112992 |   760.00 | Midwest Systems   |       60000.00
     112975 |  2100.00 | JCP Inc.          |       50000.00
     113055 |   150.00 | Holm & Landis     |       55000.00
     113048 |  3750.00 | Rico Enterprises  |       50000.00
     112993 |  1896.00 | Fred Lewis Corp.  |       65000.00
     113065 |  2130.00 | Fred Lewis Corp.  |       65000.00
     113003 |  5625.00 | Holm & Landis     |       55000.00
     113049 |   776.00 | Midwest Systems   |       60000.00
     112987 | 27500.00 | Acme Mfg.         |       50000.00
     113057 |   600.00 | JCP Inc.          |       50000.00
     113042 | 22500.00 | Ian & Schmidt     |       20000.00
(30 rows)

SELECT pe.num_pedido, pe.importe, cl.empresa, cl.limite_credito
FROM pedidos pe RIGHT JOIN clientes cl
ON pe.clie = cl.num_clie;
 num_pedido | importe  |      empresa      | limite_credito 
------------+----------+-------------------+----------------
     112961 | 31500.00 | J.P. Sinclair     |       35000.00
     113012 |  3745.00 | JCP Inc.          |       50000.00
     112989 |  1458.00 | Jones Mfg.        |       65000.00
     113051 |  1420.00 | Midwest Systems   |       60000.00
     112968 |  3978.00 | First Corp.       |       65000.00
     110036 | 22500.00 | Ace International |       35000.00
     113045 | 45000.00 | Zetacorp          |       50000.00
     112963 |  3276.00 | Acme Mfg.         |       50000.00
     113013 |   652.00 | Midwest Systems   |       60000.00
     113058 |  1480.00 | Holm & Landis     |       55000.00
     112997 |   652.00 | Peter Brothers    |       40000.00
     112983 |   702.00 | Acme Mfg.         |       50000.00
     113024 |  7100.00 | Orion Corp        |       20000.00
     113062 |  2430.00 | Peter Brothers    |       40000.00
     112979 | 15000.00 | Orion Corp        |       20000.00
     113027 |  4104.00 | Acme Mfg.         |       50000.00
     113007 |  2925.00 | Zetacorp          |       50000.00
     113069 | 31350.00 | Chen Associates   |       25000.00
     113034 |   632.00 | Ace International |       35000.00
     112992 |   760.00 | Midwest Systems   |       60000.00
     112975 |  2100.00 | JCP Inc.          |       50000.00
     113055 |   150.00 | Holm & Landis     |       55000.00
     113048 |  3750.00 | Rico Enterprises  |       50000.00
     112993 |  1896.00 | Fred Lewis Corp.  |       65000.00
     113065 |  2130.00 | Fred Lewis Corp.  |       65000.00
     113003 |  5625.00 | Holm & Landis     |       55000.00
     113049 |   776.00 | Midwest Systems   |       60000.00
     112987 | 27500.00 | Acme Mfg.         |       50000.00
     113057 |   600.00 | JCP Inc.          |       50000.00
     113042 | 22500.00 | Ian & Schmidt     |       20000.00
            |          | QMA Assoc.        |       45000.00
            |          | Smithson Corp.    |       20000.00
            |          | Solomon Inc.      |       25000.00
            |          | Three-Way Lines   |       30000.00
            |          | AAA Investments   |       45000.00
            |          | Carter & Sons     |       40000.00
(36 rows)


-- 28.Llista cada un dels venedors i la ciutat i regió on treballen 

SELECT rep.num_empl, rep.nombre, ofi.ciudad, ofi.region
FROM repventas rep JOIN oficinas ofi
ON rep.oficina_rep  = ofi.oficina;
 num_empl |    nombre     |   ciudad    | region 
----------+---------------+-------------+--------
      105 | Bill Adams    | Atlanta     | Este
      109 | Mary Jones    | New York    | Este
      102 | Sue Smith     | Los Angeles | Oeste
      106 | Sam Clark     | New York    | Este
      104 | Bob Smith     | Chicago     | Este
      101 | Dan Roberts   | Chicago     | Este
      108 | Larry Fitch   | Los Angeles | Oeste
      103 | Paul Cruz     | Chicago     | Este
      107 | Nancy Angelli | Denver      | Oeste
(9 rows)


SELECT rep.num_empl, rep.nombre, ofi.ciudad, ofi.region
FROM repventas rep LEFT JOIN oficinas ofi
ON rep.oficina_rep  = ofi.oficina;
 num_empl |    nombre     |   ciudad    | region 
----------+---------------+-------------+--------
      105 | Bill Adams    | Atlanta     | Este
      109 | Mary Jones    | New York    | Este
      102 | Sue Smith     | Los Angeles | Oeste
      106 | Sam Clark     | New York    | Este
      104 | Bob Smith     | Chicago     | Este
      101 | Dan Roberts   | Chicago     | Este
      110 | Tom Snyder    |             | 
      108 | Larry Fitch   | Los Angeles | Oeste
      103 | Paul Cruz     | Chicago     | Este
      107 | Nancy Angelli | Denver      | Oeste
(10 rows)

-- 29.Llista les oficines, i els noms i títols dels directors. 

SELECT DISTINCT o.oficina, r.nombre, o.dir
FROM oficinas o JOIN repventas r
ON o.dir = r.num_empl;
 oficina |   nombre    | dir 
---------+-------------+-----
      22 | Larry Fitch | 108
      21 | Larry Fitch | 108
      11 | Sam Clark   | 106
      12 | Bob Smith   | 104
      13 | Bill Adams  | 105
(5 rows)

-- 30.Llista les oficines, noms i titols del seus directors amb un objectiu superior a 600.000. 
training=# SELECT DISTINCT o.oficina, o.ciudad, o.dir, o.objetivo, r.director FROM repventas r RIGHT JOIN oficinas o ON o.objetivo > 600.000;
 oficina |   ciudad    | dir | objetivo  | director 
---------+-------------+-----+-----------+----------
      11 | New York    | 106 | 575000.00 |      101
      11 | New York    | 106 | 575000.00 |      104
      11 | New York    | 106 | 575000.00 |      106
      11 | New York    | 106 | 575000.00 |      108
      11 | New York    | 106 | 575000.00 |         
      12 | Chicago     | 104 | 800000.00 |      101
      12 | Chicago     | 104 | 800000.00 |      104
      12 | Chicago     | 104 | 800000.00 |      106
      12 | Chicago     | 104 | 800000.00 |      108
      12 | Chicago     | 104 | 800000.00 |         
      13 | Atlanta     | 105 | 350000.00 |      101
      13 | Atlanta     | 105 | 350000.00 |      104
      13 | Atlanta     | 105 | 350000.00 |      106
      13 | Atlanta     | 105 | 350000.00 |      108
      13 | Atlanta     | 105 | 350000.00 |         
      21 | Los Angeles | 108 | 725000.00 |      101
      21 | Los Angeles | 108 | 725000.00 |      104
      21 | Los Angeles | 108 | 725000.00 |      106
      21 | Los Angeles | 108 | 725000.00 |      108
      21 | Los Angeles | 108 | 725000.00 |         
      22 | Denver      | 108 | 300000.00 |      101
      22 | Denver      | 108 | 300000.00 |      104
      22 | Denver      | 108 | 300000.00 |      106
      22 | Denver      | 108 | 300000.00 |      108
      22 | Denver      | 108 | 300000.00 |         
(25 rows)

-- 31.Llista els venedors de les oficines de la regió est. 
training=# SELECT o.oficina, o.region, r.nombre FROM repventas r JOIN oficinas o ON r.oficina_rep = o.oficina WHERE o.region = 'Este';
 oficina | region |   nombre    
---------+--------+-------------
      13 | Este   | Bill Adams
      11 | Este   | Mary Jones
      11 | Este   | Sam Clark
      12 | Este   | Bob Smith
      12 | Este   | Dan Roberts
      12 | Este   | Paul Cruz
(6 rows)

-- 32.Llista totes les comandes, mostrant els imports i les descripcions del producte. 
training=# SELECT pr.descripcion, pe.importe FROM pedidos pe JOIN productos pr ON id_producto = producto;
    descripcion    | importe  
-------------------+----------
 Bisagra Izqda.    | 31500.00
 Manivela          |  3745.00
 Articulo Tipo 3   |  3745.00
 Bancada Motor     |  1458.00
 Articulo Tipo 4   |  3978.00
 Montador          | 22500.00
 Bisagra Dcha.     | 45000.00
 Articulo Tipo 4   |  3276.00
 Manivela          |   652.00
 Articulo Tipo 3   |   652.00
 Cubierta          |  1480.00
 Manivela          |   652.00
 Articulo Tipo 3   |   652.00
 Articulo Tipo 4   |   702.00
 Reductor          |  7100.00
 Bancada Motor     |  2430.00
 Montador          | 15000.00
 Articulo Tipo 2   |  4104.00
 Riostra 1/2-Tm    |  2925.00
 Riostra 1-Tm      | 31350.00
 V Stago Trinquete |   632.00
 Articulo Tipo 2   |   760.00
 Pasador Bisagra   |  2100.00
 Ajustador         |   150.00
 Riostra 2-Tm      |  3750.00
 V Stago Trinquete |  1896.00
 Reductor          |  2130.00
 Riostra 2-Tm      |  5625.00
 Reductor          |   776.00
 Extractor         | 27500.00
 Ajustador         |   600.00
 Bisagra Dcha.     | 22500.00
(32 rows)

-- 33.Llista les comandes superiors a 25.000, incloent el nom del venedor que va servir la comanda i el nom del client que el va sol·licitar. 
training=# SELECT p.num_pedido, p.importe, r.nombre, c.empresa FROM pedidos p JOIN repventas r ON p.rep = r.num_empl JOIN clientes c ON p.clie = c.num_clie WHERE p.importe > 25000;
 num_pedido | importe  |    nombre     |     empresa     
------------+----------+---------------+-----------------
     112961 | 31500.00 | Sam Clark     | J.P. Sinclair
     113045 | 45000.00 | Larry Fitch   | Zetacorp
     113069 | 31350.00 | Nancy Angelli | Chen Associates
     112987 | 27500.00 | Bill Adams    | Acme Mfg.
(4 rows)

-- 34.Llista les comandes superiors a 25000, mostrant el client que va demanar la comanda i el nom del venedor que té assignat el client. 
SELECT c.num_clie, p.clie, c.rep_clie, c.empresa, r.num_empl 
FROM clientes c 
JOIN pedidos p 
ON p.clie = c.num_clie 
JOIN repventas r 
ON c.rep_clie = r.num_empl 
WHERE p.importe > 25000;
 num_clie | clie | rep_clie |     empresa     | num_empl 
----------+------+----------+-----------------+----------
     2117 | 2117 |      106 | J.P. Sinclair   |      106
     2112 | 2112 |      108 | Zetacorp        |      108
     2109 | 2109 |      103 | Chen Associates |      103
     2103 | 2103 |      105 | Acme Mfg.       |      105
(4 rows)

-- 35.Llista les comandes superiors a 25000, mostrant el nom del client que el va 
-- ordenar, el venedor associat al client, i l'oficina on el venedor treballa. 
training=# SELECT p.num_pedido, p.importe, r.nombre, c.rep_clie, p.clie, o.oficina FROM pedidos p 
JOIN clientes c ON p.clie = c.num_clie JOIN repventas r ON r.num_empl = c.rep_clie JOIN oficinas o ON r.oficina_rep = o.oficina WHERE p.importe > 25000;
 num_pedido | importe  |   nombre    | rep_clie | clie | oficina 
------------+----------+-------------+----------+------+---------
     112961 | 31500.00 | Sam Clark   |      106 | 2117 |      11
     113045 | 45000.00 | Larry Fitch |      108 | 2112 |      21
     113069 | 31350.00 | Paul Cruz   |      103 | 2109 |      12
     112987 | 27500.00 | Bill Adams  |      105 | 2103 |      13
(4 rows)



-- 35bis.- Llista les comandes superiors a 25000, mostrant el nom del client que el 
-- va ordenar, el venedor associat al client, i l'oficina on el venedor treballa. També cal que mostris la descripció del producte. 
SELECT p.num_pedido, p.importe, r.nombre, c.rep_clie, p.clie, o.oficina 
FROM pedidos p 
JOIN clientes c 
ON p.clie = c.num_clie 
JOIN repventas r 
ON r.num_empl = c.rep_clie 
JOIN oficinas o 
ON r.oficina_rep = o.oficina 
WHERE p.importe > 25000; 
 num_pedido | importe  |    nombre     | rep_clie | clie | oficina 
------------+----------+---------------+----------+------+---------
     112961 | 31500.00 | Sam Clark     |      106 | 2117 |      11
     113045 | 45000.00 | Larry Fitch   |      108 | 2112 |      21
     113069 | 31350.00 | Nancy Angelli |      103 | 2109 |      22
     112987 | 27500.00 | Bill Adams    |      105 | 2103 |      13
(4 rows)


SELECT p.num_pedido, p.importe, r.nombre, p.rep, p.clie, o.oficina, pr.descripcion 
FROM pedidos p 
JOIN productos pr
	ON ( p.fab = pr.id_fab AND p.producto = pr.id_producto) 
JOIN clientes c 
ON p.clie = c.num_clie
JOIN repventas r 
ON r.num_empl = p.rep 
JOIN oficinas o 
ON r.oficina_rep = o.oficina 
WHERE p.importe > 25000;
 num_pedido | importe  |    nombre     | rep | clie | oficina |  descripcion   
------------+----------+---------------+-----+------+---------+----------------
     112987 | 27500.00 | Bill Adams    | 105 | 2103 |      13 | Extractor
     113069 | 31350.00 | Nancy Angelli | 107 | 2109 |      22 | Riostra 1-Tm
     112961 | 31500.00 | Sam Clark     | 106 | 2117 |      11 | Bisagra Izqda.
     113045 | 45000.00 | Larry Fitch   | 108 | 2112 |      21 | Bisagra Dcha.
(4 rows)


-- 36.Trobar totes les comandes rebudes en els dies en que un nou venedor va ser contractat. 
training=# SELECT fecha_pedido, contrato FROM repventas, pedidos WHERE fecha_pedido = contrato;
 fecha_pedido |  contrato  
--------------+------------
 1989-10-12   | 1989-10-12
 1989-10-12   | 1989-10-12
 1989-10-12   | 1989-10-12
 1989-10-12   | 1989-10-12
(4 rows)

-- 37.Llista totes les combinacions de venedors i oficines on la quota del venedor és superior a l'objectiu de l'oficina. 
training=# SELECT * FROM oficinas, repventas WHERE cuota > objetivo;
 oficina | ciudad | region | dir | objetivo  |  ventas   | num_empl |   nombre    | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
---------+--------+--------+-----+-----------+-----------+----------+-------------+------+-------------+------------+------------+----------+-----------+-----------
      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00 |      105 | Bill Adams  |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00
      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00 |      102 | Sue Smith   |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00
      22 | Denver | Oeste  | 108 | 300000.00 | 186042.00 |      108 | Larry Fitch |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00
(3 rows)

-- 38.Mostra el nom, les vendes i l'oficina de cada venedor. 
training=# SELECT SUM(p.importe), o.oficina, r.nombre, p.rep 
FROM repventas r 
JOIN pedidos p 
ON r.num_empl = p.rep 
JOIN oficinas o 
ON r.oficina_rep = o.oficina 
GROUP BY p.rep, o.oficina, r.nombre;
   sum    | oficina |    nombre     | rep 
----------+---------+---------------+-----
 26628.00 |      12 | Dan Roberts   | 101
 58633.00 |      21 | Larry Fitch   | 108
 32958.00 |      11 | Sam Clark     | 106
  2700.00 |      12 | Paul Cruz     | 103
 34432.00 |      22 | Nancy Angelli | 107
 22776.00 |      21 | Sue Smith     | 102
 39327.00 |      13 | Bill Adams    | 105
  7105.00 |      11 | Mary Jones    | 109
(8 rows)

-- 39.Informa sobre tots els venedors i les oficines en les que treballen. 
training=# SELECT r.nombre, o.oficina FROM repventas r JOIN oficinas o ON r.oficina_rep = o.oficina ;
    nombre     | oficina 
---------------+---------
 Bill Adams    |      13
 Mary Jones    |      11
 Sue Smith     |      21
 Sam Clark     |      11
 Bob Smith     |      12
 Dan Roberts   |      12
 Larry Fitch   |      21
 Paul Cruz     |      12
 Nancy Angelli |      22
(9 rows)


-- 40.Informa sobre tots els venedors (tota la informació de repventas) més la ciutat i regió on treballen. 
training=# SELECT repventas.*, o.ciudad, o.region FROM repventas JOIN oficinas o ON oficina_rep = o.oficina ;
 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   |   ciudad    | region 
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+-------------+--------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 | Atlanta     | Este
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 | New York    | Este
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 | Los Angeles | Oeste
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 | New York    | Este
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 | Chicago     | Este
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 | Chicago     | Este
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 | Los Angeles | Oeste
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 | Chicago     | Este
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 | Denver      | Oeste
(9 rows)

-- (*)41.Llista el nom dels venedors i el del seu director. 

SELECT d.nombre, r.nombre AS "Director" 
FROM repventas r 
JOIN repventas d 
ON r.num_empl = d.director ;
    nombre     |  Director   
---------------+-------------
 Bill Adams    | Bob Smith
 Mary Jones    | Sam Clark
 Sue Smith     | Larry Fitch
 Bob Smith     | Sam Clark
 Dan Roberts   | Bob Smith
 Tom Snyder    | Dan Roberts
 Larry Fitch   | Sam Clark
 Paul Cruz     | Bob Smith
 Nancy Angelli | Larry Fitch
(9 rows)

SELECT vendedor.nombre, dir.nombre
FROM repventas vendedor LEFT JOIN oficinas
ON vendedor.oficina_rep = oficina
LEFT JOIN repventas dir
ON oficinas.dir = dir.num_empl;
    nombre     |   nombre    
---------------+-------------
 Bill Adams    | Bill Adams
 Mary Jones    | Sam Clark
 Sue Smith     | Larry Fitch
 Sam Clark     | Sam Clark
 Bob Smith     | Bob Smith
 Dan Roberts   | Bob Smith
 Tom Snyder    | 
 Larry Fitch   | Larry Fitch
 Paul Cruz     | Bob Smith
 Nancy Angelli | Larry Fitch
(10 rows)


-- 42.Llista els venedors amb una quota superior a la dels seus directors. 

SELECT rep.nombre AS "Vendedores", dir.nombre AS "Directores", rep.cuota AS "Cuota Vendedor", dir.cuota AS "Cuota Vendedor"
FROM repventas rep
JOIN repventas dir
ON rep.num_empl = dir.director
WHERE rep.cuota > dir.cuota;
 Vendedores  |  Directores   
-------------+---------------
 Sam Clark   | Bob Smith
 Larry Fitch | Nancy Angelli
(2 rows)

-- 43.Llista totes les combinacions possibles de venedors i ciutats. 

SELECT * FROM repventas JOIN oficinas ON oficina_rep = oficina;
 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   | oficina |   ciudad    | region | dir | objetivo 
 |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------+---------+-------------+--------+-----+----------
-+-----------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00 |      13 | Atlanta     | Este   | 105 | 350000.00
 | 367911.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00 |      11 | New York    | Este   | 106 | 575000.00
 | 692637.00
      102 | Sue Smith     |   48 |          21 | Rep Ventas | 1986-12-10 |      108 | 350000.00 | 474050.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00
 | 835915.00
      106 | Sam Clark     |   52 |          11 | VP Ventas  | 1988-06-14 |          | 275000.00 | 299912.00 |      11 | New York    | Este   | 106 | 575000.00
 | 692637.00
      104 | Bob Smith     |   33 |          12 | Dir Ventas | 1987-05-19 |      106 | 200000.00 | 142594.00 |      12 | Chicago     | Este   | 104 | 800000.00
 | 735042.00
      101 | Dan Roberts   |   45 |          12 | Rep Ventas | 1986-10-20 |      104 | 300000.00 | 305673.00 |      12 | Chicago     | Este   | 104 | 800000.00
 | 735042.00
      108 | Larry Fitch   |   62 |          21 | Dir Ventas | 1989-10-12 |      106 | 350000.00 | 361865.00 |      21 | Los Angeles | Oeste  | 108 | 725000.00
 | 835915.00
      103 | Paul Cruz     |   29 |          12 | Rep Ventas | 1987-03-01 |      104 | 275000.00 | 286775.00 |      12 | Chicago     | Este   | 104 | 800000.00
 | 735042.00
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00 |      22 | Denver      | Oeste  | 108 | 300000.00
 | 186042.00
(9 rows)

-- 44.Llistar el nom de l'empresa i totes les comandes fetes pel client 2.103.
 

-- 45.Llista els venedors i les oficines en què treballen. 

-- 46.Llista els venedors i les ciutats en què treballen. 

-- 47.Fes que la consulta anterior mostri les dades dels deu venedors. 



